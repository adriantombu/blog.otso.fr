export GOMODULE111=on
export PATH=$PATH:$(go env GOPATH)/bin
go get github.com/adriantombu/orion
orion build
