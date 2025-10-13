@echo off
SET ZIP_FILENAME=Classification_Dataset.zip
SET VENV_DIR=venv
SET EXTRACT_DIR=.

REM 1. Check if ZIP exists
IF NOT EXIST "%ZIP_FILENAME%" (
    echo ERROR: %ZIP_FILENAME% not found in %CD%
    exit /b 1
)

REM 2. Unzip the dataset
echo Extracting %ZIP_FILENAME%...
powershell -Command "Expand-Archive -Path '%ZIP_FILENAME%' -DestinationPath '%EXTRACT_DIR%' -Force"
echo Extraction complete!

REM 3. Delete old virtual environment if exists
IF EXIST "%VENV_DIR%" (
    echo Deleting old virtual environment...
    rmdir /s /q "%VENV_DIR%"
)

REM 4. Create virtual environment
echo Creating new virtual environment...
python -m venv "%VENV_DIR%"

REM 5. Upgrade pip and install requirements
echo Installing requirements...
"%VENV_DIR%\Scripts\pip.exe" install --upgrade pip
"%VENV_DIR%\Scripts\pip.exe" install -r requirements.txt

REM 6. Install Jupyter kernel
echo Installing Jupyter kernel...
"%VENV_DIR%\Scripts\python.exe" -m ipykernel install --user --name=venv --display-name "venv"

echo Setup complete! You can now run "jupyter notebook" and select the "venv" kernel.
pause
