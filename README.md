# Sys-Audit
**Comprehensive Linux Server Hardening & Health-Check Utility**

**Sys-Audit** is a professional, interactive command-line tool designed for system administrators and security engineers. It performs rapid server diagnostics, identifies security vulnerabilities, and provides an automated **Security Score** to evaluate the overall hardening of the system.

## Key Features
- **Modular Architecture**: The logic is separated into independent modules (Network, Users, System), allowing for easy maintenance and extensibility.
- **Automated Security Scoring**: Features a built-in heuristic algorithm that evaluates server protection levels (e.g., SSH port configuration, Firewall status, unauthorized root accounts) and provides a rating out of 10.
- **Interactive CLI Menu**: A user-friendly terminal interface for quick navigation between audit modules.
- **Production-Ready Reporting**: Generates clean, plain-text reports (`.log` files) stripped of ANSI color codes, making them perfect for email distribution or monitoring systems.
- **Environment Agnostic (Docker-Ready)**: Extensively tested in minimal environments. Includes pre-flight dependency checks to ensure all required utilities are available.

## Visual Tour
### Interactive Main Menu
<p align="center">
  <img src="https://github.com/user-attachments/assets/ce5bd5b0-906f-4aed-98d6-a253c35a0219" width="800" alt="Main Menu">
</p>

### Comprehensive System & Network Audit
<p align="center">
<img width="578" height="558" alt="image" src="https://github.com/user-attachments/assets/2c67bc57-f0ab-49fb-910b-0c26038c7956" />
</p>

### Automated Security Scoring
<p align="center">
<img width="525" height="439" alt="image" src="https://github.com/user-attachments/assets/d4e0528f-2d38-4916-b0b2-c74d9da290db" />
</p>



## Audit Modules
1. **System Info**: Analyzes Hostname, Kernel version, Uptime, and CPU Load via `/proc/loadavg`.
2. **User Audit**: Scans for unauthorized root-privileged accounts (UID/GID 0), active user sessions, and verifies shell access permissions.
3. **Network Audit**: Maps listening ports, detects suspicious connection activity (DDoS/Scan detection), and audits SSH daemon security settings.
4. **Security Assessment**: Provides a final verdict on system health based on verified security best practices.

## Installation & Setup

1. **Clone the repository**:
```bash
git clone https://github.com/febaSec/Sys-Audit.git
cd Sys-Audit
```

2. **Set permissions**:
```bash
chmod +x sys_audit.sh
```

3. **Run the utility (Requires root privileges)**:
```bash
sudo ./sys_audit.sh
```

## Project Structure
- `sys_audit.sh` — The main entry point and menu controller.
- `src/` — Functional modules and libraries:
  - `dependencies.sh` — Pre-flight tool verification.
  - `audit_network.sh` — Network and port analysis.
  - `audit_users.sh` — User and privilege auditing.
  - `security_score.sh` — Scoring logic and hardening checks.
  - `create_report.sh` — Report generation engine.
  - `colors.sh` — UI color definitions.

## System Dependencies
The script automatically verifies the presence of:
`ss`, `awk`, `free`, `df`, `uptime`, `grep`, `cut`.

## License
This project is licensed under the MIT License.
