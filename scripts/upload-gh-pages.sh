#!/bin/sh

git config --global user.name "Travis CI"
git config --global user.email "noreply+travis@fossasia.org"

cd docs/sources

make html
mkdir _build/html/docs

git clone --quiet --branch=gh-pages https://$USERNAME:$GITHUB_API_KEY@github.com/$USERNAME/pslab-documentation gh-pages > /dev/null

cd gh-pages

rm -rf *
cp -r ../_build/html/* .

git checkout --orphan temporary

git add --all .
git commit -am "[Auto] Update GH-Pages ($(date +%Y-%m-%d.%H:%M:%S))"

git branch -D gh-pages
git branch -m gh-pages

git push origin gh-pages --force --quiet > /dev/null
