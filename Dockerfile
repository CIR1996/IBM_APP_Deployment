# Use a slimmer version of the official Python image from Docker Hub
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /usr/src/app
# Install Git (not needed for this simple app, but included as per previous context)
RUN apt-get update && apt-get install -y git
# Copy the requirements file into the container
COPY requirements.txt ./

# Install the dependencies specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Install gunicorn
RUN pip install gunicorn

# Copy the rest of the application code into the container
COPY . .

# Expose the port the app runs on
EXPOSE 3000
#maybe it works now

# Define the command to run the application using gunicorn
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:3000", "app:app"]
