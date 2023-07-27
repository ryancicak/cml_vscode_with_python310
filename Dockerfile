# Copyright 2023 Cloudera. All Rights Reserved.
FROM docker.repository.cloudera.com/cloudera/cdsw/ml-runtime-jupyterlab-python3.10-standard:2023.05.2-b7

RUN apt update && apt upgrade -y && apt clean && rm -rf /var/lib/apt/lists/*
RUN curl -fsSL https://code-server.dev/install.sh | sh -s --  --version 4.2.0
RUN printf "#!/bin/bash\n/usr/bin/code-server --auth=none --bind-addr=127.0.0.1:8090 --disable-telemetry" > /usr/local/bin/vscode
RUN chmod +x /usr/local/bin/vscode
RUN rm -f /usr/local/bin/ml-runtime-editor
RUN ln -s /usr/local/bin/vscode /usr/local/bin/ml-runtime-editor

# Override Runtime label and environment variables metadata
ENV ML_RUNTIME_EDITOR="VsCode" \
    ML_RUNTIME_EDITION="v4.2.0" \
	ML_RUNTIME_SHORT_VERSION="1.4" \
	ML_RUNTIME_MAINTENANCE_VERSION="1" \
    ML_RUNTIME_FULL_VERSION="1.4.1" \
    ML_RUNTIME_DESCRIPTION="This runtime includes VsCode editor"

LABEL com.cloudera.ml.runtime.editor=$ML_RUNTIME_EDITOR \
      com.cloudera.ml.runtime.edition=$ML_RUNTIME_EDITION \
	  com.cloudera.ml.runtime.full-version=$ML_RUNTIME_FULL_VERSION \
      com.cloudera.ml.runtime.short-version=$ML_RUNTIME_SHORT_VERSION \
      com.cloudera.ml.runtime.maintenance-version=$ML_RUNTIME_MAINTENANCE_VERSION \
      com.cloudera.ml.runtime.description=$ML_RUNTIME_DESCRIPTION
