=================================================

Command Lines to run UCloud with Terminal Ubuntu

=================================================

Copy the all folder ucloud at the root of your working folder.

/work/{some-folder}/
├── data/
└── ucloud/


Usage

cd /work/{some-folder}/ucloud/ucloud
bash run.sh

/work/{some-folder}/
├── {some-repo}/
├── data/
├── install/
└── ucloud/


What the script does

- Install binaries for Linux with apt.
- Authenticate to GitHub.
- Clone / Pull repositories.


options:

delete          To erase the app.
gh auth login   To login to GitHub.
gh auth logout  To logout from GitHub.
update          To update 'ucloud' script.
start           To go back to the launching page.


author:
JV-conseil | JulienVieillefont#7058
contact@jv-conseil.net


version:
2023-02-16 (rev)
2021-11-16
