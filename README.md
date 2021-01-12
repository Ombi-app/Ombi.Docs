# Ombi.Docs

This is the source repository for the upcoming Ombi Docs site. The intent is to replace the aging wiki with something a little more... professional.
It is very much a work in progress at this point.

The site is being built using [mkdocs](https://www.mkdocs.org/), which converts standard markdown to static html.  
The site layout is configured using markup, held in the `mkdocs.yml` file in the root directory here.  
This language _is_ indent sensitive, so the new documentation repository is not going to be directly publicly editable - all edit requests will need to be approved by [submitting a pull request](https://docs.github.com/en/free-pro-team@latest/articles/creating-a-pull-request).

## Setting up a dev environment

The best method to install mkdocs is via python - it's consistent across environments. Install Python for your OS, and then run `pip install mkdocs`.

The current theme in use is "material" (since material design is nice and consistent). To install this in your development environment run `pip install mkdocs-material`.

Once the two above things have been done, clone this repository and edit the markdown files under "docs" to change site content. VS Code is a good option to use, and has extensions for markup and markdown syntax highlighting, as well as preview functions.  
mkdocs itself can be told to 'serve' the folder by opening the folder containing `mkdocs.yml` in your relevant console/terminal and running `mkdocs serve`. This will let you live preview the site in your browser, with changes being updated any time you save an edit to a file. 