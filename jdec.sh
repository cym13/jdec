#!/bin/sh
# Under GPLv3 License © Cédric Picard 2017

set -e

if [ "$#" -eq 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ] ; then
cat <<EOF
Decompile class, jar and war files

Usage: jdec [-h] FILE...

Options:
    -h, --help    Print this help and exit.

Arguments:
    FILE          Files or directory to decompile
                  Supported: class, war, jar, apk, dex, zip

Notes:
    + cfr and jad are the two decompilers used, in that order
    + dex2jar is required for apk and dex support
    + zip files get unzipped only if containing a decompilable file
EOF
exit 0
fi

if [ -n "$(which cfr)" ] ; then
    ENGINE=cfr
elif [ -n "$(which jad)" ] ; then
    ENGINE="jad -p"
else
    echo "No decompiler found" >&2
    exit 1
fi

while [ $# -ne 0 ] ; do
    base="${1%.*}"

    if [ -f "$1" ] && echo "$1" | grep '\.class$' ; then
        $ENGINE "$1" > "$base.java"

    elif [ -f "$1" ] && echo "$1" | grep '\.\(jar\|war\|apk\|zip\)$' ; then
        if [ "${1##*.}" != "zip" ] || \
            zip --show-files "$1" | grep -q "\.\(jar\|war\|apk\|class\|dex\)$"
        then
            mkdir -v "$base"
            unzip -d "$base" "$1"
            "$0" "$base"
        fi

    elif [ -f "$1" ] && echo "$1" | grep '\.dex$' ; then
        if [ -z "$(which dex2jar)" ] ; then
            echo "Install dex2jar for this to work" >&2
            exit 1
        fi
        dex2jar "$1" -o "$base-dex2jar.jar"
        "$0" "$base-dex2jar.jar"

    elif [ -d "$1" ] ; then
        find "$1" -type f          \
                  -print0          \
                  -iname "*.class" \
              -or -iname "*.jar"   \
              -or -iname "*.war"   \
              -or -iname "*.apk"   \
              -or -iname "*.dex"   \
              -or -iname "*.zip"   \
        | xargs -0 "$0"
    fi
    shift
done
