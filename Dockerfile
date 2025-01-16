ARG UBUNTU_VERSION_NAME=latest

FROM ubuntu:${UBUNTU_VERSION_NAME}

EXPOSE 4000

# For above Ubuntu 24.04
RUN touch /var/mail/ubuntu && chown ubuntu /var/mail/ubuntu && userdel -r ubuntu ; exit 0

RUN apt-get update && apt-get install -y --no-install-recommends python3-dev python3-pip python3-venv \
    && apt-get remove -y --autoremove --purge wget && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && update-alternatives --install /usr/local/bin/python python "$(which python3)" 60 \
    && pip3 install litellm litellm[proxy] --break-system-packages

# If you want to use GitHub API, you need.
ENV GITHUB_API_KEY=""

# If you want to use OpenAPI, you need.
ENV OPENAI_API_KEY=""

# Select Your AI Model
ENV AI_Model="github/gpt-4o"

CMD litellm --model ${AI_Model}