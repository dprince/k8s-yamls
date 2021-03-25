unset OS_CLOUD
export OS_AUTH_TYPE=none
export OS_ENDPOINT=http://openstack-heat:8004/v1/admin

TEMPLATES_DIR=$HOME/tripleo-deploy-test/tripleo-heat-installer-templates
rm -Rf "$TEMPLATES_DIR"
mkdir $TEMPLATES_DIR

cp -a /usr/share/openstack-tripleo-heat-templates/* $TEMPLATES_DIR
pushd $TEMPLATES_DIR
python3 tools/process-templates.py -r /usr/share/openstack-tripleo-heat-templates/roles_data.yaml -n /usr/share/openstack-tripleo-heat-templates/network_data.yaml

openstack tripleo container image prepare default --output-env-file container-image-prepare.yaml
openstack tripleo container image prepare -e container-image-prepare.yaml -r roles_data.yaml --output-env-file=tripleo-overcloud-images.yaml

OS_AUTH_TYPE=none OS_ENDPOINT=http://openstack-heat:8004/v1/admin openstack stack delete overcloud --yes --wait

sleep 1

openstack stack list

#FIXME: need a way to generate the ~/tripleo-overcloud-passwords.yaml below
time openstack stack create --wait \
    -e $TEMPLATES_DIR/overcloud-resource-registry-puppet.yaml \
    -e $TEMPLATES_DIR/tripleo-overcloud-images.yaml \
    -e $TEMPLATES_DIR/environments/deployed-server-environment.yaml \
    -e $TEMPLATES_DIR/environments/docker-ha.yaml \
    -e ~/config/deployed-server-map.yaml \
    -e ~/config/hostnamemap.yaml \
    -e ~/config/mandatory.yaml \
    -e ~/config-custom/custom.yaml \
    -e ~/config-custom/glance-backend-nfs.yaml \
    -e ~/config-custom/network-environment.yaml \
    -e ~/tripleo-overcloud-passwords.yaml \
    -t overcloud.yaml overcloud

# FIXME: there is no local 'config-download' command in OSP 16
/usr/bin/python3 - <<"EOF_PYTHON"
from tripleoclient import utils as oooutils
from osc_lib import utils
API_NAME = 'tripleoclient'
API_VERSIONS = {
    '1': 'heatclient.v1.client.Client',
}
api_port='8004'
heat_client = utils.get_client_class(
    API_NAME,
    '1',
    API_VERSIONS)
client = heat_client(
    endpoint='http://openstack-heat:%s/v1/admin' % api_port,
    username='admin',
    password='fake',
    region_name='regionOne',
    token='fake',
)
oooutils.download_ansible_playbooks(client, 'overcloud', output_dir='/home/cloud-admin/ansible')
EOF_PYTHON
