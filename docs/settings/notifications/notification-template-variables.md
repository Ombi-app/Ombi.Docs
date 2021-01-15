In all of the notification templates you are able to pass in data the Ombi will populate when sending out the notification message.

Below are all the supported variables.

| Variable       | Description |
| ------------- |-------------| 
| {UserName}     |  The username of the user |
| {Alias}     |  The Alias of the user (if no alias then it falls back to UserName) |
| {UserPreference}     |  The value of the preference set on the User Management page for that notification agent |
| {RequestedDate}      | The Date the media was requested       | 
| {RequestId}      | Ombi's Internal ID for this request       | 
| {RequestStatus}      | Current status of the request       | 
| {Type} | The type of the request e.g. Movie, TvShow       |
| {Title} | The title of the request e.g. Lion King       |
| {Overview} |    Overview of the requested item    |
| {AvailableDate} |   The date the request was made available|
| {Year} |  The release year of the request     |
| {EpisodesList} |    A comma separated list of Episodes requested    |
| {SeasonsList} |    A comma separated list of seasons requested   |
| {PosterImage} |   The requested poster image link    |
| {ApplicationName} |    The Application Name from the Customization Settings   |
| {ApplicationUrl} |   The Application URL from the Customization Settings    |
| {IssueDescription} | * The description of the issue provided by the user |
| {IssueCategory} | * The issue category that was assigned to the issue |
| {IssueSubject} | * The subject of the issue that was provided by the user |
| {NewIssueComment} | ** The new comment text on the issue |
| {DenyReason} | *** This is the reason text when we deny a request |
| {LongDate} |  15 June 2017      |
| {ShortDate} |  15/06/2017      |
| {LongTime} |    16:02:34    |
| {ShortTime} |    16:02    |

Notes:

`*` This is for Issues only  
`**`This is only for an issue comment notification, it will be empty for everything else
`***` this is only for requests that have been denied

## Newsletter

Since there is no real request associated with a newsletter it's slightly different, these are the allowed variables:

| Variable       | Description |
| ------------- |-------------| 
| {UserName}     |  The User who the email is being sent to |
| {Alias}     |  The User who the email is being sent to |
| {ApplicationName} |    The Application Name from the Customization Settings   |
| {ApplicationUrl} |   The Application URL from the Customization Settings    |
| {LongDate} |  15 June 2017      |
| {ShortDate} |  15/06/2017      |
| {LongTime} |    16:02:34    |
| {ShortTime} |    16:02    |
