---
published: true
title: From Python to Scala - Variables
categories: [Python, Scala]
---

![Scala](/assets/images/scala_logo.png?raw=true){: .center-image }

## Introduction
Python is a beautiful, high-level programming language. I've solved innumerable problems with it over the years, so I have a particular fondness for its abilities. However, no tool is perfect for everything. Each has its strengths and each has its weaknesses. Part of Python's power comes from its object-oriented construction. With it, you can do some pretty amazing things. However, functional programming has proven itself a powerful tool for massive scale systems. Therefore, it is time to move beyond Python to the wonderful world of Scala.

Scala is short for **Scalable Language**. It is a hybrid language that melds object-oriented structures and functional programming. Basically, it gives you the best of both worlds. Therefore, what follows is a series that will take you on a journey from Python to Scala. I hope you find it helpful!

## Lesson 1: Variables
Our first lesson is variables. In Python, saving a value to a variable is dead simple. It looks like this:
```
myString = "this is a string"
myInt = 42
myFloat = 4.2
```
Python automatically infers the type of each variable. For example, the variable `myString` is saved as a string object. Python knows it's a string because of the quotes around the text *this is a string*. You could just as easily have saved `"42"` or even `'42'`. That too would have been saved as a string object. The advantage is obvious: it takes no effort (and no thought) on the part of the user to save variables. The result is clean, easy to read code. 

With Scala, you can do the same with only a minor change. Let's take a look:
```
var myString = "this is a string"
var myInt = 42
var myFloat = 4.2
```
Notice the `var` in front of the variables here. That's important. Scala has the same ability to infer data types, same as Python, but you're giving Scala additional information. It turns out you must provide this information to Scala or else an error is thrown. Try running this bit of code:
```
myString2 = "this is a string"
```
See what I mean?

Should you feel the need to be explicit, Scala has your back:
```
var myString: String = "this is a string"
var myInt: Int = 42
var myFloat: Double = 42
```
Now if I want to change `myString` to `"string string string"`, `myInt` to `99`, and `myFloat` to `3.14`, it's as simple as:
```
myString = "string string string"
myInt = 99
yFloat = 3.14
```
This is all basic stuff. There's almost no difference from Python. But wait, there's more. Scala gives you an alternative way to reference objects. Check this out:
```
val myStaticString = "you cannot reassign myStaticString"
val myStaticInt: Int = 12345
val myStaticFloat: Double = 2.71828
```
Ok, what's the difference between `var` and `val`? Try to reassign `myStaticString`, `myStaticInt`, or `myStaticFloat`. 

Run these commands in the interpreter:
```
myStaticString = "try to reassign me, I dare you"
myStaticInt: Int = 1010101011
myStaticFloat: Double = 1.2121210
```
Didn't work did it? Therein lies the difference. `var` lets you reassign while `val` does not. `val` is a great way to guarantee you don't experience unwanted side effects in your code if you want to ensure a reference object never changes. You get a guarantee! How awesome is that?! 

A quick side tangent. You can assign a new reference object if you include `val` at the beginning like this:
```
val myStaticString = "try to reassign me, I dare you"
val myStaticInt: Int = 1010101011
val myStaticFloat: Double = 1.2121210
```
So be careful. If you're clumsy with your code, Scala can't save you.

# Summary
What did we learn today? We learned Python is beautifully simple while Scala is simply beautiful. And we took our first baby step into Scala by leveraging our knowledge of Python. Scala has the same ability to infer object types when saving variables just like Python. The key difference is that Scala requires this thing called a *predicate* that can take the form `var` or `val`. We learned the difference between `var` and `val` is that the former can be reassigned whereas the latter can not. We also learned that if you write sloppy code, well, then that's on you because no programming language is going to save your ass. 
