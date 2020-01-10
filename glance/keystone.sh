openstack user create --domain default --password CAspTtEy7vjtzbpvPLJThLJ4b glance
openstack role add --project service --user glance admin
openstack service create --name glance --description "OpenStack Image" image
openstack endpoint create --region RegionOne image public http://openstack-glance-test.apps.test.dprince/
openstack endpoint create --region RegionOne image admin http://openstack-glance-test.apps.test.dprince/
openstack endpoint create --region RegionOne image internal http://openstack-glance/
