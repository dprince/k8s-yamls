openstack user create --domain default --password CAspTtEy7vjtzbpvPLJThLJ4b neutron
openstack role add --project service --user neutron admin
openstack service create --name neutron --description "OpenStack Network" network
openstack endpoint create --region RegionOne network public http://openstack-neutron-test.apps.test.dprince/
openstack endpoint create --region RegionOne network internal http://openstack-neutron-test.apps.test.dprince/
openstack endpoint create --region RegionOne network admin http://openstack-neutron-test.apps.test.dprince/
