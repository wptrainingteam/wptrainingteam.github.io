#!/usr/bin/env sh

REPO="https://api.github.com/orgs/wptrainingteam"
OMIT="omitted-repos.manifest"
ALL="all-repos.manifest"
LESSONLIST="lesson-plans.manifest"
LESSONPATH="../lesson-plan/"

curl "$REPO/repos?per_page=1000" |
    grep -w clone_url |
    grep -o '[^"]\+://.\+.git' > "$ALL"

awk 'NR == FNR { list[$0]=1; next } { if (! list[$0]) print }' "$OMIT" "$ALL" > "$LESSONLIST"

LESSONS="$(cat $LESSONLIST)"
cd "$LESSONPATH"

for lesson in $LESSONS; do
    git submodule add -b master "$lesson" || continue
done

git submodule init
git submodule sync
git submodule update --remote --merge
