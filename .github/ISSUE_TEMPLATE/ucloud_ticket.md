---
name: UCloud Ticket 🎫
about: Tracking UCloud Tickets
title: 'UCloud #TICKET-{nb} 🎫 about {short-description}'
labels: UCloud
assignees: ''

---

<!--

  Hi there 👋 Thank you for tracking down tickets opened on UCloud jira.

  Before you submit this; let's make sure of a few things.
  Please make sure the following boxes are ticked if they are correct.
  If not, please try and fulfill these first.

-->

- [ ] I have activated the browser Private mode to evaluate if the error still happens.
- [ ] I have checked UCloud [health status page][ucloud.status].
- [ ] I have checked UCloud [frequently asked questions][ucloud.faq] section.
- [ ] I have checked UCloud [user guide][ucloud.user-guide] section.
- [ ] I have checked that no other similar [issues][issues] or [discussions][discussions] are already opened and believe that this is not a duplicate.

### On SDU eScience Service Desk powered by Jira Service Management

1. If you don't have a Jira account yet, sign up for one 👉 <https://jira.cloud.sdu.dk/servicedesk/customer/user/signup>
2. Access SDU eScience Service Desk > User Support 👉 <https://jira.cloud.sdu.dk/servicedesk/customer/portal/43/group/75>
3. Create a new ticket by clicking on one category like **Service unavailable** for instance.
4. Summary: **{short-description}**
5. Select a system: **HPC Type 1 (UCloud)**
6. Priority (optional): **P2 - High**
7. Once the ticket is created, share it with collaborators by typing their email addresses, e.g.: racos@sdu.dk.

![ucloud_ticket](https://user-images.githubusercontent.com/8126807/223265317-8a193e65-94e9-4b61-9be4-d588dd0880de.png)
*Sample of an eScience Service Desk Opened Ticket*

---

### Link to UCloud ticket 🎫

> e.g.: 👉 <https://jira.cloud.sdu.dk/projects/TICKET/queues/custom/160/TICKET-1847>

### UCloud credentials 👤

> Under which username did you make the report.
>
> - Jira account e.g.: jv-jvc@sdu.dk

### Copy Paste the content you wrote in the UCloud ticket 📝

> Dear eScience Center 👋
>
> I hope this ticket will find you well.
>
> ...
>
> **Environment**
>
> - Terminal Ubuntu v22.10
> - Django v4.1.2
> - PostgreSQL v14.6
>
> **Provide an example**
>
> Create a shared folder on UCloud to run a basic version of an example that reproduces the problem.
> Ask support team to communicate their UCloud usernames to invite them to your shared folder.
>
> **Request**
>
> Could you please bump the version of Django to [v4.1.7](https://docs.djangoproject.com/en/4.1/releases/4.1.7/)❓
>
> `pip install django==4.*,<5.0`
>
> And provide an updated version of the Django containerized app on UCloud [apps](https://cloud.sdu.dk/app/applications/overview/).
>
> Thank you in advance,
> JulienVieillefont#7058
>
> [jv-jvc@sdu.dk](mailto:jv-jvc@sdu.dk)

<!-- links -->

[issues]: https://github.com/JV-conseil/ucloud/issues?q=is%3Aissue+label%3AUCloud
[discussions]: https://github.com/JV-conseil/ucloud/discussions?discussions_q=label%3AUCloud
[jira.cloud.sdu.dk]: https://jira.cloud.sdu.dk/servicedesk/customer/portal/43/group/75
[ucloud.status]: https://status.cloud.sdu.dk/
[ucloud.faq]: https://docs.cloud.sdu.dk/help/faq.html
[ucloud.user-guide]: https://docs.cloud.sdu.dk/Apps/django.html
