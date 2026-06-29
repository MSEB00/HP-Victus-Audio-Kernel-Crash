# Reproduction Guide

**Project:** HP Victus Audio Kernel Crash Investigation

**Document:** Reproduction Guide

**Purpose:** Provide a repeatable procedure for reproducing the kernel crash observed during wired audio endpoint transitions while gaming.

---

# Reproduction Status

| Item                   | Status                         |
| ---------------------- | ------------------------------ |
| Reproducible           | Yes                            |
| Reproduction Frequency | High (under tested conditions) |
| Hardware Dependent     | Unknown                        |
| Software Dependent     | Under Investigation            |

---

# Test Environment

## Laptop

* HP Victus 15-fb0xxx

## BIOS

* Version: F.26
* Date: 20-Mar-2026

## Operating System

* Windows 11 Home Single Language
* Build: 26100.8737

## CPU

* AMD Ryzen 5 5600H

## GPU

* NVIDIA GeForce RTX 3050 Laptop GPU

## Audio Stack

* Realtek High Definition Audio
* AMD Audio Co-Processor (ACP)
* Windows MMDevAPI
* Microsoft PortCls
* HDAudBus

---

# Required Software

* Valorant
* Riot Vanguard

Optional (not required):

* Valorant Tracker

The issue has been reproduced both with and without Valorant Tracker installed.

---

# Required Hardware

The issue has been reproduced using multiple wired headsets.

Example:

* Trigger Trinity 2 using Ambrane 3.5 mm wired Jack
* Additional 3.5 mm wired headset (different model)

This suggests the issue is **not limited to a specific headset**.

---

# Preconditions

Before beginning:

* Windows boots normally.
* Wired headset is connected through the 3.5 mm audio jack.
* Audio playback is functioning correctly.
* Valorant launches successfully.
* No other abnormal system behavior is observed.

---

# Reproduction Procedure

## Method 1 – Primary Reproduction

1. Boot Windows normally.
2. Connect a wired 3.5 mm headset.
3. Launch Valorant.
4. Join an active match.
5. Begin normal gameplay.
6. While the game is running, interact with the headset connector by:

   * Slightly moving the connector.
   * Reinserting the connector.
   * Plugging or unplugging the headset.
7. Continue playing.

---

# Expected Result

The operating system should:

* Detect the audio endpoint transition.
* Switch audio devices normally.
* Continue gameplay without interruption.

No crash should occur.

---

# Actual Result

Observed sequence:

```text
3.5 mm headset interaction

↓

Audio output freezes

↓

Valorant freezes

↓

Windows desktop continues responding

↓

Approximately 5–10 seconds

↓

Display turns black

↓

Automatic recovery begins

↓

System restarts
```

---

# Important Observation

The operating system **does not become completely unresponsive immediately**.

Observed behavior:

* Mouse cursor may continue moving.
* Windows remains active briefly.
* Only the game and audio processing stop responding initially.
* The kernel bugcheck occurs several seconds later.

This suggests that kernel corruption likely occurs **before** Windows detects the integrity failure.

---

# Timing Characteristics

Approximate timeline:

| Event                                | Time                           |
| ------------------------------------ | ------------------------------ |
| Audio endpoint transition            | Immediate                      |
| Audio freeze                         | Immediate                      |
| Game freeze                          | Immediate                      |
| Windows remains partially responsive | ~5–10 seconds                  |
| Black recovery screen                | After delay                    |
| Automatic restart                    | Immediately after black screen |

---

# Reproduction Success Indicators

A successful reproduction includes **all** of the following:

* Audio freezes.
* Valorant freezes.
* No immediate BSOD is displayed.
* Screen turns black after several seconds.
* Windows automatically restarts.
* A new kernel dump is generated.
* Reliability Monitor records a Critical Event.

---

# Collected Evidence

Successful reproductions generated:

* Kernel memory dump (.dmp)
* Reliability Monitor entry
* Event Viewer logs
* WinDbg analysis
* BlackBox PnP information
* BlackBox Winlogon information

---

# Crash Signatures Observed

## Crash Type A

```text
SYSTEM_SERVICE_EXCEPTION (0x3B)
```

Faulting process:

```text
audiodg.exe
```

Faulting driver:

```text
amdacpbus.sys
```

---

## Crash Type B

```text
KERNEL_SECURITY_CHECK_FAILURE (0x139)
```

Failure:

```text
FAST_FAIL_CORRUPT_LIST_ENTRY
```

Detection point:

```text
nt!KiProcessExpiredTimerList()
```

Repeated failure hash:

```text
{9db7945b-255d-24a1-9f2c-82344e883ab8}
```

---

# Variables Tested

| Variable                        | Tested | Result                                 |
| ------------------------------- | ------ | -------------------------------------- |
| Valorant Tracker Enabled        | Yes    | Crash reproduced                       |
| Valorant Tracker Disabled       | Yes    | Crash reproduced                       |
| Different Wired Headset         | Yes    | Crash reproduced                       |
| HP OEM Audio Driver Reinstalled | Yes    | Crash persists                         |
| Realtek Audio Console Installed | Yes    | Audio routing restored; crash persists |
| BIOS Updated                    | Yes    | Crash persists                         |
| Windows Updated                 | Yes    | Crash persists                         |

---

# Notes

The issue has only been reproduced while **Valorant is actively running**.

Current evidence suggests that gameplay alone is **not sufficient** to trigger the issue.

The trigger consistently involves **interaction with the 3.5 mm audio endpoint during active gameplay**, indicating a likely software interaction between the Windows audio stack and the gaming workload.

Further testing with additional DirectX games is recommended to determine whether the issue is Valorant-specific or affects a broader class of applications.
