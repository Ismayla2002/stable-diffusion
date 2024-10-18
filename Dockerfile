# Use a Python base image
FROM python:3.8-slim

# Set environment variables to avoid issues with buffering
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Update system packages and install necessary dependencies
RUN apt-get update && apt-get install -y git libgl1-mesa-glx curl

# Upgrade pip to avoid outdated versions
RUN pip install --upgrade pip
# Add this line to install accelerate
RUN pip install accelerate

# Install PyTorch and torchvision (using CPU version for free-tier deployment)
RUN pip install torch torchvision --index-url https://download.pytorch.org/whl/cpu

# Clone the stable-diffusion repository
RUN git clone https://github.com/Ismayla2002/stable-diffusion /app

# Set the working directory
WORKDIR /app

# Install Python packages
RUN pip install albumentations \
    diffusers \
    opencv-python \
    pudb \
    invisible-watermark \
    imageio \
    imageio-ffmpeg \
    pytorch-lightning \
    omegaconf \
    test-tube \
    streamlit \
    einops \
    torch-fidelity \
    transformers \
    torchmetrics \
    kornia \
    git+https://github.com/CompVis/taming-transformers.git@master#egg=taming-transformers \
    git+https://github.com/openai/CLIP.git@main#egg=clip \
    Flask

# Expose port for Flask API
EXPOSE 5000

# Command to run Flask API or the desired script
CMD ["python", "api.py"]
