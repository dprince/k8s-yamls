set -x
oc delete datavolume upload-datavolume
sleep 3
oc delete pv cdi-dell0-0
oc delete pv cdi-dell0-1
oc delete storageclass cdi-dell0
#oc delete pv cdi-dell0-scratch
#oc delete storageclass cdi-dell0-scratch
