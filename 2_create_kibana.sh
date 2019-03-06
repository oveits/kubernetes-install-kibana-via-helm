

CMD=$1
[ "$CMD" == "" ] && CMD=install

if [ "$CMD" != "install" ] && [ "$CMD" != "template" ] && [ "$CMD" != "delete" ] && [ "$CMD" != "del" ]; then
  echo "usage: bash $0 [install|template]"
  exit 1
fi 

source 0_source_config.sh

OPTIONS="--name ${RELEASE} \
      --set env.ELASTICSEARCH_URL=${ELASTICSEARCH_URL} \
      --set files.kibana.yml.elasticsearch.url=${ELASTICSEARCH_URL} \
      --set service.externalPort=5601 \
      --namespace elasticsearch"

[ "$STORAGE_CLASS" != "" ] && OPTIONS="$OPTIONS \
      --set persistentVolumeClaim.storageClass=${STORAGE_CLASS}"

case $CMD in
  "delete"|"del")
    helm ls --all ${RELEASE} && helm del --purge ${RELEASE}
    ;;
  "install") 
    helm ls --all ${RELEASE} && helm del --purge ${RELEASE}
    helm $CMD stable/kibana $OPTIONS
    ;;
  "template")
    helm $CMD ../charts/stable/kibana $OPTIONS
    ;;
  *) echo "no clue - $CMD"; ;;
esac;
