# Timeline

**Project:** HP Victus Audio Kernel Crash Investigation

**Document:** Timeline

**Purpose:** Maintain a chronological record of the observed issue, troubleshooting performed, evidence collected, and major findings throughout the investigation.

---

# Investigation Timeline

---

## Initial Observation

### Symptoms

The issue was initially observed while playing **Valorant** using a wired **3.5 mm headset**.

Unexpected behavior included:

* Audio suddenly freezing
* Valorant freezing
* Windows remaining partially responsive
* Display turning black after several seconds
* Automatic system restart

No traditional Blue Screen of Death (BSOD) was displayed.

---

## Initial Assumption

Possible causes considered:

* Defective headset
* Faulty 3.5 mm jack
* Windows corruption
* Audio driver corruption
* GPU driver issue

No conclusions were made at this stage.

---

## Windows Health Verification

The operating system was verified using Microsoft's servicing tools.

Performed:

* SFC
* DISM
* Component Store Cleanup
* Windows Update verification

Result:

No evidence suggested severe operating system corruption capable of explaining the crashes.

---

## Audio Driver Investigation

HP OEM audio package was reinstalled.

Realtek audio drivers were reinstalled.

Realtek Audio Console was installed.

During testing:

* Speaker routing temporarily stopped functioning.
* Audio endpoint configuration was restored after installing the Realtek Audio Console.
* Microphone behavior also changed during troubleshooting before returning to normal operation.

These actions resolved several endpoint routing issues but **did not eliminate the system crashes**.

---

## Driver Enumeration

Verified installed drivers including:

* Realtek HD Audio
* AMD Audio Device
* AMD ACP Bus Driver
* Audio Processing Objects
* Windows Audio Endpoints

Confirmed:

* Drivers loaded successfully.
* No missing audio drivers.
* No unknown devices in Device Manager.

---

## Reproduction Testing

Repeated testing demonstrated the issue could be reproduced.

Observed trigger:

* Active Valorant gameplay
* Interaction with wired 3.5 mm headset

  * Plugging
  * Unplugging
  * Reinserting
  * Slight connector movement

The crash was reproduced using multiple wired headsets.

---

## Overlay Investigation

Valorant Tracker was suspected.

Testing performed:

* Tracker enabled
* Tracker disabled

Result:

Crash reproduced under both conditions.

Conclusion:

Valorant Tracker is **not a required condition**.

---

## First Kernel Dump Analysis

WinDbg identified:

BugCheck:

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

This suggested a possible interaction involving the AMD Audio Co-Processor driver.

---

## Subsequent Kernel Dumps

Additional crashes generated:

```text
BugCheck 0x139
```

Failure bucket:

```text
0x139_3_CORRUPT_LIST_ENTRY_KTIMER_LIST_CORRUPTION_nt!KiProcessExpiredTimerList
```

The same failure bucket appeared across multiple independent crashes.

---

## WinDbg Investigation

Kernel analysis included:

* !analyze -v
* lm
* lmvm
* !blackboxpnp
* !blackboxntfs
* !blackboxwinlogon
* !thread
* !timer

Findings:

* Repeated kernel linked-list corruption
* MMDevAPI endpoint activity recorded before crash
* No NTFS errors
* No storage-related failures

---

## Trigger Refinement

Further testing showed:

Simply playing Valorant was generally stable.

The crash consistently occurred after interacting with the wired headset during gameplay.

Observed sequence:

```text
Audio endpoint transition

↓

Audio freezes

↓

Valorant freezes

↓

Windows remains responsive

↓

Approximately 5–10 seconds

↓

Kernel bugcheck

↓

Automatic restart
```

---

## Additional Observation

An important behavior was identified:

The operating system continues responding for several seconds after the game freezes.

Examples:

* Mouse remains usable.
* Windows does not immediately crash.
* Only the game and audio processing stop first.

This indicates that kernel corruption likely occurs before Windows detects the integrity violation.

---

## Driver Version Verification

Verified versions:

Realtek HD Audio

* 6.0.9692.1

AMD Audio Device

* 6.0.1.44

AMD ACP Bus Driver

* 6.0.1.85

BIOS

* F.26

Operating System

* Windows 11 Build 26100.8737

---

## Repository Created

A public investigation repository was created to preserve:

* Crash dumps
* WinDbg analysis
* Driver information
* Event Viewer logs
* Reliability Monitor reports
* Reproduction procedures
* Technical reports

The objective is to assist HP, AMD, Microsoft, Riot Games, and other affected users in identifying the root cause.

---

# Current Status

| Item                                    | Status  |
| --------------------------------------- | ------- |
| Issue reproducible                      | Yes     |
| Multiple crash dumps collected          | Yes     |
| WinDbg analysis completed               | Yes     |
| Driver versions documented              | Yes     |
| Reproduction procedure documented       | Yes     |
| Root cause identified                   | Not yet |
| Public investigation repository created | Yes     |

---

# Current Working Hypothesis

Current evidence suggests that the failure originates during a wired audio endpoint transition while Valorant is running.

The recurring BugCheck signatures, repeated reproduction pattern, earlier `amdacpbus.sys` involvement, and MMDevAPI Plug and Play activity collectively indicate a likely software interaction within the Windows audio subsystem.

At present, there is insufficient evidence to attribute the defect to a single vendor component. The interaction may involve one or more of the following:

* Windows Audio Stack
* AMD ACP Audio Drivers
* Realtek HD Audio Drivers
* HP OEM Audio Components
* Riot Vanguard
* Valorant

Further analysis using private symbols and Driver Verifier would be required to identify the component responsible for the initial kernel memory corruption.

---

# Investigation Status

**Status:** Active

The investigation remains ongoing. New crash dumps, additional reproduction scenarios, updated driver versions, and future findings will be appended to this timeline as they become available.
