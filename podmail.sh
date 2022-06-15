#!/bin/bash
output=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}} {{.status.phase}} {{.metadata.creationTimestamp}}{{"\n"}}{{end}}' | grep Pending | awk '$3 <= "'$(date -d '2 hours ago' -Ins --utc | sed 's/+0000/Z/')'" { print $1 }')
lcount=$(echo $output | tr ' ' '\n' | wc -l)
if [ $lcount > 0 ]; then
    echo -e $output | tr ' ' '\n' | mail -s "Pending Pod List > 6 hours" saspattn@cisco.com
fi
