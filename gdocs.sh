#!/bin/bash
NAME=$1
REPO=$2
INSTALLER=$3
INSTALLER_VERSION=$4
INSTALLER_VERSION_NUMBER=$5
CACHE=$6
NODE_MODULES=$7
LOCKFILE=$8
DURATION=$9

DATE=`date +%Y-%m-%d`

SPREADSHEET=1ZE5B4qJw1kNGMzjgslcWTuPYrpatzQJXSYMGNOhZ2ys
TABLE=Data

curl -v --request POST \
  --url "https://sheets.googleapis.com/v4/spreadsheets/$SPREADSHEET/values/$TABLE:append?valueInputOption=USER_ENTERED&insertDataOption=INSERT_ROWS" \
  --header "authorization: Bearer $GOOGLE_OAUTH_TOKEN" \
  --header 'content-type: application/json' \
  --data "{\"values\": [[\"$DATE\",\"$NAME\",\"$INSTALLER\",\"$INSTALLER_VERSION\",\"$INSTALLER_VERSION_NUMBER\",\"$CACHE\",\"$NODE_MODULES\",\"$LOCKFILE\",$DURATION]]}"
