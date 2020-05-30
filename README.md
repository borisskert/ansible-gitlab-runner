# ansible-gitlab-runner

Installs gitlab-runner as docker container managed by systemd.

## Supported systems

* Ubuntu:
  * 16.04 (xenial)
  * 18.04 (bionic)
  * 20.04 (focal - installing `docker.io` package)
* Debian
  * 9 (stretch)
  * 10 (buster)

It's possible other systems are working, but they are not tested.

## Requirements

* Docker
* Systemd

## Tasks

* Create volume paths for docker container
* Setup systemd unit file
* Register runner to gitlab if specified
* Start/Restart gitlab-runner service

## Role parameters

| Variable      | Type | Mandatory? | Default | Description           |
|---------------|------|------------|---------|-----------------------|
| gitlab_runner_image_name    | text | no         | gitlab/gitlab-runner | Docker image name    |
| gitlab_runner_image_version | text | no         | alpine-v12.9.0       | Docker image version |
| gitlab_runner_config_volume | text | yes        | <empty>              | Path to config volume |
| gitlab_runner_gitlab_uri    | url  | yes        | <empty>              | Url to gitlab instance (needed for registration) |
| gitlab_runner_registration_token | text  | yes  | <empty>              | Registration token (needed for registration, provided by gitlab) |
| gitlab_runner_refresh_register   | boolean | no | False                | Delete the old registration config and re-register to Gitlab instance |
| gitlab_runner_disable_register   | boolean | no | False                | Disable registration (for testing purposes) |
| gitlab_runner_runner_name          | text    | no | <empty>              | Runner name for multiple instances on one machine                |
| gitlab_runner_description          | text    | no | 'Docker_Runner'      | Runner description displayed in your Gitlab instance             |


## Usage

### Add to `requirements.yml`:

```yaml
- name: install-gitlab-runner
  src: https://github.com/borisskert/ansible-gitlab-runner.git
  scm: git
```

### Typical playbook:

```yaml
    - hosts: servers
    - role: install-gitlab-runner
      gitlab_runner_image_version: alpine-v12.9.0
      gitlab_runner_gitlab_uri: https://my.gitserver.org/
      gitlab_runner_registration_token: mYReGIstR4TI0NtOK3n
      gitlab_runner_runner_name: my-custom-runner-name
      gitlab_runner_description: My runner description
      gitlab_runner_config_volume: /srv/gitlab-runner
      gitlab_runner_disable_register: no
      gitlab_runner_refresh_register: no
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
 molecule test --scenario-name vagrant --parallel
```
