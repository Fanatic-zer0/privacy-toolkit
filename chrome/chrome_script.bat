@echo off
REM ################################################################################
REM Chrome Privacy Launch Script - Windows Version
REM Launches Google Chrome with maximum privacy settings
REM ################################################################################

echo ================================
echo Chrome Privacy Launch Script
echo ================================
echo.

REM Set Chrome path
set CHROME_PATH=C:\Program Files\Google\Chrome\Application\chrome.exe
set CHROME_USER_DATA=%USERPROFILE%\AppData\Local\Google\Chrome-Privacy

REM Check if Chrome exists
if not exist "%CHROME_PATH%" (
    echo Chrome not found at: %CHROME_PATH%
    echo Please update CHROME_PATH in the script.
    pause
    exit /b 1
)

echo Found Chrome at: %CHROME_PATH%
echo Using separate user data directory: %CHROME_USER_DATA%
echo.

REM Create user data directory
if not exist "%CHROME_USER_DATA%" mkdir "%CHROME_USER_DATA%"

echo Launching Chrome with privacy-focused settings...
echo.

REM Launch Chrome with privacy flags
start "" "%CHROME_PATH%" ^
  --user-data-dir="%CHROME_USER_DATA%" ^
  --disable-sync ^
  --disable-background-networking ^
  --disable-background-timer-throttling ^
  --disable-backgrounding-occluded-windows ^
  --disable-breakpad ^
  --disable-client-side-phishing-detection ^
  --disable-component-update ^
  --disable-default-apps ^
  --disable-domain-reliability ^
  --disable-features=AutofillServerCommunication ^
  --disable-features=CertificateTransparencyComponentUpdater ^
  --disable-hang-monitor ^
  --disable-sync-types=All ^
  --disable-features=InterestFeedContentSuggestions ^
  --disable-features=Translate ^
  --disable-features=OptimizationHints ^
  --disable-features=MediaRouter ^
  --disable-features=CalculateNativeWinOcclusion ^
  --disable-features=AutofillEnableAccountWalletStorage ^
  --disable-features=ImprovedCookieControls ^
  --disable-features=LazyFrameLoading ^
  --disable-features=GlobalMediaControls ^
  --disable-features=DestroyProfileOnBrowserClose ^
  --disable-features=AcceptCHFrame ^
  --disable-features=PrivacySandboxSettings4 ^
  --no-pings ^
  --no-crash-upload ^
  --disable-logging ^
  --disable-permissions-api ^
  --disable-notifications ^
  --disable-infobars ^
  --disable-save-password-bubble ^
  --disable-session-crashed-bubble ^
  --disable-dinosaur-easter-egg ^
  --metrics-recording-only ^
  --no-first-run ^
  --no-default-browser-check ^
  --no-experiments ^
  --no-service-autorun ^
  --disable-features=NetworkPrediction ^
  --disable-features=Prerender2 ^
  --dns-prefetch-disable ^
  --disable-preconnect ^
  --enforce-webrtc-ip-permission-check ^
  --force-webrtc-ip-handling-policy=default_public_interface_only ^
  --disable-extensions-http-throttling ^
  --safebrowsing-disable-auto-update ^
  --safebrowsing-disable-download-protection ^
  --disable-features=SafeBrowsingEnhanced ^
  --bwsi ^
  --incognito ^
  --disable-boot-animation ^
  --disable-cloud-import ^
  --disable-device-discovery-notifications ^
  --disable-machine-id ^
  --disable-search-geolocation-disclosure ^
  --disable-spell-checking ^
  --enable-features=EnableTLS13EarlyData ^
  --no-report-upload ^
  --disable-offer-store-unmasked-wallet-cards ^
  --disable-offer-upload-credit-cards ^
  --disable-webgl ^
  --disable-webgl2 ^
  --disable-features=WebGLDraftExtensions ^
  --disable-accelerated-2d-canvas ^
  --disable-gl-drawing-for-tests ^
  --disable-reading-from-canvas ^
  --disable-canvas-aa ^
  --disable-2d-canvas-clip-aa ^
  --disable-gl-extensions ^
  --process-per-site ^
  --site-per-process

echo.
echo Chrome launched with privacy settings!
echo Note: This is a separate Chrome profile in: %CHROME_USER_DATA%
echo.
echo See chrome-privacy-README.md for additional manual setup steps.
echo.
pause
