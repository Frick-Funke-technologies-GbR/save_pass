


// class BackupClass {
//   Map<String, dynamic> info = {
//           'creation_date': now,
//           'created_by': 'mobile_client',
//           'synced_with_server': await cache.getBoolFromCache('passwords_synced'),
//           'last_sync_datetime': DateTime



//   }
// }

//       {
//         'info': {
//           'creation_date': now,
//           'created_by': 'mobile_client',
//           'synced_with_server': await cache.getBoolFromCache('passwords_synced'),
//           'last_sync_datetime':
//               await cache.getStringFromCache('last_sync_datetime')
//         },
//         'user': {
//           'user_name': await cache.getSecureStringFromCache('user_name'),
//           'user_ident': await cache.getSecureStringFromCache('user_ident'),
//           'first_name': await cache.getSecureStringFromCache('first_name'),
//           'last_name': await cache.getSecureStringFromCache('last_name'),
//           'email_address': await cache.getSecureStringFromCache('email_address'),
//           'password': passwordHash,
//           'register_date': null,
//           'last_login_date': null,
//           'google_sign_in': null
//         },
//         'data': {
//           'password_entries': _passwordEntriesToList(
//             await db.getEncryptedPasswordEntries(),
//           ),
//         },
//       },
//     );
//   }