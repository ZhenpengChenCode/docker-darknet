# Sha256 corresponds to tag '16.04'
FROM sha256:e5ec578bd8c334d7c9849fd9bbaa78ec25f2b51b0bf7c9e18b1e9b7ca32d6681

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
