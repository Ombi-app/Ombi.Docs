## Dark and Light Theme Defaults
### Dark Mode with Red Default:

```
.dark .mat-fab.mat-accent, .dark .mat-flat-button.mat-accent, .dark .mat-mini-fab.mat-accent, .dark .mat-raised-button.mat-accent, .dark .mat-list-item.active-list-item, .dark .mat-checkbox-checked.mat-accent .mat-checkbox-background, .dark .mat-checkbox-indeterminate.mat-accent .mat-checkbox-background, .dark .buttons button[type="button"], .dark .mat-tab-label-active[role="tab"] {
background-color: #a30000 !important;
}
```

### Light Mode with Red Default:

```
.mat-fab.mat-accent, .mat-flat-button.mat-accent, .mat-mini-fab.mat-accent, .mat-raised-button.mat-accent, .mat-list-item.active-list-item, .mat-checkbox-checked.mat-accent .mat-checkbox-background, .mat-checkbox-indeterminate.mat-accent .mat-checkbox-background, .buttons button[type="button"], .mat-tab-label-active[role="tab"] {
background-color: #a30000 !important;
}
```

***

## Custom Colors
**Note:** Change all #a30000 to the hex colour you want for all the coloured UI elements (this is red).<br>
**Note:** Change #121212 (currently the colour black) to whatever you want the background colour to be.<br>
**Note:** A good online tool is this one [Colour Selector Tool](https://www.hexcolortool.com). It has RGB, HEX, and RGBA, all on one screen. You can use it to find the colour you want to change.

```
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

## Remove "Sign in with Ombi"
(Only show "Sign in with Plex")<br>
**Note:** This css mod hides the "Sign in with Ombi" option (but does not disable it). A user _could_ inspect the HTML element and "unhide" the ombi login option, but the hope is "out of sight == out of mind".

V3:
```
.login-buttons button:nth-of-type(1) {
  display:none;
}
```

V4:
```
button#sign-in{
display:none;
}
```
***

## Increase "Search Bar" for better mobile viewing
**Note:** The current search bar is hard coded to "width: 50%". This solution is neither perfect nor elegant, but it works for now.

```
app-nav-search mat-form-field{
    margin-left: -50%;
    min-width: 200%;
}
```

***

## Hide Movies/TV-Shows/Music from Menu

**Note:** Basically you're going to hide the ID of whatever tab you want to hide using a CSS tag.

### Hide TV-Shows
```
#TVtab {
display: none;
}
```

### Hide Movies
```
#Moviestab {
display: none;
}
```

### Hide Music
```
#Music {
display: none;
}
```

## Contributors

**Please thank all the people posting their custom CSS and the people below. Most of these are from the community at large, so credit where credit is due.**
### Reddit
[sokotaro](https://www.reddit.com/user/sokotaro/)
* Remove Sign In with Ombi
* Increase Searchbar on Mobile

[Rockfist93](https://www.reddit.com/user/Rockfist93/)
* Default Light Theme
* Default Dark Theme

[bigworm50](https://www.reddit.com/user/bigworm50/)
* Custom Colored UI

[zimreapers](https://www.reddit.com/user/zimreapers/)
* Hide Movies,TV-Shows,and Music Tabs
### Github
[DevilsCoder](https://github.com/DevilsDesigns/)
* [OmbiFlix Dark Netflix Clone](https://github.com/DevilsDesigns/OmbiFlix-Themes)