#source colors.sh
function security_score() {
    local score=10
    echo -e "\n========== Calculating Security Score =========="
    # 1. Verification Root користувачів
    local extra_roots=$(awk -F: '$3 == 0 {print $1}' /etc/passwd | grep -v "root" | wc -l)
    if (( extra_roots > 0 )); then
        echo -e "${RED}[-] Found extra root users! (-3 points)${NC}"
        ((score -= 3))
    fi
    # 2. Verification SSH порту
    local ssh_p=$(grep -i "^Port" /etc/ssh/sshd_config | awk '{print $2}')
    if [[ "$ssh_p" == "22" || -z "$ssh_p" ]]; then
        echo -e "${YELLOW}[-] SSH is using default port 22. (-1 point)${NC}"
        ((score -= 1))
    fi
    # 3. Verification PermitRootLogin
    if grep -iq "PermitRootLogin yes" /etc/ssh/sshd_config 2>/dev/null; then
        echo -e "${RED}[-] Root login via SSH is allowed! (-2 points)${NC}"
        ((score -= 2))
    fi
    # 4. Verification UFW (Firewall)
    if ! systemctl is-active --quiet ufw 2>/dev/null; then
        echo -e "${YELLOW}[-] Firewall (UFW) is not active. (-2 points)${NC}"
        ((score -= 2))
    fi
    echo -e "\n-----------------------------------------------"
    echo -e "${GREEN}FINAL SECURITY SCORE${NC}: ${CYAN}$score/10${NC}"
    echo -e "-----------------------------------------------"
}

