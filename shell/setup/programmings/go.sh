wget https://go.dev/dl/go1.25.2.linux-amd64.tar.gz
rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.25.2.linux-amd64.tar.gz
rm go1.25.2.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
go version
