# Documentation

--8<-- "assets/glossary.md"

## Framework

This documentation is built using [mkdocs](https://www.mkdocs.org).

## Submitting Content

Please see the [repository readme](https://github.com/Ombi-app/Ombi.Docs/blob/main/README.md) for information on submitting content for the site.

## Project layout

    mkdocs.yml    # The configuration file for the site itself.
    assets/
        ... # Files to be included in other pages that shouldn't be directly accessible themselves.
    docs/
        index.md  # The documentation homepage.
        ...       # Other top-level markdown pages, including explanations of each Ombi UI page.
        assets/
            scripts/
                ... # Any scripts that need to be easily downloadable from the site.
            images/
                embeds/
                    ... # Images for use in pages
                ombi/
                    ... # Official Ombi images (logos etc).
        development/
            ... # Markdown page relating to development of or contributing to the Ombi project.
        guides/
            ... # Any markdown page classified as a 'guide' (installation, updating etc)
        info/
            ... # Any markdown page that falls under the 'info' category (explanations, supporting documentation outside of Ombi specifically)
        settings/
            ... # Markdown pages explaining each specific settings page
            notifications/
                ... # Markdown pages explaining each notification setting page 
