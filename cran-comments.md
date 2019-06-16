## Test environments

* local: mingw32-3.6.0
* travis:
  - OSs: Ubuntu trusty (14.04.5 LTS), and macOS 10.13 w/ Xcode 9.4.1
  - R:  oldrel, release, and devel (devel only for linux)
* appveyor:
  - OS: Visual Studio 2015 w/ Windows Server 2012 R2 
  - R:  oldrel, patched, release, devel
* r-hub: windows-x86_64-devel, ubuntu-gcc-release, fedora-clang-devel
* win-builder: windows-x86_64-devel

> note: we do not test <= R 3.4 because the package Suggests (for the
    analyses template) the package **rms** which depends on the
    package **mvtnorm**, which is not available there. The package
    itself pass the test up to R 3.2 (fail in R 3.1 because of
    **knitr**), but we prefer to maintain the Suggests on **rms**.

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.
