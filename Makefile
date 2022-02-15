.PHONY: help # List of targets with descriptions
help:
	@grep '^.PHONY: .* #' Makefile | sed 's/\.PHONY: \(.*\) # \(.*\)/\1\t\2/' | expand -t20

.PHONY: check # Run various checks, e.g. shellcheck
check:
	shellcheck millw
