Rook :  A new and easy way to run your Ceph storage on Kubernetes
==================================================================

Some links
-----------
- Rook website: https://rook.io
- Rook GitHub: https://github.com/rook/rook

> TODO: add link to presentation video once it is live

Try out Rook yourself
----------------------
This directory contains configuration files used to set up the OpenStack and Rook clusters used in
the presentation's demo. Take a look at the presentation slides for an idea of what the demo setup
was and what you can expect the demo to do.

> TODO: print PDF of slides after presentation for this repo

## Prerequisites
- A Kubernetes cluster with at least 3 schedulable nodes for Rook to use
  - At least 3 of the Kubernetes nodes should have at least one blank volume attached
  - Kubernetes installation isn't part of this guide
    - [kubeadm](https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/) is a good
      starting place
- An additional node for OpenStack (set up by DevStack) connected to the same network as the
  Kubernetes nodes
  - Our OpenStack node had 2 network interfaces both connected to the same network

## Quick instructions
1. Copy these repo files or clone this repo to the system where `kubectl` can be ran from for the
   Kubernetes cluster
2. Run the following command to install Rook's base components and the Rook Ceph operator
   - ```kubectl create -f common.yaml -f operator.yaml```
3. Check that the `rook-ceph-operator-...` pod is running in the `rook-ceph` namespace
   - ```kubectl -n rook-ceph get pods```
4. Run the following command to define the Ceph cluster for Rook to deploy and to create the toolbox
   pod which is used to interface with Ceph via CLI.
   - ```kubectl create -f cluster.yaml -f toolbox.yaml```
5. Wait for all of your expected Ceph osds to be running in kubernetes
   - ```watch kubectl -n rook-ceph get pods```
   - If you have 5 nodes with 3 disks each, for example, you are waiting to see a running OSD pod
     with the name `rook-ceph-osd-14-...`

> Still a WIP
