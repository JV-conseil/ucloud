<!-- markdownlint-disable MD026 MD033 MD041 -->

<a href="https://cloud.sdu.dk/app/applications/overview/" target="_blank" title="UCloud">
<img src="https://docs.cloud.sdu.dk/_static/logo_esc.svg" align="right" alt="UCloud" height="150" style="margin: -12px 10px 0px 0px">
</a>

<!-- omit in toc -->
# GitHubbing on UCloud with Ubuntu Terminal

[![Ubuntu 22.10](https://img.shields.io/badge/Ubuntu-22.10-brightgreen)](https://releases.ubuntu.com/kinetic/)
[![Python 3.11.1](https://img.shields.io/badge/Python-3.11.1-green)](https://www.python.org/downloads/release/python-3111/)
<!--[![PostgreSQL 14.6](https://img.shields.io/badge/PostgreSQL-14.6-green.svg)](https://www.postgresql.org/docs/14.6/)-->
[![License BSD 3-Clause](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](LICENSE)
[![Become a sponsor to JV-conseil](https://img.shields.io/static/v1?label=Sponsor&message=%E2%9D%A4&logo=GitHub&color=%23fe8e86)](https://github.com/sponsors/JV-conseil)
[![Follow JV conseil – Internet Consulting on Twitter](https://img.shields.io/twitter/follow/JVconseil.svg?style=social&logo=twitter)](https://twitter.com/JVconseil)

> The missing repo to start GitHubbing on UCloud with Ubuntu Terminal.

## What is UCloud

> UCloud is an interactive digital research environment built to support the needs of researchers for both computing and data management, throughout all the data life cycle — [SDU
eScience Center][UCloud User Guide]

## Usage

Authenticate on [UCloud](https://cloud.sdu.dk/app/login).

Navigate to <kbd>[Apps][UCloud Apps]</kbd> > <kbd>[Terminal Ubuntu][UCloud Terminal Ubuntu]</kbd>.

Configure a <kbd>[Terminal Ubuntu][UCloud Terminal Ubuntu]</kbd> run with <kbd>"Add folder"</kbd> to select one of your folder then click on <kbd>Submit</kbd>.

Once <kbd>[Terminal Ubuntu][UCloud Terminal Ubuntu]</kbd> job is running click on <kbd>Open terminal</kbd>.

Then copy paste the following `bash` commands.

```bash
ls
cd {your-working-folder}
git clone https://github.com/JV-conseil/ucloud.git
ls
cd ucloud
git pull
cd ucloud
. run.sh
```

## Further Readings 📚

- [UCloud][UCloud User Guide] User Guide.
- [UCloud][UCloud Developer Guide] Developer Guide.
- [Awesome Bash][Awesome Bash] A curated list of delightful Bash scripts and resources.
- [The Ultimate Guide to Modularizing Bash Script Code][The Ultimate Guide to Modularizing Bash Script Code] by Shinichi Okada (medium.com).
- [Shell Scripting for Beginners][Shell Scripting for Beginners – How to Write Bash Scripts in Linux] — How to Write Bash Scripts in Linux (freecodecamp.org).

## Sponsorship

If this project helps you, you can offer me a cup of coffee ☕️ :-)

<!-- [![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/R5R018CIU) -->

[![Become a sponsor to JV-conseil](https://img.shields.io/static/v1?label=Sponsor&message=%E2%9D%A4&logo=GitHub&color=%23fe8e86)](https://github.com/sponsors/JV-conseil)

<!-- Links -->

[Awesome Bash]: https://github.com/awesome-lists/awesome-bash
[Shell Scripting for Beginners – How to Write Bash Scripts in Linux]: https://www.freecodecamp.org/news/shell-scripting-crash-course-how-to-write-bash-scripts-in-linux/
[The Ultimate Guide to Modularizing Bash Script Code]: https://medium.com/mkdir-awesome/the-ultimate-guide-to-modularizing-bash-script-code-f4a4d53000c2
[UCloud Apps]: https://cloud.sdu.dk/app/applications/overview/
[UCloud Developer Guide]: https://docs.cloud.sdu.dk/dev/index.html
[UCloud Terminal Ubuntu]: https://cloud.sdu.dk/app/jobs/create?app=terminal-ubuntu&version=0.20.0
[UCloud User Guide]: https://docs.cloud.sdu.dk/index.html
