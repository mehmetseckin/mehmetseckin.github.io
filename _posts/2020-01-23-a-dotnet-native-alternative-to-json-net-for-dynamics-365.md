---
layout: post
title: A .NET Native Alternative to JSON.NET (a.k.a. Newtonsoft.Json) for Dynamics 365 Plugins
---

# {{ page.title }}

<p class="meta">23 January 2020, Birmingham, UK</p>

## Background

JSON.NET (a.k.a Newtonsoft.Json) is a powerful JSON library. But when working with Dynamics 365 plug-ins, it needs to be combined into your plug-in DLL using ILMerge. This works fine, but using ILMerge for plug-in and custom workflow assemblies is [unsupported](https://cloudblogs.microsoft.com/dynamics365/no-audience/2010/11/09/how-to-reference-assemblies-from-plug-ins/?source=crm) and can jeopardise your support agreement.

If you don't want to use ILMerge, or unable to for some reason, you can use `DataContractJsonSerializer` for most JSON tasks [JSON.NET](https://www.newtonsoft.com/json/help/html/JsonNetVsDotNetSerializers.htm) is capable of.

## Show me the code

Here is an example drop-in replacement class with the same interface as JSON.NET:

```csharp
using System.IO;
using System.Runtime.Serialization.Json;
using System.Text;

public static class JsonConvert
{
    public static string Serialize<T>(T obj)
    {
        using (var stream = new MemoryStream())
        {
            GetSerializer<T>().WriteObject(stream, obj);
            return Encoding.UTF8.GetString(stream.ToArray());
        }
    }

    public static T Deserialize<T>(string json)
    {
        using (var stream = new MemoryStream())
        {
            using (var writer = new StreamWriter(stream))
            {
                writer.Write(json);
                writer.Flush();
                stream.Position = 0;
                return (T)GetSerializer<T>().ReadObject(stream);
            }
        }
    }

    private static DataContractJsonSerializer GetSerializer<T>()
    {
        var settings = new DataContractJsonSerializerSettings
        {
            UseSimpleDictionaryFormat = true
        };

        return new DataContractJsonSerializer(typeof(T), settings);
    }
}
```

This can be used in the same way as JSON.NET:

```csharp
// Serialize a Person object into a JSON string
string json = JsonConvert.Serialize(person);

// Deserialize a string into a Person object.
var person = JsonConvert.Deserialize<Person>(json);
```

```csharp
using System.Runtime.Serialization;

[DataContract]
public class Person
{
    [DataMember]
    public string FullName { get; set; }

    [DataMember]
    public Dictionary<string, string> Attributes { get; set; }
}
```

Hope this saves someone a minute or two!
