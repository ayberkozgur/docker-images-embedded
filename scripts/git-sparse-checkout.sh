#!/usr/bin/env sh

LOCAL_PATH=""
REMOTE_URL=""
REMOTE_TAG=""

for arg in "$@"
do
    if [ -z "$LOCAL_PATH" ]
    then
        LOCAL_PATH="$arg"
        echo "Using local path: $LOCAL_PATH"
    elif [ -z "$REMOTE_URL" ]
    then
        REMOTE_URL="$arg"
        echo "Using remote at: $REMOTE_URL"
    elif [ -z "$REMOTE_TAG" ]
    then
        REMOTE_TAG="$arg"
        echo "Using tag/branch: $REMOTE_TAG"
        git clone "$REMOTE_URL" "$LOCAL_PATH" --branch "$REMOTE_TAG" --depth 1
    else
        echo "Adding path to sparse checkout: $LOCAL_PATH/$arg"
        mkdir -p `dirname $LOCAL_PATH/.tmp/$arg`
        mv $LOCAL_PATH/$arg $LOCAL_PATH/.tmp/$arg
    fi
done

rm -rf $LOCAL_PATH/*
mv $LOCAL_PATH/.tmp/* $LOCAL_PATH
rm -rf $LOCAL_PATH/.tmp/ $LOCAL_PATH/.git/ $LOCAL_PATH/.github/ $LOCAL_PATH/.gitignore

echo "Done."
