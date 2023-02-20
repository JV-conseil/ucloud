

==================================================================
 Command Lines to start GitHubbing on UCloud with Ubuntu Terminal
==================================================================

Clone the 'ucloud' repo at the root of your working folder

/work/{working-folder}/
├── data/
└── ...

cd /work/{working-folder} || exit
git clone https://github.com/JV-conseil/ucloud.git

/work/{working-folder}/
├── {some-repo}/
├── data/
├── install/
└── ucloud/


Usage

cd /work/{working-folder}/ucloud || exit
bash main.sh


What this script does

- Install packages for Linux with apt.
- Install GitHub CLI
- Authenticate to GitHub.
- Clone / Pull GitHub repositories.


options:

clone           To clone a GitHub repo.
gh auth logout  To logout from GitHub.
gh_cli_install  To install GitHub CLI.
install         To install packages for Linux with apt.
login           To login to GitHub.
update          To update "ucloud" repo.


author:
JV-conseil


version:
2023-02-17
