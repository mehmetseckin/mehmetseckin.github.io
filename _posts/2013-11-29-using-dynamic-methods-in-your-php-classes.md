---
title: Using dynamic methods in your PHP Classes
meta: 2013-11-29 00:00:00 +0000
categories: [Miscellaneous]
tags: [php, dynamic, getter, setter]
---

Hello all!

I was just trying to design an object oriented PHP interface to handle basic CRUD operations in a PostgreSQL Database, and I came up with the idea of using dynamic methods to call the stored procedures. I'll try to explain what I did here, and how.


I have a test database which has an `employees` table in it; and a stored procedure called `addEmployee`, with the arguments `name`, `salary`, and `hire_date`. This procedure returns true if the new record was successfully added to the table.

What I want to achieve was to be able to call this stored procedure directly from PHP, and see what it returns to me. Let's assume we have an `Engine` class that connects to the database automatically. I wanted to do something like this:

```php
$engine = new Engine();

$name = "Mehmet Seckin";
$salary = 5600;
$hired = "2013-12-20";

// Adding "Mehmet Seckin"
$engine->addEmployee($name, $salary, $hired);
// Loading a single boolean result.
$result = $engine->loadBoolean();
```

After a quick google search, i found out PHP (> 5.0.1) has a nice overloading method named ``__call()`. This method lets you overload ANY method that is called from your class, which is just what i wanted to do.

`__call()` takes two arguments, and these are `$method`, and `$arguments`; which are speaking for themselves.

Now, when we call a non-existent method;

```php
$myObject->foo("bar","goo");
```

Our `__call()` method takes over. `$method` stands for the method name (`foo`), and `$arguments` is an array containing the arguments (`foo` and `bar`).

So, I overloaded the `__call()` method like this:
```php
function __call($method,$arguments) {
    
    $query = "SELECT "$method"(";
    foreach($arguments as $argument) {
        $query .= "'$argument',";
    }
    
    if(count($arguments) > 0) {
        // Remove the extra comma
        $query = substr($query, 0, strlen($query)-1);
    }
    
    $query .= ");";
    //...
    // Execute query and return the results.
}
```

And I was able to call any stored procedure directly within PHP, no queries, no `fetch_array`s, no trouble…

Feel free to check the actual [source code](https://github.com/seckin92/phostgre).
