# Webhook

You can configure Ombi to notify applications using a webhook.

## Registering a Webhook

Refer to your Ombi instance's Swagger doc for guidance on how to register your webhook.

Each webhook is registered using an application key specific to the application that wishes to receive webhook notifications. A single application key can only ever have one webhook registered to it.

If you wish to know if you have already registered a webhook, you can query for the webhook for the application's application key and check the returned webhook URL (if any).

## Request Structure

A webhook request is composed of two items: a collection of headers and a request body.

A webhook notification will contain the following headers:

* `Host`: the host URL of the webhook being invoked - e.g., if the webhook URL is configured as `https://yoursystem.com:7483/webhook`, this will be `https://yoursystem.com:7483`
* `User-Agent`: a user agent identifying the agent as Ombi. This follows a format of `Ombi/<version> (https://ombi.io/)` - e.g., if you are running version 4.47.1 of Ombi, this header will be `Ombi/4.47.1 (https://ombi.io/)`
* `Content-Type`: the type of the content; this will be `application/json`
* `Content-Length`: the number of bytes of data in the request body

## Request Body

The request body contains a JSON payload with information about the notification event. The structure includes:

* `requestId`: the unique identifier of the request
* `requestedUser`: the username of the user who made the request
* `title`: the title of the requested media
* `requestedDate`: the date the request was made (formatted as long date)
* `type`: the type of media request (e.g., "Movie", "TV Show", "Album")
* `additionalInformation`: any additional information provided with the request
* `longDate`: the current date in long format
* `shortDate`: the current date in short format (MM/DD/YYYY)
* `longTime`: the current time in long format
* `shortTime`: the current time in short format
* `overview`: a brief description or synopsis of the requested media
* `year`: the release year of the requested media
* `episodesList`: list of episodes (for TV shows, null for movies)
* `seasonsList`: list of seasons (for TV shows, null for movies)
* `posterImage`: URL to the poster or thumbnail image
* `applicationName`: the name of the Ombi instance
* `applicationUrl`: the base URL of the Ombi instance
* `issueDescription`: description of any associated issue
* `issueCategory`: category of any associated issue
* `issueStatus`: status of any associated issue
* `issueSubject`: subject of any associated issue
* `newIssueComment`: new comment on any associated issue
* `issueUser`: user associated with any issue
* `userName`: the username of the user associated with the notification
* `alias`: user alias or display name
* `requestedByAlias`: alias of the user who made the request
* `userPreference`: user notification preferences
* `denyReason`: reason for denial (if applicable)
* `availableDate`: the date the content became available
* `requestStatus`: the current status of the request (e.g., "Available", "Processing Request")
* `providerId`: the unique identifier from the media provider (e.g., TMDB ID)
* `partiallyAvailableEpisodeNumbers`: list of partially available episode numbers (for TV shows), separated by commas
* `partiallyAvailableSeasonNumber`: season number that is partially available (for TV shows)
* `partiallyAvailableEpisodesList`: list of partially available episodes (for TV shows), separated by commas, in the format of `<season number>x<episode number>`
* `partiallyAvailableEpisodeCount`: count of partially available episodes (for TV shows)
* `notificationType`: the type of notification (e.g., "RequestAvailable", "RequestApproved", "RequestDeclined"); refer to `NotificationType.cs` in the Ombi source code for a complete list of possible types

### Example Request Body

```json
{
  "requestId": "123",
  "requestedUser": "username",
  "title": "Example Movie",
  "requestedDate": "Saturday, January 1, 2024",
  "type": "Movie",
  "additionalInformation": "",
  "longDate": "Saturday, January 1, 2024",
  "shortDate": "1/1/2024",
  "longTime": "12:00:00 PM",
  "shortTime": "12:00 PM",
  "overview": "An example movie about a protagonist who goes on an adventure and learns valuable lessons along the way.",
  "year": "2024",
  "episodesList": null,
  "seasonsList": null,
  "posterImage": "https://image.tmdb.org/t/p/w300/example123.jpg",
  "applicationName": "Ombi",
  "applicationUrl": "https://ombi.yourdomain.com",
  "issueDescription": "",
  "issueCategory": "",
  "issueStatus": "",
  "issueSubject": "",
  "newIssueComment": "",
  "issueUser": "username",
  "userName": "username",
  "alias": "username",
  "requestedByAlias": null,
  "userPreference": null,
  "denyReason": null,
  "availableDate": "Saturday, January 1, 2024",
  "requestStatus": "Available",
  "providerId": "123456",
  "partiallyAvailableEpisodeNumbers": null,
  "partiallyAvailableSeasonNumber": null,
  "partiallyAvailableEpisodesList": null,
  "partiallyAvailableEpisodeCount": null,
  "notificationType": "RequestAvailable"
}
```

