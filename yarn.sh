#!/bin/bash
NAME=$1
REPO=$2

gclonecd() {
  git clone "$REPO" npm-local-dir && cd npm-local-dir
}

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
  time yarn install --no-progress
  DURATION=`echo $SECONDS`
  ../gdocs.sh $NAME $REPO $INSTALLER $INSTALLER_VERSION $($INSTALLER --version) $1 $2 $3 $DURATION
  echo "$DURATION s CACHE: $1, NODE_MODULES: $2, LOCKFILE: $3"
}

gclonecd $1

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

cd .. && rm -rf ./npm-local-dir
