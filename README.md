install-docker-gitlab
=====================

Installs gitlab as docker container.

System requirements
-------------------

* Docker
* Systemd

Role requirements
-----------------

* python-docker package

Tasks
-----

* Create volume paths for docker container
* Setup gitlab config
* Setup systemd unit file
* Start/Restart gitlab service

Role parameters
--------------

| Variable      | Type | Mandatory? | Default | Description           |
|---------------|------|------------|---------|-----------------------|
| image_name    | text | no         | gitlab/gitlab-ce | Docker image name    |
| image_version | text | no         | 9.5.4-ce.0       | Docker image version |
| https_port    | port | no         | 443              | Mapped HTTPS port    |
| http_port     | port | no         | 80               | Mapped HTTP port     |
| ssh_port      | port | no         | 10022            | Mapped SSH port      |
| config_volume | path | no         | <empty>          | Path to config volume |
| data_volume   | path | no         | <empty>          | Path to data volume   |
| log_volume    | path | no         | <empty>          | Path to log volume    |
| backup_volume | path | no         | <empty>          | Path to backup volume |
| external_url  | url  | no         | <empty>          | Gitlab Url, like git.example.org |
| ssh_host      | host | no         | <empty>          | SSH Host, lile ssh.example.org   |
| email.enabled | boolean | no      | false            | Is mailing enabled?              |
| email.from    | email address | no | <empty>         | Email from address               |
| email.display_name | text     | no | <empty>         | Email from name                  |
| email.reply_to     | email address | no | <empty>    | Reply email address              |
| email.subject_suffix | text        | no | <empty>    | Suffix in email subject, like [GitLab] |
| smtp.address         | host        | no | <empty>    | SMTP server host                       |
| smtp.port            | port        | no | <empty>    | SMTP server port                       |
| smtp.user_name       | text        | no | <empty>    | SMTP user name                         |
| smtp.password        | text        | no | <empty>    | SMTP password                          |
| smtp.domain          | text        | no | <empty>    | SMTP domain                            |
| smtp.enable_starttls_auto | boolean | no | <empty>   | Is start-tls-auto enabled?             |
| smtp.tls                  | boolean | no | <empty>   | Use TLS?                               |

Example Playbook
----------------

Usage (without parameters):

    - hosts: servers
      roles:
         - { role: install-docker-gitlab }

Usage (with parameters):

    - hosts: servers
      roles:
      - role: install-docker-gitlab
        config_volume: /srv/docker/gitlab/config
        data_volume: /srv/docker/gitlab/data
        log_volume: /srv/docker/gitlab/log
        backup_volume: /srv/docker/gitlab/backups
        external_url: http://vboxserver
        ssh_host: vboxserver:10022
        email:
          enabled: true
          from: 'your_mail@gmail.com'
          display_name: 'Gitlab vboxserver'
          reply_to: 'your_mail@gmail.com'
          subject_suffix: '[Gitlab]'
        smtp:
          address: 'smtp.gmail.com'
          port: 587
          user_name: 'your_mail@gmail.com'
          password: 'your_password'
          domain: 'www.gmail.com'
          enable_starttls_auto: true
          tls: false
