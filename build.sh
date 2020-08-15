#!/bin/bash -uex

IMG_PREFIX="kmaehashi/cuda11-centos7"
IMG_BASE="${IMG_PREFIX}:11.0-base-centos7"
IMG_RUNTIME="${IMG_PREFIX}:11.0-runtime-centos7"
IMG_RUNTIME_CUDNN="${IMG_PREFIX}:11.0-cudnn8-runtime-centos7"
IMG_DEVEL="${IMG_PREFIX}:11.0-devel-centos7"
IMG_DEVEL_CUDNN="${IMG_PREFIX}:11.0-cudnn8-devel-centos7"

pushd cuda-container-images/dist/11.0/centos7-x86_64

# IMG_BASE
pushd base
docker build -t "${IMG_BASE}" .
popd

# IMG_RUNTIME
pushd runtime
docker build -t "${IMG_RUNTIME}" --build-arg "IMAGE_NAME=${IMG_PREFIX}" .
popd

# IMG_RUNTIME_CUDNN
pushd runtime/cudnn8
docker build -t "${IMG_RUNTIME_CUDNN}" --build-arg "IMAGE_NAME=${IMG_PREFIX}" .
popd

# IMG_DEVEL
pushd devel
docker build -t "${IMG_DEVEL}" --build-arg "IMAGE_NAME=${IMG_PREFIX}" .
popd

# IMG_DEVEL_CUDNN
pushd devel/cudnn8
docker build -t "${IMG_DEVEL_CUDNN}" --build-arg "IMAGE_NAME=${IMG_PREFIX}" .
popd

# Publish
cat << _EOF_
Finished!

To publish:

docker push "${IMG_BASE}"
docker push "${IMG_RUNTIME}"
docker push "${IMG_RUNTIME_CUDNN}"
docker push "${IMG_DEVEL}"
docker push "${IMG_DEVEL_CUDNN}"
_EOF_
