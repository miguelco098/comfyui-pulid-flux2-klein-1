# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.8.4-base

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/

# user-provided inputs override the auto-generated placeholders above.
RUN wget --progress=dot:giga -O '/comfyui/input/Flux2_dev_00003_.png' "https://cool-anteater-319.convex.cloud/api/storage/0d05086d-110d-4951-8c56-48c3afa513da"
RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/iFayens/ComfyUI-PuLID-Flux2.git && \
    cd ComfyUI-PuLID-Flux2 && \
    pip install insightface onnxruntime-gpu open-clip-torch safetensors ml_dtypes==0.3.2 && \
    pip install --upgrade ml_dtypes onnx
