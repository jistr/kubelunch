#!/bin/bash

TEMPORARY_HOSTS_BANNER="# this is a temporary generated file, will be deleted"

if [ ! -v DIR -o -z "$DIR" ]; then
    echo "DIR env variable not set or zero length"
    exit 1
fi

function generate_hosts_file() {
    if [ -e "$1" ]; then
        echo "$1 exists, not overwriting."
    fi

    if [ ! -v KUBELUNCH_FQDN ]; then
        echo "Setting KUBELUNCH_FQDN (the host machine for k8s VMs) is mandatory."
        exit 1
    fi

    mkdir "$DIR/tmp" &> /dev/null || true
    echo "$TEMPORARY_HOSTS_BANNER" > "$1"
    echo "[kube_host]" >> "$1"
    echo "$KUBELUNCH_FQDN  ansible_ssh_user=root" >> "$1"
}

# removes hosts file if it contains $TEMPORARY_HOSTS_BANNER
# first argument is the hosts file to check and optionally remove
function remove_hosts_file_if_temporary() {
    if [ -z "$1" ]; then
        echo "get_hosts_file_path first argument has zero length"
        exit 1
    fi

    if grep "$TEMPORARY_HOSTS_BANNER" "$1" &> /dev/null; then
        rm "$1"
    fi
}
