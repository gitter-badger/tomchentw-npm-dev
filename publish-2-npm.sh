#!/bin/sh
changelog_name="CHANGELOG.md"
#
# runtime constants
#
new_version_semver=${NEW_VERSION:-"patch"}
old_version=$(node -e "console.log(require('./package.json').version)")
#
# actual script
#
npm run build
git add -A
git commit

echo "Bumping to $new_version_semver"
npm version $new_version_semver -m "chore(package.json): bump version to %s"
npm version

echo "Bump version completed"

new_version=$(node -e "console.log(require('./package.json').version)")
if [[ ! -f $changelog_name ]]; then
  old_version=$(git log --pretty=format:%H | tail -1)
fi
node ./_changelog.js $changelog_name $old_version
git add $changelog_name
git commit --amend --no-edit
git tag -fa v$new_version

echo "Please run \`npm publish\` and \`git push --tags\` manually"
