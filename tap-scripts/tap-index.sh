#!/bin/bash
# Copyright 2022 VMware, Inc.
# SPDX-License-Identifier: BSD-2-Clause

CWD=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo "scripts working dir: $CWD"
source "${CWD}/var.conf"

echo "KUBECONFIG: $KUBECONFIG"


# create a temporary kubeconfig add clusters
# export KUBECONFIG="${CWD}/tmp-kubeconfig.yaml"
touch $KUBECONFIG

for cluster in ${ALL_CLUSTERS[@]}; do
    aws eks --region $aws_region update-kubeconfig --name $cluster
done

chmod +x "${CWD}/tap-view.sh"
chmod +x "${CWD}/tap-run.sh"
chmod +x "${CWD}/tap-build.sh"
chmod +x "${CWD}/tanzu-cli-setup.sh"
chmod +x "${CWD}/tap-demo-app-deploy.sh"
chmod +x "${CWD}/tap-iterate.sh"
chmod +x "${CWD}/tap-iterate.sh"

chmod +x "${CWD}/var-input-validatation.sh"

${CWD}/var-input-validatation.sh
echo "Step 1 => installing tanzu cli !!!"
${CWD}/tanzu-cli-setup.sh
echo "Step 2 => Setup TAP View Cluster"
${CWD}/tap-view.sh
echo "Step 3 => Setup TAP Run Cluster"
${CWD}/tap-run.sh
echo "Step 4 => Setup TAP Build Cluster"
${CWD}/tap-build.sh
echo "Step 5 => Setup TAP Iterate Cluster"
${CWD}/tap-iterate.sh

echo "pick an external ip from service output and configure DNS wildcard records in your dns server for view and run cluster"
echo "example view cluster - *.view.customer0.io ==> <ingress external ip/cname>"
echo "example run cluster - *.run.customer0.io ==> <ingress external ip/cname> " 
echo "example iterate cluster - *.iter.customer0.io ==> <ingress external ip/cname> " 

echo "Step 5 => Deploy sample app"
${CWD}/tap-demo-app-deploy.sh
