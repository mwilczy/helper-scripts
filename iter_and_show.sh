#!/bin/bash

# Ensure that you're in the correct git repository
if [ ! -d ".git" ]; then
    echo "Error: This script must be run from the root of a git repository."
    exit 1
fi

# Define the commit range
START_COMMIT="5ae76a386d97dd85f057623f2f04d6ad0b50de47"
END_COMMIT="7bee916810e96858a918baa14a44bf95cc37409b"

# Create a new branch to apply the changes
git checkout "linux-next-notify-remove_v{9}"
git checkout -b "linux-next-notify-remove_v${1}"

# Perform the rebase with the sed command
#git rebase -i --exec "git diff --name-only HEAD^ | xargs -I {} find {} -type f -not -path './.git/*' -exec sed -i 's/acpi_device_install_notify_handler/acpi_device_install_event_handler/g; s/acpi_device_remove_notify_handler/acpi_device_remove_event_handler/g' {} \; git add -u; git commit --amend --no-edit" $START_COMMIT^

# vim -c "/acpi_device_remove_event_handler"
#git rebase -i --exec "git diff --name-only HEAD^ | xargs -I {} sh -c 'find {} -type f -not -path \"./.git/*\" -exec sed -i \"s/acpi_device_install_notify_handler/acpi_device_install_event_handler/g; s/acpi_device_remove_notify_handler/acpi_device_remove_event_handler/g\" {} \;' && git add -u && git commit --amend --no-edit" $START_COMMIT^
function open_files_with_search() {
    for file in $(git diff --name-only HEAD^); do
        vim -c "normal /acpi_device_remove_event_handler" "$file"
    done
    git add -u
    git commit --amend --no-edit
}

export -f open_files_with_search

git rebase -i --exec 'bash -c open_files_with_search' $START_COMMIT^

# Verify changes by comparing the old and new branches
git diff $END_COMMIT "linux-next-notify-remove_v{$1}"
