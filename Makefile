.PHONY: clean doctor help serve
.DEFAULT_GOAL := help

clean:
	bundle exec jekyll clean
doctor:
	bundle exec jekyll doctor

help:
	bundle exec jekyll help

serve:
	bundle exec jekyll serve --livereload --port 10101 --strict_front_matter --trace
