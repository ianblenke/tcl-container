TCL_BASE_URL:=http://tinycorelinux.net/5.x/x86

all: rootfs.tgz
	[ -d rootfs ] && sudo rm -fr rootfs
	docker build -t tinycorelinux .

rootfs.tgz: unsquash
	cd rootfs && sudo tar cvf ../$@ .

unsquash: squashfs-tools-4.x.tcz
	make extract
	which unsquashfs || brew install squashfs
	cd rootfs && sudo unsquashfs -d . -f ../$<

squashfs-tools-4.x.tcz:
	wget $(TCL_BASE_URL)/tcz/$@

extract: rootfs.gz
	mkdir -p rootfs
	cd rootfs && \
	cat ../$< | gunzip -cd | sudo cpio -i -d --insecure 

rootfs.gz: rootfs.gz.md5.txt
	wget $(TCL_BASE_URL)/release/distribution_files/$@
	[ "$$( (md5 $@ || md5sum $@) | sed -e 's/^.*\([0-9a-f]\{32\}).*$$/\1/')" = "$(awk '{print $$1}' $<)" ]

rootfs.gz.md5.txt:
	wget $(TCL_BASE_URL)/release/distribution_files/$@

clean:
	rm -f rootfs.gz rootfs.gz.md5.txt rootfs.tgz
