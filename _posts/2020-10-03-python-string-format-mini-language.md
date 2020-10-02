---
layout: post
title:  That Python has a mini-language for string formatting, including right-align
date:   2020-10-02 15:15:00 -0500
categories:
    - python
---


https://docs.python.org/3/library/string.html#format-specification-mini-language


When trying to muck with the Click HelpFormatter subclass, I noticed something in its [write_heading()](https://click.palletsprojects.com/en/7.x/api/#click.HelpFormatter.write_heading) method:

```py
    def write_heading(self, heading):
        """Writes a heading into the buffer."""
        self.write(f"{'':>{self.current_indent}}{heading}:\n")
```
Specifically, the use of `:>`

```py
f"{'':>{some_int}}"
```

(`current_indent`/`some_int` is an integer value)


TKTK

So this is equivalent:

```py
hed = "My title"
f'{hed.rjust(20)}'
>>> '            My title'

'{:>20}'.format(hed)
>>> '            My title'
```

TKTK
