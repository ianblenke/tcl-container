FROM tinycorelinux

COPY deps.list /root/

ENV TCL_REPO_BASE   http://tinycorelinux.net/5.x/x86

ADD cache/ /tmp/

# Install the TCZ dependencies
RUN cd /tmp && for dep in $(cat /root/deps.list) isl.tcz file.tcz; do \
    echo "Download $TCL_REPO_BASE/tcz/$dep" &&\
        if [ -f /cache/$dep ]; then cp /cache/$dep /tmp/$dep ; fi && \
        if [ ! -f /tmp/$dep ]; then wget $TCL_REPO_BASE/tcz/$dep ; fi && \
        unsquashfs -f -d / /tmp/$dep && \
        rm -f /tmp/$dep ;\
    done ; \
    ln -sf /usr/local/bin/file /usr/bin/file ; \
    ln -sf `which cpp` /lib/cpp

RUN ldconfig

COPY patches /root/patches/
COPY build.sh /root/

