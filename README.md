# release-delivery-insights-examples

This repository contains... TODO

## Prerequisites

### Docker
You'll need to have Docker installed on your machine before you begin:

* Mac: https://docs.docker.com/docker-for-mac/
* Windows: https://docs.docker.com/docker-for-windows/
* Linux: Refer to the instructions for your Linux distribution on how to install Docker

You may need to start the VPN client (Cisco AnyConnect) to be able to download the latest XL Release and XL Deploy Docker images.

### Continuum

TODO

### Licenses

You need to bring your own Release license and copy it to the following place

* `docker/xl-release/default-conf/xl-release-license.lic`

License files are in `.gitignore` to prevent them from being committed.

## Setup
### Configure passwords

Configure third-party passwords before starting XL Release.

Create a file `~/.xebialabs/secrets.xlvals`, paste in the following section and configure the passwords:

    
    jira_url = https://yourcompany.atlassian.net/
    jira_user = your_jira_user
    jira_password = your_jira_password
    
    github_user: your_github_user
    github_token: your_github_token
    
    continuum_url: http://yourcompany.v1testdrive.com
    continuum_apiToken: your_continuum_api_token


## Start & stop

Start all Docker containers: 

    [Continuum]$ ./up.sh

Wait until running and then

    [Continuum]$ ./setup.sh
    
To tear down the entire demo:

    [Continuum]$ ./down.sh

## Exporting templates

If you edited the templates in the UI, you can export them using the following command.

    ./xlw generate xl-release -o -f out.yaml --path "Continuum Integration" --templates

Then manually pick and copy the relevant bits from `out.yaml` into `data/continuum-configuration.yaml`

## GitOps 

Slightly more advanced example of promoting templates and configuration through as-code/Git

Server 1:

    xl generate xl-release --configurations --file continuum-config.yaml -o
    xl generate xl-release --path "Continuum Integration" --templates --file continuum-demo.yaml -o
    
Revise, commit, review

Server 2:

Pull and then

    xl apply --xl-release-url http://localhost:5517 -f continuum-config.yaml -f continuum-demo.yaml 
    
    

## Accessing XL Release

Use http://localhost:5516/#/login as your entry point.

