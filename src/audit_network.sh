# Function
function audit_network() {
	echo -e "\n========== Network & Ports Audit =========="
	# Ports
	local listening_ports=$(ss -tulpn | grep LISTEN | awk '{n=split($5,a,":"); split($7,p,"\""); printf "  - Port: %-5s | Program: %s\n", a[n], p[2]}')
	echo -e "${GREEN}1.Listening ports:${NC}\n${CYAN}${listening_ports}${NC}"
	# Suspicious Activity
	echo -e "${GREEN}2.Suspicious Activity:"
	while read -r connections ip; do
		if [[ -z "$ip" || "$ip" == "127.0.0.1" || "$ip" == "0.0.0.0" ]]; then
			continue
		fi

		if (( "$connections" > 20 )); then
                	echo -e "${B_RED}- [ALERT] Address: $ip. Connections count: $connections"
        	elif (( "$connections" > 10 )); then
                	echo -e "${B_YELLOW}- [WARNING] Address: $ip. Connections count: $connections"
        	else
                	echo -e "${CYAN}- Address: $ip. Connections: $connections${NC}"
        	fi
	done < <(ss -tun | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -rn)
	# SSH Security  Check
	if [[ -f /etc/ssh/sshd_config ]]; then
		echo -e "${GREEN}3.SSH Connection:${NC}"
		local sshd_port=$(cat /etc/ssh/sshd_config | grep -oP 'Port\s\d{2,5}' | cut -d' ' -f2)
		local root_connect_opt=$(cat /etc/ssh/sshd_config | grep -oP '^#?PermitRootLogin\s\w+(-\w+)?' | tr -d "#")
		echo -e "${CYAN}- Service Port: $sshd_port${NC}"
		echo -e "${CYAN}- Root permissions: $root_connect_opt\n${NC}"
	else
		echo -e "${YELLOW}- SSH server not installed (sshd_config missing)${NC}"
	fi
}

