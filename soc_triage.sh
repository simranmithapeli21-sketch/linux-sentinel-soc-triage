#!/bin/bash

REPORT="reports/investigation_report.txt"

echo "====================================" > "$REPORT"
echo "      LINUX SOC TRIAGE REPORT" >> "$REPORT"
echo "====================================" >> "$REPORT"

echo "" >> "$REPORT"
echo "Investigation Date: $(date)" >> "$REPORT"
echo "" >> "$REPORT"

echo "SOC Investigation Started"
echo "Report created successfully!"
echo "Report location: $REPORT"
echo "" >> "$REPORT"

echo "====================================" >> "$REPORT"
echo "           USER INFORMATION         " >> "$REPORT"
echo "====================================" >> "$REPORT"
echo "" >> "$REPORT"

echo "Current User:" >> "$REPORT"
whoami >> "$REPORT"
echo "" >> "$REPORT"

echo "Currently Logged-In Users:" >> "$REPORT"
who >> "$REPORT"
echo "" >> "$REPORT"

echo "Recent login/system history:" >> "$REPORT"
last -n 10 >> "$REPORT"
echo "" >> "$REPORT"

echo "=====================================" >> "$REPORT"
echo "         PROCESS INFORMATION         " >> "$REPORT"
echo "=====================================" >> "$REPORT"
echo "" >> "$REPORT"

echo "All Running Processes:" >> "$REPORT"
ps aux >> "$REPORT"
echo "" >> "$REPORT"

echo " TOP CPU_COnsuming Processes:" >> "$REPORT"
ps aux --sort=-%cpu | head -n 10 >> "$REPORT"
echo "" >> "$REPORT"

echo "===============================" >> "$REPORT"
echo "      NETWORK INFORMATION      " >> "$REPORT"
echo "===============================" >> "$REPORT"
echo "" >> "$REPORT"

echo "IP Address and Network Interfaces:" >> "$REPORT"
ip a >> "$REPORT"

echo "" >> "$REPORT"
echo "Routing Information:" >> "$REPORT"
ip route >> "$REPORT"

echo "" >> "$REPORT"
echo "Listening Ports:" >> "$REPORT"
ss -tuln >> "$REPORT"

echo "" >> "$REPORT"
echo "Listening Ports and Associated Processes:" >> "$REPORT"
sudo ss -tulpn >> "$REPORT"

echo "" >> "$REPORT"
echo "=========================" >> "$REPORT"
echo " AUTHENTICATION INVESTIGATION " >> "$REPORT"
echo "=========================" >> "$REPORT"

echo "" >> "$REPORT"
echo "Recent Authentication Activity:" >> "$REPORT"
tail -n 30 /var/log/auth.log >> "$REPORT" 2>&1

echo "" >> "$REPORT"
echo "Failed Login Attempts:" >> "$REPORT"
grep "Failed" /var/log/auth.log >> "$REPORT" 2>&1

echo "" >> "$REPORT"
echo "Successful SSH Logins:" >> "$REPORT"
grep "Accepted" /var/log/auth.log >> "$REPORT" 2>&1
echo "" >> "$REPORT"

echo "=========================" >> "$REPORT"
echo " PERSISTENCE INVESTIGATION " >> "$REPORT"
echo "=========================" >> "$REPORT"

echo "" >> "$REPORT"
echo "Current User Cron Jobs:" >> "$REPORT"
crontab -l >> "$REPORT" 2>&1

echo "" >> "$REPORT"
echo "Root Cron Jobs:" >> "$REPORT"
sudo crontab -l >> "$REPORT" 2>&1

echo "" >> "$REPORT"
echo "System Cron Directories:" >> "$REPORT"
ls -la /etc/cron* >> "$REPORT" 2>&1

echo "" >> "$REPORT"
echo "=========================" >> "$REPORT"
echo " SUSPICIOUS FILE INVESTIGATION " >> "$REPORT"
echo "=========================" >> "$REPORT"

echo "" >> "$REPORT"
echo "All Files in /tmp:" >> "$REPORT"
ls -la /tmp >> "$REPORT" 2>&1

echo "" >> "$REPORT"
echo "Recently Modified Files in /tmp (Last 24 Hours):" >> "$REPORT"
find /tmp -type f -mtime -1 >> "$REPORT" 2>&1

echo "" >> "$REPORT"
echo "=========================" >> "$REPORT"
echo " FILE INTEGRITY CHECK " >> "$REPORT"
echo "=========================" >> "$REPORT"

echo "" >> "$REPORT"
echo "SHA256 Verification:" >> "$REPORT"
sha256sum -c integrity/important_file.hash >> "$REPORT" 2>&1
