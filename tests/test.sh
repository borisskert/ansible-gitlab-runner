#!/bin/bash
set -e

vagrant up --provision

ansible-galaxy install -r requirements.yml -p ./roles --force

ansible-playbook -i inventory.ini test.yml --extra-vars "force_cert_creation=false"

ansible-playbook -i inventory.ini test.yml --extra-vars "force_cert_creation=false" \
  | grep -q 'changed=0.*failed=0' \
  && (echo 'Idempotence test: pass' && exit 0) \
  || (echo 'Idempotence test: fail' && exit 1)

vagrant destroy -f
