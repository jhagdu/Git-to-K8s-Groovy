cp -r ../1-Git-Pull/* .
code=webapp.*
code_file=$(echo $code)
nodeport=$(kubectl get svc -o jsonpath={.items[*].spec.ports[*].nodePort})
status=$(curl -s -w "%{http_code}" -o /dev/nell http://192.168.99.100:$nodeport/$code_file)

if [ $status -eq 200 ]
then
  exit 1
else 
  exit 0
fi
