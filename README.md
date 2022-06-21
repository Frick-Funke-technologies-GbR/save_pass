# save_pass

An open-source cross-platform password manager with cloud sync function. Currently only available on android.

## contents

(...)

### save_pass backup file

+ File format for storing backups.
+ Structure: cloud sql db entrys of user. Currently in encrypted json format.
    + all dates are in JavaScript Date's toJson format, according to [this](https://stackoverflow.com/a/15952652/14773532) post.
    + the created_by entry should be one of the fillowing:
        + 'mobile_client'
        + 'web_client'
        + 'cloud_server'
        + 'manually'
    + synced_with_server is true when created_by is cloud_server
+ Created by client app automatically. No manual manipulation recommendet, there will be no option to recover corrupted files.

#### structure example

```json
{
    'info' :
    {
        'creation_date' : '2021-04-23T18:25:43.511Z',
        'created_by' : 'mobile_client',
        'synced_with_server' : false,
        'last_sync_datetime' : ''
    },
    'user' :
    {
        'user_name' : 'DarthVader',
        'user_ident' : '#av9387n0qng',
        'first_name' : 'Darth',
        'last_name' : 'Vader',
        'email_address' : 'darthvader@darkimperium.dstar',
        'password' : '',
        'register_date' : '2021-04-23T18:25:43.511Z',
        'last_login_date' : '2021-04-23T18:25:43.511Z',
        'google_sign_in' : null
    },
    'data' : 
    {
        'password_entries' :
        [
            {
                'alias': 'asdjcpoianbpoverin',
                'creation_date': 'öasdlfjopivnaweofn', // creation_date is also encrypted
                'encryption_salt': 'laskdnoviawhngüäi',
                'id': 12,
                'notes': 'lasdfvnaoiwenv',
                'password': 'aspüdvonpoainseoinn',
                'thumbnail': null,
                'url': 'lasdfkopvnoaweinv',
                'user_name': 'lasvdndvoiawneöpoigh',
            }
        ]
    }
}
```
