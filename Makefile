bootstrap:
	@make venv
	@make project
	@make workspace

workspace:
	@make _run module=Scripts.generate_xcworkspace

project:
	@make _run module=Scripts.generate_xcodeproj

venv:
	@rm -rf scripts/.venv
	@cd scripts && python3 -m venv .venv

_run:
	@chmod +x $(CURDIR)/Scripts/.venv/bin/activate && $(CURDIR)/Scripts/.venv/bin/activate
	@chmod +x "$(CURDIR)/Scripts/.venv/bin/python" && "$(CURDIR)/Scripts/.venv/bin/python" -m $(module)
