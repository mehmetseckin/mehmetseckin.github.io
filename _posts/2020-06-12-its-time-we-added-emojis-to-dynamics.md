---
title: 'It''s time we''ve added some emojis to Dynamics 365!'
date: 2020-06-12 23:47:12 +0100
categories: [Power Platform, PowerApps Component Framework, Dynamics 365]
tags: [typescript, pcf, timezone, react, fluent-ui, reactions, emoji]
seo:
  date_modified: 2020-06-12 23:47:12 +0100
---

Dynamics 365 and Model-driven Apps are great, and even though the shiny new Unified Interface looks awesome, but sometimes the user interface can get a little bit repetitive and monotonous. I recently thought about bringing emojis and reactions into Dynamics 365 / Model-driven Apps. So, I started working on a PCF component called [Reactions](https://github.com/mehmetseckin/Reactions) ⚡!

Here is an outline of the available features:

### ✅ Add/remove emoji reactions on a form

The control allows users to react to records on a form. 👍

![Reactions on form](assets/img/posts/reactions-on-form.png)

### ✅ Ability to configure the available emoji set

The emoji reactions available to the users are configurable on a per-control basis. 🤓

### ✅ Show a summary of reaction owners in a tooltip

When hovered over, reactions will show a summary of their owners. 🚁

![Owner Summary](assets/img/posts/owner-summary.png)

### ✅ Ability to list reaction owners in a modal

The detailed list of owners for a reaction can be seen by clicking the summary in the tooltip. 📃

![Owner List](assets/img/posts/owners-modal.png)

### ✅ Read-only and field security support

When the attribute is read-only, the control will not allow users to add or remove any reactions. However the owner summary and modal will still display the reaction owners. 🔒

![Read-only support](assets/img/posts/read-only-support.png)

I'd also like to add a couple more features to enhance the experience, such as:

- 💡 Ability to show reactions in a view / list of records (data-grid component)
- 💡 Enhance list of owners showing information like skype/teams availability, profile pictures, job title, quick message/call/email links etc.

As much as this sounds like a just-for-fun project, I think these little visual indicators could add a lot of value to otherwise repetitive text displays of information.

I would love to hear your opinions and ideas, so please feel free to [try it out](https://github.com/mehmetseckin/Reactions/releases/latest), have fun and please let me know what you think!