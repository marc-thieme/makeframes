set unstable

readme-typ-file := 'README.typ'

setup: && _add-assets-to-git-exclude
    git worktree add assets
[confirm("Add new worktree 'assets' to '.git/info/exclude'?")]
_add-assets-to-git-exclude:
    echo assets >> .git/info/exclude

push-new-readme: (readme-compile "assets/README.svg") && commit-and-push-assets

[confirm("Do you want to commit and push all changes on the assets branch?")]
[script]
commit-and-push-assets commit-msg="Update.":
    cd assets
    git add .
    git commit -m {{commit-msg}}
    git push

readme-watch output="":
    typst watch {{readme-typ-file}} {{output}}

readme-compile output="":
    typst compile {{readme-typ-file}} {{output}}

_version-regex := '[0-9]+\.[0-9]+\.[0-9]+'
release new-version:
    sed -Ei 's|#import "@preview/frame-it:{{_version-regex}}"|#import "@preview/frame-it:{{new-version}}"|g' README.typ
    sed -Ei 's|version = "{{_version-regex}}"|version = "{{new-version}}"|g' typst.toml
    echo Don\'t forget to open a pull request for the new version!
