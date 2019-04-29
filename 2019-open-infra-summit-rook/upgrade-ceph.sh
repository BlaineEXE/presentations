#!/usr/bin/env bash

kubectl --namespace=rook-ceph patch --type=merge CephCluster rook-ceph \
    --patch='{"spec": {"cephVersion": {"image": "ceph/ceph:v14.2"}}}'
