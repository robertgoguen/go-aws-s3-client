export DEV_DIR=$HOME/src
alias cds='cd $DEV_DIR'

function go-aws-s3-client {
  export PS1="\[\e]0;\u@\h:(go-aws-s3-client) \w\a\]\u@\h:\W$ "
  export TOP_DIR=$DEV_DIR/go-aws-sw-client
  export GOPATH=$TOP_DIR/go
  export GOPATH_SRC=$GOPATH/src
  export GOBIN=$GOPATH/bin
  export MASTER_DIR=$GOPATH_SRC/github.com/robertgoguen/go-aws-s3-client
  export CSCOPE_DIR=$GOPATH_SRC/
  export PATH="$GOBIN:$PATH"
  export PATH="~/.local/bin:$PATH"
  alias mkg='git clone https://github.com/rgoguen/go-aws-s3-client.git $MASTER_DIR'
  alias fo='(cd $MASTER_DIR; find.original .)'
  alias cdt='cd $TOP_DIR'
  alias cdm='cd $MASTER_DIR'
  alias cdgo='cd $GOPATH_SRC'
  alias cdcscope='cd $CSCOPE_DIR'
  alias remacs='run_emacs go-aws-s3-client'
  export KUBECONFIG="$HOME/.kube/config"
}
