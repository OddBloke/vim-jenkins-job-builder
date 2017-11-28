# vim-jenkins-job-builder

Vim plugin to enhance working with [Jenkins Job
Builder](https://docs.openstack.org/infra/jenkins-job-builder/) YAML
files.

Currently, it provides the following functionality:

* custom folding for JJB YAML files

## Basic Usage

To avoid conflicting with regular YAML files, the plugin defines a new
file type, "jjb\_yaml".  All customisations are applied to this file
type.

Currently, it is up to you to set this file type appropriately.  If you
want it to apply to all YAML files, you can add this to your `.vimrc`:

```vim
autocmd FileType yaml setlocal filetype=jjb_yaml
```

## Basic Configuration

At the moment, the plugin doesn't provide any configuration options.

## Installation

This repo should be compatible with your favourite vim plugin
installation method.
