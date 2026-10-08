# Common Themes

## WARNING

V4 introduced/introduces an entirely new UI structure, and is in the process of being entirely rewritten.  
As such, these classes and themes are subject to change. They may or may not work.  
Once we finish the standardisation of CSS classes, we will write up a "how-to" regarding what classes we have, and validate these theme options.

## Custom Colors

**Note:** Replace #a30000 with the hex colour you want for all the coloured UI elements (this is red).  
**Note:** Replace #121212 (currently black) with whatever you want the background colour to be.  
**Note:** A good online tool is this one [Colour Selector Tool](https://www.hexcolortool.com). It has RGB, HEX, and RGBA, all on one screen. You can use it to find the colour you want to change.

``` css
.navbar-default .navbar-brand {
color: #a30000;
}

.nav-tabs>li.active>a, .nav-tabs>li.active>a:focus, .nav-tabs>li.active>a:hover {
background-color: #a30000;
border: 1px solid #a30000;
}

.nav>li>a:focus, .nav>li>a:hover {
background-color: #a30000;
}

.navbar-default .navbar-nav>li>a:focus, .navbar-default .navbar-nav>li>a:hover {
color: #a30000;
background-color: #121212;
}

.pace .pace-progress {
background: #a30000;
position: fixed;
z-index: 2000;
top: 0;
right: 100%;
width: 100%;
height: 5px;
}
```

***

### Red Buttons

=== "Dark Mode"

    ``` css
    .dark .mat-fab.mat-accent, .dark .mat-flat-button.mat-accent, .dark .mat-mini-fab.mat-accent, .dark .mat-raised-button.mat-accent, .dark .mat-list-item.active-list-item, .dark .mat-checkbox-checked.mat-accent .mat-checkbox-background, .dark .mat-checkbox-indeterminate.mat-accent .mat-checkbox-background, .dark .buttons button[type="button"], .dark .mat-tab-label-active[role="tab"] {
    background-color: #a30000 !important;
    }
    ```

=== "Light Mode"

    ``` css
    .mat-fab.mat-accent, .mat-flat-button.mat-accent, .mat-mini-fab.mat-accent, .mat-raised-button.mat-accent, .mat-list-item.active-list-item, .mat-checkbox-checked.mat-accent .mat-checkbox-background, .mat-checkbox-indeterminate.mat-accent .mat-checkbox-background, .buttons button[type="button"], .mat-tab-label-active[role="tab"] {
    background-color: #a30000 !important;
    }
    ```

***

## Wider Search Bar

**Note:** The current search bar is hard coded to "width: 50%".  
This solution is neither perfect nor elegant, but it works for now.

``` css
app-nav-search mat-form-field{
    margin-left: -50%;
    min-width: 200%;
}
```

***

## Hide "Sign in with Ombi"

(Only show "Sign in with Plex")  
**Note:** This css mod hides the "Sign in with Ombi" option (but does not disable it). A user _could_ inspect the HTML element and "un-hide" the ombi login option, but the hope is "out of sight == out of mind".  

=== "V4"

``` css
/* Hide Ombi Sign-in Button */
p.login-subtitle, button.btn-login.btn-login--primary, div.oauth-buttons div.divider-row {
    display: none !important;
}
```

=== "V3 (Legacy)"

``` css
.login-buttons button:nth-of-type(1) {
    display:none;
}
```

***

## Use an Image instead of Application Name

This allows you to replace the application name (on the left) with an image.  
The example below uses a relative location for the logo, so bear in mind that if it's hosted elsewhere you'll need to put in the complete URL to the file.

The image replaces the default "Ombi" text, including for screen readers. `content: url("images/ombi.png") / "Ombi";` restores an accessible name in browsers that support the syntax (and is harmlessly ignored where they don't).

```css
/* Nav Bar Logo */
#nav-applicationName .brand-link {
  content: url("images/ombi.png") / "Ombi";
  box-sizing: border-box;
  max-width: 100%;
  height: auto;
}
```

***

## Override for custom application image showing as user avatars

In some cases when using a custom application image, that image is shown as the avatar for all users. This will replace that image with a generic no-avatar style person logo.

```css
/* Profile image override */
.profile-avatar img {
  content: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 32 32'%3E%3Ccircle cx='16' cy='16' r='16' fill='%23555'/%3E%3Ccircle cx='16' cy='13' r='5.5' fill='%23ddd'/%3E%3Cpath d='M5 29a11 11 0 0 1 22 0z' fill='%23ddd'/%3E%3C/svg%3E");
}
```

***

## Hide "Play on Plex" button

``` css
a#viewOnPlexButton {
display:none;
}
```

***

## Hide "Stream On" services

``` css
#streamingContainer {
    display: none;
}
.streaming-on
{
    display: none;
}
```

***

## Community Themes

People with their own repositories of themes can have ones they'd like shared publicly linked here.  
Please note that these are not tested or endorsed by the Ombi(tm) team. Any 'jank' encountered is down to the maintainer of the theme.

* [Theme-Park](https://docs.theme-park.dev/themes/ombi/)
* [OmbiFlix (Dark Netflix Clone)](https://github.com/DevilsDesigns/OmbiFlix-Themes)

***

## Hide Media Types

**Note:**  
You're basically hiding the ID of whatever tab you want to hide using a CSS tag.  
This only works for V3 (legacy) builds, as V4 is no longer tabbed like this.

=== "TV Shows"

    ``` css
    #TVtab {
        display: none;
    }
    ```

=== "Movies"

    ``` css
    #Moviestab {
        display: none;
    }
    ```

=== "Music"

    ``` css
    #Music {
        display: none;
    }
    ```
***

## Hide Hero/Discover Section

```css
.hero-section{ display: none !important; }
```

***

## Hide Quick Genre Button Section

```css
.genre-section.discover-section { display: none !important; }
```

***

## Contributors

**Please thank all the people posting their custom CSS and the people below. Most of these are from the community at large, so credit where credit is due.**

=== "Reddit"
    [sokotaro](https://www.reddit.com/user/sokotaro/)  

    * Remove Sign In with Ombi
    * Increase Search bar on Mobile

    [Rockfist93](https://www.reddit.com/user/Rockfist93/)  

    * Default Light Theme
    * Default Dark Theme

    [bigworm50](https://www.reddit.com/user/bigworm50/)  

    * Custom Colored UI

    [zimreapers](https://www.reddit.com/user/zimreapers/)  

    * Hide Movies,TV-Shows,and Music Tabs

=== "Github"

    [DevilsCoder](https://github.com/DevilsDesigns/)  

    * [OmbiFlix (Dark Netflix Clone)](https://github.com/DevilsDesigns/OmbiFlix-Themes)

=== "Discord"

    [Alacard]()

    * Hide "Stream on" services
