#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

export RUNNER_ALLOW_RUNASROOT=true
cd /home/ubuntu



# Create the directory if it doesn't exist
mkdir -p actions-runner

# Navigate into the directory
cd actions-runner

# Download the latest GitHub Actions runner package
curl -o actions-runner-linux-x64-2.315.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.315.0/actions-runner-linux-x64-2.315.0.tar.gz

# Verify the integrity of the downloaded package
echo "6362646b67613c6981db76f4d25e68e463a9af2cc8d16e31bfeabe39153606a0  actions-runner-linux-x64-2.315.0.tar.gz" | shasum -a 256 -c

# Extract the package
tar xzf ./actions-runner-linux-x64-2.315.0.tar.gz

# Configure the runner to connect it to the repository
./config.sh --url https://github.com/bones2peaches/sre-resume-project-dm --token BF75S6RCPDISWUOLN3VAW7LGERN42 --unattended \
--name "default-runner-name" --work "_work" --labels "self-hosted,Linux,X64" \
--runnergroup "Default"

# Install and start the runner service

./svc.sh install
./svc.sh start

echo "DONE"

