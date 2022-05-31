import * as functions from 'firebase-functions'
import * as admin from 'firebase-admin'
import { sendNotification } from './helpers/send_notification'

export const handleGroupMsg = functions.firestore
  .document('groups/{gID}/messages/{msgID}')
  .onCreate(async (snapshot) => {
    const message = snapshot.data()
    if (!message) return
    const { groupID, fromID, fromName, content, type } = message
    const group = (
      await admin.firestore().doc(`groups/${groupID}`).get()
    ).data()
    if (!group) return
    const { name: groupName } = group
    let title = `${groupName}: ${fromName} sent you a message.`
    let body = message.content
      ? message.content.length <= 100
        ? message.content
        : message.content.substring(0, 97) + '...'
      : ''
    if (type == 1) {
      title = `${groupName}: ${fromName} sent you a image.`
      body = 'Image'
    } else if (type == 2) {
      title = `${groupName}: ${fromName} sent you a voice message.`
      body = 'Voice'
    } else if (type == 3) {
      title = `${groupName}: ${fromName} sent you a video message.`
      body = 'Video'
    } else if (type == 4) {
      title = `${groupName}: ${fromName} sent you a emoji.`
      body = 'Emoji'
    } else if (type == 5) {
      title = `${groupName}: ${fromName} sent you a gif.`
      body = 'GIF'
    } else if (type == 6) {
      title = `${groupName}: ${fromName} sent you a sticker.`
      body = 'Sticker'
    }
    const members: string[] = group.members ?? []
    const mutedFor: string[] = group.mutedFor ?? []
    for (const uid of members) {
      if (mutedFor.includes(uid) || uid === fromID) {
        console.error(uid, 'muted group:', groupName)
        continue
      }
      await sendNotification(
        uid,
        title,
        body,
        { groupID, groupName, fromID, fromName, content, type: `${type}` },
        'group'
      )
    }
  })
