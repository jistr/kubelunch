#!/bin/bash

set -euo pipefail

DIR=$(cd $(dirname "$BASH_SOURCE[0]") && pwd)
source "$DIR/lib/common.sh"

KUBELUNCH_HOSTS=${KUBELUNCH_HOSTS:-"$DIR/tmp/hosts.$KUBELUNCH_FQDN"}
KUBELUNCH_PLAYBOOK=${KUBELUNCH_PLAYBOOK:-playbooks/kubelunch.yml}

remove_hosts_file_if_temporary "$KUBELUNCH_HOSTS"
generate_hosts_file "$KUBELUNCH_HOSTS"

ansible-playbook \
    -i "$KUBELUNCH_HOSTS" \
    "$@" \
    "$KUBELUNCH_PLAYBOOK"

remove_hosts_file_if_temporary "$KUBELUNCH_HOSTS"
