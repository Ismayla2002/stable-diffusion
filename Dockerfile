# Use a Python base image
FROM python:3.8-slim

# Set environment variables to avoid issues with buffering
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Update system packages and install necessary dependencies
RUN apt-get update && apt-get install -y git libgl1-mesa-glx curl

# Upgrade pip to avoid outdated versions
RUN pip install --upgrade pip

# Install PyTorch and torchvision (using CPU version for free-tier deployment)
RUN pip install torch==1.11.0+cpu torchvision==0.12.0+cpu --index-url https://download.pytorch.org/whl/cpu

# Clone the stable-diffusion repository
RUN git clone https://github.com/Ismayla2002/stable-diffusion /app

# Set the working directory
WORKDIR /app

# Install Python packages listed in the environment.yaml via pip
RUN pip install albumentations==0.4.3 \
    diffusers \
    opencv-python==4.1.2.30 \
    pudb==2019.2 \
    invisible-watermark \
    imageio==2.9.0 \
    imageio-ffmpeg==0.4.2 \
    pytorch-lightning==1.4.2 \
    omegaconf==2.1.1 \
    test-tube>=0.7.5 \
    streamlit>=0.73.1 \
    einops==0.3.0 \
    torch-fidelity==0.3.0 \
    transformers==4.19.2 \  # Pin transformers version here
    torchmetrics==0.6.0 \
    kornia==0.6 \
    git+https://github.com/CompVis/taming-transformers.git@master#egg=taming-transformers \
    git+https://github.com/openai/CLIP.git@main#egg=clip \
    Flask  # Explicitly install Flask here

# Expose port for Flask API
EXPOSE 5000

# Command to run Flask API or the desired script
CMD ["python", "api.py"]
