# Mobile App

[![Android App](../assets/images/get_it_on_play_store.png)](https://play.google.com/store/apps/details?id=com.tidusjar.Ombi&hl=en_NZ&gl=US)  
[![iOS App](../assets/images/get_it_on_app_store.png)](https://apps.apple.com/us/app/ombi/id1335260043)

## Connecting the App

### QR Code Login

To enable the QR Code login, you need to ensure you have setup your Application URL.

Once you have set that up you can find the QR code to scan under your user profile (Top right where your username is) and then press the Mobile Tab, there should now be a QR code present!

### Mobile Browser

If you (or your users) have difficulty with the QR method, you can also open your Ombi instance in a web browser on your mobile device.  
From here, tapping/clicking on the user icon (top  right) will open the user preferences page, which includes:

* Google Play (Android app) link.
* App Store (iOS app) link.
* "Open Mobile App" button.

Click "Open Mobile App" to open the app on your device and auto-fill the settings.  
_Note: This requires the application URL to be configured correctly, and the app to be installed already._

### Logging in manually with Plex 2FA

If you do not want to use the QR code mechanism, you still can log in manually.  
If you have a Plex Account with MFA/2FA enabled, you will need to enter your password in the following format: `password132456` where the `132465` is your 2FA code.

## Application URL

You can find this in the [Customization Settings](../../settings/customization/#application-url).  
Make sure the application url is set to your externally accessible domain for Ombi.  
e.g. the demo site uses `https://demo.ombi.io/`  

A good idea is to set this up using a [Reverse Proxy](../../info/reverse-proxy), rather than simply forwarding a port.

**If you experience a "Wrong Server Version" error** from your device, but browsing from your PC/Computer/Other devices is working.  You might have issues with your SSL configuration.
Review the [Reverse Proxy](../../info/reverse-proxy) page for additional details.
