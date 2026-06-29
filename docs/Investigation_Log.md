# Investigation Log

**Project:** HP Victus Audio Kernel Crash Investigation

**Document:** Investigation Log

**Purpose:** Chronological engineering log documenting observations, experiments, hypotheses, debugging steps, and conclusions throughout the investigation.

---

# Investigation Status

| Item           | Status    |
| -------------- | --------- |
| First Observed | Completed |
| Reproducible   | Yes       |
| Root Cause     | Unknown   |
| Investigation  | Ongoing   |

---

# Timeline

---

## Entry 001

### Initial Observation

While playing **Valorant**, the game unexpectedly froze.

Several seconds later Windows displayed a black recovery screen and automatically restarted.

Initially this appeared to be a random crash.

---

### Initial Assumption

Possible causes included:

* GPU driver
* Windows corruption
* Memory instability
* Riot Vanguard
* Hardware instability

---

## Entry 002

### Additional Observation

The crash occurred multiple times.

A pattern began to emerge.

The issue appeared while using a wired headset.

---

### Action

Collected Reliability Monitor history.

Collected Event Viewer logs.

Enabled kernel memory dumps.

---

## Entry 003

### Crash Dump Analysis

The first crash dump was opened in WinDbg.

BugCheck:

```text
SYSTEM_SERVICE_EXCEPTION (0x3B)
```

Faulting process:

```text
audiodg.exe
```

Faulting module:

```text
amdacpbus.sys
```

---

### Observation

The first kernel crash involved the AMD Audio Co-Processor Bus Driver.

At this point the investigation shifted toward the Windows audio stack.

---

## Entry 004

### Driver Investigation

Investigated installed drivers.

Verified:

* Realtek HD Audio
* AMD Audio Device
* AMD ACP Bus
* Microsoft Audio Components

---

### Action

Reinstalled HP OEM audio package.

---

### Result

Issue persisted.

---

## Entry 005

### Audio Investigation

The microphone stopped functioning after driver reinstall.

Speaker routing also became inconsistent.

Installed:

* Realtek Audio Console

---

### Result

Speaker functionality returned.

Microphone functionality recovered.

However, kernel crashes continued.

---

## Entry 006

### Pattern Recognition

Repeated testing identified a common trigger.

Crash sequence:

```text
Move headset connector

↓

Audio freezes

↓

Valorant freezes

↓

Windows still responds

↓

5–10 seconds

↓

Automatic restart
```

---

### Observation

The operating system does **not** freeze immediately.

Only the game and audio subsystem stop responding.

---

## Entry 007

### Overlay Investigation

Tested with:

* Valorant Tracker enabled

Result:

Crash reproduced.

Removed overlay.

Result:

Crash reproduced again.

---

### Conclusion

Overlay software is **not** required.

---

## Entry 008

### Hardware Investigation

Repeated testing using:

* Headset A
* Headset B

Both reproduced the issue.

---

### Conclusion

The problem is not specific to one headset.

---

## Entry 009

### Driver Version Documentation

Documented:

* BIOS
* Windows Build
* AMD Audio Driver
* Realtek Driver
* NVIDIA Driver
* Microsoft Audio Components

Repository updated accordingly.

---

## Entry 010

### WinDbg Analysis

Additional crash dumps analyzed.

Observed:

```text
BugCheck 0x139
```

Failure:

```text
FAST_FAIL_CORRUPT_LIST_ENTRY
```

Detection:

```text
KiProcessExpiredTimerList()
```

---

### Observation

Windows consistently detected corruption inside the kernel timer subsystem.

---

## Entry 011

### Correlation

Earlier dump:

```text
SYSTEM_SERVICE_EXCEPTION

↓

amdacpbus.sys
```

Later dumps:

```text
BugCheck 0x139

↓

Kernel timer detects corruption
```

---

### Working Theory

Kernel memory corruption likely occurs before the timer subsystem reports it.

The timer subsystem appears to detect existing corruption rather than causing it.

---

## Entry 012

### Plug-and-Play Investigation

BlackBoxPnP consistently reports:

```text
SWD\MMDEVAPI
```

---

### Observation

The reported device belongs to the Windows Multimedia Device API endpoint layer.

This aligns with every reproduced failure beginning immediately after an audio endpoint transition.

---

## Entry 013

### Driver Verification

Verified installed versions:

* RTKVHD64.sys
* amdacpbus.sys
* PortCls.sys
* HDAudBus.sys

No unexpected versions were observed.

---

## Entry 014

### Reproducibility

Current known reproduction sequence:

1. Boot Windows
2. Connect wired headset
3. Launch Valorant
4. Join match
5. Interact with 3.5 mm connector
6. Continue playing

Observed:

Repeated kernel crash.

---

## Entry 015

### Current Technical Assessment

Current evidence suggests an interaction involving:

* Windows MMDevAPI
* Audio endpoint transition
* AMD ACP
* Realtek HD Audio
* Windows audio stack
* Active gaming workload

The precise source of corruption remains unknown.

---

# Investigation Metrics

| Item                   | Status             |
| ---------------------- | ------------------ |
| Crash Dumps Collected  | 3                  |
| WinDbg Sessions        | Multiple           |
| Reliability Logs       | Collected          |
| Event Viewer Logs      | Collected          |
| Driver Reinstallations | Completed          |
| BIOS Updated           | Yes                |
| Windows Updated        | Yes                |
| Headsets Tested        | Multiple           |
| Overlay Tested         | Enabled & Disabled |
| Reproducible           | Yes                |

---

# Current Hypothesis

Current evidence suggests the following sequence:

```text
3.5 mm endpoint transition

↓

Windows MMDevAPI

↓

Kernel-mode audio processing

↓

Kernel memory corruption

↓

Game freezes

↓

Windows continues executing

↓

Timer subsystem validates linked list

↓

Integrity failure detected

↓

BugCheck 0x139

↓

Automatic restart
```

This remains a working hypothesis and will be revised as additional evidence becomes available.

---

# Next Investigation Tasks

* [ ] Enable Driver Verifier for selected audio drivers
* [ ] Collect ETW audio traces
* [ ] Compare older HP audio packages
* [ ] Test newer BIOS releases
* [ ] Test different Windows builds
* [ ] Collect additional kernel dumps
* [ ] Compare with community reports
* [ ] Obtain vendor feedback

---

# Changelog

| Date      | Update                          |
| --------- | ------------------------------- |
| June 2026 | Investigation initiated         |
| June 2026 | First WinDbg analysis completed |
| June 2026 | Reproduction sequence confirmed |
| June 2026 | Repository created              |
