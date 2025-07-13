---
title: Are we fooling ourselves?
meta: 2025-07-13 00:00:00 +0000
categories: [AI, Software Engineering, Power Platform]
tags: [ai, sofware, power platform]
seo:
  date_modified: 2025-07-13 00:00:00 +0000
---
# **Are We Fooling Ourselves?**

![A humorous illustration of a developer running in a hamster wheel that looks like a progress bar, feeling productive but actually going nowhere]({{ "/assets/img/posts/are-we-fooling-ourselves-hamster-wheel.png" | relative_url }})

That dopamine hit when an AI assistant spits out a perfect chunk of code? It feels like magic. It feels like productivity. It feels like the future. We're living in the future, shipping features at lightning speed, right?

A recent, and frankly startling, study from the non-profit research institute METR suggests we might be collectively deluding ourselves.

The study, "Measuring the Impact of Early-2025 AI on Experienced Open-Source Developer Productivity"<sup>[1]</sup>, conducted a randomized controlled trial with experienced open-source developers working on their own projects. The result? When allowed to use AI tools like Cursor with Claude 3.5/3.7, developers didn't get faster.

**They got 19% slower.**

Let that sink in. The tools we believe are accelerating our work might actually be pumping the brakes.

### **The Great Deception: Perception vs. Reality**

Here’s the kicker, the part that really makes you question your own senses. Before the study, developers predicted that AI would make them 24% faster. Okay, a little optimism is healthy. But even *after* completing the tasks and experiencing the slowdown, they *still believed* the AI had made them 20% faster.

This isn't just a small discrepancy. It's a chasm between our perception of productivity and the stopwatch reality. We *feel* more productive, even when the data screams the opposite<sup>[1]</sup>. Why?

Perhaps it’s because the AI eliminates the part of the job we find most tedious: the blank page, the initial boilerplate. It gives us a running start, and that momentum feels incredible. But the study suggests this initial burst of speed is more than paid for by the time spent prompting, waiting, reviewing, and debugging code that we didn't write ourselves. We're trading the friction of creation for the friction of verification, and it seems to be a bad deal.

### **What This Means for Developers (Especially in the Power Platform World)**

For those of us deep in the world of Dataverse, Power Platform, and Dynamics 365, this hits close to home. Our platforms are complex ecosystems. It's not just about writing a standalone function; it's about understanding a rich data model, intricate business logic, security roles, and a web of existing plugins and workflows.

An AI can generate a perfect C\# plugin snippet in isolation. But does it understand the full execution context? Does it account for the specific pre- and post-images, the depth of the relationship graph, or the performance implications of a query within a larger transaction?

The study hints that the cost of getting the AI up to speed on this deep, implicit context might be the very thing slowing us down. We spend so much time course-correcting the AI's plausible-but-wrong suggestions that we would have been better off just writing the code ourselves, drawing on the expertise we've spent years building.

### **The Pros and Cons Re-evaluated**

**Pros of AI Assistance:**

* **Reduces Tedium:** It's great for boilerplate, generating standard patterns, and tackling well-defined, isolated problems.  
* **Learning Tool:** It can be a fantastic way to explore a new library or API, offering a starting point for your own experimentation.  
* **Breaks the Blank Page:** Sometimes, you just need a little nudge to get started.

**Cons Highlighted by the Study:**

* **The Illusion of Speed:** The feeling of productivity is dangerously misleading.  
* **Context is King:** AI struggles with the deep, implicit knowledge required for complex, mature codebases. This is the bread and butter of enterprise development.  
* **The Cost of Verification:** Debugging someone else's code is hard. Debugging an AI's subtly flawed code might be even harder. It introduces errors that experienced humans often don't make.

### **Where Do We Go From Here?**

This isn't a call to abandon AI tools. That would be like trying to put the genie back in the bottle. Instead, this is a call for a dose of healthy skepticism and a more mature approach to integrating AI into our workflows.

1. **Measure, Don't Guess:** Stop relying on your gut feeling of productivity. If you're a team lead or a technical architect, find ways to measure actual outcomes. Look at cycle times, bug rates, and rework. The data might surprise you.  
2. **Wield it like a scalpel, not a sledgehammer.** Use AI for precise, well-defined tasks like generating boilerplate or converting data formats. Don't ask it to perform open-heart surgery on your core business logic. You are the surgeon who holds the deep context; the AI is just a tool in your hand.  
3. **Invest in Skills, Not Just Tools:** The study noted that the one developer with over 50 hours of experience in the specific AI tool *did* see a speedup. This suggests there's a steep learning curve. Getting good at using these tools is a skill in itself. It's not just about typing a question; it's about expert-level prompting, scaffolding, and critical evaluation.  
4. **Trust, but Verify. Aggressively.** Treat every line of AI-generated code with suspicion. Review it with the same rigor you would a junior developer's first pull request. The time you save in generation must be reinvested in verification.

We are at a crucial inflection point. We can either be fooled by the seductive feeling of speed, or we can be rigorous, data-driven professionals who harness these powerful new tools without succumbing to their illusions.

Let's choose to be the latter.

### **References**

1. METR. (2025, July 10). *Measuring the Impact of Early-2025 AI on Experienced Open-Source Developer Productivity*. [https://metr.org/blog/2025-07-10-early-2025-ai-experienced-os-dev-study/](https://metr.org/blog/2025-07-10-early-2025-ai-experienced-os-dev-study/)