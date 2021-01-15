# Ombi.Docs

Docs Site: [https://docs/ombi.app](https://docs.ombi.app/)  
![Doc Deployment](https://github.com/Ombi-app/Ombi.Docs/workflows/Build%20and%20deploy%20docs/badge.svg)

This is the source repository for the upcoming Ombi Docs site. The intent is to replace the aging wiki with something a little more... professional.
It is very much a work in progress at this point.  

## Setting up a dev environment

The easiest method to install mkdocs is via python - it's consistent across different OS environments.  
Install Python for your OS, ensuring that it gets added to PATH.  

Once you have Python installed, you'll need to clone the repository and install the python packages used by this site (like mkdocs itself).
To do this, clone the repo, and from the relevant terminal/shell/prompt, change directory to the repo folder and run  
`pip install -r docs/requirements.txt`  
to ensure you have all the relevant packages for use.

## Editing the site

To edit the site content, edit the markdown files under "docs".  
To edit the site layout, edit the `mkdocs.yml` file (held in the root directory).  
Note that as `mkdocs.yml` _is_ written in an indent-sensitive language, the new documentation repository is not going to be directly publicly editable - all edit requests will need to go through approval by [submitting a pull request](https://docs.github.com/en/free-pro-team@latest/articles/creating-a-pull-request).

## Suggested editor

[VS Code](https://code.visualstudio.com/) is a good option to use for this, as it has extensions for markup and markdown syntax highlighting (as well as preview functions).  
[Atom](https://atom.io/) is another good option.

## Using mkdocs

The site is being built using [mkdocs](https://www.mkdocs.org/), which converts standard markdown to static html.  
mkdocs itself can be told to 'serve' the folder by opening the folder containing `mkdocs.yml` in your relevant console/terminal and running `mkdocs serve`.  
This will let you live preview the site in your browser, with changes being updated any time you save an edit to a file.  
