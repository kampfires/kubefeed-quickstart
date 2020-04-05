# Kubefeed Quickstart

Kubefeed is an app that makes it super easy to implement [Declarative Management of Kubernetes Objects Using Configuration Files](https://kubernetes.io/docs/tasks/manage-kubernetes-objects/declarative-config/), with an added method for handling object and configuration item deletions.  

To use kubefeed, you run a simple Jenkins-x quickstart process per the instructions below. Jenkins-x will setup a Tekton pipeline in your Kubernetes cluster that executes kubectl apply to the /manifests directory in a your new kubefeed repo the jx quickstart will create for you.  

Once initialized, you can add new manifests or update existing manifests in your kubefeed repo /manifests directory, and when you submit a pull request to your kubefeed repo, the kubefeed pipeline will run and apply any diffs in the manifests in your repo. 

To delete objects, simply move a manifest from the manifests/ folder to the delete/folder, and kubefeed will apply kubectl delete -f on the file and then delete the file as the delete only needs to be applied once.

## Requirements
Kubefeed requires Jenkins-X running on a Kubernetes cluster, and should be setup using an account that has admin permissions in the target kubernetes cluster. 

Kubefeed should work with most versions of Jenkins-x, initially it has been tested against JX v2.0.1185

## How To setup your own Kubefeed instance
We will need to use Jx Quickstart commands to create your own Kubefeed instance from this quickstart template

### 1.1 Ensure you are logged into JX and authenticated to the Kubernetes cluster you would like kubefeed to provide declarative kubernetes object management for. 

Note: Each instance of Kubefeed will execute kubectl apply commands on the kubernetes cluster you are connected to when you run jx create quickstart to initialize your kubefeed instance. You can have as many kubefeed instances as you would like, however you shoudl only need a single kubefeed instance per kubernetes cluster. You will need a dedicated kubefeed instance for each kubernetes cluster you want kubefeed to manage objects for.  

### 1.2 Run this command to add kampfires as a Quickstart location for your team:

`jx create quickstartlocation --url https://github.com --owner kampfires --kind github`  

To get the list of registered quickstart locations run command:

`jx get quickstartlocations`  

### 1.3 Run the Following command to to initiate the quickstart wizard which will create your own kubefeed instance for you.
`jx create quickstart --owner kampfires --filter kubefeed-quickstart`

## How to use Kubefeed

Kubefeed can apply any file that can be executed with the command `kubectl apply -f {filename}`

You use kubefeed by changing or adding a manifest file to the /manifests directory in your kubefeed repo. 

You can add or modify manifest files using the standard pull request process either through the github GUI, API or git command line utility.

If you would like to delete a manifest, simply move a manifest from the manifests/ folder to the delete/folder, and kubefeed will apply kubectl delete -f on the file and then delete the file as the delete only needs to be applied once.
