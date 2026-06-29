![License](https://img.shields.io/badge/license-MIT-blue)        ![Platform](https://img.shields.io/badge/platform-Windows%2011-blue)        ![Status](https://img.shields.io/badge/status-Investigation-orange)        ![BugCheck](https://img.shields.io/badge/BugCheck-0x139-red)        ![WinDbg](https://img.shields.io/badge/WinDbg-Analyzed-success)        **Version:** v1.0.0  
**Status:** 🟡 Active Investigation  
**License:** MIT  

# HP-Victus-Audio-Kernel-Crash
Technical documentation of a reproducible Windows kernel crash involving audio endpoint transitions on HP Victus laptops. Repository includes evidence, WinDbg analysis, driver details, crash dumps, logs, and troubleshooting to assist HP, AMD, Microsoft, and the community.


# HP Victus Audio Kernel Crash Investigation

> Engineering investigation into a reproducible Windows kernel crash triggered by 3.5 mm audio endpoint transitions during gaming on an HP Victus 15-fb0xxx laptop.

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

# Repository Status

**Status:** Under Investigation

**Reproducibility:** Reproducible

**Current Root Cause:** Unknown

**Primary Suspected Area:**

Windows Audio Stack during wired audio endpoint transitions under gaming workload.

---

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

Version

6.0.9692.1

Driver

RTKVHD64.sys

Timestamp

04-Jun-2024

---

## AMD Audio Device

Version

6.0.1.44

---

## AMD ACP Bus Driver

Driver

amdacpbus.sys

Version

6.0.1.85

Timestamp

02-Apr-2026

---

## Microsoft Components

PortCls.sys

10.0.26100.8737

HDAudBus.sys

10.0.26100.8521

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

## Crash A

BugCheck

SYSTEM_SERVICE_EXCEPTION (0x3B)

Faulting Process

audiodg.exe

Faulting Module

amdacpbus.sys

Failure Bucket

AV_amdacpbus

---

## Crash B

BugCheck

KERNEL_SECURITY_CHECK_FAILURE (0x139)

Failure Bucket

0x139_3_CORRUPT_LIST_ENTRY_KTIMER_LIST_CORRUPTION_nt!KiProcessExpiredTimerList

---

## Crash C

Same failure signature as Crash B.

Failure Hash

```
{9db7945b-255d-24a1-9f2c-82344e883ab8}
```

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

# Disclaimer

This repository documents observed behavior and debugging results.

No conclusions are made regarding the responsibility of any specific vendor. Any references to drivers or software are based solely on publicly available crash dump analysis and observed system behavior.

---

# License

This repository is released under the MIT License unless otherwise specified.

---

# Acknowledgements

Thanks to the Windows debugging community, HP Community members, AMD Community members, Microsoft Learn documentation, and everyone contributing additional testing and analysis.

---

## Contact

If you have reproduced this issue or discovered a workaround, please open a GitHub Issue or submit a Pull Request so the findings can be documented for future users.
