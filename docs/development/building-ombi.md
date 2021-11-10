# Ombi Development

## Frontend

In this example I'll be using VS Code to edit the frontend.

1. Clone the Repository
1. Change to the relevant branch (currently `development`)
1. Install the .Net Core SDK (latest) [https://dotnet.microsoft.com/download/dotnet-core](https://dotnet.microsoft.com/download/dotnet-core)
1. Install [NodeJS](https://nodejs.org/en/download/) and Tools for Node.js Native Modules
1. Install [Yarn](https://yarnpkg.com/en/)
1. Set the Env variable to development `$export ASPNETCORE_Environment=Development` or `$env:ASPNETCORE_ENVIRONMENT = "Development"` in Powershell
1. Open up a New Terminal in the following location: `~src/Ombi/ClientApp`, run the following:
   1. `yarn` _(wait for it to install all dependencies)_
   1. `yarn start`
1. Go to `~/src/Ombi` in a Terminal Window and run `dotnet run -- --host http://*:5000`
1. Navigate to [http://localhost:5000/](http://localhost:5000/)

You can now make UI changes and it will use Hot Module Reloading to show the changes.

_If you are doing this on your server machine changing the environment will make your Ombi install fail to run._
_Be sure to change the environment back to `production` to re-run Ombi._

## Backend

To edit the backend of Ombi, you'll need to use [Visual Studio](https://visualstudio.microsoft.com/).

1. Clone the Repository.
1. Change to the relevant branch (currently `development`).
1. Install the .Net Core SDK (latest) [https://dotnet.microsoft.com/download/dotnet-core](https://dotnet.microsoft.com/download/dotnet-core).
1. Install [NodeJS](https://nodejs.org/en/download/) and Tools for Node.js Native Modules.
1. Install [Yarn](https://yarnpkg.com/en/).
1. Install [Visual Studio](https://visualstudio.microsoft.com/) (we suggest Community Edition, set up for C#).
1. Open the `Ombi.sln` file in the `~\src` folder.
1. Make the changes you want made/think are needed.
   1. We suggest saving changes to either a new branch (if you have access), or making a fork of the repo for your edits to be kept in.
   1. Save often, and commit changes using the git option regularly (with logical commit messages). This helps you revert changes if you break something (and yes, we do it too).
1. When ready to test the changes, set the Env variable to development `$export ASPNETCORE_Environment=Development` or `$env:ASPNETCORE_ENVIRONMENT = "Development"` in Powershell.
1. Open up a New Terminal in the following location: `~src/Ombi/ClientApp`, run the following:
   1. `yarn` _(wait for it to install all dependencies)_.
   1. `yarn start`.
1. Go to `~/src/Ombi` in a Terminal Window and run `dotnet run -- --host http://*:5000`.
1. Navigate to [http://localhost:5000/](http://localhost:5000/).

If Ombi compiles and runs successfully with your changes, you'll be able to load the web UI on the link above.  
If Ombi fails to compile, the error will appear in the terminal window you ran the `dotnet run...` command in - that's the compilation command. Generally speaking, it'll give you an error message with details as to why it didn't work.

## Submitting Changes

Any changes you make to the code should be pushed up to the branch you made for working on.  
Once you are happy with your changes, [submit a Pull Request](https://docs.github.com/en/free-pro-team@latest/articles/creating-a-pull-request) to the [Ombi repository](https://github.com/Ombi-app/Ombi) for review.
