# TODOS

Just a personal list of things todo for this repo/project/blog


## 2020-11-16
- added webbrowser opening to makefile
- footer has proper links

## 2020-10-30

- Added tk-status logic
- fixed post/default layout inheritance (i.e. repeating headlines)
- Right now, homepage lists all of my posts. In the future, I should create a link to the fullindex
- post.html template should show tag links
- homnepage.md should be homepage.html (though that creates naming confusion with layouts/homepage.html)

## 2020-10-03
- Set a style for all `<img>` with a post/page's content body:
    - should be 100% in sm/lg
    - should have a max-width/height when view is lg/xl, and then centered
    - should have a faint border to make it obvious there's an image, especially when the image has a background as white as the blog post
    - create a `free-range` class for images that are meant to be very large and unbordered

- figure out a way to set image urls as relative without having to do the clunky `| relative_url` filter each and every time.



# TILs


- 2020-11-11: 
    - learned how to use smartquotes_action sphinx config
        - https://www.sphinx-doc.org/en/master/usage/configuration.html#confval-smartquotes
        - https://github.com/docutils-mirror/docutils/blob/master/docutils/utils/smartquotes.py
        - smartquotes_action = "qe"
    - ansi2html is what jsvine uses to embed attractive HTML display in his sphinx:
        - https://jsvine.github.io/intro-to-visidata/
        - https://github.com/pycontribs/ansi2html
    - use str.casefold() and unicodedata.normalize (i.e. Unicode database) for bigger unicode normalization
        - page 176 of Fluent Python
        - https://docs.python.org/3/library/stdtypes.html#str.casefold
        - https://docs.python.org/3/library/unicodedata.html
        - 
- [ ] Python: size = os.get_terminal_size()
- [ ] Python: intermixed args: https://docs.python.org/dev/library/argparse.html#argparse.ArgumentParser.parse_intermixed_args
- AWS: you can't let an IAM user have access to a limitedlist of buckets
- Python/boto3/testing: how to stub test requests
- Python: the point of using TypeVar and generics: https://google.github.io/styleguide/pyguide.html#typing-type-var
- Python: TypeOptional: https://docs.python.org/3/library/typing.html#typing.Union
    - instead of Union[str, None]
- 2020-10-12:
    - Python annotated variables in 3.6: https://docs.python.org/3/whatsnew/3.6.html#whatsnew36-pep526
    - Google recs: https://google.github.io/styleguide/pyguide.html#221-type-annotated-code
    - btw google has a really nice style guide
