---
title: 'That Time an Azure AI Search Indexer Failed Silently'
meta: 2025-07-15 15:00:00 +0000
categories: [Azure AI Search, Azure, AI, Gotchas]
tags: [azure-ai-search, azure, gotchas]
seo:
  date_modified: 2025-10-08 19:00:00 +0000
---

![Azure AI Search Text Split skill]({{ "/assets/img/posts/azure-ai-search-text-split.png" | relative_url }})

We've all been there. You're working with a powerful new service, following the documentation, and everything seems to be set up correctly. You run it, and... nothing. No errors, no warnings, just a complete lack of the expected outcome. That was my experience recently while configuring a simple indexer with the Text Splitting skill in Azure AI Search.

After a lot of trial and error that I wouldn't wish on my worst enemy, I finally found the culprit: a single, incorrect value in the default JSON definition for the skill. The `"context"` property for the Text Split skill needs to be changed to `"/document"`. The default value, `"/document/content"`, causes the indexer to fail silently.

#### The Silent Failure

I was setting up an Azure AI Search resource with minimal, default settings, using the Text Splitting skill to chunk large documents into smaller pieces. The goal was to improve search results by indexing smaller, more focused passages of text. I added the Text Splitting skill to my skillset, configured the inputs and outputs, and ran the indexer. I expected to see my index fill up with the chunked text, but instead, I got nothing.

The most frustrating part was the lack of feedback. The indexer reported success, but the index was empty. I started tearing my configuration apart, checking and rechecking every setting. Was it my data source? My index definition? My skillset?

#### The Fix

After a lot of digging, I finally isolated the problem to the `context` property in the Text Splitting skill's JSON definition. The default value is `"/document/content"`, which seems logical since that's where the text to be split is located. However, this is incorrect.

Here’s the corrected JSON definition:

```json
{
  "@odata.type": "#Microsoft.Skills.Text.SplitSkill",
  "name": "splitText",
  "description": "Split skill to chunk documents",
  "context": "/document",
  "defaultLanguageCode": "en",
  "textSplitMode": "pages",
  "maximumPageLength": 4000,
  "pageOverlapChars": 500,
  "inputs": [
    {
      "name": "text",
      "source": "/document/content"
    }
  ],
  "outputs": [
    {
      "name": "textItems",
      "targetName": "pages"
    }
  ]
}
```

The only change is on line 5: `"context": "/document"`. With this simple change, the indexer started working as expected, and my index was populated with the chunked text.

#### So, What's Going On?

My theory is that the `context` property defines the scope at which the skill operates. When it's set to `"/document/content"`, the skill is trying to work within the content field itself, rather than on the document as a whole. By changing the `context` to `"/document"`, we're telling the skill to process the entire document, which allows it to correctly find and split the content.

It's a small detail, but it makes all the difference. If you're working with the Text Splitting skill in Azure AI Search and your indexer is failing silently, check the context property. It might just save you a few hours of frustration.