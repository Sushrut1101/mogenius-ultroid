# Base Image
FROM archlinux:base-devel

# Setup Timezone
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

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

# Install more python dependencies
RUN pip install -U tzdata

# Setup CMD
CMD ["bash", "startup"]
