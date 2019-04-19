#!/usr/bin/env bash

OMIT=omitted-repos.manifest
ALL=all-repos.manifest
LESSONLIST=lesson-plans.manifest
LESSONPATH=../lesson-plan/

curl "https://api.github.com/orgs/wptrainingteam/repos?per_page=1000" | grep -w clone_url | grep -o '[^"]\+://.\+.git' > $ALL

awk 'NR == FNR { list[$0]=1; next } { if (! list[$0]) print }' $OMIT $ALL > $LESSONLIST

LESSONS=$(cat lesson-plans.manifest)
cd ../lesson-plan/

for lesson in $LESSONS;
do
	git submodule add -b master $lesson || continue
done

git submodule foreach git submodule init
git submodule foreach git submodule sync
git submodule foreach git submodule update --remote --merge
