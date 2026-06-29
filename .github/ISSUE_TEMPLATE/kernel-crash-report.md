---
name: Kernel Crash Report
about: Submit a reproducible kernel crash or audio-related issue to help expand this
  investigation.
title: "[BUG] Short description of the crash"
labels: amd, audio, bug, kernal, realtek, reproducible, windows
assignees: ''

---

## Describe the issue

Provide a clear and concise description of the problem.

Example:

- Audio freezes first
- Game freezes
- Windows automatically reboots after a few seconds
- Black screen before restart
- BSOD visible or hidden

---

## Reproduction Steps

1. Laptop model:
2. BIOS version:
3. Windows version:
4. Game/Application:
5. Audio device used:
6. Wired or Bluetooth:
7. Steps performed:
8. Is the issue reproducible? (Always / Sometimes / Once)

---

## Expected Behavior

Describe what should have happened instead.

---

## Actual Behavior

Describe exactly what happened.

Include the sequence if possible.

Example:

Audio → Game Freeze → Black Screen → Automatic Restart

---

## System Information

**Laptop Model:**

**CPU:**

**GPU:**

**Windows Build:**

**BIOS Version:**

---

## Audio Configuration

**Realtek Driver Version:**

**AMD ACP Driver Version:**

**Audio Device:**

**3.5 mm Jack / USB / Bluetooth:**

---

## Crash Information

**BugCheck Code (if available):**

**Failure Bucket:**

**Failure Hash:**

**Dump File Available?**

- [ ] Yes
- [ ] No

---

## WinDbg Analysis (Optional)

Paste the important output from:

```text
!analyze -v
```

If available, also include:

```text
!blackboxpnp
lmvm RTKVHD64
lmvm amdacpbus
```

---

## Reliability Monitor

Please attach screenshots from Reliability Monitor if available.

---

## Event Viewer

Relevant Event IDs (if known):

---

## Additional Evidence

Attach any of the following if available:

- Screenshots
- Minidumps
- Event Viewer logs
- Driver versions
- DxDiag
- PowerShell output

---

## Additional Notes

Anything else that may help reproduce or investigate the issue.

Examples:

- Works normally until headset is replugged.
- Happens only while gaming.
- Only occurs with Valorant.
- Happens with multiple wired headsets.
- Does not occur over Bluetooth.
