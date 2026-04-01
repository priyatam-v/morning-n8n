FROM n8nio/runners:2.11.3

# Switch to root strictly for installation
USER root

# 1. Install Python Libraries (Bypassing broken activate script)
# We explicitly tell 'uv' where the Python executable is.
RUN uv pip install \
    --python /opt/runners/task-runner-python/.venv/bin/python \
    youtube-transcript-api

# 2. Install JavaScript Libraries
RUN cd /opt/runners/task-runner-javascript \
    && pnpm add uuid

# 3. Inject our Fixed Configuration
COPY n8n-task-runners.json /etc/n8n-task-runners.json

# CRITICAL: Allow the JS runner to use external modules
ENV NODE_FUNCTION_ALLOW_EXTERNAL=sharp

# CRITICAL: Return to secure user for runtime
USER runner
