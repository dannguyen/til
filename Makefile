.PHONY: clean doctor help serve
.DEFAULT_GOAL := help


PORT = 4567
LOCAL_URL = http://127.0.0.1:$(PORT)

define BROWSER_PYSCRIPT
import webbrowser
webbrowser.open("$(LOCAL_URL)")
endef
export BROWSER_PYSCRIPT
BROWSER := python -c "$$BROWSER_PYSCRIPT"


clean:
	bundle exec jekyll clean
doctor:
	bundle exec jekyll doctor

help:
	bundle exec jekyll help

serve:
	@echo Opening $(LOCAL_URL)
	$(BROWSER)
	bundle exec jekyll serve --livereload --port $(PORT) --strict_front_matter --trace
