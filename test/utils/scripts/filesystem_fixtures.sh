#!/bin/bash

test_root=/tmp/git-ihm

function clear_fixtures {
  rm -rf ${test_root}
}

function make_simple_directory {
  mkdir -p ${test_root}/nonGitProject
}

function make_git_project {
  git_project=${test_root}/gitProject
  mkdir -p $git_project
  cd $git_project || exit
  git init --quiet
  git commit --allow-empty --quiet -m "initial commit"
}

clear_fixtures
make_simple_directory
make_git_project
