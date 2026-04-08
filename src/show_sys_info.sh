# Function
function show_sys_info() {
	mapfile -t uname_info <<< $(uname -a | awk '{print $2 "\n" $3}') #[0] - hostname; [1] - core version
	local active_time=$(uptime -p | cut -d' ' -f2-)
	mapfile -t -d ' ' load_avarage < <(awk '{print $1" "$2" "$3}' /proc/loadavg | tr -d "\n")
	local sys_memory=$(free -h | awk 'NR==2{print "- Total: "$2 "\n" "- Used: " $3 "\n" "- Free: " $4 "\n" "- Available: " $7}')
	local root_memory=$(( 100 - $(df -h / | awk 'NR==2{print $5}' | tr -d '%' )))
	echo -e "\n==============System info=============="
	echo -e "${GREEN}1.Hostname:${NC} ${CYAN}${uname_info[0]}${NC}"
	echo -e "${GREEN}2.Core version:${NC} ${CYAN}${uname_info[1]}${NC}"
	echo -e "${GREEN}3.System works:${NC} ${CYAN}$active_time${NC}"
	echo -e "${GREEN}4.CPU Load${NC}\n${CYAN}- 1 minute: ${load_avarage[0]}${NC}"
	echo -e "${CYAN}- 5 minutes: ${load_avarage[1]}${NC}"
	echo -e "${CYAN}- 15 minutes: ${load_avarage[2]}${NC}"
	echo -e "${GREEN}5.RAM Status${NC}\n${CYAN}$sys_memory${NC}"
	echo -e "${GREEN}6.Disk Usage:${NC} ${CYAN}$root_memory%${NC}"
}

