FROM python:3.8-slim

# Install dependencies
RUN apt-get update && apt-get install -y git libgl1-mesa-glx
RUN pip install torch torchvision transformers diffusers invisible-watermark flask

# Clone Stable Diffusion
RUN git clone https://github.com/CompVis/stable-diffusion.git /app
WORKDIR /app

# Install Stable Diffusion requirements
RUN pip install -r requirements.txt

# Expose port for Flask API
EXPOSE 5000

# Run Flask API
CMD ["python", "api.py"]

