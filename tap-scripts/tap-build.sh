#!/bin/bash
# Copyright 2022 VMware, Inc.
# SPDX-License-Identifier: BSD-2-Clause

set -e
CWD=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "${CWD}/var.conf"

chmod +x ${CWD}/tanzu-essential-setup.sh
chmod +x ${CWD}/tap-repo.sh
chmod +x ${CWD}/tap-build-profile.sh
chmod +x ${CWD}/tap-dev-namespace.sh
chmod +x ${CWD}/eks-csi.sh

chmod +x ${CWD}/var-input-validatation.sh

${CWD}/var-input-validatation.sh

echo  "BUILD Cluster - Login and check AWS EKS CSI Driver"
${CWD}/eks-csi.sh -c $TAP_BUILD_CLUSTER_NAME

echo "Step 1 => installing tanzu essential in BUILD Cluster !!!"
${CWD}/tanzu-essential-setup.sh
echo "Step 2 => installing TAP Repo in BUILD Cluster !!! "
${CWD}/tap-repo.sh
echo "Step 3 => installing TAP Build Profile !!! "
${CWD}/tap-build-profile.sh
echo "Step 4 => installing TAP developer namespace in BUILD Cluster !!! "
${CWD}/tap-dev-namespace.sh