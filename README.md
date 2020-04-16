# ansible-gitlab

Ansible role to install gitlab as docker service.
This role is tested only on Ubuntu 16.04

## System requirements

* Docker
* Systemd

## Role requirements

* python-docker package

## Tasks

* Create volume paths for docker container
* Setup gitlab config
* Setup systemd unit file
* Start/Restart gitlab service

## Role parameters

| Variable      | Type | Mandatory? | Default | Description           |
|---------------|------|------------|---------|-----------------------|
| image_name    | text | no         | gitlab/gitlab-ce | Docker image name    |
| image_version | text | no         | 12.9.2-ce.0      | Docker image version |
| interface     | ip address | no   | 0.0.0.0          | Mapped network for web-interface ports |
| https_port    | port       | no   | 443              | Mapped HTTPS port        |
| http_port     | port       | no   | 80               | Mapped HTTP port         |
| ssh_port      | port       | no   | 10022            | Mapped SSH port          |
| config_volume | path       | no   | <empty>          | Path to config volume    |
| data_volume   | path       | no   | <empty>          | Path to data volume      |
| log_volume    | path       | no   | <empty>          | Path to log volume       |
| backup_volume | path       | no   | <empty>          | Path to backup volume    |
| external_url  | url        | no   | <empty>          | Gitlab Url, like git.example.org |
| ssh_host      | host       | no   | <empty>          | SSH Host, like ssh.example.org   |
| shell_ssh_port | host      | no   | <empty>          | Gitlab shell SSH port, like 10022 |
| email.enabled  | boolean   | no   | false            | Is mailing enabled?               |
| email.from     | email address | no | <empty>        | Email from address                |
| email.display_name | text      | no | <empty>        | Email from name                   |
| email.reply_to     | email address | no | <empty>    | Reply email address               |
| email.subject_suffix | text        | no | <empty>    | Suffix in email subject, like [GitLab] |
| smtp.address         | host        | no | <empty>    | SMTP server host                       |
| smtp.port            | port        | no | <empty>    | SMTP server port                       |
| smtp.user_name       | text        | no | <empty>    | SMTP user name                         |
| smtp.password        | text        | no | <empty>    | SMTP password                          |
| smtp.domain          | text        | no | <empty>    | SMTP domain                            |
| smtp.enable_starttls_auto | boolean | no | <empty>   | Is start-tls-auto enabled?             |
| smtp.tls                  | boolean | no | <empty>   | Use TLS?                               |
| backup_keep_time          | number  | no | <empty>   | The duration in seconds to keep backups before they are allowed to be deleted |
| disable_hsts              | boolean | no | no        | If you are running your GitLab instance behind a reverse proxy you probably don't want to configure HSTS in GitLab |

## Usage

### requirements.yml

```yaml
- name: install-gitlab
  src: https://github.com/borisskert/ansible-gitlab.git
  scm: git
```

### Playbook

minimal:

```yaml
    - hosts: servers
      roles:
      - role: install-gitlab
```

```yaml
    - hosts: servers
      roles:
      - role: install-gitlab
        config_volume: /srv/docker/gitlab/config
        data_volume: /srv/docker/gitlab/data
        log_volume: /srv/docker/gitlab/log
        backup_volume: /srv/docker/gitlab/backups
        external_url: http://your.gitlab.org
        ssh_host: your.gitlab.org
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
```
