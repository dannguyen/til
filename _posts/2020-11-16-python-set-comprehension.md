---
title:  How to make a Python set without set()
description: |
    Sets have a comprehension syntax just like lists and dicts, and can also be instantiated with curly braces
date:   2020-11-16 11:00:00
categories:
    - python
    - basics
---


## tl;dr

via the [data structures tutorial in the Python docs](https://docs.python.org/3/tutorial/datastructures.html#sets), this is a **set** comprehension in Python: 

```py
names = {p.name for p in [people]}
```

Sets can also be instantiated with curly braces:

```py
names = {'Bob', 'Alice', 'Bob', 'Charlie', 'Alice'}
# {'Bob', 'Alice', 'Charlie'}
```

*However*, empty sets must be created with `set()`, as `{}` will create an empty **dict**.


## The context

For some reason I've treated Python sets as just an ancillary structure, and I end up using them so infrequently that I have to google the actual syntax because I'm unsure if its constructor is `Set()` (that's actually [Ruby](https://ruby-doc.org/stdlib-2.7.2/libdoc/set/rdoc/Set.html)) or if I need to import it via the [collections library](https://docs.python.org/3/library/collections.html). Turns out it's as easy and basic as it is for lists and dicts.

Credit goes to the fantastic book [Fluent Python](https://smile.amazon.com/Fluent-Python-Concise-Effective-Programming/dp/1491946008), by [Luciano Ramalho](https://github.com/ramalho), a book I bought years ago but continues to pay dividends even as I casually skim chapters. 

I noticed this basic Python syntax feature this morning when reading *Chapter 6: Design Patterns with First-Class Functions*, and actually taking time to read the code in Ramalho's detailed examples:

```py
class LargeOrderPromo(Promotion): # third Concrete Strategy 
  """7% discount for orders with 10 or more distinct items"""
    def discount(self, order):
        distinct_item = {item.product for item in order.cart}
        if len(distinct_items) >= 10:
            return order.total() * .07
        return 0
```

*Ramalho, Luciano. [Fluent Python: Clear, Concise, and Effective Programming (p. 177). O'Reilly Media. Kindle Edition](https://www.amazon.com/Fluent-Python-Concise-Effective-Programming/dp/1491946008).* 

