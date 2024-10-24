#!/bin/bash

set -ue

#--------------------------------------------------------------#
##          Functions                                         ##
#--------------------------------------------------------------#

function helpmsg() {
  print_default "Usage: ${BASH_SOURCE[0]:-$0} [--help | -h] [--install | -i] [--update | -u]" 0>&2
  print_default ""
}

#--------------------------------------------------------------#
##          main                                              ##
#--------------------------------------------------------------#

function main() {
  local current_dir
  local current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
  source "${current_dir}"/install_scripts/lib/dotinstaller/utilfuncs.sh

  local is_install="false"
  local is_update="false"

  while [ $# -gt 0 ]; do
    case ${1} in
      --help | -h)
        helpmsg
        exit 1
        ;;
      --install | -i)
        is_install="true"
        ;;
      --update | -u)
        is_update="true"
        ;;
      *)
        print_error "[ERROR] Invalid arguments '${1}'"
        helpmsg
        exit 1
        ;;
    esac
    shift
  done

  # install
  if [[ "$is_install" = true ]]; then
    # dotinstaller
    "${current_dir}"/install_scripts/dotinstaller.sh
    print_info ""
    print_info "#####################################################"
    print_info "$(basename "${BASH_SOURCE[0]:-$0}") install finish!!!"
    print_info "#####################################################"
    print_info ""

    # Mac setup
    "${current_dir}"/install_scripts/setup-mac.sh
    print_info ""
    print_info "#####################################################"
    print_info "Mac setup finish!!!"
    print_info "#####################################################"
    print_info ""
  fi

  # update
  if [[ "$is_update" = true ]]; then
    "${current_dir}"/install_scripts/dotinstaller.sh update
    print_info ""
    print_info "#####################################################"
    print_info "update finish!!!"
    print_info "#####################################################"
    print_info ""
  fi

}

main "$@"
