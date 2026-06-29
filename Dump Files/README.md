# Kernel Dump Collection

This directory contains all kernel memory dumps collected during the investigation of a reproducible Windows kernel crash affecting an HP Victus 15-fb0xxx during wired audio endpoint transitions while gaming.

## Dump Inventory

| Dump File           | Date        | Status   | Notes                                    |
| ------------------- | ----------- | -------- | ---------------------------------------- |
| 061826-44000-01.dmp | 18-Jun-2026 | Archived | First recorded crash                     |
| 062326-23562-01.dmp | 23-Jun-2026 | Archived | Early investigation                      |
| 062326-31781-01.dmp | 23-Jun-2026 | Archived | Early investigation                      |
| 062326-44265-01.dmp | 23-Jun-2026 | Archived | Early investigation                      |
| 062426-25531-01.dmp | 24-Jun-2026 | Analyzed | Preceded detailed investigation          |
| 062626-21953-01.dmp | 26-Jun-2026 | Analyzed | First confirmed recurring BugCheck 0x139 |
| 062826-21593-01.dmp | 28-Jun-2026 | Analyzed | Same BugCheck and failure bucket         |

## Observed Pattern

The later crash dumps consistently report:

* **BugCheck:** `0x139 (KERNEL_SECURITY_CHECK_FAILURE)`
* **Fast Fail:** `FAST_FAIL_CORRUPT_LIST_ENTRY`
* **Failure Bucket:**

  ```
  0x139_3_CORRUPT_LIST_ENTRY_KTIMER_LIST_CORRUPTION_nt!KiProcessExpiredTimerList
  ```
* **Failure Hash:**

  ```
  {9db7945b-255d-24a1-9f2c-82344e883ab8}
  ```

Earlier dumps have been retained for historical comparison and may help identify when the issue first appeared or whether the failure signature evolved over time.

## Download

Due to GitHub file size considerations, the original crash dump files are hosted on Google Drive.

**Google Drive (Kernel Dump Collection):**

https://drive.google.com/drive/folders/1LB8lVZBJ2sOJ5Y7boibF_O57x6I2YvNP?usp=drive_link

## Related Documentation

* `docs/Technical_Report.md`
* `docs/WinDbg_Analysis.md`
* `docs/Reproduction.md`
* `docs/Investigation_Log.md`
* `docs/Timeline.md`

For additional logs, screenshots, and driver information, refer to the repository documentation.
