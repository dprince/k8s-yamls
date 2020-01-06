#oc delete replicationcontroller mysql
#oc delete service mysql
#oc delete storageclass my-local-storage
#oc delete persistentvolumeclaims claim-mysql
#oc delete pv local-volume

oc delete pod keystone
oc delete configmap keystone-config-map
oc delete service keystone
