---
title: Creating nice JSON strings on PHP
date: 2013-11-03 00:00:00 +0000
categories: [Miscellaneous]
tags: [php, json, format]
seo:
  date_modified: 2020-03-17 00:40:12 +0000
---

Hello everyone!

I spent some valuable time last night, trying to create a reliable algorithm to merge two arrays, so I can use PHP's [`json_encode()`](http://php.net/manual/en/function.json-encode.php) for a simple logging class I'm writing, [Loggy](https://github.com/seckin92/loggy).

This morning, I found out that was unnecessary, turns out PHP's [`array_combine()`](http://php.net/manual/en/function.array-combine.php) method could've got it all covered.

Let's talk about the problem;

I had a `format` array, which has

```json
{ "ID", "ip", "message", "tag", "date" }
```

in it. I read some data from a file, it is separated by a certain pattern. I created an array using [`explode()`](http://php.net/manual/en/function.explode.php) :

```php
$entries = explode($separator, $line);
```

This produces an array like :

```json
{ "LGY_123456", "10.23.231.221", "This is a dummy message", "Foo", "03.11.2013 12:11" }
```

I wanted these two arrays to be transformed into key-value pairs.

My first approach was, to loop through the arrays using foreach and a counter; and create third array, which consumes more system resources and requires more time. The code follows.

```php
// Creating a third array to put my key-value pairs in.
$tmp = array();
// A counter to iterate through the format array.
$i = 0;
foreach($entries as $entry) {
    $tmp[$format[i]] = $entry;
    $i++;
}
$output = json_encode($tmp);
```

As you see, the code looks messy and it's a long way to go, looping through all the contents.

Now, I'm using [`array_combine()`](http://php.net/manual/en/function.array-combine.php) to do all that, by one simple line:

```php
$output = json_encode(array_combine($format, $entries));
```

That's all of it! Faster, reliable and clean-looking code.