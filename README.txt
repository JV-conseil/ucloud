

=====================================
 Command Lines to run apps on UCloud
=====================================

Clone the "ucloud" repo at the root of your working folder

/work/{working-folder}/
├── data/
└── {ucloud}

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


The missing repo to manage apps on UCloud...

- Start GitHubbing: authenticate, clone, pull your repos.
- PostreSQL: install database and users, activate SSL.
- Django: deployment scripts.
- App: run a Python app.


author:
JV-conseil


version:
2023-02-17

