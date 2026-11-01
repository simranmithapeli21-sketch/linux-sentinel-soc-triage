# Linux Sentinel – Linux SOC Triage Toolkit

## Overview
Linux Sentinel is a Linux-based SOC triage and investigation project. It uses a Bash script to collect system and security information and a Python Streamlit dashboard to display the investigation report in a browser.

## Features
- User and system information collection
- Running process investigation
- Network information collection
- SSH authentication investigation
- Cron job investigation
- Suspicious file investigation
- File integrity checking
- Browser-based investigation dashboard

## Technologies Used
- Ubuntu Linux
- Bash Scripting
- Python
- Streamlit

## How to Run

### 1. Run the investigation script
```bash
bash soc_triage.sh
```

### 2. Start the dashboard
Activate your Python virtual environment, then run:
```bash
python -m streamlit run dashboard.py
```

### 3. Open the dashboard
Visit `http://localhost:8501` in your browser.

## Project Limitation
The current version performs on-demand investigation. It does not provide continuous real-time monitoring.
