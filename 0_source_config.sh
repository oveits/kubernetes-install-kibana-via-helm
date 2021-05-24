[ "$NAMESPACE" == "" ] && export NAMESPACE=elasticsearch
[ "$RELEASE" == "" ] && export RELEASE=kibana-v1
[ "$ELASTIC_DETECTED" == "" ] \
  && export ELASTIC_DETECTED=$(kubectl -n $NAMESPACE get svc | grep 'elastic.*client' | head -n 1 | awk '{print $1}')
[ "$ELASTICSEARCH_URL" == "" ] && [ "$ELASTIC_DETECTED" != "" ] && export ELASTICSEARCH_URL=http://${ELASTIC_DETECTED}:9200

if [ "$ELASTICSEARCH_URL" == "" ]; then
  echo "ELASTICSEARCH_URL could not be detected; Exiting..." >&2
  exit 1
fi
