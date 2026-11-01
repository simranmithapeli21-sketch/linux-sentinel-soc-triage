import streamlit as st
import os
import re
from datetime import datetime

st.set_page_config(
    page_title="Linux Sentinel | SOC Dashboard",
    page_icon="🛡️",
    layout="wide"
)

# Custom design
st.markdown("""
<style>
.stApp {
    background: linear-gradient(135deg, #08111f, #101d33);
    color: #e5edf8;
}
h1, h2, h3 {
    color: #e5edf8 !important;
}
p, label {
    color: #a9bad0;
}
div[data-testid="stMetric"] {
    background: #172943;
    padding: 18px;
    border: 1px solid #29486b;
    border-radius: 12px;
}
div[data-testid="stExpander"] {
    background: #13243b;
    border: 1px solid #29486b;
    border-radius: 10px;
}
</style>
""", unsafe_allow_html=True)

# Header
st.markdown("# 🛡️ LINUX SENTINEL")
st.markdown("### SECURITY OPERATIONS CENTER")
st.caption("LINUX TRIAGE • INCIDENT INVESTIGATION • SYSTEM MONITORING")

st.divider()

# Load existing report
report_path = "reports/investigation_report.txt"

if os.path.exists(report_path):
    with open(report_path, "r") as file:
        report = file.read()

    modified = datetime.fromtimestamp(
        os.path.getmtime(report_path)
    ).strftime("%d %b %Y, %I:%M %p")

    sections = re.split(
        r"(?m)^={2,}\s*(.*?)\s*={2,}\s*$",
        report
    )

    # Summary cards
    col1, col2, col3 = st.columns(3)

    col1.metric("Report Status", "Available")
    col2.metric("Report Size", f"{os.path.getsize(report_path) // 1024} KB")
    col3.metric("Investigation Sections", str((len(sections) - 1) // 2))

    st.caption(f"Last report update: {modified}")

    st.divider()
    st.subheader("🔍 Investigation Findings")

    # Display report sections
    found_section = False

    for i in range(1, len(sections), 2):
        title = sections[i].strip()
        content = sections[i + 1].strip()

        if title and content:
            found_section = True
            with st.expander(f"📂 {title}", expanded=False):
                st.code(content, language="text")

    if not found_section:
        st.info("No formatted sections found. Showing the complete report.")
        st.text(report)

else:
    st.error("Investigation report not found. Check the report path.")

st.divider()
st.caption("LINUX SENTINEL | SOC INVESTIGATION TOOLKIT")
