#!/bin/bash

PROJECT_NAME="anti-flux"

green=`tput bold setaf 2`
reset=`tput sgr0`

rm -fr exports

info() {
    echo "$green$1$reset"
}

export_as() {
    info "Exporting $1..."
    mkdir -p exports/$(dirname $2)
    godot --export "$1" exports/$2 --no-window 

    if [[ $2 != *.zip ]]; then
        pushd exports > /dev/null
        export_dir=$(dirname $2)
        info "Zipping exports/$export_dir.zip..."
        zip -r $export_dir.zip $export_dir -9
        popd > /dev/null
    fi
}

export_as HTML5 $PROJECT_NAME-html/index.html
export_as "Windows Desktop" $PROJECT_NAME-windows/$PROJECT_NAME-windows.exe
export_as "Linux/X11" $PROJECT_NAME-linux/$PROJECT_NAME-linux.x86_64
export_as "Mac OSX" $PROJECT_NAME-macos.zip

printf "\nPush to github pages? [y/N] "
read input
if [ "$input" = "y" ]; then 
    current_commit=$(git rev-parse HEAD)
    cd exports
    [ ! -d "gh-pages" ] && git worktree add gh-pages gh-pages
    cd gh-pages
    git rm -r .
    cp ../$PROJECT_NAME-html/* .
    git add .
    git commit -m "deploy at $current_commit"
    git push origin gh-pages
fi

