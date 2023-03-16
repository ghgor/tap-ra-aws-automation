#!/bin/bash
# Copyright 2022 VMware, Inc.
# SPDX-License-Identifier: BSD-2-Clause

set -e
CWD=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "${CWD}/var.conf"

chmod +x ${CWD}/tanzu-essential-setup.sh
chmod +x ${CWD}/tap-repo.sh
chmod +x ${CWD}/tap-view-profile.sh
chmod +x ${CWD}/tap-dev-namespace.sh
chmod +x ${CWD}/eks-csi.sh

chmod +x ${CWD}/var-input-validatation.sh

${CWD}/var-input-validatation.sh

echo  "VIEW Cluster - Login and check AWS EKS CSI Driver"
${CWD}/eks-csi.sh -c $TAP_VIEW_CLUSTER_NAME

#kubectl config get-contexts
#read -p "Select Kubernetes context of view cluster: " target_context
#kubectl config use-context $target_context
echo "Step 1 => installing tanzu cli and tanzu essential in VIEW cluster !!!"
${CWD}/tanzu-essential-setup.sh
echo "Step 2 => installing TAP Repo in VIEW cluster !!! "
${CWD}/tap-repo.sh
echo "Step 3 => installing TAP VIEW  Profile !!! "
${CWD}/tap-view-profile.sh
echo "Step 4 => installing TAP developer namespace in VIEW cluster !!! "
${CWD}/tap-dev-namespace.sh