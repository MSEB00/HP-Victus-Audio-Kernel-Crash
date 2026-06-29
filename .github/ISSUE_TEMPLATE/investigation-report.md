---
name: Investigation Report
about: Submit findings, analysis, experiments, or possible root causes related to
  this investigation.
title: "[INVESTIGATION] Brief summary of finding"
labels: amd, amd-acp, audio, bios, bug, driver, hp-victus, kernal, realtek, reproduced,
  reproducible, Valorant, Vanguard, windows
assignees: ''

---

# Investigation Summary

Provide a brief summary of your investigation or finding.

---

# Investigation Type

Select one or more:

* [ ] New finding
* [ ] Possible root cause
* [ ] Driver analysis
* [ ] WinDbg analysis
* [ ] Reproduction attempt
* [ ] Workaround
* [ ] Possible fix
* [ ] Regression after update
* [ ] Hardware testing
* [ ] Other

---

# Objective

What were you trying to investigate?

---

# Test Environment

**Laptop Model:**

**CPU:**

**GPU:**

**BIOS Version:**

**Windows Build:**

**Realtek Driver Version:**

**AMD ACP Driver Version:**

---

# Methodology

Describe exactly what you tested.

Example:

* Installed latest HP audio package
* Disabled AMD ACP
* Updated BIOS
* Clean NVIDIA installation
* Tested Bluetooth only
* Tested wired headset
* Enabled Driver Verifier
* Captured kernel dump

---

# Results

Describe the outcome of your investigation.

Example:

* Issue no longer reproduced.
* Crash frequency reduced.
* Different BugCheck observed.
* No noticeable change.

---

# Evidence

Attach any supporting material if available.

* Screenshots
* WinDbg output
* Reliability Monitor
* Event Viewer
* Minidumps
* Driver versions
* DxDiag
* PowerShell output
* ETL traces

---

# WinDbg Analysis (Optional)

Paste important output from:

```text
!analyze -v
```

If applicable, also include:

```text
lmvm RTKVHD64
lmvm amdacpbus
!blackboxpnp
```

---

# Conclusion

Summarize your findings.

Example:

"I believe the issue is related to audio endpoint transitions involving the AMD ACP driver while under gaming load."

---

# Confidence Level

How confident are you in this conclusion?

* [ ] Low
* [ ] Medium
* [ ] High

---

# Additional Notes

Include any extra information that may help future investigators.
