kubelunch
=========

Run on Fedora 24, get a Kubernetes development environment.

    KUBELUNCH_FQDN=localhost ./kubelunch.sh

You can run kubelunch also remotely, just specify appropriate
`KUBELUNCH_FQDN` and make sure Ansible can log into the machine as
root.

After the kubelunch playbook finishes running, log in as
`kube` user into the machine, and run:

    # inspect these and tweak if desired
    source gimmerc
    source kuberc

    cd kubernetes
    make quick-release
    ./cluster/kube-up.sh

This will give you a multi-node Kubernetes development cluster, using
Vagrant as the management tool.


Local image registry
--------------------

To run a local image registry on the host, run kubelunch with:

    ./kubelunch.sh -e install_docker_registry=yes


Kolla
-----

To clone Kolla repo on the host, run kubelunch with:

    ./kubelunch.sh -e install_kolla_source=yes
