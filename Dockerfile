FROM nvidia/cuda:11.1-base-ubuntu20.04

MAINTAINER krishneel@krishneel

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV ROS_PYTHON_VERSION 3
ENV ROS_DISTRO foxy

COPY deps /tmp/deps
RUN chmod +x /tmp/deps/*
RUN ./tmp/deps/vnc.sh && \
	./tmp/deps/foxy.sh && \
	rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3 /usr/local/bin/python
RUN ln -sf /usr/bin/pip3 /usr/bin/pip

ADD image /
RUN pip install setuptools wheel && pip install -r /usr/lib/web/requirements.txt

RUN cp /usr/share/applications/terminator.desktop /root/Desktop
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> /root/.bashrc

EXPOSE 80
WORKDIR /home
ENV HOME /home
ENV SHELL /bin/bash
ENV COLCON_HOME $HOME/.colcon
ENV HOSTNAME ros2
ENV USER ubuntu

ENV RCUTILS_COLORIZED_OUTPUT 1
ENV RCUTILS_LOGGING_BUFFERED_STREAM 1

ENTRYPOINT ["/startup.sh"]
