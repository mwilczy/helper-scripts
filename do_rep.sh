#!/bin/bash

# Ensure that you're in the correct git repository
if [ ! -d ".git" ]; then
    echo "Error: This script must be run from the root of a git repository."
    exit 1
fi

# Define the commit range
START_COMMIT="5c2f6c24aa57af0a4923f25f2ff6fc534a169eae"
END_COMMIT="f8c8aecfe231d99f801dafcb3ed27157804ec3bf"

# Create a new branch to apply the changes
git checkout linux-next-notify-remove
git checkout -b linux-next-notify-remove_v{$1}

# Perform the rebase with the sed command
#git rebase -i --exec "git diff --name-only HEAD^ | xargs -I {} find {} -type f -not -path './.git/*' -exec sed -i 's/acpi_device_install_notify_handler/acpi_device_install_event_handler/g; s/acpi_device_remove_notify_handler/acpi_device_remove_event_handler/g' {} \; git add -u; git commit --amend --no-edit" $START_COMMIT^


git rebase -i --exec "git diff --name-only HEAD^ | xargs -I {} sh -c 'find {} -type f -not -path \"./.git/*\" -exec sed -i \"s/acpi_device_install_notify_handler/acpi_device_install_event_handler/g; s/acpi_device_remove_notify_handler/acpi_device_remove_event_handler/g\" {} \;' && git add -u && git commit --amend --no-edit" $START_COMMIT^


# Verify changes by comparing the old and new branches
git diff $END_COMMIT linux-next-notify-remove_v{$1}
