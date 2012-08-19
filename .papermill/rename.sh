#!/bin/sh

git filter-branch -f --env-filter '

an="$GIT_AUTHOR_NAME"
am="$GIT_AUTHOR_EMAIL"
cn="$GIT_COMMITTER_NAME"
cm="$GIT_COMMITTER_EMAIL"

if [ "$GIT_AUTHOR_NAME" = "Max F. Albrecht" ]
then
cn="Max F. Albrecht"
cm="1@178.is"
fi
if [ "$GIT_AUTHOR_NAME" = "Max F. Albrecht" ]
then
an="Max F. Albrecht"
am="1@178.is"
fi

export GIT_AUTHOR_NAME="$an"
export GIT_AUTHOR_EMAIL="$am"
export GIT_COMMITTER_NAME="$cn"
export GIT_COMMITTER_EMAIL="$cm"
'
