# Chrome Privacy Configuration Guide

## Quick Start

```bash
./chrome-privacy-launch.sh
```

This script launches Chrome with maximum privacy settings, disabling:
- ✅ Google sync and background services
- ✅ Telemetry and crash reporting
- ✅ Tracking and profiling
- ✅ Network prediction and preloading
- ✅ Safe Browsing (sends URLs to Google)
- ✅ WebRTC IP leaks
- ✅ Canvas fingerprinting
- ✅ WebGL fingerprinting
- ✅ DNS prefetching
- ✅ Component auto-updates
- ✅ Default apps and extensions

## Important Notes

### Separate Profile
The script uses a **separate Chrome profile** located at:
- **macOS**: `~/Library/Application Support/Google/Chrome-Privacy`
- **Linux**: `~/.config/google-chrome-privacy`
- **Windows**: `%USERPROFILE%/AppData/Local/Google/Chrome-Privacy`

This keeps your privacy-focused browsing separate from your regular Chrome profile.

### Incognito Mode
The script launches in **incognito mode** by default for maximum privacy. No history, cookies, or cache are saved after closing.

## Manual Configuration Steps

After first launch, configure these settings manually:

### 1. Install Privacy Extensions
- **uBlock Origin** - Ad and tracker blocking
- **Privacy Badger** - Automatic tracker blocking
- **HTTPS Everywhere** - Force HTTPS connections
- **Decentraleyes** - Block CDN tracking

### 2. Chrome Settings (chrome://settings)

#### Privacy and Security (chrome://settings/privacy)
- ✅ Cookies: "Block third-party cookies"
- ❌ Disable "Preload pages for faster browsing"
- ❌ Disable "Use a prediction service to help complete searches"
- ✅ Enable "Send a 'Do Not Track' request" (optional)
- ❌ Disable "Use a web service to help resolve navigation errors"
- ❌ Disable all **Privacy Sandbox** features
- ✅ Enable "Use secure DNS" (DNS-over-HTTPS)

#### Sync and Google Services (chrome://settings/syncSetup)
- ❌ Disable all sync features
- ❌ Disable "Autocomplete searches and URLs"
- ❌ Disable "Help improve Chrome's features"

#### Autofill (chrome://settings/autofill)
- ❌ Disable "Payment methods"
- ❌ Disable "Addresses and more"

#### Passwords (chrome://settings/passwords)
- ❌ Disable "Offer to save passwords"
- ❌ Disable "Auto sign-in"

#### Site Settings (chrome://settings/content)
- **Location**: Blocked
- **Camera**: Ask before accessing
- **Microphone**: Ask before accessing
- **Notifications**: Blocked
- **Background sync**: Blocked
- **Automatic downloads**: Ask

### 3. Advanced Flags (chrome://flags)

Copy and paste these URLs to disable additional features:

```
chrome://flags/#enable-quic
```
Set to: **Disabled** (QUIC can bypass some privacy protections)

```
chrome://flags/#enable-webrtc-hide-local-ips-with-mdns
```
Set to: **Enabled** (hides local IP from WebRTC)

```
chrome://flags/#privacy-sandbox-settings-4
```
Set to: **Disabled**

```
chrome://flags/#privacy-sandbox-ads-apis
```
Set to: **Disabled**

```
chrome://flags/#federated-learning-of-cohorts
```
Set to: **Disabled** (FLoC tracking)

## DNS-over-HTTPS Configuration

For maximum DNS privacy, configure DNS-over-HTTPS in Chrome:

1. Go to: `chrome://settings/security`
2. Enable "Use secure DNS"
3. Choose a privacy-focused provider:
   - **Cloudflare**: `https://cloudflare-dns.com/dns-query`
   - **Quad9**: `https://dns.quad9.net/dns-query`
   - **Mullvad**: `https://dns.mullvad.net/dns-query`
   - **AdGuard**: `https://dns.adguard-dns.com/dns-query`

## Search Engine

Replace Google Search with privacy-focused alternatives:

1. Go to: `chrome://settings/searchEngines`
2. Set default to:
   - **DuckDuckGo**: `https://duckduckgo.com/?q=%s`
   - **Startpage**: `https://www.startpage.com/do/search?q=%s`
   - **Brave Search**: `https://search.brave.com/search?q=%s`
   - **Searx**: Self-hosted or public instance

## Content Settings Policy File (Advanced)

For enterprise-level control, you can create a Chrome policy file:

### macOS
Create: `/Library/Managed Preferences/com.google.Chrome.plist`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>MetricsReportingEnabled</key>
    <false/>
    <key>SafeBrowsingEnabled</key>
    <false/>
    <key>SearchSuggestEnabled</key>
    <false/>
    <key>AlternateErrorPagesEnabled</key>
    <false/>
    <key>NetworkPredictionOptions</key>
    <integer>2</integer>
    <key>BackgroundModeEnabled</key>
    <false/>
    <key>DefaultCookiesSetting</key>
    <integer>4</integer>
    <key>DefaultGeolocationSetting</key>
    <integer>2</integer>
    <key>PrivacySandboxPromptEnabled</key>
    <false/>
</dict>
</plist>
```

### Linux
Create: `/etc/opt/chrome/policies/managed/privacy-policy.json`

```json
{
  "MetricsReportingEnabled": false,
  "SafeBrowsingEnabled": false,
  "SearchSuggestEnabled": false,
  "AlternateErrorPagesEnabled": false,
  "NetworkPredictionOptions": 2,
  "BackgroundModeEnabled": false,
  "DefaultCookiesSetting": 4,
  "DefaultGeolocationSetting": 2,
  "PrivacySandboxPromptEnabled": false
}
```

## Testing Your Privacy

After configuration, test your privacy:

1. **WebRTC Leak Test**: https://browserleaks.com/webrtc
2. **DNS Leak Test**: https://dnsleaktest.com/
3. **Browser Fingerprint**: https://coveryourtracks.eff.org/
4. **IP Check**: https://ipleak.net/

## Limitations

**Important**: No browser can be 100% "privacy proof" while remaining functional. This configuration:
- ✅ Blocks most Google telemetry and tracking
- ✅ Prevents common fingerprinting techniques
- ✅ Disables ads and tracking networks (with extensions)
- ⚠️ Some websites may break (especially Google services)
- ⚠️ Cannot prevent determined fingerprinting at OS/hardware level
- ⚠️ Chrome is still proprietary Google software

## Better Alternatives

For maximum privacy, consider:
- **Brave Browser** - Chromium-based with built-in privacy features
- **Firefox** with privacy addons - More privacy-friendly
- **Tor Browser** - Maximum anonymity (slower)
- **Ungoogled Chromium** - Chrome without Google services

## Troubleshooting

### Chrome won't launch
- Check Chrome installation path in script
- Verify script has execute permissions: `chmod +x chrome-privacy-launch.sh`

### Websites not working
Some features are disabled for privacy. To fix:
- Temporarily disable incognito mode (remove `--incognito` flag)
- Enable specific features as needed
- Use regular Chrome for incompatible sites

### Script exits immediately
The script runs Chrome in the background. It will stay open until you close Chrome.

## Usage Examples

### Regular Launch
```bash
./chrome-privacy-launch.sh
```

### Open specific URL
```bash
./chrome-privacy-launch.sh https://duckduckgo.com
```
### Run without incognito (edit script first)
Remove the `--incognito \` line from the script.


This script is provided as-is for privacy-conscious users. Use at your own risk.

---

**Last Updated**: May 2026
