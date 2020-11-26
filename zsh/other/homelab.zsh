export FLUX_NAMESPACE="flux-system"
export VELERO_NAMESPACE="storage"
export CEPH_NAMESPACE="rook-ceph"

alias ap="ansible-playbook --vault-password-file ${VAULT_PASS_FILE} -K -u ansible"
alias aves="ansible-vault encrypt_string --vault-password-file ${VAULT_PASS_FILE}"

alias cephtk="kubectl -n ${CEPH_NAMESPACE} exec -it $(kubectl -n ${CEPH_NAMESPACE} get pod -l 'app=rook-ceph-tools' -o jsonpath='{.items[0].metadata.name}') bash"
alias fluxctl="fluxctl --k8s-fwd-ns ${FLUX_NAMESPACE}"
alias fluxlogs="kubectl -n ${FLUX_NAMESPACE} logs deployment/source-controller -f --tail=100"
alias fluxhelmlogs="kubectl -n ${FLUX_NAMESPACE} logs deployment/helm-controller -f --tail=100"
alias fluxlogsall="kubectl -n ${FLUX_NAMESPACE} logs deployment/source-controller -f"
alias fluxhelmlogsall="kubectl -n ${FLUX_NAMESPACE} logs deployment/helm-controller -f"
alias ksealsecret="kubeseal --format=yaml --cert=/home/soleblaze/git/flux/pub-cert.pem"
alias kubeseal="kubeseal --controller-name=sealed-secrets"
alias s3cmd="s3cmd --host=${AWS_HOST}"

if command -v velero 2>&1 >/dev/null; then
  source <(velero completion zsh)
  alias velero="velero -n ${VELERO_NAMESPACE}"
fi
