#!/bin/sh

roundtrips_foldfirst() {
    folded=;unfolded=
    folded="${1:-foo}"."folded"
        unfolded="${1:-foo}"."unfolded"
    <"$1"      ./foldpod > "$folded"
    <"$folded" ./foldpod -u > "$unfolded"
    if cmp --silent "${1:-foo}" "$unfolded"; then
        echo OK
    else
        echo NOT OK
        diff "${1:-foo}" "$unfolded"
        return 10
    fi
}

set -e

cd "$(dirname "$0")" || exit 20
test -f foldpod || exit 20

echo "self tests"
./foldpod --selftest

echo "round trip -- 01"
roundtrips_foldfirst ./test_files/01_rand_hex.pl

echo "round trip -- 02"
roundtrips_foldfirst ./test_files/02_nullbyte.pl
