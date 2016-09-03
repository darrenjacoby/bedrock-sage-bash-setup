# Setup Bedrock & Sage
Bash script for starting new projects with Bedrock and Sage9.  Tested with Bash & ZSH on MacOSX.

## Tasks
* Bedrock
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
* Sage
  * Download Sage
  * Replace bedrock.dev with project_name.dev in assets/config.json
  * Init Git
  * Run NPM install and build
  * Activate theme
  * Open Atom

## Requires
* [Composer](https://getcomposer.org/doc/00-intro.md)
* [WP CLI](https://github.com/wp-cli/wp-cli)
* [WP CLI Dotenv](https://github.com/aaemnnosttv/wp-cli-dotenv-command)
* [Git](https://git-scm.com/)

## Installation
Clone files:
```bash
git clone https://github.com/darrenjacoby/setup-bedrock-sage.git bedrock-sage
```

Move bash script bedrock-sage.sh to /usr/local/bin:
```bash
mv /bedrock-sage/bedrock-sage.sh  /usr/local/bin
```

#### Set up an alias:
Using Bash:
```bash
echo 'alias bedrock-sage="bash ~/usr/local/bin/bedrock-sage.sh"' >>~/.bash_profile
```
Using ZSH:
```bash
echo 'alias bedrock-sage="bash ~/usr/local/bin/bedrock-sage.sh"' >>~/.zshrc
```

## Run
cd to the parent directory for your project (example: dev/)

```bash
cd dev/
bedrock-sage
```
Follow the prompts and that should be it.
