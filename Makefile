.PHONY: clean doctor help serve
.DEFAULT_GOAL := help

clean:
	bundle exec jekyll clean
doctor:
	bundle exec jekyll doctor

help:
	bundle exec jekyll help

serve:
	@echo Open a browser at:
	@echo open http://127.0.0.1:4567

	bundle exec jekyll serve --livereload --port 4567 --strict_front_matter --trace
