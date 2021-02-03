# release-delivery-insights-examples

* The Digital.ai Release with Delivery Insights brings together Agile and DevOps to help you improve visibility and collaboration across software development and deliveries by seamlessly connecting the data and artifacts at each stage of the release to the related agile stories and features, allowing the whole organization to use a single tool to easily track progress end-to-end.
* Digital.ai Release version 10.0 supports integration with Continuum 21.0. 
* Digital.ai Release is our Release orchestrator and is more focused on the workflow – less on the contents of the flow, but more of the process. 
* Continuum continuously tracks the content: work items, commits, packages, versions and where they are in the development Value Stream. 
* The idea is to bring (integrate) them together, so that Release provides a rich insight in what is flowing through your development Value Stream. This combo of Release and Continuum is being offered as the Release with DevOps Insights solution. 
* Release will be the customer facing product; Continuum will be a headless server in the background. All Continuum functionality that we want to expose goes through Release in principle.

Here are a few Digital.ai Release templates that are readily available to simplify the process of configuring the Release—Continuum integration. 

## Templates included:

* Continuum Server Configuration:

    This activity needs to be run only once. It is fine to have it as a one-off release. 
    The tasks are configured with raw JSON content that is pumped into Continuum using the ‘import’ mechanism.

* Continuum project configuration:

    In the scope of this demo, a project is one GitHub repository, using JIRA as a source control mechanism that produces a single package .
    Each project needs to be configured separately. 
    We need to set this up in Continuum so it starts tracking commits, associates them with JIRA work items and is able to produce a package version when a build succeeds. 

    Project setup needs to run once so it also makes sense to model it as a user-run template in Release.

* Release sample with Continuum Integration

    After a successful build, Release does a callback to Continuum to tell it to bundle the collected commits into a package manifest.
    

## Prerequisites

### Docker
You'll need to have Docker installed on your machine before you begin:

* Mac: https://docs.docker.com/docker-for-mac/
* Windows: https://docs.docker.com/docker-for-windows/
* Linux: Refer to the instructions for your Linux distribution on how to install Docker

You may need to start the VPN client (Cisco AnyConnect) to be able to download the latest XL Release and XL Deploy Docker images.

### Continuum

A Continuum server

### Licenses

You need to bring your own Release license and copy it to the following location

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

