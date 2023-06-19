DOWNLOAD_VERSIONS = 0.6.0 0.7.0 0.8.0 0.10.0 0.11.0-M8 0.11.0
DOWNLOAD_CHECK_TARGETS = $(addprefix downloadcheck_,$(DOWNLOAD_VERSIONS))
.PHONY: $(DOWNLOAD_VERSIONS) $(DOWNLOAD_CHECK_TARGETS)
MILL := ./millw

.PHONY: help # List of targets with descriptions
help:
	@grep '^.PHONY: .* #' Makefile | sed 's/\.PHONY: \(.*\) # \(.*\)/\1\t\2/' | expand -t20

.PHONY: check # Run various checks, e.g. shellcheck
check: shellcheck downloadcheck

.PHONY: clean # Cleanup temporary output files
clean:
	$(RM) -rf -- "./out"

.PHONY: shellcheck # Check for issues in the shell script
shellcheck:
	shellcheck millw

.PHONY: downloadcheck # Try to download some Mill binaries
downloadcheck: $(DOWNLOAD_CHECK_TARGETS)

$(DOWNLOAD_CHECK_TARGETS):
	$(RM) -rf -- "./out/mill-worker*"
	MILL_DOWNLOAD_PATH=./out/download MILL_VERSION=$(subst downloadcheck_,,$@) sh -e -x $(MILL) -i --help
