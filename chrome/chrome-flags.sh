#!/bin/bash

################################################################################
# Chrome Flags Privacy Configuration Generator
# Generates a Local State file to set Chrome flags programmatically
################################################################################

YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}Chrome Flags Privacy Configuration Generator${NC}\n"

# Determine Chrome user data directory
if [[ "$OSTYPE" == "darwin"* ]]; then
    CHROME_DIR="$HOME/Library/Application Support/Google/Chrome-Privacy"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    CHROME_DIR="$HOME/.config/google-chrome-privacy"
else
    echo "Unsupported OS. Please set CHROME_DIR manually."
    exit 1
fi

LOCAL_STATE="$CHROME_DIR/Local State"

echo -e "${YELLOW}This script will configure privacy-focused Chrome flags.${NC}"
echo -e "${YELLOW}Target directory: $CHROME_DIR${NC}\n"

# Check if Chrome is running
if pgrep -f "chrome.*$CHROME_DIR" > /dev/null; then
    echo -e "${YELLOW}⚠ Chrome appears to be running with this profile.${NC}"
    echo "Please close Chrome and run this script again."
    exit 1
fi

# Create directory if it doesn't exist
mkdir -p "$CHROME_DIR"

# Backup existing Local State if present
if [ -f "$LOCAL_STATE" ]; then
    cp "$LOCAL_STATE" "$LOCAL_STATE.backup.$(date +%s)"
    echo -e "${GREEN}✓ Backed up existing Local State${NC}"
fi

# Generate Local State with privacy flags
cat > "$LOCAL_STATE" << 'EOF'
{
   "browser": {
      "enabled_labs_experiments": [
         "enable-webrtc-hide-local-ips-with-mdns@1",
         "enable-quic@2",
         "privacy-sandbox-settings-4@2",
         "privacy-sandbox-ads-apis@2",
         "federated-learning-of-cohorts@2",
         "client-side-phishing-detection@2",
         "safe-browsing-enhanced@2"
      ]
   }
}
EOF

echo -e "${GREEN}✓ Chrome flags configured successfully!${NC}\n"
echo "Configured flags:"
echo "  • WebRTC IP hiding: ENABLED"
echo "  • QUIC protocol: DISABLED"
echo "  • Privacy Sandbox v4: DISABLED"
echo "  • Privacy Sandbox Ads: DISABLED"
echo "  • FLoC: DISABLED"
echo "  • Client-side phishing detection: DISABLED"
echo "  • Enhanced Safe Browsing: DISABLED"
echo ""
echo -e "${GREEN}You can now launch Chrome using ./chrome-privacy-launch.sh${NC}"
