source ~/scripts-and-conf/linux-source.sh

setup-wslu() {
	git clone git@github.com:wslutilities/wslu.git
	git checkout "tags/$1" -b "branch-$1"
  make all
  sudo make install
}

setup(){
  setup-wslu v4.1.1
}

export BROWSER=wslview
