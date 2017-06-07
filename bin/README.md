**Set up SSH Keys**
~~~~
$> ssh-keygen -t rsa
~~~~

**Copy to remote servers**
~~~~
$> for i in server1 server2 server3; do ssh-copy-id $i; done
~~~~
