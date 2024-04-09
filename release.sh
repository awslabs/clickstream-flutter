#!/bin/bash

version="$1"
echo ${version}
regex="[0-9]\+\.[0-9]\+\.[0-9]\+"

sed -i "s/version: ${regex}/version: ${version}/g" pubspec.yaml
sed -i "s/s.version          = '${regex}'/s.version          = '${version}'/g" ios/clickstream_analytics.podspec
