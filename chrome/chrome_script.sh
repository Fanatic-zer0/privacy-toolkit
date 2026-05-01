#!/bin/bash

################################################################################
# Chrome Privacy Launch Script
# Launches Google Chrome with maximum privacy settings
# Disables telemetry, tracking, profiling, ads, and data collection
################################################################################

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}================================${NC}"
echo -e "${GREEN}Chrome Privacy Launch Script${NC}"
echo -e "${GREEN}================================${NC}\n"

# Detect Chrome installation path based on OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    CHROME_PATH="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
    CHROME_USER_DATA="$HOME/Library/Application Support/Google/Chrome-Privacy"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    CHROME_PATH="/usr/bin/google-chrome"
    CHROME_USER_DATA="$HOME/.config/google-chrome-privacy"
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    # Windows (Git Bash)
    CHROME_PATH="C:/Program Files/Google/Chrome/Application/chrome.exe"
    CHROME_USER_DATA="$USERPROFILE/AppData/Local/Google/Chrome-Privacy"
else
    echo -e "${RED}Unsupported OS: $OSTYPE${NC}"
    exit 1
fi

# Check if Chrome exists
if [ ! -e "$CHROME_PATH" ]; then
    echo -e "${RED}Chrome not found at: $CHROME_PATH${NC}"
    echo "Please update CHROME_PATH in the script to match your installation."
    exit 1
fi

echo -e "${GREEN}Found Chrome at: $CHROME_PATH${NC}"
echo -e "${YELLOW}Using separate user data directory: $CHROME_USER_DATA${NC}\n"

# Create user data directory if it doesn't exist
mkdir -p "$CHROME_USER_DATA"

echo -e "${GREEN}Launching Chrome with privacy-focused settings...${NC}\n"

# Launch Chrome with comprehensive privacy flags
"$CHROME_PATH" \
  --user-data-dir="$CHROME_USER_DATA" \
  \
  `# === Disable Google Services & Sync ===` \
  --disable-sync \
  --disable-background-networking \
  --disable-background-timer-throttling \
  --disable-backgrounding-occluded-windows \
  --disable-breakpad \
  --disable-client-side-phishing-detection \
  --disable-component-update \
  --disable-default-apps \
  --disable-domain-reliability \
  --disable-features=AutofillServerCommunication \
  --disable-features=CertificateTransparencyComponentUpdater \
  --disable-hang-monitor \
  --disable-sync-types=All \
  \
  `# === Disable Tracking & Profiling ===` \
  --disable-features=InterestFeedContentSuggestions \
  --disable-features=Translate \
  --disable-features=OptimizationHints \
  --disable-features=MediaRouter \
  --disable-features=CalculateNativeWinOcclusion \
  --disable-features=AutofillEnableAccountWalletStorage \
  --disable-features=ImprovedCookieControls \
  --disable-features=LazyFrameLoading \
  --disable-features=GlobalMediaControls \
  --disable-features=DestroyProfileOnBrowserClose \
  --disable-features=AcceptCHFrame \
  --disable-features=PrivacySandboxSettings4 \
  --no-pings \
  --no-crash-upload \
  \
  `# === Disable Telemetry & Reporting ===` \
  --disable-logging \
  --disable-permissions-api \
  --disable-notifications \
  --disable-infobars \
  --disable-save-password-bubble \
  --disable-session-crashed-bubble \
  --disable-dinosaur-easter-egg \
  --disable-gpu-compositing \
  --metrics-recording-only \
  --no-first-run \
  --no-default-browser-check \
  --no-experiments \
  --no-service-autorun \
  \
  `# === DNS & Network Privacy ===` \
  --host-resolver-rules="MAP * ~NOTFOUND , EXCLUDE localhost" \
  --disable-features=NetworkPrediction \
  --disable-features=Prerender2 \
  --dns-prefetch-disable \
  --disable-preconnect \
  \
  `# === WebRTC Privacy (prevent IP leak) ===` \
  --enforce-webrtc-ip-permission-check \
  --force-webrtc-ip-handling-policy=default_public_interface_only \
  \
  `# === Disable Extensions Auto-Update ===` \
  --disable-extensions-http-throttling \
  --disable-extensions-file-access-check \
  \
  `# === Disable Safe Browsing (sends URLs to Google) ===` \
  --safebrowsing-disable-auto-update \
  --safebrowsing-disable-download-protection \
  --disable-features=SafeBrowsingEnhanced \
  \
  `# === Misc Privacy Settings ===` \
  --disable-features=WebRtcHideLocalIpsWithMdns \
  --bwsi \
  --incognito \
  --disable-boot-animation \
  --disable-cloud-import \
  --disable-context-menu \
  --disable-device-discovery-notifications \
  --disable-machine-id \
  --disable-search-geolocation-disclosure \
  --disable-spell-checking \
  --enable-features=EnableTLS13EarlyData \
  --no-report-upload \
  --disable-offer-store-unmasked-wallet-cards \
  --disable-offer-upload-credit-cards \
  \
  `# === Additional Fingerprinting Protection ===` \
  --disable-webgl \
  --disable-webgl2 \
  --disable-features=WebGLDraftExtensions \
  --disable-accelerated-2d-canvas \
  --disable-gl-drawing-for-tests \
  --disable-reading-from-canvas \
  --disable-canvas-aa \
  --disable-2d-canvas-clip-aa \
  --disable-gl-extensions \
  \
  `# === Open with custom flags ===` \
  --disable-features=ProcessPerSiteUpToMainFrameThreshold \
  --process-per-site \
  --site-per-process \
  &

echo -e "\n${GREEN}✓ Chrome launched with privacy settings!${NC}"
echo -e "${YELLOW}Note: This is a separate Chrome profile in: $CHROME_USER_DATA${NC}"
echo ""
echo -e "${GREEN}Additional Manual Steps (First Time Setup):${NC}"
echo "1. Install uBlock Origin extension for ad blocking"
echo "2. Go to chrome://settings/privacy and verify:"
echo "   - Disable 'Preload pages for faster browsing'"
echo "   - Disable 'Use a prediction service to help complete searches'"
echo "   - Disable 'Send a 'Do Not Track' request' (or enable it)"
echo "   - Disable all 'Privacy Sandbox' features"
echo "3. Go to chrome://settings/syncSetup - ensure sync is OFF"
echo "4. Go to chrome://settings/autofill - disable all autofill"
echo "5. Go to chrome://settings/passwords - disable password manager"
echo "6. Go to chrome://settings/cookies - set to 'Block third-party cookies'"
echo "7. Consider using DNS-over-HTTPS (chrome://settings/security)"
echo ""
echo -e "${YELLOW}Press Ctrl+C to stop this script when you close Chrome${NC}"

# Wait for Chrome to close
wait
