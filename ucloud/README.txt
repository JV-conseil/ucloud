=================================================================

Command Lines to start GitHubbing on UCloud with Ubuntu Terminal

=================================================================

Clone the 'ucloud' repo at the root of your working folder

cd /work/{working-folder} || exit
git clone https://github.com/JV-conseil/ucloud.git

/work/{working-folder}/
├── data/
└── ...


Usage

cd /work/{working-folder}/ucloud/ucloud
bash run.sh

/work/{working-folder}/
├── {some-repo}/
├── data/
├── install/
└── ucloud/


What the script does

- Install binaries for Linux with apt.
- Authenticate to GitHub.
- Clone / Pull repositories.


options:

clone           To clone a GitHub repo.
delete          To erase the app.
login           To login to GitHub.
gh_cli_install  To install GitHub CLI.
gh auth logout  To logout from GitHub.
update          To update 'ucloud' script.
start           To go back to the launching page.


author:
JV-conseil


version:
2023-02-17
