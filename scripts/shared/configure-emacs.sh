#!/bin/bash

dependency_path="${HOME}/.emacs.d/site-lisp"
mkdir -p $dependency_path

fci_url="https://raw.githubusercontent.com/alpaker/Fill-Column-Indicator/master/fill-column-indicator.el"
curl $fci_url > $dependency_path/fill-column-indicator.el

yaml_url="https://raw.githubusercontent.com/yoshiki/yaml-mode/master/yaml-mode.el"
curl $fci_url > $dependency_path/yaml-mode.el
