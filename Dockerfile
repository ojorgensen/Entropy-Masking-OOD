FROM tensorflow/tensorflow:2.7.0-gpu-jupyter

RUN rm /etc/apt/sources.list.d/cuda.list
RUN rm /etc/apt/sources.list.d/nvidia-ml.list
RUN apt-key del 7fa2af80
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/7fa2af80.pub

RUN apt-get update
RUN apt install graphviz -y
RUN apt install vim -y
RUN apt install screen -y

RUN python -m pip install --upgrade pip
COPY requirements.txt ./requirements.txt
RUN python -m pip install -r requirements.txt
CMD ["jupyter", "lab", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]

ENV LD_LIBRARY_PATH="/usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH"

ENV PYTHONPATH="/tf/project:$PYTHONPATH"
RUN rm -rf tensorflow-tutorials
