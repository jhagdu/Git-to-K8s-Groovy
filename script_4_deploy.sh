if ! kubectl get pvc | grep web-pvc
then
  kubectl create -f ../1-Git-Pull/K8s-YAML/pvc.yml
fi

if ! kubectl get svc | grep web-svc
then
  kubectl create -f ../1-Git-Pull/K8s-YAML/service.yml
fi

if ls /root/.jenkins/workspace/1-Git-Pull/*.* | grep html
then
  if ! kubectl get pods | grep httpd | grep Running
  then
    kubectl create -f ../1-Git-Pull/K8s-YAML/httpd.yml

    while kubectl get pods | grep httpd | grep ContainerCreating
    do
      sleep 1
    done    
    kubectl cp ../1-Git-Pull/*.html $(kubectl get pods -o=jsonpath='{.items[0].metadata.name}'):/var/www/html/ 

  else
    kubectl cp ../1-Git-Pull/*.html $(kubectl get pods -o=jsonpath='{.items[0].metadata.name}'):/var/www/html/
  fi

elif ls /root/.jenkins/workspace/1-Git-Pull/*.* | grep php
then
  if ! kubectl get pods | grep php | grep Running
  then
    kubectl create -f ../1-Git-Pull/K8s-YAML/php.yml

    while kubectl get pods | grep php | grep ContainerCreating
    do
      sleep 1
    done 
    kubectl cp ../1-Git-Pull/*.php $(kubectl get pods -o=jsonpath='{.items[0].metadata.name}'):/var/www/html/ 

  else
    kubectl cp ../1-Git-Pull/*.php $(kubectl get pods -o=jsonpath='{.items[0].metadata.name}'):/var/www/html/
  fi
fi
