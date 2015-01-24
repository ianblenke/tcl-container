TCL_BASE_URL:=http://tinycorelinux.net/6.x/x86_64

all: rootfs64.tgz
	[ -d rootfs64 ] && sudo rm -fr rootfs64
	docker build -t tinycorelinux .

rootfs64.tgz: unsquash
	cd rootfs64 && sudo tar cvf ../$@ .

unsquash: squashfs-tools.tcz
	make extract
	which unsquashfs || brew install squashfs
	cd rootfs64 && sudo unsquashfs -d . -f ../$<

squashfs-tools.tcz:
	wget $(TCL_BASE_URL)/tcz/$@

extract: rootfs64.gz
	mkdir -p rootfs64
	cd rootfs64 && \
	cat ../$< | gunzip -cd | sudo cpio -i -d --insecure 

rootfs64.gz: rootfs64.gz.md5.txt
	wget $(TCL_BASE_URL)/release/distribution_files/$@
	[ "$$( (md5 $@ || md5sum $@) | sed -e 's/^.*\([0-9a-f]\{32\}).*$$/\1/')" = "$(awk '{print $$1}' $<)" ]

rootfs64.gz.md5.txt:
	wget $(TCL_BASE_URL)/release/distribution_files/$@


