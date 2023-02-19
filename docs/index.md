<!-- markdownlint-disable MD026 MD033 MD041 -->

<a href="https://cloud.sdu.dk/app/applications/overview/" target="_blank" title="UCloud">
<img src="https://docs.cloud.sdu.dk/_static/logo_esc.svg" align="right" alt="UCloud" height="100" style="margin: 0px 0px 0px 0px">
</a>

<!-- omit in toc -->
# GitHubbing on UCloud with Ubuntu Terminal

[![Ubuntu 22.10](https://img.shields.io/badge/Ubuntu-22.10-brightgreen)](https://releases.ubuntu.com/kinetic/)
[![Python 3.11.1](https://img.shields.io/badge/Python-3.11.1-green)](https://www.python.org/downloads/release/python-3111/)
[![License BSD 3-Clause](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](LICENSE)
[![Become a sponsor to JV-conseil](https://img.shields.io/static/v1?label=Sponsor&message=%E2%9D%A4&logo=GitHub&color=%23fe8e86)](https://github.com/sponsors/JV-conseil)
[![Follow JV conseil – Internet Consulting on Twitter](https://img.shields.io/twitter/follow/JVconseil.svg?style=social&logo=twitter)](https://twitter.com/JVconseil)
<!--[![PostgreSQL 14.6](https://img.shields.io/badge/PostgreSQL-14.6-green.svg)](https://www.postgresql.org/docs/14.6/)-->

> The missing repo to start GitHubbing on UCloud with Ubuntu Terminal.

![social-media-preview](https://user-images.githubusercontent.com/8126807/219748305-e5d5d517-ec5c-4364-8a61-7baefdaf6f63.png)

## What is UCloud

> UCloud is an interactive digital research environment built to support the needs of researchers for both computing and data management, throughout all the data life cycle — [SDU eScience Center][UCloud User Guide]

*This project is in no way affiliated with [GitHub](https://github.com/), [Ubuntu](https://ubuntu.com), [SDU eScience Center][SDU eScience Center], [University of Southern Denmark](https://www.sdu.dk/en), [Aalborg University](https://www.aau.dk), [Aarhus Universitet](https://www.au.dk), [Danmarks Tekniske Universitet](https://www.dtu.dk) and [DeiC](https://www.deic.dk) (Danish e-infrastucture Coorperation).*

## Usage

Authenticate on [UCloud](https://cloud.sdu.dk/app/login).

Navigate to [<kbd>Apps</kbd>][UCloud Apps] > [<kbd>Terminal Ubuntu</kbd>][UCloud Terminal Ubuntu]

Configure a [<kbd>Terminal Ubuntu</kbd>][UCloud Terminal Ubuntu] run with <kbd>"Add folder"</kbd> to select one of your folder then click on <kbd>Submit</kbd>

Once [<kbd>Terminal Ubuntu</kbd>][UCloud Terminal Ubuntu] job is running click on <kbd>Open terminal</kbd>

Then copy paste the following `bash` commands.

```bash
ls -FGlAhp
cd {your-working-folder} || exit

git clone https://github.com/JV-conseil/ucloud.git
ls -FGlAhp

cd ucloud
git pull

cd github
. run.sh
```

![The missing repo to start GitHubbing on UCloud with Ubuntu Terminal](https://user-images.githubusercontent.com/8126807/219773779-26b31233-79e3-495a-82bd-5699e3f9131e.gif)

## Available options

```md
# Command Lines to start GitHubbing on UCloud with Ubuntu Terminal

Clone the 'ucloud' repo at the root of your working folder

cd /work/{working-folder} || exit
git clone https://github.com/JV-conseil/ucloud.git

/work/{working-folder}/
├── data/
└── ...

## Usage

cd /work/{working-folder}/ucloud/github
bash run.sh

/work/{working-folder}/
├── {some-repo}/
├── data/
├── install/
└── ucloud/

## What the script does

- Install packages for Linux with apt.
- Authenticate to GitHub.
- Clone / Pull repositories.

## Options

clone           To clone a GitHub repo.
delete          To erase the app.
login           To login to GitHub.
gh_cli_install  To install GitHub CLI.
gh auth logout  To logout from GitHub.
update          To update 'ucloud' script.
start           To go back to the launching page.
```

## Running an app on UCloud

Once you are in sync with your [GitHub][GitHub] repos, follow guidelines in the sample [app_run_script](app_run_script/README.md) folder to run your app on UCloud.

When your UCloud folder structure will look like this.

```bash
/work/{your-working-folder}/
├── data/
└── {your-repo}/
    └── .bash/
        └── ucloud/
            └── run.sh
├── install/
└── ucloud/
    └── github/
            └── run.sh
```

Then you can run the script of the app.

```bash
cd /work/{your-working-folder}/{your-repo}/.bash/ucloud/ || exit
. run.sh
```

## Further Readings 📚

- [UCloud][UCloud User Guide] User Guide.
- [UCloud][UCloud Developer Guide] Developer Guide.
- [Awesome Bash][Awesome Bash] A curated list of delightful Bash scripts and resources.
- [The Ultimate Guide to Modularizing Bash Script Code][The Ultimate Guide to Modularizing Bash Script Code] by Shinichi Okada (medium.com).
- [Shell Scripting for Beginners][Shell Scripting for Beginners – How to Write Bash Scripts in Linux] — How to Write Bash Scripts in Linux (freecodecamp.org).
- [GitHub CLI][GitHub CLI manual] or gh, is a command-line interface to GitHub for use in your terminal or your scripts.
- [Google Shell Style Guide][Google Shell Style Guide] v2.02.
- [How to use a key-value dictionary][How to use a key-value dictionary in bash] in bash.

## Sponsorship

If this project helps you, you can offer me a cup of coffee ☕️ :-)

<!-- [![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/R5R018CIU) -->

[![Become a sponsor to JV-conseil](https://img.shields.io/static/v1?label=Sponsor&message=%E2%9D%A4&logo=GitHub&color=%23fe8e86)](https://github.com/sponsors/JV-conseil)

<!-- Links -->

[Awesome Bash]: https://github.com/awesome-lists/awesome-bash
[GitHub CLI manual]: https://cli.github.com/manual/
[GitHub]: https://github.com/
[Google Shell Style Guide]: https://google.github.io/styleguide/shellguide.html
[How to use a key-value dictionary in bash]: https://www.xmodulo.com/key-value-dictionary-bash.html
[SDU eScience Center]: https://escience.sdu.dk/
[Shell Scripting for Beginners – How to Write Bash Scripts in Linux]: https://www.freecodecamp.org/news/shell-scripting-crash-course-how-to-write-bash-scripts-in-linux/
[The Ultimate Guide to Modularizing Bash Script Code]: https://medium.com/mkdir-awesome/the-ultimate-guide-to-modularizing-bash-script-code-f4a4d53000c2
[UCloud Apps]: https://cloud.sdu.dk/app/applications/overview/
[UCloud Developer Guide]: https://docs.cloud.sdu.dk/dev/index.html
[UCloud Terminal Ubuntu]: https://cloud.sdu.dk/app/jobs/create?app=terminal-ubuntu&version=0.20.0
[UCloud User Guide]: https://docs.cloud.sdu.dk/index.html
