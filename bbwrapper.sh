#!/usr/bin/env bash

set -e -o pipefail

gitroot="$(git rev-parse --show-toplevel)"

# https://stackoverflow.com/a/28776166/2200540
if (return 0 2>/dev/null); then
  sourced=1
  # Prevent calling shell from getting closed on error
  set +e
else
  sourced=0
fi

# If BitBake (and therefore the build directory) was not set up before, then do it now.
if ! type bitbake >/dev/null 2>&1; then
  TEMPLATECONF="${gitroot}/meta-gardena/conf"
  export TEMPLATECONF
  source openembedded-core/oe-init-build-env build
fi

if [ ${sourced} -ne 1 ]; then
  exec bitbake "${@:1}"
fi
