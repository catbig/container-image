#!/bin/sh
APP_NAME=arc
NAMESPACE="action-runner"
CHART_VERSION=0.18.0
GITHUB_PAT=?
helm repo add arc https://actions-runner-controller.github.io/actions-runner-controller
helm upgrade --install ${APP_NAME} actions-runner-controller/actions-runner-controller \
  certManagerEnabled=false --labels self-host \
  --namespace ${NAMESPACE} --create-namespace \
  --wait actions-runner-controller \
  --version ${CHART_VERSION}

APP_NAME="arc-runner-set"
NAMESPACE="arc-runners"
GITHUB_CONFIG_URL="https://github.com/catbig/runner"
CHART_VERSION=0.18.0

helm install "${INSTALLATION_NAME}" \
    --namespace "${NAMESPACE}" \
    --create-namespace \
    --set githubConfigUrl="${GITHUB_CONFIG_URL}" \
    --set githubConfigSecret.github_token="${GITHUB_PAT}" \
    oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set
