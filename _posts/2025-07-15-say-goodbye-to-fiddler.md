---
title: 'Say Goodbye to Fiddler: A Modern Proxy Alternative for developing PCF controls'
meta: 2025-07-15 15:00:00 +0000
categories: [PCF, Software Engineering, Power Platform]
tags: [pcf, sofware, power platform]
seo:
  date_modified: 2025-07-13 15:00:00 +0000
---

![PCF CLI Proxy Tool logo replacing Fiddler]({{ "/assets/img/posts/say-goodbye-to-fiddler.png" | relative_url }})

If you've ever built a Power Apps Component Framework (PCF) control, you know that debugging can be a real pain. You have your local test harness, which is great, but what about when you need to see real data from Dataverse in your component? For years, the answer has been "just use Fiddler," which is awesome... if you're on Windows.

For those of us on a Mac or Linux, this has always been a headache. Getting proxies and traffic interception to work right for debugging PCF controls was never a simple task. Until now!

I stumbled upon a fantastic community tool that solves this problem beautifully: [**PCF CLI Proxy Tools**](https://github.com/framitdavid/pcf-cli-proxy-tools).

A massive shout-out to [David Øvrelid](https://www.linkedin.com/in/davidovrelid) for creating this and sharing it with the community! It's tools like this that make a real difference in our day-to-day development lives, smoothing out the little bumps in the road that can cause so much frustration.

It’s a simple command-line tool that lets you proxy your local PCF files to a live Dataverse environment. For non-Windows developers, it's a total game-changer!

## **Getting Started: It's Super Easy!**

Getting this set up is surprisingly simple, but there are a couple of things you'll want to get right:

1. First, install the tools right into your PCF component's folder:  

    ```
    cd src/YourPcfComponent/  
    npx github:framitdavid/pcf-cli-proxy-tools
    ```
2. Next up, you'll need to configure your environment. This is the most important step! The tool adds a `.env.example` file. Just rename that to `.env` and pop in the paths to your local apps.

<br />

> **Pro tip:** The example file is set up for Windows, which makes sense. If you're on a Mac like me, yours will look something like this:
>    ```
>    # Path to your local mitmproxy executable  
>    MITMPROXY_PATH=/opt/homebrew/bin/mitmproxy
>
>    # Path to your Chrome executable  
>    CHROME_EXE_PATH="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
>    ```
>    Just make sure those paths are correct for your machine!

### **The HTTPS Gotcha**

Heads up! The proxy works with HTTP right away, but to get it to see the secure traffic from Dataverse, you have to make your machine trust the mitmproxy certificate. This is a crucial step and easy to forget! You just need to install the `mitmproxy-ca-cert.pem` certificate into your system's keychain and set it to be trusted.

## **How to Use It**

Once you're all set up, using the tool is as easy as running a single command:

```
npm run dev:proxy -- <your-pcf-control-name>
```

This one command does all the magic for you:

1. It starts the proxy.  
2. It opens a fresh Chrome window that's already set up to use the proxy.  
3. It lets you load your local PCF control right into your Dataverse environment!

No more annoying CORS errors. No more fighting with manual proxy settings. It just works!

## **Final Thoughts**

This tool is a perfect example of what makes the Power Platform community so great. Someone found a common problem and built a simple, smart solution for it. It's a huge help for developers on Mac and Linux, making the whole PCF development process way smoother. Plus, it's independent and can be automated, so you're not tied to Fiddler and all its manual setup. Who knows, we may even see this integrated to `pcf-scripts` one day. If you've ever been frustrated with PCF debugging on a non-Windows computer, you should definitely give this a try!

I recommend checking out [David's original post on Medium](https://davidovrelid.com/ditch-fiddler-for-good-a-faster-way-to-test-pcf-components-in-dynamics-365-b88a8f1f69b2), and the [docs for the tool](https://pcfproxy.dev) too!