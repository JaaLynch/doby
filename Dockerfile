FROM ubuntu:18.04

# Install packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    sudo nano htop tree git curl wget zsh

# Set the default shell to zsh
RUN chsh -s $(which zsh)

# Create user and add sudo privlages
RUN  useradd doby && echo "doby:pw" | chpasswd && adduser doby sudo
USER doby
WORKDIR /home/doby

# Install Oh-My-Zsh
RUN sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
RUN sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="fletcherm"/g' .zshrc

# Install and configure anaconda
RUN wget https://repo.anaconda.com/archive/Anaconda3-2020.11-Linux-x86_64.sh
RUN bash Anaconda3-2020.11-Linux-x86_64.sh -b
RUN echo "source /home/doby/anaconda3/bin/activate" >> .zshrc

# Get environment.yml
RUN git clone https://github.com/JaaLynch/doby.git

# Conda environment
RUN /home/doby/anaconda3/condabin/conda env create -f /home/doby/doby/environment.yml
RUN echo "conda activate env" >> .zshrc

# Expose a port for jupyter notebook
EXPOSE 8888

CMD zsh