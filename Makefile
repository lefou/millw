.PHONY: help # List of targets with descriptions
help:
	@grep '^.PHONY: .* #' Makefile | sed 's/\.PHONY: \(.*\) # \(.*\)/\1\t\2/' | expand -t20

.PHONY: check # Run various checks, e.g. shellcheck
check: shellcheck downloadcheck

.PHONY: clean # Cleanup temporary output files
clean:
	rm -rf -- "./out"

.PHONY: shellcheck # Check for issues in the shell script
shellcheck:
	shellcheck millw

.PHONY: downloadcheck # Try to download some Mill binaries
downloadcheck:
	for VER in 0.6.0 0.7.0 0.8.0 0.9.3 0.10.0 0.11.0-M8 0.11.0 ; do \
	  echo "Testing Mill $${VER} ..." ; \
	  rm -rf -- "./out/mill-worker*" ; \
	  MILL_DOWNLOAD_PATH=./out/download MILL_VERSION=$${VER} sh -e -x ./millw -i --help || exit 1; \
	done
