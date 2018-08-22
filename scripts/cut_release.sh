#!/bin/sh
git checkout -b release/$(gitversion -showvariable MajorMinorPatch)
touch CHANGELOG.md
printf '%s\n\n%s' "$(git log $(git branch --list release/* --no-color --no-merged | tail -1 | xargs)..HEAD --pretty=format:"%s (%h)" | sort -k1.1,1.2 -s)" "$(cat CHANGELOG.md)" > CHANGELOG.md
printf '%s\n========\n%s\n' "$(gitversion -showvariable MajorMinorPatch)" "$(cat CHANGELOG.md)" > CHANGELOG.md
git add CHANGELOG.md
npm version $(gitversion -showvariable SemVer) --no-git-tag-version
git add package*json
git commit -m"docs(release): Cut release $(gitversion -showvariable MajorMinorPatch)"
printf 'To finish release cut, publish with following command: git push -u origin release/%s \n' "$(gitversion -showvariable MajorMinorPatch)"
printf 'Then do: git checkout develop && git merge release/%s --no-edit && git push -u origin develop' "$(gitversion -showvariable MajorMinorPatch)"
