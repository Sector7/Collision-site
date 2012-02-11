#!/bin/bash
PROFILE=collision

function run_cmd {
  if pushd "$2" > /dev/null; then
    if ! eval $1; then
      exit 1
    fi
    popd > /dev/null
  fi
}

function apply_patch {
  DEPTH=$(echo ${2}|sed 's/[^/]//g'|wc -m)
  PATCH_DIR="patches/";
  for i in $(seq 1 ${DEPTH}); do
    PATCH_DIR="../${PATCH_DIR}";
  done

  run_cmd "${2}" "git apply ${PATCH_DIR}${1}"
}

drush dl nodestream

run_cmd "ln -s ../../${PROFILE}_profile ${PROFILE}" "nodestream/profiles"
run_cmd "ln -s ../../nodestream/profiles/nodestream/modules/ modules" "${PROFILE}_profile/modules/"
run_cmd "ln -s ../../nodestream/profiles/nodestream/libraries/ libraries" "${PROFILE}_profile/modules/"
run_cmd "ln -s ../../nodestream/profiles/nodestream/themes/ themes" "${PROFILE}_profile/modules/"
