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
