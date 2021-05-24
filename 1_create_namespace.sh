
source 0_source_config.sh

kubectl get namespace elasticsearch \
  || kubectl create namespace elasticsearch
