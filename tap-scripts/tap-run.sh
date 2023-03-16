#!/bin/bash
# Copyright 2022 VMware, Inc.
# SPDX-License-Identifier: BSD-2-Clause

set -e

CWD=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "${CWD}/var.conf"

chmod +x ${CWD}/tanzu-essential-setup.sh
chmod +x ${CWD}/tap-repo.sh
chmod +x ${CWD}/tap-run-profile.sh
chmod +x ${CWD}/tap-dev-namespace.sh
chmod +x ${CWD}/eks-csi.sh

chmod +x ${CWD}/var-input-validatation.sh

${CWD}/var-input-validatation.sh

echo  "RUN Cluster - Login and check AWS EKS CSI Driver"
${CWD}/eks-csi.sh -c $TAP_RUN_CLUSTER_NAME

echo "Step 1 => installing tanzu essential in RUN cluster !!!"
${CWD}/tanzu-essential-setup.sh
echo "Step 2 => installing TAP Repo in RUN cluster !!! "
${CWD}/tap-repo.sh
echo "Step 3 => installing TAP RUN Profile !!! "
${CWD}/tap-run-profile.sh
echo "Step 4 => installing TAP developer namespace in RUN cluster !!! "
${CWD}/tap-dev-namespace.sh