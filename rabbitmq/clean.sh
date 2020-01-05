oc delete pod rabbitmq
oc delete configmap rabbitmq
oc delete service openstack-rabbitmq
oc delete pvc rabbitmq
oc delete pv rabbitmq

# this one is created by mariadb as well?
#oc delete storageclass local-storage
