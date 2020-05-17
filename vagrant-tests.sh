#!/bin/bash
set -e

molecule test -s vagrant-xenial
molecule test -s vagrant-bionic
molecule test -s vagrant-focal
molecule test -s vagrant-stretch
molecule test -s vagrant-buster
