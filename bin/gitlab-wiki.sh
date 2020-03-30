#!/usr/bin/env bash

function debug() {
    echo "::debug file=${BASH_SOURCE[0]},line=${BASH_LINENO[0]}::$1"
}

GITHUB_ACTOR="thecb4"
GITHUB_REPOSITORY=shellkit
WIKI_COMMIT_MESSAGE=$

# https://stackoverflow.com/questions/25409700/using-gitlab-token-to-clone-without-authentication/29570677#29570677
GIT_REPOSITORY_URL="https://gitlab-ci-token:${SECRET_PAT}@gitlab.com/$GITHUB_ACTOR/$GITHUB_REPOSITORY.wiki.git"

debug "Checking out wiki repository"
tmp_dir=$(mktemp -d -t ci-XXXXXXXXXX)
(
    cd "$tmp_dir" || exit 1
    git init
    git config user.name "$GITHUB_ACTOR"
    git config user.email "$GITHUB_ACTOR@users.noreply.github.com"
    git pull "$GIT_REPOSITORY_URL"
)

debug "Enumerating contents of $1"
for file in $(find $1 -maxdepth 1 -type f -name '*.md' -execdir basename '{}' ';'); do
    debug "Copying $file"
    cp "$1/$file" "$tmp_dir"
done

debug "Committing and pushing changes"
(
    cd "$tmp_dir" || exit 1
    git add .
    git commit -m "$WIKI_COMMIT_MESSAGE"
    git push --set-upstream "$GIT_REPOSITORY_URL" master
)

rm -rf "$tmp_dir"
exit 0