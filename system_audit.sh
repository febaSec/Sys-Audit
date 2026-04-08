#!/bin/bash
set -euo pipefail
trap 'echo -e "\nThe script was interrupted by the user (Ctrl+C)."; exit 0 ' SIGINT

# Resources
source ./src/audit_network.sh
source ./src/audit_users.sh
source ./src/show_sys_info.sh
source ./src/security_score.sh
source ./src/create_report.sh
source ./src/dependencies.sh
source ./src/colors.sh

# Dependencies
dependencies

# Use sudo
if [[ "$EUID" -ne 0 ]]; then
   echo "This script must be run as root (use sudo)"
   exit 1
fi


while true; do
	echo -e "\n--- SYS-AUDIT MENU ---"
	echo "1) System General Info"
	echo "2) Users & Groups Audit"
	echo "3) Network & Ports Audit"
	echo "4) Calculate Security Score"
	echo "5) Generate Full Report (txt)"
	echo "0) Exit"
	echo " "
	read -p "Select option: " opt
	echo " "

	case "$opt" in
		1)
		   show_sys_info
		   ;;
		2)
		   audit_users
		   ;;
		3)
		   audit_network
		   ;;
		4)
		   security_score
		   ;;
		5)
		   create_report
		   ;;
		0)
		   exit 0
		   ;;
	esac
done


