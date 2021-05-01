# Mobile App

Note: The iOS app is currently going through the Apple Review Process.  
I'm hopeful, but they have declined the app a lot at this point.

## Connecting the App

### QR Code Login

To enable the QR Code login, you need to ensure you have setup your Application URL.

Once you have set that up you can find the QR code to scan under your user profile (Top right where your username is) and then press the Mobile Tab, there should now be a QR code present!

### Logging in manually with Plex 2FA

If you do not want to use the QR code mechanism, you still can log in manually.  
If you have a Plex Account with MFA/2FA enabled, you will need to enter your password in the following format: `password132456` where the `132465` is your 2FA code.

## Application URL

You can find this in the [Customization Settings](../../settings/customization/#application-url).  
Make sure the application url is set to your externally accessible domain for Ombi.  
e.g. the demo site uses `https://demo.ombi.io/`  

A good idea is to set this up using a [Reverse Proxy](../reverse-proxy), rather than simply forwarding a port.
