FROM tatsushid/tinycore:7.0-x86_64

# Instructions are run with 'tc' user

RUN tce-load -wic \
        ncurses

# Instructions after here are run with 'root' user
USER root

RUN mkdir /lib64 \
    && ln -s /lib/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2 \
    && ln -s /usr/local/lib/libncurses.so.5 /lib/libtinfo.so.5

RUN cd /home \
    && wget http://www.jsoftware.com/download/j805/install/j805_linux64.tar.gz \
    && tar -xf j805_linux64.tar.gz \
    && rm -rf j805_linux64.tar.gz


ENV CONFIG="BIND=:''localhost''"
ENV RUN=""

# example command line
# docker run -p 65001:65001 -e CONFIG="BIND=:''any'' [ USER=:''joe'' [ PASS=:''test''" tinycore-jhs:latest
# docker run -p 65001:65001 -e CONFIG="BIND=:''any'' [ USER=:''joe'' [ PASS=:''test'' [ OKURL=:''jdemo1''" -e RUN="load '~addons/ide/jhs/demo/jdemo1.ijs'" tinycore-jhs:latest
ENTRYPOINT /home/j64-805/bin/jconsole -js "config_jhs_ =: 3 : '$CONFIG'" -js "$RUN" -js "load'~addons/ide/jhs/core.ijs'" "init_jhs_''"
