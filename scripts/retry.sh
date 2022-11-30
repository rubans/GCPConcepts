#usage: retry.sh;echo $?

n=0
success=false
until [ "$n" -ge 3 ]
do
  http_status=$(curl -s -w '%{http_code}' -o /dev/null "https://www.google.com/foo")
  echo $http_status
  if [ $http_status -eq 200 ]
  then
    success=true
    echo="request returned 200"
    break;
  fi  
  sleep 1
  n=$((n+1)) 
  echo "retrying..."
done
#if [ !$success ]; then exit 1; else exit 0;fi
if [ $success == true ]; then
  echo "success!"
else
  echo "failed!"
  exit 1
fi
