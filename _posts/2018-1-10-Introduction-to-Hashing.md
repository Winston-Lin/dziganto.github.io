---
published: true
title: An Introduction to Hashing
categories: [Computer Science, Data Science, Hashing, Machine Learning, Python]
---

![image](/assets/images/hashing.png?raw=true){: .center-image }

## Introduction
Unless your background is in Computer Science, **hashing** is likely one of those ubiquitous terms that you've heard but maybe don't quite understand. If that's the case, then this post is for you.

Imagine you run a company with 20,000 employees. Also imagine you have an up-to-date table called *Employees* that contains key personal information like first name, last name, address, salary, and so on. If you were to run a query to retrieve personal information for the employee with the last name *Ziganto*, how long would it take? 

Turns out it depends how you stored the table. If you stored it as a list of lists where your master list is the table and the sublists include key information about each individual employee, then your lookup time can be very long. How long exactly? You have to consider the worst case scenario. Here, there are 20,000 employees. Let's assume the table is sorted alphabetically by last name. Therefore, *Ziganto* is somewhere near the end, maybe even the last entry. The best we can do with this type of table is a *linear search*, meaning we check to see if the first entry for last name is *Ziganto*. If it is, great, we can stop. If not, move on to the next last name and check it. You keep doing this until you find the last name *Ziganto* or you exhaust your list. The worst case scenario is a full search of the table. If you're familiar with Big O notation, then you know the time complexity is O(n). 

Given modern computing systems, this process of searching 20,000 last names is not a big deal. But imagine you had millions or billions of values to search through. The search time grows linearly with the number of items, hence the term *linear search*. Clearly, this is not optimal. In fact, it's extraordinarily bad. 

The good news is that there's a MUCH better way to do this and it's called **hashing**.

First, a bit of terminology.

## Terminology
You should walk away from this post knowing what the following terms mean:
* hashing
* key
* hash key 
* hash function 
* collision 
* linear probing 
* chaining

### Definitions
**Hashing:** the conversion of a key to a numeric value with the goal of saving or returning a specific record in an array, table, database, etc.

**Key:** any unique, immutable value (e.g. string, integer, tuple) used in hashing.

**Hash Key:** the numeric value returned from a hash function.

**Hash Function:** the process of converting a key to a hash key.

> Note: Collision, linear probing, and chaining will be discussed later.

## Disclaimer
This is only an introduction to hashing. It's a jumping off point really. There are so many amazing things you can do with it but for now just get the general idea.

## Our Very Own Hash Function
The best way to learn about hash functions is to build our own. Let's create a little function called *hasher*. I'll explain what it does in a second.

```
import numpy as np

def hasher(key, num_slots):
    
    ```
    Simple hashing function that returns hash key.
    
    Input:
        key: (int or str) thing to hash
        num_slots: (int) number of memory slots to allocate
    Output:
        (int) hash key
    ```
    
    assert type(key) == int or type(key) == str, "key must be an integer or string!"
    assert type(num_slots) == int, "num_slots must be an integer!"
    
    if type(key) == int:
        return key % num_slots
    elif type(key) == str:
        # sum the ASCII values to convert string to integer
        str2int = [ord(char) for char in list(key)]
        return np.sum(str2int) % num_slots
```

The first bit in triple quotes is just a lengthy docstring. It explains the function parameters *key* and *num_slots* as well as the data types expected. It also describes the output of this function, which is an integer representing the hash key.

The assert statements are a quick and dirty way to ensure inputs are of the right type. Specifically, the *key* must be an integer or string while *num_slots* must be an integer. Otherwise an assertion error is thrown alerting the user to a problem.

Great, now on to the main logic. 

We start with a simple logical check to see if the *key* is an integer or string. If it's an integer, simply return ***key* mod *num_slots***. If it's a string, we need to first process the text to convert it into numbers. One way to do that is by simply parsing the string into individual characters, returning the ASCII integer for each character, summing all ASCII integers, and applying the mod function. That's precisely what's happening in our hasher function with `str2int = [ord(char) for char in list(key)]` and then `np.sum(str2int) % num_slots`. That's all there is to it.

## Example
Let's simulate a table called *Employees*. To keep things simple, *Employees* will only contain eight employees, not 20,000. The table has the following last names:
```
# employees last names
last_names = ['Eisenhower', 'Harding', 'Kennedy', 'Lincoln', 
              'Obama', 'Roosevelt', 'Washington', 'Ziganto']
```

The table itself is simulated as an array like so (note *num_slots*=8 here):
```
table = np.zeros(8).astype('int')
for i, name in enumerate(last_names, 1):
    table[hasher(name, 8)] = i
```

Printing the table gives us the output `[5 1 7 6 8 2 3 4]`. It's important to understand what those numbers mean because ultimately it describes how the hash function works. What happened in the code above is that we fed elements of our list called *last_names* into our function called *hasher*. The result is a hash key. The hash key simply says, when you feed *Eisenhower* into this particular hash faction, store/retrieve any associated data in/from memory block #5. When you feed *Harding* into this hash function, store/retrieve its associated data in/from memory block #1. The process continues until we reach the end, *Ziganto* in this case. So what the hash function does is it maps a key (i.e. last name) to a specific memory block where we can save or retrieve data. In other words, we've created a hash table. 

Remember our original goal was to retrieve data on *Ziganto*. How do we do that? Merely apply `hasher('ziganto', 8)`
which returns 4. This means the record for *Ziganto* is stored in the 4th index of our table. Notice the time complexity. It's constant or O(1). 

Ok, so we've got eight employees and we see that all the memory slots are full. 

**Question:** What happens if we try to add another name?

**Answer:** We get a collision.

A **collision** happens when two different keys map to the same memory block. It's not a problem for some situations, but often times it is. It's definitely problem in our scenario. We certainly don't want two different employees mapping to the same memory block. There'd be no way to keep their records separate given our discussion thus far. But there are ways to handle collisions. Let's look at them now.

### Addressing Collisions
What can we do about collisions?

1. Change divisor to a prime number
2. Increase divisor to create more memory blocks
3. Extend hashing by adding additional functionality

**Question #1:** Why would changing the divisor to a prime number help avoid collisions?

**Answer #1:** Because a prime is divisible only by itself and 1 so you do not have to worry about common factors.

### Quick Example
```
for i in range(8,88,8):
    print('index: {:2} | hash: {}'.format(i, hasher('hello world+', i)))
```

This code runs through the multiples of 8 for the divisor and prints the multiple called *index* as well as the hash key called *hash*. It's important to note that the *key* remains constant throughout. The primary goal is to show that even with the same *key*, we can control the number of collisions if we're smart about it. 

The output looks like this:
```
index:  8 | hash: 7
index: 16 | hash: 7
index: 24 | hash: 7
index: 32 | hash: 7
index: 40 | hash: 39
index: 48 | hash: 7
index: 56 | hash: 39
index: 64 | hash: 7
index: 72 | hash: 7
index: 80 | hash: 39
```

That's a lot of collisions. Not cool. 

Let's try that again with prime numbers.
```
for i in [7,11,13,17,19,23,29,31,37,41]:
    print('index: {:2} | hash: {}'.format(i, hasher('hello world+', i)))
```

Where the output is:
```
index:  7 | hash: 4
index: 11 | hash: 4
index: 13 | hash: 2
index: 17 | hash: 3
index: 19 | hash: 0
index: 23 | hash: 9
index: 29 | hash: 28
index: 31 | hash: 12
index: 37 | hash: 12
index: 41 | hash: 11
```

We still get two collisions in this case but there far fewer of them. We could easily correct this by using larger primes.

>**Side note:** You should clearly see how this relates to the **dictionary** data structure, which is nothing more than a hash table. It also explains why order is not **guaranteed**. If a collision occurs, the hash function is recomputed to create more memory slots. Therefore, a new hash function almost always leads to new indices for your initial data. 

**Question #2:** Why would changing the divisor to a larger number help avoid collisions?

**Answer #2:** Because a larger divisor allocates more memory slots, decreasing the probability of a collision.

>**Side note:** Your best bet is to use prime numbers, and if you run out of memory slots leading to collisions, use larger primes. That way you get the best of both worlds - no common factors and a large number of memory slots. 

**Question #3:** How can we extend hashing by adding additional functionality

**Answer #3:** There are ways to extend the hash function to handle collisions gracefully. Here, I will present two methods known as **linear probing** and **chaining**. By no means are they the only methods. However, they should give you some idea about how collisions can be handled. 

### Linear Probing
The idea of linear probing is simple. When a collision occurs, try the next memory slot. If that memory slot is empty, use it. If not, try the next and the next and the next until you find one that's open or until you've exhausted your search by checking all slots.

We'll need some code to automate this process. Here goes:
```
def updater(table, ix, value):
    
    ```
    Runs the linear search.
    
    Input: 
        table: numpy array initialized with all zeros the size of num_slots
        ix: (int) initial index to try
        value: (int) value to store
    ```
    
    while True:
        if np.all(table) != 0:
            print('all slots taken')
            break
        else:
            if table[ix] == 0:
                table[ix] = value
                break
            else:
                print('{} taken, linear searching...'.format(int(ix)))
                if ix+1 == table.size:  ## reset index if ix   
                    ix = 0               ## is last index value
                else:
                    ix += 1        
    return table
    
def linear_probe_hasher(table, value, key, num_slots):
    
    ```
    Input:
        table: numpy array initialized with all zeros the size of num_slots
        value: (int) value to store
        key: (int or str) thing to hash
        num_slots: (int) number of memory slots to allocate
    Output:
        (int) hash value
    ```
    
    assert len(table) == num_slots, "your table length does not match the number of slots!"
    assert type(key) == int or type(key) == str, "key must be an integer or string!"
    
    if type(key) == int:
        idx = key % num_slots
        return updater(table2, idx, value)
    elif type(key) == str:
        # sum the ASCII values to convert string to integer
        str2int = [ord(char) for char in list(key)]
        idx = np.sum(str2int) % num_slots
        return updater(table2, idx, 1)
```
The first function *updater* is a helper function that runs linear search. Simply put, *updater* checks to see if all memory slots are taken. If they are, it returns "all slots taken" and stops. If there's at least one opening, *updater* will check the slot provided by the hash key. If that slot is not available, it will check each memory slot in sequential order until it finds an open slot.

The second function *linear_probe_hasher* acts just like *hasher* from earlier. The only difference is that it leverages linear probing when a collision occurs.

Running *linear_probe_hasher* with several collisions should clarify what's going on.
```
table2 = np.zeros(5).astype('int')

keys = [99, 94, 94, 94, 94, 94, 94]
for i, key in enumerate(keys, 1):
    print('hash key: {}'.format(hasher(key=key, num_slots=5)))
    print('table:', linear_probe_hasher(table2, value=i, key=key, num_slots=5))
    print()
```

Output:
```
hash key: 4
table: [0 0 0 0 1]

hash key: 4
4 taken, linear searching...
table: [2 0 0 0 1]

hash key: 4
4 taken, linear searching...
0 taken, linear searching...
table: [2 3 0 0 1]

hash key: 4
4 taken, linear searching...
0 taken, linear searching...
1 taken, linear searching...
table: [2 3 4 0 1]

hash key: 4
4 taken, linear searching...
0 taken, linear searching...
1 taken, linear searching...
2 taken, linear searching...
table: [2 3 4 5 1]

hash key: 4
all slots taken
table: [2 3 4 5 1]

hash key: 4
all slots taken
table: [2 3 4 5 1]
```

You can see the procedure prevents additional collisions once all memory slots are taken.

### Chaining
Instead of sequentially searching through memory slots, chaining uses linked lists to append values in the same memory slot when collisions occur. Say we have a record for *David Ziganto*. Since we're merely using *Ziganto* as our key to lookup key personal information, we can easily have a collision if there's another employee with the same last name. Perhaps *Benjamin Ziganto* is also an employee. Therefore, two employees map to the same memory slot. Chaining allows us to keep their records separate even though they map to the same place. 
> **Side note:* Obviously, using first and last name as your key would be much more effective here but hopefully you get the idea behind chaining.
```
def chain_hasher(table, value, key, num_slots):
    
    ```
    Input:
        table: list of lists
        value: (int) value to store
        key: (int or str) thing to hash
        num_slots: (int) number of memory slots to allocate
    Output:
        (int) hash value
    ```
    
    assert len(table) == num_slots, "your table length does not match the number of slots!"
    assert type(key) == int or type(key) == str, "key must be an integer or string!"
    
    if type(key) == int:
        idx = key % num_slots
        
    elif type(key) == str:
        # sum the ASCII values to convert string to integer
        str2int = [ord(char) for char in list(key)]
        idx = np.sum(str2int) % num_slots
        
    return table[idx].append(value)
```

A bit of code to simulate populating the table. We'll round this out by creating a collision on purpose by passing the same key *abc* twice.

```
table3 = [[],[],[],[],[]]
keys = [0, 1, 'abc', 'abc']
for i, key in enumerate(keys,1):
    chain_hasher(table3, i, key, 5)
```  

Printing *table3* returns `[[1], [2], [], [], [3, 4]]`. You can see the 4 causes a collision but was handled gracefully. This is equivalent to storing information about two employees in the same record; however, it allows you to keep their records separate for updates or retrieval. It's certainly not elegant but it works in a pinch. 

## Now What?
This was just the beginning. I hope you have a high-level understanding of how hashing works and some basic use cases. If you found this interesting, take a look at other hashing strategies, other ways to handle collisions, and algorithms like MD5, SHA-1, and othe cryptographic hashes.

Happy hashing!
