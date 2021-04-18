# Common Themes

## Dark Mode Red Buttons

``` css
.dark .mat-fab.mat-accent, .dark .mat-flat-button.mat-accent, .dark .mat-mini-fab.mat-accent, .dark .mat-raised-button.mat-accent, .dark .mat-list-item.active-list-item, .dark .mat-checkbox-checked.mat-accent .mat-checkbox-background, .dark .mat-checkbox-indeterminate.mat-accent .mat-checkbox-background, .dark .buttons button[type="button"], .dark .mat-tab-label-active[role="tab"] {
background-color: #a30000 !important;
}
```

## Light Mode Red Buttons

``` css
.mat-fab.mat-accent, .mat-flat-button.mat-accent, .mat-mini-fab.mat-accent, .mat-raised-button.mat-accent, .mat-list-item.active-list-item, .mat-checkbox-checked.mat-accent .mat-checkbox-background, .mat-checkbox-indeterminate.mat-accent .mat-checkbox-background, .buttons button[type="button"], .mat-tab-label-active[role="tab"] {
background-color: #a30000 !important;
}
```

***

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
    button#sign-in{
       display:none;
    }
    ```

=== "V3 (old)"

    ``` css
    .login-buttons button:nth-of-type(1) {
        display:none;
    }
    ```

***

## Hide Media Types

**Note:** You're basically hiding the ID of whatever tab you want to hide using a CSS tag.

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

## Contributors

**Please thank all the people posting their custom CSS and the people below. Most of these are from the community at large, so credit where credit is due.**

### Reddit

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

### Github

[DevilsCoder](https://github.com/DevilsDesigns/)  

* [OmbiFlix (Dark Netflix Clone)](https://github.com/DevilsDesigns/OmbiFlix-Themes)
