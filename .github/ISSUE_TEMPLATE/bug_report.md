---
name: Bug Report 🐞
about: Did you find a bug?
title: ''
labels: bug, triage
assignees: ''

---

<!--
  Hi there! Thank you for discovering and submitting an issue.

  Before you submit this; let's make sure of a few things.
  Please make sure the following boxes are ticked if they are correct.
  If not, please try and fulfill these first.
-->

<!-- Checked checkbox should look like this: [x] -->
- [ ] I have searched the [issues] of this repo and believe that this is not a duplicate.
- [ ] If an exception occurs when executing a command, I executed it again in debug mode (`DEBUF = True` in settings).

<!--
  Once those are done, if you're able to fill in the following list with your information,
  it'd be very helpful to whoever handles the issue.
-->

### Describe the bug 🐛 

> A clear and precise description of what the bug is, please be descriptive! Thanks 🙌

### To Reproduce 🚶

> Steps to reproduce the behavior:
> 
> 1. Go to '...'
> 2. Click on '....'
> 3. Scroll down to '....'
> 4. See error

### Expected behavior 🚀

> A clear and concise description of what you expected to happen.

### Configuration ⚙️ 

> A clear and concise description of your configuration.
>
> Python 3.11.0
> PostgreSQL Server 14.5
> Django version 4.1.2
> ...

### Screenshots 📸 

> If applicable, add screenshots to help explain your problem.

### Diagnosis attempts 🩺 

> `curl "https://some.domain.name" --verbose`

### Additional context 🌍

> Add any other context about the problem here.

<!-- links -->

[issues]: https://github.com/JV-conseil/ucloud/issues



==============================================================


[<img width="1264" alt="upstream connect error or disconnect:reset before headers  reset reason connection failure" src="https://user-images.githubusercontent.com/8126807/221378949-d513c87c-c750-4bd6-bc36-e5b2bd2e922d.png">](https://stackoverflow.com/a/64096669/2477854)

**[kubernetes - upstream connect error or disconnect/reset before headers. reset reason: connection failure](https://stackoverflow.com/a/64096669/2477854)** 👀 

> I solved it. In my case the yaml file was wrong. I reviewed it and the problem now is solved. Thank you – [stackoverflow.com](https://stackoverflow.com/questions/63408608/upstream-connect-error-or-disconnect-reset-before-headers-reset-reason-connect)



[UCloud][UCloud] public link does not connect with a running Django app 🐍 

When visiting the page <https://app-githubbing.cloud.sdu.dk> we got an error message 🙅‍♂️ 

> upstream connect error or disconnect/reset before headers. reset reason: connection failure

### Configuration ⚙️ 

nginx
Python 3.11.0
PostgreSQL Server 14.5
Django version 4.1.2

### Expected behavior

Display a 🚀 when visiting <https://app-githubbing.cloud.sdu.dk>

### Documentation 📚 

> UCloud utilizes [Kubernetes for Container orchestration][Kubernetes for Container orchestration]. This is used both for the deployment of UCloud and scheduling of user jobs. — [UCloud  3rd party dependencies][Kubernetes for Container orchestration]

### Diagnosis attempts 🩺 

**curl request**

`curl "https://app-githubbing.cloud.sdu.dk" --verbose`👇
