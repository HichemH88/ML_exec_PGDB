FROM postgres:15

# Install Python, pip, and plpython3
RUN apt-get update && \
    apt-get install -y python3 python3-pip postgresql-plpython3-15 && \
    pip3 install --no-cache-dir scikit-learn