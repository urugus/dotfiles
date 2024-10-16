
#!/bin/bash

set -ue


#--------------------------------------------------------------#
##          Functions                                         ##
#--------------------------------------------------------------#

function helpmsg() {
  print_default "Usage: ${BASH_SOURCE[0]:-$0} [install | update | link] [--with-gui] [--help | -h]" 0>&2
  print_default "  install: add require package install and symbolic link to $HOME from dotfiles [default]"
  print_default "  update: add require package install or update."
  print_default "  link: only symbolic link to $HOME from dotfiles."
  print_default ""
}

#--------------------------------------------------------------#
##          main                                              ##
#--------------------------------------------------------------#

function main() {
  local current_dir
  current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
  source $current_dir/lib/dotinstaller/utilfuncs.sh

  local is_link="false"
  local is_install="false"
  local is_update="false"

  while [ $# -gt 0]; do
    case ${1} in
      --help | -h)
        helpmsg
        exit 1
        ;;
      install)
        is_install="true"
        is_link="true"
        ;;
      update)
        is_update="true"
        ;;
      link)
        is_link="true"
        ;;
      *)
        print_error "[ERROR] Invalid arguments '${1}'"
        helpmsg
        exit 1
        ;;
    esac
    shif
  done

  # default befavior
  if [[ "$is_link" == false && "$is_install" == false ]]; then
    is_link="true"
    is_install="true"
    is_update="false"
  fi

  # is_install: true
  if [[ "$is_install" = true ]]; then
    # install fonts
    source $current_dir/lib/dotsinstaller/install-fonts.sh
    # install libraries & GUI Apps
    brew file install
  fi

  # is_update: true
  if [[ "$is_update" = true ]]; then
    brew file update
  fi

  # is_link: true
  if [[ "$is_link" = true ]]; then
    # Add Symbolic Link
    source $current_dir/lib/dotsinstaller/link-to-homedir.sh
    # Set git config
    source $current_dir/lib/dotsinstaller/gitconfig.sh
    print_info ""
    print_info "#####################################################"
    print_info "$(basename "${BASH_SOURCE[0]:-$0}") link success!!!"
    print_info "#####################################################"
    print_info ""
  fi
}

main "$@"
