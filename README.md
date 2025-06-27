# My Neovim config files

<p align="center">
<img width="800" alt="image" src="/neovim.png">
</p>

## Index

- [Introduction](#introduction)
- [Dependencies](#dependencies)
- [Install](#install)
- [Installed](#installed)
  - [Lenguage Server Protocol](#language-server-protocol)
  - [Debugger](#debugger)
  - [Linter](#linter)
  - [Formatter](#formatter)

## Introduction

I used [NvChad](https://nvchad.com/) as starting point for my configuration.
In this repository you will find the custom folders to make possible 
work with my custom configurations.

## Dependencies

The only dependencies you need here is the proper NvChad, go to 
[install section](https://nvchad.com/docs/quickstart/install) if you want to 
know more.

## Install

1 - Install NvChad and run it:
```Bash
git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
```
2 - Exit from neovim and copy the configuration:
```Bash
git clone --branch main git@github.com:GiomarOsorio/vim.git && cp -r ./.config/nvim/* $HOME/.config/nvim/ && sudo rm -r ./vim
```
3 - Run nvim
```Bash
nvim
```

## Installed
### Language Server Protocol

- Ansible
- Bash
- Docker
- Docker Composer
- Eslint
- Go
- JavaScript
- JSON
- Lua
- Markdown
- Python
- Terraform
- TypeScript
- YAML

### Debugger

- Bash
- JavaScript
- TypeScript

### Linter

- Shellcheck

### Formatter

- Prettier
