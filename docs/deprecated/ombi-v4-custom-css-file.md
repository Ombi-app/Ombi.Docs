# CSS Hack

**Important Note:  
THIS IS NOT AN OFFICIALLY SUPPORTED METHOD. FOLLOW THIS AT YOUR OWN RISK.**

## How to Make A Custom CSS for Ombi

1. Go to your ombi directory
2. Inside the ombi root directory, go to `/ClientApp/dist/`
3. Find `index.html`
4. Make the below edits to the file.
Add `<link rel="stylesheet" href="CustomCSS.css">` right under `<link rel="stylesheet" href="styles.4d16b0dc8c12c7d965e8.css"><link rel="stylesheet" href="main.8ae492ffa0cbafb195ba.css">` and before `</head>`
5. Save your changes.
6. Make a new file named `CustomCSS.css` in this same folder.
7. Edit this CSS to your liking.
8. Save and refresh your Ombi browser window without cache (usually ctrl+F5).

***
