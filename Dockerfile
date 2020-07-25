# Sha256 corresponds to tag 'nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04'
FROM sha256:6cd48444de35a2aa8fa8652da86769205f6e895167d304537403e169bcee1fd8

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    build-essential=12.* \
    ca-certificates=* \
    curl=7.58.* \
    g++=4:7.* \
    gcc=4:7.* \
    git=1:2.17* \
  && rm -rf /var/lib/apt/lists/*
  
  RUN mkdir /output
  
  RUN mkdir /output

RUN git clone --depth 1 https://github.com/AlexeyAB/darknet.git

WORKDIR /darknet

# Download weights for YOLOv4 dection
RUN curl -sSLO https://github.com/AlexeyAB/darknet/releases/download/darknet_yolo_v3_optimal/yolov4.weights

RUN make

COPY darknet_wrapper.sh .

ENTRYPOINT ["./darknet_wrapper.sh"]

CMD ["detector", "test", "cfg/coco.data", "cfg/yolov4.cfg", "yolov4.weights"]
