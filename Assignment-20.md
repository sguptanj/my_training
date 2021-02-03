# Assignment 20

**Problem Statement:**
- Create a Jenkins shared library to read a property file in which we can enable and disable CI check for a Java-based project. -  - Include code stability, code quality, code coverage, and, unit testing 
- A property file example could be like this:

      - code_stability = true 
      - code_quality = false 
      - code_coverage = true 
      - unit_test = true 
      - code_quality_report_path = <path> 
      - code_coverage_report_path = <path> 
      - unit_test_report_path = <path> 
- Make sure in case of a disabled step, the stage should not view under stage view.
