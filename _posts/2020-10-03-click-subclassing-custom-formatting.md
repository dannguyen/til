---
title:  How to subclass Click classes and formatting to create more helpful CLIs (TK)
date:   2020-10-03 15:15:00 -0500
categories:
    - python
    - command-line
    - Click
---

TKTK

Lorem ipsum, dolor sit amet consectetur adipisicing elit. Dolorum consectetur nostrum eaque nesciunt officia, ipsa maxime vel sequi quibusdam voluptatem. Unde id cumque et perspiciatis dolorum impedit saepe, commodi enim.


```py
class MyCliHelpFormatter(click.formatting.HelpFormatter):
    def write_lined_heading(self, heading):
        """
        Writes a heading into the buffer, sans trailing colon, e.g.        
            ────────────────
            My section title
            ────────────────
        """
        sep = "".join("─" for i in range(self.width))
        self.write(f"{'':>{self.current_indent}}{sep}\n")
        self.write(f"{'':>{self.current_indent}}{heading}\n")
        self.write(f"{'':>{self.current_indent}}{sep}\n")

```

Then, override `click.Context.make_formatter()`; instead of:

```py
class MyCliContext(click.Context):
    def make_formatter(self):
        # self.formatter_class isn't accessible in Click < 8.0
        # return self.formatter_class(
        return MyCliHelpFormatter(
            width=self.terminal_width, max_width=self.max_content_width
        )
```
