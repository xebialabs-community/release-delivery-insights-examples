# Offical
FROM xebialabs/xl-release:10.1

# Install license
COPY default-conf/xl-release-license.lic /opt/xebialabs/xl-release-server/default-conf/

# Copy demo-specific plugins
COPY default-plugins /opt/xebialabs/xl-release-server/default-plugins

# initial configuration
COPY default-conf/reference.conf /opt/xebialabs/xl-release-server/default-conf/
