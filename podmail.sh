#!/bin/bash
output=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}} {{.status.phase}} {{.metadata.creationTimestamp}}{{"\n"}}{
{end}}' | grep Running | awk '$3 <= "'$(date -d '2 hours ago' -Ins --utc | sed 's/+0000/Z/')'" { print $1 }') | tr ' ' '\n'
lcount=$output | wc -l
if [ $lcount > 0 ]; then
    echo $output | mail -s "Pending Pod List > 6 hours" saspattn@cisco.com
fi
