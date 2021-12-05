export GOMODULE111=on
export PATH=$PATH:$(go env GOPATH)/bin
go install github.com/adriantombu/orion@latest
orion build
