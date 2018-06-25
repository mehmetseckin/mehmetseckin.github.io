---
layout: post
title: Extending Dynamics 365 Package Deployer
---

{{ page.title }}
================

<p class="meta">25 June 2018, Windsor, UK</p>

The Dynamics 365 Package Deployer is a great tool that allows you to move your customisations and data between environments in bulk.

It imports your solutions and data, and provides an API to hook your custom code up to this process at certain points. These hooks are as follows:

![Custom code hooks for Dynamics 365 Package Deployer process](/images/dynamics-365-package-deployer-hooks.png)
*Custom code hooks for Dynamics 365 Package Deployer process*

| Method Name | Execution Time |
| ----------- | -------------- |
| `InitializeCustomExtension` | After the package deployer extension is initialized, before the solution import process. |
| `PreSolutionImport` | Before importing each solution. |
| `RunSolutionUpgradeMigrationStep` | Before importing each solution, only if the solution that is being imported is already present in the target Dynamics 365 instance. |
| `BeforeImportStage` | Before the solution import completes, if the sample data or flat files are being imported. |
| `AfterPrimaryImport` | After the solution and data imports are completed. |

There are some special parameters and properties that you can set in some of these methods. These parameters and properties can be set to alter the deployment behaviour, such has enabling plug-ins and workflows disabled, overriding safety checks during data import, etc.

There are also some cool methods that lets you interfere with the user interface, such as the `CreateProgressItem`, `RaiseUpdateEvent`, `RaiseFailEvent` methods. These methods enables you to create your own progress items in the progress items pane, however they seem to be only effective after the solution import process begins.

Another cool property that is provided via the Dynamics 365 Package Deployer API is `RootControlDispatcher`. This property allows you invoke logic in the Package Deployer's main UI thread. This means, you can use your custom WPF user interface during a package deployment.

The Package Deployer also supports customised Welcome and End HTML pages for license agreements, release notes and whatnot. This also supports javascript, however I haven't tried to run a full-blown single page application on there, and I believe the javascript support would be somewhat limited.

![A JavaScript alert from a custom welcome page in Dynamics 365 deployment package](/images/dynamics-365-package-deployer-script-alert.png)
*A JavaScript alert from a custom welcome page in Dynamics 365 deployment package*

There is a lot of clever stuff that can be done using these extension points if you want to customise, enhance and automate the deployment process of your Dynamics 365 applications.