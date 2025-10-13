import zipfile
import subprocess
import sys
import os

# Change these as needed
ZIP_FILENAME = "Classification_Dataset.zip"  # Replace with your actual zip filename

# 1. Unzip the file
with zipfile.ZipFile(ZIP_FILENAME, 'r') as zip_ref:
    zip_ref.extractall(".")

# 2. Create virtual environment
subprocess.run([sys.executable, "-m", "venv", "venv"])

# 3. Activate virtual environment and install requirements
if os.name == "nt":  # Windows
    activate_script = r"venv\Scripts\activate"
    pip_cmd = r"venv\Scripts\pip"
else:  # Unix/Mac
    activate_script = "source venv/bin/activate"
    pip_cmd = "venv/bin/pip"

subprocess.run([pip_cmd, "install", "-r", "requirements.txt"])

# 4. Install IPython kernel
subprocess.run([pip_cmd.replace("pip", "python"), "-m", "ipykernel", "install", "--user", "--name=venv"])

print("Setup complete. You can now run 'jupyter notebook'.")