<!-- markdownlint-disable MD026 MD033 MD041 -->

<a href="https://cloud.sdu.dk/app/applications/overview/" target="_blank" title="UCloud">
<img src="https://docs.cloud.sdu.dk/_static/logo_esc.svg" align="right" alt="UCloud" height="100" style="margin: 0px 0px 0px 0px">
</a>

<!-- omit in toc -->
# GitHubbing on UCloud with Ubuntu Terminal

![visitors](https://visitor-badge.laobi.icu/badge?page_id=JV-conseil.ucloud)
[![UCloud Health Status](https://img.shields.io/website?down_color=red&down_message=down&label=UCloud&up_color=green&up_message=up&url=https%3A%2F%2Fapp-health-status.cloud.sdu.dk%2F)](https://app-health-status.cloud.sdu.dk)
[![Umami - GDPR compliant alternative to Google Analytics](https://img.shields.io/badge/analytics-umami-green)](https://analytics.umami.is/share/M19mr5L7jVhHuFnb/jv-conseil.github.io "Umami - GDPR compliant alternative to Google Analytics")
[![made-with-bash](https://img.shields.io/badge/-Made%20with%20Bash-1f425f.svg?logo=image%2Fpng%3Bbase64%2CiVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw%2FeHBhY2tldCBiZWdpbj0i77u%2FIiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8%2BIDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTExIDc5LjE1ODMyNSwgMjAxNS8wOS8xMC0wMToxMDoyMCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIDIwMTUgKFdpbmRvd3MpIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOkE3MDg2QTAyQUZCMzExRTVBMkQxRDMzMkJDMUQ4RDk3IiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOkE3MDg2QTAzQUZCMzExRTVBMkQxRDMzMkJDMUQ4RDk3Ij4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6QTcwODZBMDBBRkIzMTFFNUEyRDFEMzMyQkMxRDhEOTciIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6QTcwODZBMDFBRkIzMTFFNUEyRDFEMzMyQkMxRDhEOTciLz4gPC9yZGY6RGVzY3JpcHRpb24%2BIDwvcmRmOlJERj4gPC94OnhtcG1ldGE%2BIDw%2FeHBhY2tldCBlbmQ9InIiPz6lm45hAAADkklEQVR42qyVa0yTVxzGn7d9Wy03MS2ii8s%2BeokYNQSVhCzOjXZOFNF4jx%2BMRmPUMEUEqVG36jo2thizLSQSMd4N8ZoQ8RKjJtooaCpK6ZoCtRXKpRempbTv5ey83bhkAUphz8fznvP8znn%2B%2F3NeEEJgNBoRRSmz0ub%2FfuxEacBg%2FDmYtiCjgo5NG2mBXq%2BH5I1ogMRk9Zbd%2BQU2e1ML6VPLOyf5tvBQ8yT1lG10imxsABm7SLs898GTpyYynEzP60hO3trHDKvMigUwdeaceacqzp7nOI4n0SSIIjl36ao4Z356OV07fSQAk6xJ3XGg%2BLCr1d1OYlVHp4eUHPnerU79ZA%2F1kuv1JQMAg%2BE4O2P23EumF3VkvHprsZKMzKwbRUXFEyTvSIEmTVbrysp%2BWr8wfQHGK6WChVa3bKUmdWou%2BjpArdGkzZ41c1zG%2Fu5uGH4swzd561F%2BuhIT4%2BLnSuPsv9%2BJKIpjNr9dXYOyk7%2FBZrcjIT4eCnoKgedJP4BEqhG77E3NKP31FO7cfQA5K0dSYuLgz2TwCWJSOBzG6crzKK%2BohNfni%2Bx6OMUMMNe%2Fgf7ocbw0v0acKg6J8Ql0q%2BT%2FAXR5PNi5dz9c71upuQqCKFAD%2BYhrZLEAmpodaHO3Qy6TI3NhBpbrshGtOWKOSMYwYGQM8nJzoFJNxP2HjyIQho4PewK6hBktoDcUwtIln4PjOWzflQ%2Be5yl0yCCYgYikTclGlxadio%2BBQCSiW1UXoVGrKYwH4RgMrjU1HAB4vR6LzWYfFUCKxfS8Ftk5qxHoCUQAUkRJaSEokkV6Y%2F%2BJUOC4hn6A39NVXVBYeNP8piH6HeA4fPbpdBQV5KOx0QaL1YppX3Jgk0TwH2Vg6S3u%2BdB91%2B%2FpuNYPYFl5uP5V7ZqvsrX7jxqMXR6ff3gCQSTzFI0a1TX3wIs8ul%2Bq4HuWAAiM39vhOuR1O1fQ2gT%2F26Z8Z5vrl2OHi9OXZn995nLV9aFfS6UC9JeJPfuK0NBohWpCHMSAAsFe74WWP%2BvT25wtP9Bpob6uGqqyDnOtaeumjRu%2ByFu36VntK%2FPA5umTJeUtPWZSU9BCgud661odVp3DZtkc7AnYR33RRC708PrVi1larW7XwZIjLnd7R6SgSqWSNjU1B3F72pz5TZbXmX5vV81Yb7Lg7XT%2FUXriu8XLVqw6c6XqWnBKiiYU%2BMt3wWF7u7i91XlSEITwSAZ%2FCzAAHsJVbwXYFFEAAAAASUVORK5CYII%3D)](https://www.gnu.org/software/bash/)
[![Ubuntu 22.10](https://img.shields.io/badge/Ubuntu-22.10-brightgreen)](https://releases.ubuntu.com/kinetic/)
[![Python 3.11](https://img.shields.io/badge/Python-3.11-green)](https://www.python.org/downloads/release/python-311/)
[![License EUPL 1.2](https://img.shields.io/badge/License-EUPL--1.2-blue.svg)](LICENSE)
[![Become a sponsor to JV-conseil](https://img.shields.io/static/v1?label=Sponsor&message=%E2%9D%A4&logo=GitHub&color=%23fe8e86)](https://github.com/sponsors/JV-conseil "Become a sponsor to JV-conseil")
[![Follow JV conseil on StackOverflow](https://img.shields.io/stackexchange/stackoverflow/r/2477854)](https://stackoverflow.com/users/2477854/jv-conseil "Follow JV conseil on StackOverflow")
[![Follow JVconseil on Twitter](https://img.shields.io/twitter/follow/JVconseil.svg?style=social&logo=twitter)](https://twitter.com/JVconseil "Follow JVconseil on Twitter")
[![Follow JVconseil on Mastodon](https://img.shields.io/mastodon/follow/109896584320509054?domain=https%3A%2F%2Ffosstodon.org)](https://fosstodon.org/@JVconseil "Follow JVconseil@fosstodon.org on Mastodon")
[![Follow JV conseil on GitHub](https://img.shields.io/github/followers/JV-conseil?label=JV-conseil&style=social)](https://github.com/JV-conseil "Follow JV-conseil on GitHub")
<!--
[![License BSD 3-Clause](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](LICENSE)
[![PostgreSQL 15.2](https://img.shields.io/badge/PostgreSQL-15.2-green.svg)](https://www.postgresql.org/docs/15/)
<img alt="https://img.shields.io/badge/stack-overflow-orange.svg" src="https://img.shields.io/badge/stack-overflow-orange.svg">
-->

> The missing repo to start GitHubbing on UCloud

![social-media-preview](https://user-images.githubusercontent.com/8126807/219748305-e5d5d517-ec5c-4364-8a61-7baefdaf6f63.png)

## What is UCloud

> UCloud is an interactive digital research environment built to support the needs of researchers for both computing and data management, throughout all the data life cycle — [SDU eScience Center](https://docs.cloud.sdu.dk/index.html)

*This project is in no way affiliated with [GitHub][GitHub], [Ubuntu](https://ubuntu.com), [SDU eScience Center](https://escience.sdu.dk/), [University of Southern Denmark](https://www.sdu.dk/en), [Aalborg University](https://www.aau.dk), [Aarhus Universitet](https://www.au.dk), [Danmarks Tekniske Universitet](https://www.dtu.dk) and [DeiC](https://www.deic.dk) (Danish e-infrastucture Coorperation).*

<img src="https://user-images.githubusercontent.com/8126807/219773779-26b31233-79e3-495a-82bd-5699e3f9131e.gif" alt="The missing repo to start GitHubbing on UCloud" width="100%"/>

## Getting Started 🚀

1. Authenticate on [<kbd>UCloud</kbd>](https://cloud.sdu.dk/app/login) and navigate to [<kbd>Apps</kbd>](https://cloud.sdu.dk/app/applications/overview/) > [<kbd>Terminal Ubuntu</kbd>][UCloud Terminal Ubuntu].

2. Configure a [<kbd>Terminal Ubuntu</kbd>][UCloud Terminal Ubuntu] run with <kbd>"Add folder"</kbd> to select one of your folder then click on <kbd>Submit</kbd>.

3. Once the [<kbd>Terminal Ubuntu</kbd>][UCloud Terminal Ubuntu] job has started, click on the <kbd>Open interface</kbd> blue button in the top right corner.

4. In the opened interface, let's import this repo with the following `bash` commands 👇

    ```bash
    ls -FGlAhp
    cd {your-working-folder} || exit

    git clone https://github.com/JV-conseil/ucloud.git

    cd ucloud || exit
    . main.sh
    ```

5. Now your skeleton should look like this 👇

    ```bash
    /work/{your-working-folder}/
    ├── data/
    ├── database/
    ├── env/
    ├── install/
    ├── jobs/
    ├── {your-gh-repo}/
    └── ucloud/
        └── main.sh
    ```

## Documentation

Extended documentation is available 👉 <https://jv-conseil.github.io/ucloud/>

## Further Readings 📚

> Check also our extended [Further Readings](docs/reading.md) 📚 page in [docs](docs/index.md).

- [UCloud](https://docs.cloud.sdu.dk/index.html) User Guide.
- [UCloud](https://docs.cloud.sdu.dk/dev/index.html) Developer Guide.
- [UCloud](https://docs.cloud.sdu.dk/help/faq.html) Frequently Asked Questions page.
- [UCloud](https://status.cloud.sdu.dk/) Health Status page.
- [UCloud](https://docs.cloud.sdu.dk/dev/backend/service-lib/wiki/third_party_dependencies.html#http-and-websockets) 3rd party dependencies (Docker, Kubernetes, WebSockets...).
- [GitHub CLI](https://cli.github.com/manual/) or gh, is a command-line interface to GitHub for use in your terminal or your scripts.

## Sponsorship

If this project helps you, you can offer me a cup of coffee ☕️ :-)

[![Become a sponsor to JV-conseil](https://img.shields.io/static/v1?label=Sponsor&message=%E2%9D%A4&logo=GitHub&color=%23fe8e86)](https://github.com/sponsors/JV-conseil)

<!-- links -->

[GitHub]: https://github.com/
[UCloud Terminal Ubuntu]: https://cloud.sdu.dk/app/jobs/create?app=terminal-ubuntu&version=0.20.0
