ansible-gitlab-runner
=====================

Installs gitlab-runner as docker container.

Requirements
------------

* Docker
* Systemd

Tasks
-----

* Create volume paths for docker container
* Setup systemd unit file
* Register runner to gitlab if specified
* Start/Restart gitlab-runner service

Role parameters
--------------

| Variable      | Type | Mandatory? | Default | Description           |
|---------------|------|------------|---------|-----------------------|
| image_name    | text | no         | gitlab/gitlab-runner | Docker image name    |
| image_version | text | no         | alpine-v9.5.0        | Docker image version |
| config_volume | text | no         | <empty>              | Path to config volume |
| gitlab_uri    | url  | no         | <empty>              | Url to gitlab instance (needed for registration) |
| registration_token | text  | no   | <empty>              | Registration token (needed for registration, provided by gitlab) |
| force_registration | boolean | no | False                | Force registration                                               |


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
        gitlab_uri: 'http://192.168.56.101'
        force_registration: False
        registration_token: 'XXX'
        config_volume: /srv/docker/gitlab-runner
