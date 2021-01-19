export FLUX_NAMESPACE="flux-system"
export VELERO_NAMESPACE="storage"
export CEPH_NAMESPACE="rook-ceph"

alias ap="ansible-playbook --vault-password-file ${VAULT_PASS_FILE} -K -u ansible"
alias aves="ansible-vault encrypt_string --vault-password-file ${VAULT_PASS_FILE}"

# flux
alias fghr="flux get hr"
alias fgks="flux get ks"
alias fgs="flux get sources"
alias fgsg="flux get sources git"
alias fgsh="flux get sources helm"
alias frks="flux reconcile ks"
alias frhr="flux reconcile hr"
alias frs="flux reconcile source"
alias frsg="flux reconcile source git"
alias frsh="flux reconcile source helm"
alias frmks="flux delete ks"
alias frmhr="flux delete hr"
alias frms="flux delete source"
alias frmsg="flux delete source git"
alias frmsh="flux delete source helm"
alias floh="kubectl -n ${FLUX_NAMESPACE} logs deployment/helm-controller -f --tail=100"
alias flloha="kubectl -n ${FLUX_NAMESPACE} logs deployment/helm-controller -f"
alias flos="kubectl -n ${FLUX_NAMESPACE} logs deployment/source-controller -f --tail=100"
alias flosa="kubectl -n ${FLUX_NAMESPACE} logs deployment/source-controller -f"


alias ksealsecret="kubeseal --format=yaml --cert=/home/soleblaze/git/flux/pub-cert.pem"
alias kubeseal="kubeseal --controller-name=sealed-secrets"

alias s3cmd="s3cmd --host=${AWS_HOST}"


if command -v velero 2>&1 >/dev/null; then
  source <(velero completion zsh)
  alias velero="velero -n ${VELERO_NAMESPACE}"
fi

cephtk() {
  POD=$(kubectl -n ${CEPH_NAMESPACE} get pod -l 'app=rook-ceph-tools' -o jsonpath='{.items[0].metadata.name}')
  kubectl -n ${CEPH_NAMESPACE} exec -it $POD bash
}
