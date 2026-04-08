# Function
function audit_users() {
	# Roots
	mapfile -t root_users < <(awk -F: '$3 == 0 || $4 == 0 {print $1}' /etc/passwd)
	echo -e "\n========== Users & Security Audit =========="
	echo -e "${GREEN}1.Privileges users:${NC}\n${CYAN}- User: root${NC}"
	if (( "${#root_users[@]}" > 1 )); then
        	for usr in "${root_users[@]}"; do
                	[[ "$usr" == "root" ]] && continue
                	echo -e "${RED}- [ALERT] User: $usr${NC}"
        	done
	fi
	# Human users
	echo -e "${GREEN}2.Human users:${NC}"
	mapfile -t human_users < <(awk -F: '$3 >= 1000 && $7 !~ /nologin|false/ {print $1 " (Shell: " $7 ")"}' /etc/passwd)
	for human in "${human_users[@]}"; do
		echo  -e "${CYAN}- User: ${human}${NC}"
	done
	# Online users
	echo -e "${GREEN}3.Online users:${NC}"
	mapfile -t online_users < <(who | awk '{print $1}' | sort -u)
	for onlu in "${online_users[@]}"; do
		echo -e "${CYAN}- User: $onlu${NC}"
	done
}

