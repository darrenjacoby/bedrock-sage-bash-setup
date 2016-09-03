# Setup Bedrock & Sage
Bash script for starting new projects with Bedrock and Sage9.  Tested with Bash & ZSH on MacOSX.

![alt text](https://cloud.githubusercontent.com/assets/15921694/18224048/2964a45a-71c9-11e6-9ac6-a4c6d5acf324.gif "Bedrock Sage Bash Setup")

## Tasks
* **Bedrock**
  * Download Bedrock
  * Create default .env file
  * Generate .env salts
  * Create database
  * Run WordPress install
  * Update WordPress options
    * Remove blog description
    * Update start of week
    * Update timezone
    * Update permalink structure
  * Remove default posts
  * Remove default themes
  * Create default homepage
  * Install plugins
    * Disable comments
* **Sage**
  * Download Sage
  * Replace bedrock.dev with project_name.dev in assets/config.json
  * Init Git
  * Run NPM install and build
  * Activate theme
  * Open Atom

## Requirements
* [Composer](https://getcomposer.org/doc/00-intro.md)
* [WP CLI](https://github.com/wp-cli/wp-cli)
* [WP CLI Dotenv](https://github.com/aaemnnosttv/wp-cli-dotenv-command)
* [Git](https://git-scm.com/)

## Installation
Clone files from this repository:
```bash
git clone git@github.com:darrenjacoby/bedrock-sage-bash-setup.git bedrock-sage
```

Move bash script bedrock-sage.sh to /usr/local/bin:
```bash
mv bedrock-sage/bedrock-sage.sh  /usr/local/bin
```

#### Set up an alias:
Using Bash:
```bash
echo 'alias bedrock-sage="bash /usr/local/bin/bedrock-sage.sh"' >>~/.bash_profile
```
Using ZSH:
```bash
echo 'alias bedrock-sage="bash /usr/local/bin/bedrock-sage.sh"' >>~/.zshrc
```

## Run
cd to the parent directory for your project (example: dev/)

```bash
cd dev/
bedrock-sage
```
**Follow the prompts to setup Bedrock and Sage9.**
