#!/bin/sh

if [ -z "$1" ]; then
  echo "Usage: $0 <cdk-major-version>"
  exit 1
fi

if echo "$2" | grep -Eq '^[0-9]+$'; then
  echo "Error: CDK major version must be a number"
  exit 1
fi

release_version=$( curl -sL https://api.github.com/repos/aws/aws-cdk/releases | jq -r .[].tag_name | grep "v$1" | sort -V -r | head -1 | sed 's/v//' )
local_version=$( grep cdkVersion .projenrc.js | awk ' { print $2 } ' | sed -e "s/'//g" -e 's/,//' )

if [  "$release_version" = "$local_version" ]; then
  echo "No need to upgrade CDK version"
else
  echo "Upgrading CDK version from $local_version to $release_version"
  echo "::set-output name=previous_version::$local_version"
  echo "::set-output name=new_version::$release_version"
  sed -i "s/cdkVersion: '$local_version'/cdkVersion: '$release_version'/g" .projenrc.js
  # # remove the lock file so we can update appropriately for the new CDK version
  # rm yarn.lock
  if npx projen --no-post && yarn install && npx jest test; then
    echo "CDK version upgraded successfully"
  else
    echo "CDK version upgrade failed"
    exit 1
  fi
fi
