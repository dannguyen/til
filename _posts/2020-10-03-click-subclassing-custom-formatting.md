---
title:  How to subclass Click classes and formatting to create more helpful CLIs
date:   2020-10-03 15:15:00 -0500
categories:
    - python
    - command-line
    - Click
status: tk
---

TKTK

I'm using Click to write a [command-line tool](https://github.com/dannguyen/csvviz) with a bunch of subcommands. Each subcommand has its own unique options, but also a lot of shared/common options. And I want to emphasize the unique options in each tool's help message. 




Luckily, Click has a fairly elegant system for subclassing custom functionality for commands, including the formatting of help text.

(TKTK will fill out later)

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



## My custom formatting results

After a few early stumbles – because I honestly liked writing non-OOP Python so much that even now I learn Pythonic OOP style on an ad-hoc basis – I was able to output custom sections and headers:


```

$ csvviz bar --help

Usage: csvviz bar [OPTIONS] [INPUT_FILE]

  An bar/column chart

──────────────────────────────────────────────────────────────────────────────
Options specific to `bar` command
──────────────────────────────────────────────────────────────────────────────
  -x, --xvar TEXT               The name of the column for mapping x-axis
                                values; if empty, the first (columns[0])
                                column is used

  -y, --yvar TEXT               The name of the column for mapping y-axis
                                values; if empty, the second (columns[1])
                                column is used

  -c, --colorvar TEXT           The name of the column for mapping bar colors.
                                This is required for creating a stacked chart.

  -cs, --color-sort [asc|desc]  For stacked bar charts, the sort order of the
                                color variable: 'asc' for ascending, 'desc'
                                for descending/reverse

  -xs, --x-sort TEXT            Sort the x-axis by the values of the x/y/fill
                                channel. Prefix with '-' to do reverse sort,
                                e.g. 'y' vs '-y'

  -H, --horizontal              Make a horizontal bar chart
  -N, --normalized              For stacked bar charts, normalize the total
                                bar heights to 100%

  --help                        Show this message and exit.

──────────────────────────────────────────────────────────────────────────────
Common options
──────────────────────────────────────────────────────────────────────────────

  Grid (i.e. faceted/trellis)
  ───────────────────────────
    -g, --grid TEXT              The name of the column to use as a facet for
                                 creating a grid of multiple charts

    -gc, --grid-columns INTEGER  Number of columns per grid row. Default is '0'
                                 for infinite.

    -gs, --grid-sort [asc|desc]  Sort the grid of charts by its facet variable
                                 in ascending or descending order.


  Chart visual styles and properties
  ──────────────────────────────────
    -C, --colors TEXT               A comma-delimited list of colors to use for
                                    the relevant marks

    -CS, --color-scheme TEXT        The name of a Vega color scheme to use for
                                    fill (this is overridden by -C/--colors)

    -H, --height INTEGER            The height in pixels for the chart
    --no-legend                     Omits any/all legends
    --theme [dark|default|fivethirtyeight|ggplot2|latimes|none|opaque|quartz|urbaninstitute|vox]
                                    Choose a built-in theme for chart
    -t, --title TEXT                A title for the chart
    -W, --width INTEGER             The width in pixels for the chart

  Axis
  ────
    --xlim TEXT  Set the min,max of the x-axis with a comma delimited string,
                 e.g. '-10,50'

    --ylim TEXT  Set the min,max of the y-axis with a comma delimited string,
                 e.g. '-10,50'


  Output and presentation
  ───────────────────────
    --interactive / --static  Produce an interactive (default) or static version
                              of the chart, in HTML+JS

    -j, --json / --no-json    Output to stdout the Vega JSON representation
    --no-preview, --np        By default, csvviz opens a web browser to show the
                              chart


  Example:        csvviz bar -x name -y amount data.csv

```


TK: include example of what this looked like before the custom formatting
