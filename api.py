from flask import Flask, request, send_file
from io import BytesIO
import torch
from diffusers import StableDiffusionPipeline

app = Flask(__name__)

# Load model (use CPU if no GPU available)
device = "cuda" if torch.cuda.is_available() else "cpu"
model = StableDiffusionPipeline.from_pretrained("CompVis/stable-diffusion-v1-4").to(device)

@app.route("/generate", methods=["POST"])
def generate():
    data = request.json
    prompt = data.get("prompt", "A scenic view of mountains")
    
    # Generate image
    with torch.no_grad():
        image = model(prompt).images[0]
    
    # Save image to a buffer
    img_io = BytesIO()
    image.save(img_io, 'PNG')
    img_io.seek(0)
    
    return send_file(img_io, mimetype='image/png')

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
  
