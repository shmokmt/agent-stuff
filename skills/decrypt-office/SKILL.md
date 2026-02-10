---
name: decrypt-office
description: Decrypt password-protected Microsoft Office files using msoffcrypto-tool
version: 0.1.0
---

# Decrypt Office Files

Decrypt password-protected Microsoft Office files (Excel, Word, PowerPoint, etc.) using `msoffcrypto-tool`.

## Instructions

1. **Receive input from the user:**
   - File path to the password-protected Office file
   - Password for decryption

2. **Run the decryption command:**
   - Execute `uvx msoffcrypto-tool <input_file> <output_file> -p <password>`
   - Output file name: prepend `decrypted_` to the original filename
     - Example: `path/to/report.xlsx` → `path/to/decrypted_report.xlsx`

3. **Report the result to the user:**
   - On success: show the output file path
   - On failure: show the error message (e.g., wrong password, unsupported format)
