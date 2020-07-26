#!/bin/bash -e
function git_push() {
    for d in $(ls -1); do
        if [ -d "$d" ] && [ -f "$d/.git" ] ; then
            cd "$d"
            echo "In ${d}, git commit and push"
            git commit -am "update doc"
            git push origin
            cd ..
        fi
    done
    git commit -am "update doc"
    git push origin
}

function git_pull() {
    for d in $(ls -1); do
        if [ -d "$d" ] && [ -f "$d/.git" ] ; then
            cd "$d"
            echo "In ${d}, git commit and push"
            git pull origin
            cd ..
        fi
    done
    git pull origin
}

function refresh_wordpress() {
    local max_days=${MAX_DAYS:-"7"}
    echo "Use emacs to update README.org"
    for d in "problems" "followup" "review" "posts"; do
    # for d in "series" "review"; do
        cd "$d"
        for f in $(find . -name 'README.org' -mtime -${max_days} | grep -v '^README.org$'); do
            echo "Update $f"
            dirname=$(basename $(dirname $f))
            (cd "$dirname" && /Applications/Emacs.app/Contents/MacOS/Emacs-x86_64-10_10 --batch -l ../../emacs-update.el)
        done
        cd ..
    done
}

function refresh_link() {
    echo "refresh link"
    cd problems
    for f in $(ls -1t */README.org); do
        dirname=$(basename $(dirname $f))
        if ! grep "github.com\/dennyzhang\/code.dennyzhang.com.*$dirname" $f 1>/dev/null 2>&1; then
            echo "Update github fork link for $f"
            sed -ie "s/github.com\/dennyzhang\/code.dennyzhang.com.*\">/github.com\/dennyzhang\/code.dennyzhang.com\/tree\/master\/problems\/$dirname\">/g" $f
            rm -rf $dirname/README.orge
        fi

        if ! grep "https:\/\/code.dennyzhang.com.*$dirname" $f 1>/dev/null 2>&1; then
            echo "Update blog url for $f"
            sed -ie "s/https:\/\/code.dennyzhang.com\/example/https:\/\/code.dennyzhang.com\/$dirname/g" $f
            rm -rf $dirname/README.orge
        fi

        if ! grep "Github:.*tree\/master/problems/.*$dirname" $f 1>/dev/null 2>&1; then
            echo "Update GitHub url for $f"
            sed -ie "s/tree\/master\/.*code.dennyzhang.com/tree\/master\/problems\/$dirname][code.dennyzhang.com/g" $f
            rm -rf $dirname/README.orge
        fi

        if ! grep -i lintcode.com $f 1>/dev/null 2>&1; then
            if ! grep "leetcode.com.*$dirname" $f 1>/dev/null 2>&1; then
                echo "Update Leetcode url for $f"            
                sed -ie "s/https:\/\/leetcode.com\/problems\/.*/https:\/\/leetcode.com\/problems\/$dirname\/description\/][leetcode.com]]/g" $f
                rm -rf $dirname/README.orge
            fi
        fi
    done
}

action=${1?}
eval "$action"
