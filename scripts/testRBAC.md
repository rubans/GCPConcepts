# create ksa
 kubectl create serviceaccount dummy-user
# create role
cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: default
  name: viewer
rules:
- apiGroups: [""]
  resources: ["pods", "pods/log"]
  verbs: ["get", "list"]
EOF
# create role binding
kubectl create rolebinding viewer --role viewer --serviceaccount default:dummy-user