K8s YAMLs
=========

Description
-----------

Some Yamls I created to mock up RDO services for OpenStack on OpenShift. These are currently hard coded to my environment and meant to act as a POC only.


Target Environment
------------------

Baremetal OpenShift 4.2 install.
Three OpenShift masters: dell0, dell1, dell2
Two OpenShift workers:  nuc1, nuc2 (what happened to nuc0!?)

The templates are using local directories on nuc1 for storage ATM (until I get a proper cloud storage setup). This means there are some hard coded aspects regarding the storage parts.

MariaDB
-------
Single Pod Galara DB install meant to act as a dev backend for developing other OpenStack services. Uses storage on nuc1's /var/lib/mysql directory.

To install:
1. (ssh to nuc1, mkdir -p /var/lib/mysql)
2. oc create -f mariadb/storage.yaml
3. oc create -f mariadb/mariadb.yaml

RabbitMQ
--------
Single Pod RabbitMQ install meant to act as a dev backend for developing other OpenStack services. Uses storage on nuc1's /var/lib/rabbitmq directory.

To install:
1. (ssh to nuc1, mkdir -p /var/lib/rabbitmq)
2. oc create -f rabbitmq/storage.yaml
3. oc create -f rabbitmq/rabbitmq.yaml

Keystone
--------
Outdated. This is now supplanted by: https://github.com/openstack-k8s-operators/keystone-operator

Neutron
-------

Nova
----
