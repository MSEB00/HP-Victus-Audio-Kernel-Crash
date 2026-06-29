# Technical Report

**Project:** HP Victus Audio Kernel Crash Investigation

**Document ID:** HVAKI-TR-001

**Version:** 1.0

**Status:** Under Investigation

**Last Updated:** June 2026

---

# Abstract

This document presents the investigation of a reproducible Windows kernel crash observed on an HP Victus 15-fb0xxx laptop during active gameplay. The failure is consistently triggered following a wired 3.5 mm audio endpoint transition while running Valorant.

Multiple kernel crash dumps, Windows Reliability Monitor entries, Event Viewer logs, and WinDbg analyses have been collected to characterize the failure. Initial evidence identifies an access violation within the AMD Audio Co-Processor (ACP) Bus Driver (`amdacpbus.sys`), while subsequent crashes consistently terminate with **KERNEL_SECURITY_CHECK_FAILURE (BugCheck 0x139)** caused by **FAST_FAIL_CORRUPT_LIST_ENTRY** detected inside the Windows kernel timer subsystem.

This report documents the observed behavior, collected evidence, troubleshooting methodology, and current technical assessment. No conclusion is made regarding responsibility of any individual vendor.

---

# Table of Contents

1. Introduction
2. System Configuration
3. Software Configuration
4. Driver Inventory
5. Problem Description
6. Reproduction Procedure
7. Observed Behaviour
8. Crash Timeline
9. Crash Dump Analysis
10. WinDbg Findings
11. Reliability Monitor Evidence
12. Event Viewer Evidence
13. Troubleshooting Performed
14. Technical Assessment
15. Current Hypothesis
16. Open Questions
17. Future Investigation
18. References

---

# 1. Introduction

During routine gameplay, the system exhibited unexpected kernel failures whenever a wired headset endpoint transitioned while Valorant was actively running.

The issue was initially believed to be a generic system instability. However, repeated reproduction demonstrated that the failure followed a consistent sequence involving the Windows audio subsystem.

The investigation therefore shifted from general troubleshooting to systematic kernel debugging.

---

# 2. System Configuration

## Hardware

| Component | Value                          |
| --------- | ------------------------------ |
| Laptop    | HP Victus 15-fb0xxx            |
| CPU       | AMD Ryzen 5 5600H              |
| GPU       | NVIDIA GeForce RTX 3050 Laptop |
| BIOS      | F.26                           |
| BIOS Date | 20-Mar-2026                    |

---

## Operating System

| Item    | Value                           |
| ------- | ------------------------------- |
| Edition | Windows 11 Home Single Language |
| Build   | 26100.8737                      |

---

# 3. Software Configuration

Gaming workload:

* Valorant

Kernel Anti-cheat:

* Riot Vanguard

Overlay Tested:

* Valorant Tracker

Result:

The issue occurs both with and without the overlay installed.

---

# 4. Driver Inventory

## Realtek

| Driver       | Version    |
| ------------ | ---------- |
| RTKVHD64.sys | 6.0.9692.1 |

---

## AMD

| Driver           | Version  |
| ---------------- | -------- |
| AMD Audio Device | 6.0.1.44 |
| amdacpbus.sys    | 6.0.1.85 |

---

## Microsoft

| Driver       | Version         |
| ------------ | --------------- |
| PortCls.sys  | 10.0.26100.8737 |
| HDAudBus.sys | 10.0.26100.8521 |

---

# 5. Problem Description

A reproducible kernel failure occurs after interacting with a wired 3.5 mm headset while playing Valorant.

The operating system initially remains responsive while the game freezes.

Several seconds later Windows performs a kernel bugcheck and automatically restarts.

---

# 6. Reproduction Procedure

1. Boot Windows.
2. Connect wired headset.
3. Launch Valorant.
4. Join a match.
5. Interact with the 3.5 mm connector.
6. Continue gameplay.

Observed result:

Repeated kernel crash.

---

# 7. Observed Behaviour

```text
Headset transition
        │
        ▼
MMDevAPI endpoint transition
        │
        ▼
Audio playback freezes
        │
        ▼
Valorant freezes
        │
        ▼
Windows desktop remains responsive
        │
        ▼
Kernel detects corruption
        │
        ▼
Black recovery screen
        │
        ▼
Automatic restart
```

---

# 8. Crash Timeline

Crash 1

BugCheck

SYSTEM_SERVICE_EXCEPTION

Faulting Process

audiodg.exe

Faulting Module

amdacpbus.sys

---

Crash 2

BugCheck

0x139

Failure Bucket

CORRUPT_LIST_ENTRY

---

Crash 3

BugCheck

0x139

Identical Failure Bucket

---

The repeated failure bucket strongly indicates that the operating system consistently detects the same underlying kernel corruption.

---

# 9. Crash Dump Analysis

### Crash A

BugCheck

SYSTEM_SERVICE_EXCEPTION (0x3B)

Faulting Driver

amdacpbus.sys

Faulting Process

audiodg.exe

Failure Bucket

AV_amdacpbus

---

### Crash B

BugCheck

KERNEL_SECURITY_CHECK_FAILURE (0x139)

Failure Bucket

CORRUPT_LIST_ENTRY

Detection Function

KiProcessExpiredTimerList()

---

### Crash C

Identical to Crash B

Failure Hash

```
{9db7945b-255d-24a1-9f2c-82344e883ab8}
```

---

# 10. WinDbg Findings

The earliest dump indicates an access violation inside the AMD ACP bus driver.

Subsequent dumps consistently terminate with:

* FAST_FAIL_CORRUPT_LIST_ENTRY
* BugCheck 0x139
* Kernel timer list corruption detection

The timer subsystem appears to detect previously corrupted kernel memory rather than causing the corruption itself.

---

# 11. Reliability Monitor

Reliability Monitor confirms repeated unexpected Windows shutdowns corresponding to the observed kernel crashes.

No application-level exception precedes the bugcheck.

The weekly Reliability Monitor view illustrates the progression of the investigation. Three kernel BugCheck events were recorded over the investigation period (24-Jun, 26-Jun, and 28-Jun), followed by a recovery in the system stability index. As of 29-Jun-2026, no additional Windows failures have been recorded, although further stress testing is required before concluding that the issue has been resolved.

---

# 12. Event Viewer

Event Viewer consistently records unexpected system shutdowns following the reproduced failures.

The collected logs align with the crash dump timestamps.

---

# 13. Troubleshooting Performed

The following corrective actions were attempted.

* HP OEM audio package reinstall
* Realtek audio driver reinstall
* AMD audio driver reinstall
* Realtek Audio Console installation
* BIOS update
* Windows Update
* SFC verification
* DISM verification
* Driver verification
* Multiple headset testing
* Overlay enabled/disabled testing
* WinDbg crash analysis

None permanently resolved the issue.

---

# 14. Technical Assessment

Based solely on collected evidence, the failure appears associated with the Windows audio endpoint transition path during an active gaming workload.

The consistent observations include:

* MMDevAPI endpoint activity
* Earlier crash inside amdacpbus.sys
* Repeated BugCheck 0x139
* Identical failure hash across multiple dumps
* Delayed kernel corruption detection by the Windows timer subsystem

No single component can currently be identified as the definitive source of the corruption.

---

# 15. Current Hypothesis

The collected evidence suggests the following sequence:

```
Audio endpoint transition
        │
        ▼
Kernel-mode audio stack activity
        │
        ▼
Kernel memory corruption
        │
        ▼
Game freeze
        │
        ▼
Windows continues execution
        │
        ▼
Kernel timer processing
        │
        ▼
Integrity check fails
        │
        ▼
BugCheck 0x139
```

This represents a working hypothesis only and is subject to revision as additional evidence becomes available.

---

# 16. Open Questions

* Is the corruption introduced by the AMD ACP driver?
* Is the corruption introduced by Realtek's miniport driver?
* Does Riot Vanguard expose an existing timing issue?
* Is the failure specific to HP's OEM audio implementation?
* Does the issue affect additional HP Victus models?

---

# 17. Future Investigation

Planned tasks include:

* Driver Verifier testing
* ETW audio tracing
* Additional WinDbg analysis
* Cross-version driver comparison
* Testing on newer BIOS revisions
* Community reproduction reports
* Vendor feedback analysis

---

# 18. References

* Windows Reliability Monitor
* Windows Event Viewer
* WinDbg
* Windows Driver Kit (WDK)
* Microsoft BugCheck Documentation
* HP OEM Driver Packages
* AMD Audio Driver Packages
* Realtek Audio Driver Packages

---

## Document Revision History

| Version | Date      | Description            |
| ------- | --------- | ---------------------- |
| 1.0     | June 2026 | Initial public release |
