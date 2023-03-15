> Validate UCloud as a stable cloud service to serve Python Django web app coupled with a PostgreSQL Server.
> Provided UCloud is up and running 👉 <https://status.cloud.sdu.dk/>

<img width="2560" alt="app-thalassa cloud sdu dk running in DEBUG=False with cache activated and collectstatic" src="https://user-images.githubusercontent.com/8126807/224797118-8913abc9-6ab7-4880-97a2-1f09eef19f52.png"><br>_[app-thalassa.cloud.sdu.dk](https://app-thalassa.cloud.sdu.dk/) running in DEBUG=False with cache activated and collectstatic._

- [x] PostgreSQL Server initialization.
- [x] PostgreSQL New Database and User creation.
- [x] PostgreSQL Server SSL set up `pg_hba.conf`.
- [x] Django access environment variables through `os.environ.get("DBHOST")`.
- [x] Django `DEBUG=True`.
- [x] Django `SECURE_SSL_REDIRECT = True` fails 👉 should not be declared in `settings.py` 🚫
- [x] Django `SECURE_PROXY_SSL_HEADER = ("HTTP_X_FORWARDED_PROTO", "https")` ✅
- [x] Django <> PostgreSQL Server connection `django.db.backends.postgresql`.
- [x] Django <> PostgreSQL Server SSL transactions `SSLMODE=require`.
- [x] Django `makemigrations` & `migrate`.
- [x] Django `create_superuser`.
- [x] Django `CSRF_COOKIE_SECURE = True` and `CSRF_USE_SESSIONS = True`.
- [x] Django `DEBUG=False`.
- [x] Django `ALLOWED_HOSTS ` set to `['localhost', 'app-627236-0.cloud.sdu.dk', 'app-githubbing.cloud.sdu.dk']`
- [x] Django `collectstatic`.
- [x] Django serves static files through `whitenoise`.
- [x] Django’s cache framework > Filesystem caching `django.core.cache.backends.filebased.FileBasedCache`.
- [x] Django run in pseudo UCloud localhost mode (see below 👀 ) https://app-{job-id}-0.cloud.sdu.dk.
- [x] Django run with a Public link https://app-githubbing.cloud.sdu.dk.
- [x] UCloud app run over 24 hours ⏳

### End of March, 2023 👀

- [ ] PostgreSQL server version bump to `v14.7`.
- [ ] Django version bump to `v4.1.7`.
- [ ] Python version bump to `v3.1.2`.

### Pseudo UCloud localhost mode

> Pseudo UCloud localhost mode = when Django app is running on https://app-{job-id}-0.cloud.sdu.dk interface with no Public link connected.

1. Pseudo UCloud localhost execution is cookie restricted to the current browser session 👉 cannot be shared with another browser session; an error 403 is raised: same browser in Private mode will fail, another browser on the same computer will fail.
2. Public link and Pseudo UCloud localhost mode are exclusive to one another.
3. Public link resources cannot be shared among users 👉 one user has to launch a job and attach a Public link he "owns", he cannot attach a Public link created by another user.

### Containers overview

> March 2022 with u1-standard-8 machine.

Environment | set -eufo pipefail | ${USER} | Python 3.11.0 | apt update | Creation | Age
:-- | --: | --: | --: | --: | --: | --:
Terminal Debian 0.9.0 | ❌ | ✅ | 3.6.8 ❌ |   | 28/12/2022 | 75 days
Terminal Ubuntu 0.20.0 | ❌ | ✅ | 3.10.7 ❌ | 960 sec | 28/12/2022 | 75 days
Terminal CentOS 0.8.0 | ❌ | ✅ | 3.6.8 ❌ |   | 14/06/2022 | 272 days
PostgreSQL Server 14.5<br>(Linux v5.4.228.el8 Debian) | ✅ | ❌ | ❌ | 218 sec | 12/10/2022 | 152 days
Django 4.1.2<br>(Linux v5.4.228.el8 Debian) | ✅ | ❌ | ✅ | 962 sec | 08/11/2022 | 125 days

### Incident review

> Health Page Status 👉 <https://status.cloud.sdu.dk/>

Year | Incidents (nb)
--: | --:
2023 | 9
2022 | 18
