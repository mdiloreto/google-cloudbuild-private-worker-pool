REPO_NAME=$1
COMMIT=$2
BRANCH=$3
log_message() {
    echo "$1 on $(date) - Repository: $REPO_NAME | Commit: $COMMIT | Branch: $BRANCH" >> deployments.log
}

# Checking if the repository directory exists
if [ ! -d "$REPO_NAME" ]; then
    log_message "Error: Repository directory $REPO_NAME not found"
    exit 1
fi

cd "$REPO_NAME"

if [ "$BRANCH" == "master" ]; then
    log_message "Deployment started"

    # Fetching latest changes from the remote and checking out to the specified commit
    if git checkout master && git pull; then
        log_message "Deployment successful"
    else
        log_message "Error during deployment"
        exit 1
    fi
else
    log_message "Cannot process: Branch is not master"
fi