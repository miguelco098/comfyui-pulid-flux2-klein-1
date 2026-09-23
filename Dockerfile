# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.10.0-base

# force-upgrade the bundled runpod SDK: worker-comfyui pins runpod~=1.7.12 in every
# tag (5.8.4-base and 5.10.0-base included), which predates the job-take protocol's
# job_in_progress query param. Against the current RunPod backend this makes job-take
# responses come back as a dict without id/input, so get_job() raises "Job has missing
# field(s): id or input." and every job silently times out ~30-50s before ever reaching
# the ComfyUI handler. Upgrading the SDK here (independent of the base image tag) fixes it.
RUN uv pip install --upgrade "runpod>=1.12.0"

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/

