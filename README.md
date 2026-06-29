# HP Victus Audio Kernel Crash Investigation

![Version](https://img.shields.io/badge/version-v1.0.0-blue)
![Status](https://img.shields.io/badge/status-Investigating-orange)
![Platform](https://img.shields.io/badge/platform-Windows%2011-0078D6)
![BugCheck](https://img.shields.io/badge/BugCheck-0x139-red)
![License](https://img.shields.io/badge/license-MIT-green)
![Issues](https://img.shields.io/github/issues/MSEB00/HP-Victus-Audio-Kernel-Crash)
![Last Commit](https://img.shields.io/github/last-commit/MSEB00/HP-Victus-Audio-Kernel-Crash)
![WinDbg](https://img.shields.io/badge/WinDbg-Analyzed-success)
![Crash Dumps](https://img.shields.io/badge/Crash_Dumps-7-blueviolet)
![Reproducible](https://img.shields.io/badge/Reproducible-Yes-brightgreen)
![Evidence](https://img.shields.io/badge/Evidence-Available-success)

**Repository Version:** v1.0.0  
**Last Updated:** 29 June 2026

---

> [!IMPORTANT]
> **Current Status**
>
>| Item | Status |
>|------|--------|
>| Investigation | 🟡 Active |
>| Reproducible | ✅ Yes |
>| Multiple Dumps | ✅ Yes |
>| WinDbg Analysis | ✅ Complete |
>| Root Cause | ❌ Not Yet Confirmed |
>| Community Reports | ⏳ Pending |

---

## Project Metrics

| Metric | Value |
|--------|------:|
| Kernel Dumps Collected | 7 |
| BugCheck Signatures | 2 |
| Driver Families Investigated | 4 |
| Investigation Documents | 6 |
| Diagnostic Scripts | Multiple |
| Reproduction Status | Confirmed |

---

## Disclaimer

This repository is an independent engineering investigation.

The observations, analyses, and hypotheses documented here are based on publicly available debugging information, crash dumps, and reproducible testing.

References to HP, AMD, Microsoft, Riot Games, Realtek, NVIDIA, or other vendors do not imply responsibility unless confirmed by the respective vendor.

Technical documentation of a reproducible Windows kernel crash involving audio endpoint transitions on HP Victus laptops.  includes evidence, WinDbg analysis, driver details, crash dumps, logs, and troubleshooting to assist HP, AMD, Microsoft, and the community.


> Engineering investigation into a reproducible Windows kernel crash triggered by 3.5 mm audio endpoint transitions during gaming on an HP Victus 15-fb0xxx laptop.

---

## Table of Contents

- [Overview](#overview)
- [Repository Status](#repository-status)
- [System Information](#system-information)
- [Driver Versions](#driver-versions)
- [Symptoms](#symptoms)
- [Crash History](#crash-history)
- [Reproduction](#reproduction)
- [Troubleshooting Performed](#troubleshooting-performed)
- [Current Findings](#current-findings)
- [Current Hypothesis](#current-hypothesis)
- [Repository Structure](#repository-structure)
- [Contribution](#contribution)
- [License](#license)
- [Acknowledgements](#acknowledgements)
- [Contact](#contact)

---

## Overview

This repository documents a reproducible Windows kernel crash affecting an **HP Victus 15-fb0xxx** laptop.

The issue occurs while playing **Valorant** and interacting with a wired **3.5 mm headset**. Shortly after an audio endpoint transition, the game freezes, audio stops responding, and Windows eventually performs an automatic kernel recovery and restart.

This repository serves as a technical investigation containing:

* WinDbg crash analysis
* Kernel dump information
* Driver versions
* Reliability Monitor logs
* Event Viewer logs
* Reproduction procedures
* Technical findings
* Troubleshooting history

The goal is to assist HP, AMD, Microsoft, Riot Games, Realtek, and the community in identifying the root cause.

---

## Documentation

| Document | Description |
|----------|-------------|
| [docs/Technical_Report.md](https://github.com/MSEB00/HP-Victus-Audio-Kernel-Crash/blob/main/docs/Technical_Report.md) | Complete technical investigation |
| [docs/WinDbg_Analysis.md](https://github.com/MSEB00/HP-Victus-Audio-Kernel-Crash/blob/main/docs/WinDbg_Analysis.md) | WinDbg crash analysis |
| [docs/Investigation_Log.md](https://github.com/MSEB00/HP-Victus-Audio-Kernel-Crash/blob/main/docs/Investigation_Log.md) | Investigation history |
| [docs/Reproduction.md](https://github.com/MSEB00/HP-Victus-Audio-Kernel-Crash/blob/main/docs/Reproduction.md) | Reproduction procedure |
| [docs/Solution_Report.md](https://github.com/MSEB00/HP-Victus-Audio-Kernel-Crash/blob/main/docs/Solution_Report.md) | Solutions and workarounds |
| [docs/Timeline.md](https://github.com/MSEB00/HP-Victus-Audio-Kernel-Crash/blob/main/docs/Timeline.md) | Investigation timeline |

---

## Investigation Flow
```
Symptom
    │
    ▼
Evidence Collection
    │
    ▼
Reproduction
    │
    ▼
WinDbg Analysis
    │
    ▼
Working Hypothesis
    │
    ▼
Community Investigation
    │
    ▼
Vendor Investigation
    │
    ▼
Solution
```

---

## Repository Status

| Item | Status |
|------|--------|
| Investigation | 🟡 Active |
| Reproducibility | ✅ Confirmed |
| Root Cause | ❌ Unknown |
| Primary Suspected Area | Windows Audio Stack during wired audio endpoint transitions under gaming workload |

---

# Community Reproduction

| Device | Windows Build | Status |
|---------|---------------|--------|
| HP Victus 15-fb0xxx | 26100.8737 | ✅ Confirmed |
| Community Reports | Pending | ⏳ |

# System Information

| Component        | Information                     |
| ---------------- | ------------------------------- |
| Laptop           | HP Victus 15-fb0xxx             |
| BIOS             | F.26                            |
| CPU              | AMD Ryzen 5 5600H               |
| GPU              | NVIDIA RTX 3050 Laptop          |
| Operating System | Windows 11 Home Single Language |
| Build            | 26100.8737                      |

---

# Driver Versions

## Realtek HD Audio

| Component | Value |
|-----------|-------|
| Driver | RTKVHD64.sys |
| Version | 6.0.9692.1 |
| Timestamp | 04-Jun-2024 |

---

## AMD Audio Device

| Component | Value |
|-----------|-------|
| Driver | AMD Audio Device |
| Version | 6.0.1.44 |

---

## AMD ACP Bus Driver

| Component | Value |
|-----------|-------|
| Driver | amdacpbus.sys |
| Version | 6.0.1.85 |
| Timestamp | 02-Apr-2026 |
---

## Microsoft Components

| Component | Version |
|-----------|---------|
| PortCls.sys | 10.0.26100.8737 |
| HDAudBus.sys | 10.0.26100.8521 |

---

# Symptoms

The issue follows a consistent sequence.

```
3.5 mm headset interaction
        │
        ▼
Audio endpoint transition
        │
        ▼
Audio freezes
        │
        ▼
Valorant freezes
        │
        ▼
Windows desktop continues responding
        │
        ▼
5–10 seconds later
        │
        ▼
Kernel bugcheck
        │
        ▼
Black recovery screen
        │
        ▼
Automatic restart
```

Notably, Windows remains responsive immediately after the game freezes, suggesting the kernel corruption is detected later rather than occurring at the instant of the audio transition.

---

# Crash History

Multiple crash dumps have been collected.

| Dump | BugCheck | Result |
|------|----------|--------|
| Crash A | 0x3B | SYSTEM_SERVICE_EXCEPTION |
| Crash B | 0x139 | KERNEL_SECURITY_CHECK_FAILURE |
| Crash C | 0x139 | Same failure bucket |

---

# Reproduction

1. Boot Windows.
2. Connect a wired 3.5 mm headset.
3. Launch Valorant.
4. Join a match.
5. Plug, unplug, or move the headset connector.
6. Continue gameplay.

Eventually:

* Audio freezes
* Game freezes
* Kernel bugcheck occurs
* Windows restarts automatically

The issue has been reproduced using multiple wired headsets.

---

# Troubleshooting Performed

* HP OEM audio package reinstalled
* Realtek audio drivers reinstalled
* AMD audio drivers reinstalled
* Realtek Audio Console installed
* Windows updated
* BIOS updated
* SFC verification
* DISM verification
* Driver verification
* WinDbg crash analysis
* Reliability Monitor inspection
* Event Viewer inspection
* Multiple headset testing
* Valorant Tracker tested enabled and disabled

---

# Current Findings

Current evidence suggests the issue is associated with an audio endpoint transition while the system is under gaming load.

Crash dump analysis consistently indicates:

* BugCheck 0x139
* FAST_FAIL_CORRUPT_LIST_ENTRY
* Kernel timer list corruption detection
* Earlier crash involving amdacpbus.sys
* MMDevAPI endpoint activity reported by BlackBoxPnP

The kernel timer subsystem appears to detect previously corrupted memory rather than being the origin of the corruption.

---

## Current Hypothesis

Based on the evidence collected so far:

- Audio endpoint transitions consistently precede the crash.
- Multiple kernel dumps produce the same BugCheck 0x139 signature.
- An earlier dump implicated `amdacpbus.sys` during audio processing.
- The issue has not yet been conclusively attributed to a specific driver or vendor.

This remains a working hypothesis and is subject to revision as new evidence becomes available.

# Known Workarounds

| Workaround | Status |
|------------|--------|
| Bluetooth headset | ⚠️ Avoids jack transitions but introduces latency |
| Avoid unplugging/replugging during gameplay | ⚠️ Partial workaround |
| Permanent fix | ❌ None identified |

# Vendor Status

| Vendor | Status |
|--------|--------|
| HP | Not Contacted |
| AMD | Not Contacted |
| Microsoft | Not Contacted |
| Riot Games | Not Contacted |
| Realtek | Not Contacted |

---

# Repository Structure

```
HP-Victus-Audio-Kernel-Crash
│
├── .github
│   ├── ISSUE_TEMPLATE
│   │   ├── bug_report.md
│   │   ├── investigation_report.md
│   │   └── solution_report.md
│   │
│   ├── PULL_REQUEST_TEMPLATE.md
│   └── CODEOWNERS
│
├── artifacts
│   ├── dism
│   ├── drivers
│   ├── dump-files
│   ├── reliability-monitor
│   └── windbg
│
├── docs
│   ├── Investigation_Log.md
│   ├── Reproduction.md
│   ├── Technical_Report.md
│   ├── Timeline.md
│   ├── WinDbg_Analysis.md
│   └── README.md
│
├── scripts
│
├── README.md
├── LICENSE
├── SECURITY.md
├── CONTRIBUTING.md
├── CODE_OF_CONDUCT.md
├── CITATION.cff
└── .gitignore
```

---

# Contribution

If you have experienced a similar issue, please consider opening an Issue with:

* Laptop model
* CPU
* BIOS version
* Windows build
* Audio driver versions
* Reproduction steps
* Minidump (if available)
* WinDbg output
* Event Viewer logs

Additional evidence helps determine whether this issue affects a broader range of HP Victus or AMD ACP platforms.

---

# License

This repository is released under the MIT License unless otherwise specified.

---

# Acknowledgements

Thanks to the Windows debugging community, HP Community members, AMD Community members, Microsoft Learn documentation, and everyone contributing additional testing and analysis.

---

## Contact

If you have reproduced this issue or discovered a workaround, please open a GitHub Issue or submit a Pull Request so the findings can be documented for future users.
