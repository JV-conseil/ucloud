

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

- Install packages for Linux with apt.
- Authenticate to GitHub.
- Clone / Pull repositories.


options:

clone           To clone a GitHub repo.
delete          To erase the app.
gh auth logout  To logout from GitHub.
gh_cli_install  To install GitHub CLI.
install         To install packages for Linux with apt.
login           To login to GitHub.
start           To go back to the launching page.
update          To update 'ucloud' script.


author:
JV-conseil


version:
2023-02-17
