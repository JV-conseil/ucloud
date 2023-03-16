

=====================================
 Command Lines to run apps on UCloud
=====================================

Clone the "ucloud" repo at the root of your working folder

/work/{your-working-folder}/
├── data/
└── {ucloud}

cd /work/{your-working-folder} || exit

git clone https://github.com/JV-conseil/ucloud.git

Now your skeleton should look like this 👇

/work/{your-working-folder}/
├── data/
├── database/
├── env/
├── install/
├── jobs/
├── {your-gh-repo}/
└── ucloud/
    └── main.sh


Usage

cd /work/{your-working-folder}/ucloud || exit
. main.sh


The missing repo to manage apps on UCloud...

- Start GitHubbing: authenticate, clone, pull your repos.
- PostreSQL: install database and users, activate SSL.
- Django: deployment scripts.
- App: run a Python app.


author:
JV-conseil


version:
2023-02-17

