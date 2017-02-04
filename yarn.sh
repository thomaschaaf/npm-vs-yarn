#!/bin/bash
cd react

function install {
  # clean cache
  if [ "$1" = "cold" ]; then
    yarn cache clean
  fi

  # remove node_modules
  if [ "$2" = "empty" ]; then
    rm -rf node_modules
  fi
  
  # remove node_modules
  if [ "$3" = "no" ]; then
    if [ -e "yarn.lock" ]; then
      mv yarn.lock .yarn.lock
    fi
    if [ -e "npm-shrinkwrap.json" ]; then
      mv npm-shrinkwrap.json .npm-shrinkwrap.json
    fi
  else
    if [ -e ".yarn.lock" ]; then
      mv .yarn.lock yarn.lock 
    fi
    if [ -e ".npm-shrinkwrap.json" ]; then
      mv .npm-shrinkwrap.json npm-shrinkwrap.json
    fi
  fi
  
  SECONDS=0
  yarn install
  echo "$SECONDS s CACHE: $1, NODE_MODULES: $2, LOCKFILE: $3
}

# CACHE: cold, NODE_MODULES: empty, LOCKFILE: no
install cold empty no

# CACHE: cold, NODE_MODULES: empty, LOCKFILE: yes
install cold empty yes

# CACHE: cold, NODE_MODULES: installed, LOCKFILE: no
install cold installed no

# CACHE: cold, NODE_MODULES: installed, LOCKFILE: yes
install cold installed yes

# CACHE: warm, NODE_MODULES: empty, LOCKFILE: no
install warm empty no

# CACHE: warm, NODE_MODULES: empty, LOCKFILE: yes
install warm empty yes

# CACHE: warm, NODE_MODULES: installed, LOCKFILE: no
install warm installed no

# CACHE: warm, NODE_MODULES: installed, LOCKFILE: yes
install warm installed yes
