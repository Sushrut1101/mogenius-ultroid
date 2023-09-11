# Base Image
FROM archlinux:base-devel

# Install needed dependencies
RUN pacman -Syyu --noconfirm
RUN pacman -S --noconfirm \
    python3 python-pip python-setuptools git curl ffmpeg mediainfo \
    neofetch tmate speedtest-cli python-virtualenv

# Setup virtual environment
RUN virtualenv /var/.venv
ENV PATH="/var/.venv/bin:$PATH"

# Clone repository
RUN git clone https://github.com/TeamUltroid/Ultroid.git /app

# Set working directory
WORKDIR /app

# Run Ultroid Setup
RUN bash installer.sh

# Setup CMD
CMD ["bash", "startup"]
