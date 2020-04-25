# ansible-gitlab-runner

Installs gitlab-runner as docker container managed by systemd.

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
| image_name    | text | no         | gitlab/gitlab-runner | Docker image name    |
| image_version | text | no         | alpine-v12.9.0       | Docker image version |
| config_volume | text | yes        | <empty>              | Path to config volume |
| gitlab_uri    | url  | yes        | <empty>              | Url to gitlab instance (needed for registration) |
| registration_token | text  | yes  | <empty>              | Registration token (needed for registration, provided by gitlab) |
| force_registration | boolean | no | False                | Delete the old registration config and re-register to Gitlab instance |
| disable_registration | boolean | no | False                | Disable registration (for testing purposes) |
| runner_name          | text    | no | <empty>              | Runner name for multiple instances on one machine                |
| description          | text    | no | 'Docker_Runner'      | Runner description displayed in your Gitlab instance             |


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
      image_version: alpine-v12.9.0
      gitlab_uri: https://my.gitserver.org/
      registration_token: mYReGIstR4TI0NtOK3n
      runner_name: my-custom-runner-name
      description: My runner description
      config_volume: /srv/gitlab-runner
```
