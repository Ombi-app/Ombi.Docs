# Friendly Names

A number of people have now asked if Ombi and Tautulli can synchronise 'friendly names' or 'aliases' for users.  
At present there is no built-in support for this.  

However, one of the Discord users (thanks, DirtyCajunRice) wrote a python script to achieve this.  
Enter the URLs and API keys for your Ombi and Tautulli instances, and save the file into your preferred scripts folder as `sync_aliases.py`.  
I prefer:  

* **Windows:** `C:\Scripts\`
* **Linux:** `/opt/scripts/`

Once that's done, enter a command prompt/terminal and run `python sync_aliases.py` to run the script and have it match entries.  
_**Note:** This script requires the requests module to be installed. You can install this with  
`pip install requests`._  
  
If you'd like to make this sync happen on a schedule, then setting a scheduled task or cron job to run the python script will achieve this. A handy utility for managing this kind of thing is [Chronos](https://github.com/simse/chronos).  

````python
from requests import Session
from urllib3 import disable_warnings
from urllib3.exceptions import InsecureRequestWarning

OMBI_URL = ''
OMBI_APIKEY = ''

TAUTULLI_URL = ''
TAUTULLI_APIKEY = ''

# Don't Edit Below #
disable_warnings(InsecureRequestWarning)
SESSION = Session()
SESSION.verify = False
HEADERS = {'apiKey': OMBI_APIKEY}
PARAMS = {'apikey': TAUTULLI_APIKEY, 'cmd': 'get_users'}
TAUTULLI_USERS = SESSION.get('{}/api/v2'.format(TAUTULLI_URL.rstrip('/')), params=PARAMS).json()['response']['data']
TAUTULLI_MAPPED = {user['username']: user['friendly_name'] for user in TAUTULLI_USERS
                   if user['user_id'] != 0 and user['friendly_name']}
OMBI_USERS = SESSION.get('{}/api/v1/Identity/Users'.format(OMBI_URL.rstrip('/')), headers=HEADERS).json()

for user in OMBI_USERS:
    if user['userName'] in TAUTULLI_MAPPED and user['alias'] != TAUTULLI_MAPPED[user['userName']]:
        print("{}'s alias in Tautulli ({}) is being updated in Ombi from {}".format(
            user['userName'], TAUTULLI_MAPPED[user['userName']], user['alias'] or 'empty'
        ))
        user['alias'] = TAUTULLI_MAPPED[user['userName']]
        put = SESSION.put('{}/api/v1/Identity'.format(OMBI_URL.rstrip('/')), json=user, headers=HEADERS)
        if put.status_code != 200:
            print('Error updating {}'.format(user['userName']))
````

## Powershell command for scheduling this

````powershell
$action = New-ScheduledTaskAction -Execute 'C:\Python27\python.exe' -Argument 'C:\Scripts\sync_aliases.py'
$trigger = New-ScheduledTaskTrigger -Daily -At 5am
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Sync Friendly Names" -Description "Synchronize friendly names between Tautulli and Ombi" -User "SYSTEM"
````
