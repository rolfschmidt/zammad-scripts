# Zammad Scripts

Here you will find a couple ruby scripts which can be helpful to get the first steps in for the package creation in zammad.

## Requirements

Only the current ruby version of zammad is required:

https://github.com/zammad/zammad/blob/develop/Gemfile#L6

There are no dependencies.

## Setup

To setup the scripts I would recommend you to clone the repository in your home directory (e.g. my home directory is /home/ubuntu-rs):

```bash
ubuntu-rs@ubuntu-rs:/opt/zammad$ cd ~
ubuntu-rs@ubuntu-rs:~$ git clone git@github.com:rolfschmidt/zammad-scripts.git
```

Then you need to setup the git aliases.

```bash
ubuntu-rs@ubuntu-rs:~$ vi ~/.gitconfig

[user]
        name = xxx
        email = xxx@xxx.com

[alias]

zammad-new-szpm = !ruby /home/ubuntu-rs/zammad-scripts/zammad_new_szpm.rb $(pwd)
zammad-update-szpm = !ruby /home/ubuntu-rs/zammad-scripts/zammad_update_szpm.rb $(pwd)
zammad-create-zpm = !ruby /home/ubuntu-rs/zammad-scripts/zammad_create_zpm.rb $(pwd) $1
zammad-migration = !ruby /home/ubuntu-rs/zammad-scripts/zammad_migration.rb $(pwd) $1
zammad-link = !ruby /home/ubuntu-rs/zammad-scripts/zammad_link.rb /workspace/git_zammad/zammad /workspace/git_zammad/$1
zammad-unlink = !ruby /home/ubuntu-rs/zammad-scripts/zammad_unlink.rb /workspace/git_zammad/zammad /workspace/git_zammad/$1
```

## Setup a new project

1. To create a new project you should always create a directory in the following format:

```bash
ubuntu-rs@ubuntu-rs:/workspace/git_zammad$ mkdir Example-NewProject
ubuntu-rs@ubuntu-rs:/workspace/git_zammad$ cd Example-NewProject
```

Example is in this case our vendor of the package and NewProject is the package name. It is important to use came case here.

2. Initialize your git
```bash
ubuntu-rs@ubuntu-rs:/workspace/git_zammad/Example-NewProject$ git init
```

3. Add the template for a new zammad package module:

```bash
ubuntu-rs@ubuntu-rs:/workspace/git_zammad/Example-NewProject$ git zammad-new-szpm
ubuntu-rs@ubuntu-rs:/workspace/git_zammad/Example-NewProject$ cat example-new_project.szpm
{
  "name": "Example-NewProject",
  "version": "1.0.0",
  "vendor": "Example GmbH",
  "license": "GNU AFFERO GENERAL PUBLIC LICENSE",
  "url": "http://example.com/",
  "files": []
}
```

## Commands

### New source zammad package module

This will create an new source file which is needed to a create a package.

```bash
ubuntu-rs@ubuntu-rs:/workspace/git_zammad/Example-NewProject$ git zammad-new-szpm
ubuntu-rs@ubuntu-rs:/workspace/git_zammad/Example-NewProject$ cat example-new_project.szpm
{
  "name": "Example-NewProject",
  "version": "1.0.0",
  "vendor": "Example GmbH",
  "license": "GNU AFFERO GENERAL PUBLIC LICENSE",
  "url": "http://example.com/",
  "files": []
}
```

### Add migration

This will create a new migration for the package

```bash
ubuntu-rs@ubuntu-rs:/workspace/git_zammad/Example-NewProject$ git zammad-migration CreateBase
create migration /workspace/git_zammad/Example-NewProject/db/addon/example_new_project/20230908080759_create_base.rb...
ubuntu-rs@ubuntu-rs:/workspace/git_zammad/Example-NewProject$ cat db/addon/example_new_project/20230908080759_create_base.rb
class CreateBase < ActiveRecord::Migration[4.2]
  def self.up
  end

  def self.down
  end
end
```

### Update file list

This will update the file list for the `*.szpm` file.

```bash
ubuntu-rs@ubuntu-rs:/workspace/git_zammad/Example-NewProject$ git zammad-update-szpm
ubuntu-rs@ubuntu-rs:/workspace/git_zammad/Example-NewProject$ cat example-new_project.szpm
{
  "name": "Example-NewProject",
  "version": "1.0.0",
  "vendor": "Example GmbH",
  "license": "GNU AFFERO GENERAL PUBLIC LICENSE",
  "url": "http://example.com/",
  "files": [
    {
      "location": "db/addon/example_new_project/20230908080759_create_base.rb",
      "permission": 644
    }
  ]
}
```

### Create a zammad package

This will create a final package which is installable by zammad.

```bash
ubuntu-rs@ubuntu-rs:/workspace/git_zammad/Example-NewProject$ git zammad-create-zpm
create zpm /workspace/git_zammad/Example-NewProject/example-new_project-1.0.0.zpm...
ubuntu-rs@ubuntu-rs:/workspace/git_zammad/Example-NewProject$ cat example-new_project-1.0.0.zpm
{
  "name": "Example-NewProject",
  "version": "1.0.0",
  "vendor": "Example GmbH",
  "license": "GNU AFFERO GENERAL PUBLIC LICENSE",
  "url": "http://example.com/",
  "files": [
    {
      "location": "db/addon/example_new_project/20230908080759_create_base.rb",
      "permission": 644,
      "encode": "base64",
      "content": "Y2xhc3MgQ3JlYXRlQmFzZSA8IEFjdGl2ZVJlY29yZDo6TWlncmF0aW9uWzQu\nMl0KICBkZWYgc2VsZi51cAogIGVuZAoKICBkZWYgc2VsZi5kb3duCiAgZW5k\nCmVuZAo="
    }
  ]
}
```

or with version parameter:

```
ubuntu-rs@ubuntu-rs:/workspace/git_zammad/Example-NewProject$ git zammad-create-zpm 1.0.0
create zpm /workspace/git_zammad/Example-NewProject/example-new_project-1.0.0.zpm...
ubuntu-rs@ubuntu-rs:/workspace/git_zammad/Example-NewProject$ cat example-new_project-1.0.0.zpm
{
  "name": "Example-NewProject",
  "version": "1.0.0",
  "vendor": "Example GmbH",
  "license": "GNU AFFERO GENERAL PUBLIC LICENSE",
  "url": "http://example.com/",
  "files": [
    {
      "location": "db/addon/example_new_project/20230908080759_create_base.rb",
      "permission": 644,
      "encode": "base64",
      "content": "Y2xhc3MgQ3JlYXRlQmFzZSA8IEFjdGl2ZVJlY29yZDo6TWlncmF0aW9uWzQu\nMl0KICBkZWYgc2VsZi51cAogIGVuZAoKICBkZWYgc2VsZi5kb3duCiAgZW5k\nCmVuZAo="
    }
  ]
}
```

### Link zammad package

This will link the zammad package into the zammad directory.

```
ubuntu-rs@ubuntu-rs:/workspace/zammad$ git zammad-link Example-HelloWorld
Link file: /workspace/git_zammad/Example-HelloWorld/example-hello_world.szpm -> /workspace/git_zammad/zammad/example-hello_world.szpm
Link file: /workspace/git_zammad/Example-HelloWorld/public/assets/hello.txt -> /workspace/git_zammad/zammad/public/assets/hello.txt
```

### Unlink zammad package

This will unlink the zammad package from the zammad directory.

```
ubuntu-rs@ubuntu-rs:/workspace/zammad$ git zammad-unlink Example-HelloWorld
Unlink file: /workspace/git_zammad/zammad/example-hello_world.szpm
Unlink file: /workspace/git_zammad/zammad/public/assets/hello.txt
```

## Optional Settings

You can modify the default data of the new SZPM with ENVs. Just add the following exports to your `~/.bashrc`:

**ZAMMAD_SCRIPTS_VENDOR**

Defines your zpm vendor.

**ZAMMAD_SCRIPTS_URL**

Defines your zpm vendor url.

**ZAMMAD_SCRIPTS_LICENSE**

Defines your zpm license.

**ZAMMAD_SCRIPTS_SKIP_LICENSE**

Defines to skip license file on new szpm creation.

**ZAMMAD_SCRIPTS_SKIP_GIT_IGNORE**

Defines to skip .gitignore file on new szpm creation.

```bash
export ZAMMAD_SCRIPTS_VENDOR="Your name"
export ZAMMAD_SCRIPTS_URL="https://github.com/yourname"
export ZAMMAD_SCRIPTS_LICENSE="GNU AFFERO GENERAL PUBLIC LICENSE"
export ZAMMAD_SCRIPTS_SKIP_LICENSE=1
export ZAMMAD_SCRIPTS_SKIP_GIT_IGNORE=1
```
