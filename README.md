# README
# The Mooqita Worklearn Platform
The worklearn platform powers the [Mooqita](https://app.mooqita.org) app. Mooqita is built on [Meteor](https://www.meteor.com/) and most of this repository is forked from [Mooqita’s Worklearn](https://github.com/Mooqita/worklearn) project page.

## Before you begin working
Here is a side-by-side comparison of coffeescript and javascript. This will show you how the syntax compares and helps so much when converting to or from ES6: http://coffeescript.org/#language

Jordan used this and suggests it when working with Meteor: https://www.udemy.com/share/1001ki/
This class is cheap and while we do not use the React framework, it is important for Meteor fundamentals and how we need to change the User Accounts, Authentication, and Routing.

Before you install Docker on Windows you must read this: https://docs.docker.com/docker-for-windows/install/#what-to-know-before-you-install


## Local Development
As part of University of Nebraska at Omaha’s ITIN4440-001 Agile Development Methods class in collaboration with the non-profits: [Siena Francis House](https://sienafrancis.org) and [Mooqita](https://www.mooqita.org/); we have created a development environment for building on the worklearn platform with [Docker](https://www.docker.com/).

### Install Docker
To run your own instance of Mooqita here is a guide how to get it running on your system. **Before you get started please have at least 5 GB or more of storage available.**

Download the Stable Docker Community Edition that matches your operating system from their [website](https://www.docker.com/get-docker). Operating systems below are linked to the prospective install guides. **Please note system requirements before install and run.**

[Windows and Docker notes](https://docs.docker.com/docker-for-windows/install/): Docker for Windows requires Windows 10 or Windows Server 2016, check the notes to see what you need to know before you install.
If you install the Docker Toolbox the installer automatically installs Oracle VirtualBox to run Docker. [Here is a useful video for configuring the VirtualBox and troubleshooting Windows with Docker](https://www.youtube.com/watch?v=ymlWt1MqURY).

[MacOS and Docker notes](https://docs.docker.com/docker-for-mac/install/): Docker.app requires at least macOS Yosemite or El Capitan as well as permissions. You do not need the Docker Toolbox. Upon installing Docker click the app to run Docker daemon. Click the whale icon to get Preferences and then the Advanced tab - its helpful to have at least 2 CPUs and 4 or more GB memory.

[Debian and Docker notes](https://docs.docker.com/install/linux/docker-ce/debian/)

[Ubuntu and Docker notes](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

Validate you have installed Docker by running:
`docker --version`

### Install Node and NPM
When you install Node.js, npm is automatically installed.
Check to see if you have Node and/or npm with this command:

`node -v && npm -v`

[Install Node.js and NPM for Windows](http://blog.teamtreehouse.com/install-node-js-npm-windows): Will require restart.

[Install Node.js and NPM for Mac](http://blog.teamtreehouse.com/install-node-js-npm-mac): Homebrew is quickest and easiest.

[Install Node.js and NPM for Ubuntu](https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-16-04)

Verify you have both Node.js and npm installed with `node -v && npm -v`

### Downloading MooqitaSFH from Git-Hub
Go to [MooquitaSFH](https://github.com/MooqitaSFH/worklearn/) project page on GitHub and clone the repository into a folder someplace on your computer. Name this folder  _mooqita_folder_

You can find the documentation on how to clone a repository [here](https://help.github.com/articles/cloning-a-repository/).

### Connecting to GitHub with SSH
In order to easily commit your changes and better familiarize yourself with github please follow this [SSH guide](https://help.github.com/articles/connecting-to-github-with-ssh/).


### Building and Running Development Environment
If you have already gotten the above dependencies I love you and promise to never hurt you again.

In your command prompt navigate to the _mooqita_folder_  you created and change directory to _worklearn_ then run:

`npm run clean && docker-compose up`

If you see Permission Denied run:

`sudo npm run clean`

Next, within the _worklearn_ folder open file docker/env/.worklearn-env and edit the _MAIL_URL_ and _DROPBOX_ACCESS_TOKEN_ getting the correct information for _MAIL_URL_ from

https://mailtrap.io

and the _DROPBOX_ACCESS_TOKEN_ from

https://blogs.dropbox.com/developers/2014/05/generate-an-access-token-for-your-own-account/

Next, run:

`docker-compose up`

Now make yourself a drink. This command will download additional dependencies, build the environment, and deploy locally in about 10 beers time.

When you see “App running at: http://0.0.0.0:3000” kiss your computer and go to http://0.0.0.0:3000 in your browser. Admin login credentials:

+ admin@mooqita-sfh.org
+ password   

Navigate around the app, create and register as an organization. Familiarize yourself and try to edit one of pages by opening up the _worklearn_ folder in your favorite editor and modifying one of the html pages in the  _views_ directory.
Save the file you modified, refresh webpage, and find the change you made!

When you’ve had enough use ctrl + c in your command prompt to gracefully stop and close the application. Quickly forcing the application to stop will result in sadness.

You can always work on the app by restarting Docker then navigate to the _worklearn_ directory and run:

`docker-compose up`

## Testing and DB
To validate in the database you can go to http://0.0.0.0:1234 while the app is running.
In the Collection name field enter: worklearn
In the Connection string field enter: mongodb://mongo:27017/worklearndb
Connect and explore.

## Known Challenges
We are aware of some issues people experienced installing the system here is a list of known issues and how to solve them:

Blank page:
If you recieve a blank page verify that you're using http. If your browser is forcing https then comment out the "force-ssl" on line 50 of the meteor/packages and rebuild.

Critical Docker issues with modules, images, or containers: clean and rebuild development environment.

When all else fails - restart.
