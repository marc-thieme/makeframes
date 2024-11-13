set unstable

setup: && _add-assets-to-git-exclude
    git worktree add assets

upload-example: (example-compile "svg") && commit-and-push-assets
    cp examples/example.svg assets/

[confirm("Do you want to commit and push all changes on the assets branch?")]
[script]
commit-and-push-assets commit-msg="Update.":
    cd assets
    git add .
    git commit -m {{commit-msg}}
    git push

[confirm("Add new worktree 'assets' to '.git/info/exclude'?")]
_add-assets-to-git-exclude:
    echo assets >> .git/info/exclude

example-watch format="pdf":
    cd examples && typst watch example.typ --root .. {{format}}

example-compile format="pdf":
    cd examples && typst compile example.typ --root .. -f {{format}}
