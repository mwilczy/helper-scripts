

PATCH_FILE="$1"


RECIPIENTS=$(`pwd`/scripts/get_maintainer.pl --nogit --nogit-fallback --norolestats --nol $PATCH_FILE)



BLACKLIST=("exclude1@example.com" "exclude2@example.com")

for address in ${BLACKLIST[@]}; do
    RECIPIENTS=$(echo "$RECIPIENTS" | grep -v "$address")
done

echo "$RECIPIENTS"
