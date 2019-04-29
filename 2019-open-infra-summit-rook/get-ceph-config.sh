#!/usr/bin/env bash

toolbox_pod="$(kubectl --namespace rook-ceph get pods \
               --selector app=rook-ceph-tools \
               --output custom-columns=name:metadata.name --no-headers)"

kubectl --namespace=rook-ceph exec "${toolbox_pod}" -- \
  cat /etc/ceph/ceph.conf
