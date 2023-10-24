k8s-login(){
	export AWS_PROFILE=prod_poweruser && aws eks --region us-east-1 update-kubeconfig --name production-cmp-services --alias production-cmp-services >> /dev/null
	kubectl config use-context production-cmp-services >> /dev/null
}

k8s-token() {
	k8s-login
	kubectl create token eks-poweruser
}

k8s-command() {
	k8s-login
	pods=$(kubectl get pod -A|grep $1)
	pods_count=$(echo $pods|grep -c '^')
	if [[ $pods == '' ]]
	then
		echo "No Matching pod found"
		return;
	
	elif [[ $pods_count -gt 1 ]]
	then
		selected_pod=$(echo $pods|awk '{print $1, $2}'|fzf|grep -oE "(\w|-)+")	
	else
		selected_pod=$(echo $pods|awk '{print $1, $2}'|awk 'NR==1'|grep -oE "(\w|-)+")	
	fi
	
	pod_namespace=$(echo $selected_pod|awk 'NR==1')
	pod_name=$(echo $selected_pod|awk 'NR==2')
	kubectl config set-context --current --namespace=$pod_namespace>>/dev/null
	containers=$(kubectl get pod $pod_name -o jsonpath='{.spec.containers[*].name}'|grep -oE "(\w|-)+")
	container_count=$(echo $containers|grep -c '^')
	if [[ container_count -gt 1 ]]
	then
		selected_container_name=$(echo $containers|grep -oE "(\w|-)+"|fzf)
	else
		selected_container_name='default'
	fi
}

k8s-shell(){
	k8s-command $1
	if [[ $selected_container_name == 'default' ]]
	then
		kubectl exec -it $pod_name -- /bin/bash
	else
		kubectl exec -it $pod_name -c $selected_container_name -- /bin/bash
	fi
}

k8s-logs(){
	k8s-command $1
	if [[ $selected_container_name == 'default' ]]
	then
		kubectl logs -f $pod_name
	else
		kubectl logs -f $pod_name -c $selected_container_name
	fi
}

function k8s(){
	if [[ $1 == "logs" ]]
	then
		k8s-logs $2
	elif [[ $1 == "shell" ]]
	then
		k8s-shell $2
	elif [[ $1 == "token" ]]
	then
		k8s-token
	else
		echo "supported command logs <pod-name-regex>, shell <pod-name-regex>, token"
	fi
}

