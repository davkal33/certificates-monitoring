# certificates-monitoring
A tool for monitoring the validity of certificates - remote and local with a notification system (bash,python)

The tools used:
Script language - BASH,
Python,
the crontab.

  Starting the tool:
The first step is to enter the folder path with local certificates and IP addresses with remote certificates in a script: narzedzie_1.sh.

2. then edit mail.py to enter script path (narzedzie_1.sh), which will be launched by calling subprocess.

  The mechanism of operation:
Program mail.py using system call subprocess launches narzedzie_1.sh, which connects via openssl command to server to port 443 (in case of remote certificate) and gets access to certificate view. Then it prints out the information it needs, e.g. if the certificate is valid. After the report is generated, the program automatically sends an e-mail with the attached report in the form of .txt to the administrator. If the certificate expires in less than 30 days, or it has already expired, the report warns us about it. An appropriate entry should be placed in the crontab table to automatically start the tool.

To change  e-mail account, edit mail.py.


