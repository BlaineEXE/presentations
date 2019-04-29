#!/usr/bin/env bash

toolbox_pod="$(kubectl --namespace rook-ceph get pods \
               --selector app=rook-ceph-tools \
               --output custom-columns=name:metadata.name --no-headers)"

kubectl --namespace=rook-ceph exec "${toolbox_pod}" -- \
  ceph auth get-or-create client.glance \
    mon "allow r" \
    osd "allow class-read object_prefix rdb_children, allow rwx pool=images" \
  -o- > /tmp/ceph.client.glance.keyring
cat /tmp/ceph.client.glance.keyring

kubectl --namespace=rook-ceph exec "${toolbox_pod}" -- \
  ceph auth get-or-create client.cinder \
    mon "allow r" \
    osd "allow class-read object_prefix rdb_children, allow rwx pool=volumes" \
  -o- > /tmp/ceph.client.cinder.keyring
cat /tmp/ceph.client.cinder.keyring

kubectl --namespace=rook-ceph exec "${toolbox_pod}" -- \
  ceph auth get-or-create client.nova \
    mon "allow r" \
    osd "allow class-read object_prefix rdb_children, allow rwx pool=vms" \
  -o- > /tmp/ceph.client.nova.keyring
cat /tmp/ceph.client.nova.keyring
