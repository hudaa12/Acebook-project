apt-get update -y
apt-get install -y openssh-client rsync

eval $(ssh-agent -s)
echo "$SSH_PRIVATE_KEY" | tr -d '\r' | ssh-add -
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# The instance ip address is 35.178.181.29
# we should probably avoid hardcoding this, in case
# the IP changes
rsync -av -e "ssh -o StrictHostKeyChecking=no" ./* ec2-user@35.178.181.29:/var/acebook/
ssh -o StrictHostKeyChecking=no ec2-user@35.178.181.29 "sudo systemctl restart acebook"
