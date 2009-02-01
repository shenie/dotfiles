#!/bin/bash

git fetch public
git merge public/master
git cherry -v origin/master
