# Ombi.Docs

Docs Site: [https://docs.ombi.app](https://docs.ombi.app/)  
![Doc Deployment](https://github.com/Ombi-app/Ombi.Docs/workflows/Build%20and%20deploy%20docs/badge.svg)

This is the source repository for the Ombi Docs site. It replaced the old wiki with something a little more... professional.

If you'd like to get involved with the project, reach out on [discord](https://discord.gg/Sa7wNWb).

---

## Setting up a dev environment

The easiest method to install Zensical is via Python - it's consistent across different OS environments.
Install Python for your OS, ensuring that it gets added to PATH.  

Once you have Python installed, you'll need to clone the repository and install the Python packages used by this site.
To do this, clone the repo, and from the relevant terminal/shell/prompt, change directory to the repo folder and run  
`pip install -r requirements.txt`  
to ensure you have all the relevant packages for use.

## Editing the site

To edit the site content, edit the markdown files under "docs".  
To edit the site layout, edit the `zensical.toml` file (held in the root directory).
If you are working on changes, use the development branch in this repo as a base, and create a branch with your suggested changes.  

Note that the new documentation repository is not directly publicly editable - for a few reasons, including (but not limited to):

- Configuration (as used in `zensical.toml`) must follow TOML syntax.
- Markdown (what all the pages themselves are written with) has defined standards.
- We'd like to be able to validate content _before_ it gets put into official documentation (the old wiki had a lot of inaccurate community-submitted content).

As such, all edit requests will need to go through approval by [submitting a pull request](https://docs.github.com/en/free-pro-team@latest/articles/creating-a-pull-request).  
All PRs need to target the [development](https://github.com/Ombi-app/Ombi.Docs/tree/development) branch of the docs, to allow for merging of formatting for consistency.

## Suggested editor

[VS Code](https://code.visualstudio.com/) is a good option to use for editing this content, as it has extensions for markup and markdown syntax highlighting (as well as preview functions).  
Included in this repository  is a workspace config for vscode with some defined spelling, linting, and error-checking methods, as well as a group of recommended VS Code extensions for use.  
[Atom](https://atom.io/) is another good option.

## Using Zensical

The site is built using [Zensical](https://zensical.org/), which converts Markdown to static HTML.
To preview the site locally, open the repository folder in your console/terminal and run `zensical serve`.
This will let you live preview the site in your browser, with changes being updated any time you save an edit to a file.  

### Zensical references

Source reference:

- [Zensical documentation](https://zensical.org/docs/)
