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
| config_volume | path       | yes  | <empty>          | Path to config volume    |
| data_volume   | path       | yes  | <empty>          | Path to data volume      |
| log_volume    | path       | yes  | <empty>          | Path to log volume       |
| backup_volume | path       | yes  | <empty>          | Path to backup volume    |
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
- hosts: test_machine
  become: yes

  roles:
  - role: install-gitlab
    config_volume: /srv/gitlab/config
    data_volume: /srv/gitlab/data
    log_volume: /srv/gitlab/log
    backup_volume: /srv/gitlab/backups
```

```yaml
- hosts: test_machine
  become: yes

  roles:
    - role: install-docker
      storage_driver: overlay2
      cleanup_enabled: no
      install_pip_docker: yes

    - role: install-gitlab
      image_version: 12.9.2-ce.0
      config_volume: /srv/gitlab/config
      data_volume: /srv/gitlab/data
      log_volume: /srv/gitlab/log
      backup_volume: /srv/gitlab/backups
      external_url: http://your.gitlab.org
      ssh_host: your.gitlab.org
      https_port: 10443
      http_port: 10080
      ssh_port: 10022
      shell_ssh_port: 10022
      disable_hsts: yes
      email:
        enabled: true
        from: 'gitlab@git.myserver.org'
        display_name: 'gitlab@git.myserver.org'
        reply_to: 'gitlab@git.myserver.org'
        subject_suffix: '[Gitlab]'
      smtp:
        address: 'smtp.gmail.com'
        port: 587
        user_name: 'your_mail@gmail.com'
        password: 'your_password'
        domain: 'www.gmail.com'
        enable_starttls_auto: true
      backup_keep_time: 604800
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
