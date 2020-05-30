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
| gitlab_image_name    | text | no         | gitlab/gitlab-ce | Docker image name    |
| gitlab_image_version | text | no         | 12.9.2-ce.0      | Docker image version |
| gitlab_interface     | ip address | no   | 0.0.0.0          | Mapped network for web-interface ports |
| gitlab_https_port    | port       | no   | 443              | Mapped HTTPS port        |
| gitlab_http_port     | port       | no   | 80               | Mapped HTTP port         |
| gitlab_ssh_port      | port       | no   | 10022            | Mapped SSH port          |
| gitlab_config_volume | path       | yes  | <empty>          | Path to config volume    |
| gitlab_data_volume   | path       | yes  | <empty>          | Path to data volume      |
| gitlab_log_volume    | path       | yes  | <empty>          | Path to log volume       |
| gitlab_backup_volume | path       | yes  | <empty>          | Path to backup volume    |
| gitlab_external_url  | url        | no   | <empty>          | Gitlab Url, like git.example.org |
| gitlab_ssh_host      | host       | no   | <empty>          | SSH Host, like ssh.example.org   |
| gitlab_shell_ssh_port | host      | no   | <empty>          | Gitlab shell SSH port, like 10022 |
| gitlab_email_enabled  | boolean   | no   | false            | Is mailing enabled?               |
| gitlab_email_from     | email address | no | <empty>        | Email from address                |
| gitlab_email_display_name | text      | no | <empty>        | Email from name                   |
| gitlab_email_reply_to     | email address | no | <empty>    | Reply email address               |
| gitlab_email_subject_suffix | text        | no | <empty>    | Suffix in email subject, like [GitLab] |
| gitlab_smtp_address         | host        | no | <empty>    | SMTP server host                       |
| gitlab_smtp_port            | port        | no | <empty>    | SMTP server port                       |
| gitlab_smtp_user_name       | text        | no | <empty>    | SMTP user name                         |
| gitlab_smtp_password        | text        | no | <empty>    | SMTP password                          |
| gitlab_smtp_domain          | text        | no | <empty>    | SMTP domain                            |
| gitlab_smtp_enable_starttls_auto | boolean | no | <empty>   | Is start-tls-auto enabled?             |
| gitlab_smtp_tls                  | boolean | no | <empty>   | Use TLS?                               |
| gitlab_backup_keep_time          | number  | no | <empty>   | The duration in seconds to keep backups before they are allowed to be deleted |
| gitlab_nginx_disable_hsts              | boolean | no | no        | If you are running your GitLab instance behind a reverse proxy you probably don't want to configure HSTS in GitLab |
| gitlab_pages_enabled             | boolean | no | no        | Enables/Disables the Gitlab Pages feature |
| gitlab_pages_port                | number  | no | 8081      | Defines the (internal) port used for Gitlab Pages |
| gitlab_pages_external_port       | number  | yes |          | Defines the mapped port used for Gitlab Pages |
| gitlab_pages_external_url        | url     | yes |          | Defines the URL used for Gitlab Pages |

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
- hosts: test_machine
  become: yes

  roles:
  - role: install-gitlab
    gitlab_config_volume: /srv/gitlab/config
    gitlab_data_volume: /srv/gitlab/data
    gitlab_log_volume: /srv/gitlab/log
    gitlab_backup_volume: /srv/gitlab/backups
```

```yaml
- hosts: test_machine
  become: yes

  roles:
    - role: install-gitlab
      gitlab_image_version: 12.9.2-ce.0
      gitlab_config_volume: /srv/gitlab/config
      gitlab_data_volume: /srv/gitlab/data
      gitlab_log_volume: /srv/gitlab/log
      gitlab_backup_volume: /srv/gitlab/backups
      gitlab_external_url: http://git.yourserver.org
      gitlab_ssh_host: your.gitlab.org
      gitlab_https_port: 10443
      gitlab_http_port: 10080
      gitlab_ssh_port: 10022
      gitlab_shell_ssh_port: 10022
      gitlab_nginx_disable_hsts: yes
      gitlab_pages_enabled: true
      gitlab_pages_external_port: 10081
      gitlab_pages_external_url: http://pages.yourserver.org/
      gitlab_email_enabled: true
      gitlab_email_from: 'gitlab@git.myserver.org'
      gitlab_email_display_name: 'gitlab@git.myserver.org'
      gitlab_email_reply_to: 'gitlab@git.myserver.org'
      gitlab_email_subject_suffix: '[Gitlab]'  
      gitlab_smtp_address: 'smtp.gmail.com'
      gitlab_smtp_port: 587
      gitlab_smtp_user_name: 'your_mail@gmail.com'
      gitlab_smtp_password: 'your_password'
      gitlab_smtp_domain: 'www.gmail.com'
      gitlab_smtp_enable_starttls_auto: true
      gitlab_smtp_tls: true
      gitlab_backup_keep_time: 604800
```

## Testing

Requirements:

* [Vagrant](https://www.vagrantup.com/)
* [VirtualBox](https://www.virtualbox.org/)
* [Ansible](https://docs.ansible.com/)
* [Molecule](https://molecule.readthedocs.io/en/latest/index.html)
* [yamllint](https://yamllint.readthedocs.io/en/stable/#)
* [ansible-lint](https://docs.ansible.com/ansible-lint/)
* [Docker](https://docs.docker.com/)

### Run within docker

```shell script
molecule test
```

### Run within Vagrant

```shell script
molecule test --scenario-name vagrant-xenial
molecule test --scenario-name vagrant-bionic
molecule test --scenario-name vagrant-focal
molecule test --scenario-name vagrant-stretch
molecule test --scenario-name vagrant-buster
```

I recommend to use [pyenv](https://github.com/pyenv/pyenv) for local testing.
Within the Github Actions pipeline I use [my own molecule Docker image](https://github.com/borisskert/docker-molecule).
