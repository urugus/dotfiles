#!/usr/bin/env bash

# Composite pipeline runner.
#
# A "step" is a leaf shell script in ./steps/NAME.sh that performs a single
# idempotent setup action. A "pipeline" is an ordered list of step names;
# run_pipeline executes each as a subprocess so steps stay isolated and any
# failure (set -e) halts the pipeline.
#
# This is the Composite pattern applied to shell: leaves and composites share
# the same invocation shape ("run a step by name"), letting dotinstaller.sh
# compose OS-specific flows from the same palette of leaves.

set -ue

PIPELINE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
STEPS_DIR="$PIPELINE_DIR/steps"

source "$PIPELINE_DIR/utilfuncs.sh"

run_step() {
  local name="$1"
  local script="$STEPS_DIR/$name.sh"
  if [[ ! -f "$script" ]]; then
    print_error "unknown step: $name (expected $script)"
    return 1
  fi
  print_info ""
  print_info "==> step: $name"
  bash "$script"
}

run_pipeline() {
  local step
  for step in "$@"; do
    run_step "$step"
  done
}
