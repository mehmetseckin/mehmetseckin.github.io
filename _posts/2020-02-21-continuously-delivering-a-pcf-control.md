---
title: Continuously Delivering a PCF Control
date: 2020-02-21 00:00:00 +0000
categories: [Tips and Tricks, DevOps, Power Platform, PowerApps Component Framework]
tags: [typescript, pcf, azure, devops, pipelines, yaml, continuous, delivery, integration, ci, cd]
---

There are lots of things that can be possible with the mighty PowerApps Component Framework. The component development experience is great thanks to the scripting provided by the framework, however once you're happy with your component, "shipping it" may not be so easy. You still have to deal with the produced solution archive (.zip) file. Moreover, the properties of this solution file is in an XML file in your repository, for example, you'll have to increment the version number for the solution that will be output by your build process manually. This is fine if it's a one-off operation, but it can be a little daunting when you have to repeat it over and over during your dev/test loop, or if you want to implement continuous delivery.

## An example scenario
I have recently developed a PCF control to learn the framework, and decided to implement continuous integration and delivery. To achieve this, I decided to use Azure Pipelines and release the control as a managed solution to GitHub.

![CI/CD Overview]({{ "/assets/img/posts/pcf-pipelines-github.png" | relative_url }})

Let's start with a CI pipeline that builds our new control:

```yaml
stages:
- stage: 'build'
  jobs:
  - job: 'build_job'
    pool:
      vmAgent: 'windows-latest'
    steps:
    - task: VSBuild@1
      displayName: "Build"
      inputs:
        solution: 'Solutions\Solutions.cdsproj'
        msbuildArgs: '/t:build /restore'
```

Well, that was easy. However, our solution is getting built in `Debug` mode, and this produces an `unmanaged` solution by default. You can manually override this setting by specifying a property in the `Solutions.cdsproj` file. (Hint: The property is included as a comment in the generated project file).

In this scenario, we will just tell the pipeline to build in `Release` mode:

```yaml
# ...
        msbuildArgs: '/t:build /restore /p:configuration=Release' # build in Release mode to get managed solution
```

Great, now we have our managed solution. Let's give our build a name to provide unique version numbers to each build:

```yaml
variables:
  version: '1.0.0'

name: $(version).$(build.buildId)

# stages: ...
```

Now each build has its own unique version number, but our solution version never changes. To update the solution version, we will use a simple PowerShell step:

```yaml
# ...
    steps:
    - powershell: |
        echo "Updating solution version: $($env:BUILD_NUMBER)"
        $solution = [xml](gc "$($env:SOLUTION_XML_PATH)")
        $solution.ImportExportXml.SolutionManifest.Version = "$($env:BUILD_NUMBER)";
        $solution.Save("$($env:SOLUTION_XML_PATH)")
      displayName: 'Update solution version'
      env:
        BUILD_NUMBER: $(build.buildNumber) # a.k.a. the 'name', e.g. 1.0.0.5523
        SOLUTION_XML_PATH: 'Solutions\Other\Solution.xml'
    # - task: VSBuild@1 ...
```

Now, every build produces a managed solution with a unique version number. It's time to tag the source in GitHub, and publish our managed solution to GitHub as a release.

To do this, we will first need to add a checkout step with `persistCredentials` flag set to `true` at the beginning of our build job, and a PowerShell script to create and push a tag to our repository.

```yaml
    steps:
    - checkout: self
      persistCredentials: true

    # ... build tasks

    - powershell: |
        echo "Tagging Build: $($env:BUILD_NUMBER)"
        git tag $env:BUILD_NUMBER
        git push origin $env:BUILD_NUMBER
      env:
        BUILD_NUMBER: $(build.buildNumber) # a.k.a. the 'name', e.g. 1.0.0.5523
        GIT_REDIRECT_STDERR: 2>&1 # This is needed because git writes warnings to error stream and this fails the task
```

Now we can use the GitHub Release task to release our solution to GitHub. The `githubConnection` parameter accepts a Service Connection name which can be configured on Azure Pipelines in `Project Settings > Service Connections`.

```yaml
    - task: GitHubRelease@1
      inputs:
        gitHubConnection: 'azure-pipelines-github-connection'
        repositoryName: '$(Build.Repository.Name)'
        action: 'create'
        target: '$(Build.SourceVersion)'
        tagSource: 'gitTag'
        assets: Solutions\bin\Release\*.zip
```

Our final pipeline definition looks like this:

```yaml
variables:
  version: '1.0.0'

name: $(version).$(build.buildId)

stages:
- stage: 'build'
  jobs:
  - job: 'build_job'
    pool:
      vmAgent: 'windows-latest'
    steps:
    - checkout: self
      persistCredentials: true
    - powershell: |
        echo "Updating solution version: $($env:BUILD_NUMBER)"
        $solution = [xml](gc "$($env:SOLUTION_XML_PATH)")
        $solution.ImportExportXml.SolutionManifest.Version = "$($env:BUILD_NUMBER)";
        $solution.Save("$($env:SOLUTION_XML_PATH)")
      displayName: 'Update solution version'
      env:
        BUILD_NUMBER: $(build.buildNumber) # a.k.a. the 'name', e.g. 1.0.0.5523
        SOLUTION_XML_PATH: 'Solutions\Other\Solution.xml'
    - task: VSBuild@1
      displayName: "Build"
      inputs:
        solution: 'Solutions\Solutions.cdsproj'
        msbuildArgs: '/t:build /restore'
    - powershell: |
        echo "Tagging Build: $($env:BUILD_NUMBER)"
        git tag $env:BUILD_NUMBER
        git push origin $env:BUILD_NUMBER
      env:
        BUILD_NUMBER: $(build.buildNumber) # a.k.a. the 'name', e.g. 1.0.0.5523
        GIT_REDIRECT_STDERR: 2>&1 # This is needed because git writes warnings to error stream and this fails the task
    - task: GitHubRelease@1
      inputs:
        gitHubConnection: 'azure-pipelines-github-connection'
        repositoryName: '$(Build.Repository.Name)'
        action: 'create'
        target: '$(Build.SourceVersion)'
        tagSource: 'gitTag'
        assets: Solutions\bin\Release\*.zip
```

Hope this helps!