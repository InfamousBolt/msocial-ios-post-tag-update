import { firestore, messaging } from 'firebase-admin'

export async function sendNotification(
  uid: string,
  title: string,
  body: string,
  data: messaging.DataMessagePayload,
  type: 'chat' | 'group' = 'chat'
) {
  const user = (await firestore().doc(`users/${uid}`).get()).data()
  if (!user) {
    console.error('User doesnt exist')
    return
  }

  const { pushToken, chatNotify, groupsNotify } = user
  if (!pushToken) {
    console.error('Invalid user push token', uid)
    return
  }
  if (type === 'chat' && !chatNotify) {
    console.error('chatNotify is Disabled for', uid)

    return
  }
  if (type === 'group' && !groupsNotify) {
    console.error('groupsNotify is disabled for', uid)
    return
  }

  return messaging()
    .sendToDevice(
      pushToken,
      {
        notification: {
          title,
          body,
          click_action: 'FLUTTER_NOTIFICATION_CLICK',
        },
        data,
      },
      {
        priority: 'high',
      }
    )
    .catch((e) => {
      console.error('Error Send To Device', e)
    })
}
