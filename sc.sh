for file in $(git diff --name-only); do
	git add "$file"
	git commit -m "$commit_message"
done
