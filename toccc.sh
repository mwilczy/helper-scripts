

PATCH_FILE="$1"


RECIPIENTS=$(`pwd`/scripts/get_maintainer.pl --nogit --nogit-fallback --norolestats --nom $PATCH_FILE)



BLACKLIST=("linux-kernel@vger.kernel.org" "example")

for address in ${BLACKLIST[@]}; do
    RECIPIENTS=$(echo "$RECIPIENTS" | grep -v "$address")
done

ALWAYS_INCLUDE=("linux-acpi@vger.kernel.org" "platform-driver-x86@vger.kernel.org" "rafael@kernel.org")

for address in ${ALWAYS_INCLUDE[@]}; do
    RECIPIENTS="${RECIPIENTS} ${address}"
done

echo "$RECIPIENTS"
