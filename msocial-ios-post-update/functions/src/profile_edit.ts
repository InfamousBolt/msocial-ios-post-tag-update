import * as functions from 'firebase-functions'
import { firestore } from 'firebase-admin'

export const editProfile = functions.https.onCall(async (data) => {
  const { id, firstName, lastName, fullName, photoURL, coverPhotoURL } = data
  if (!id) {
    console.error('no user id been given')
    return
  } else if (
    !firstName &&
    !lastName &&
    !fullName &&
    !photoURL &&
    !coverPhotoURL
  ) {
    console.error('no data to edit been given')
    return
  }
  await firestore().doc(`users/${id}`).update({
    firstName,
    lastName,
    fullName,
    photoURL,
    coverPhotoURL,
  })

  await handleProfileEdit(id, photoURL)
})

async function handleProfileEdit(userId: string, authorPhotoURL: string) {
  const posts = (
    await firestore().collection('posts').where('authorID', '==', userId).get()
  ).docs

  for (const doc in posts) {
    if (posts.hasOwnProperty(doc)) {
      const post = posts[doc]
      await post.ref.update({ authorPhotoURL })
    }
  }

  const comments = (
    await firestore()
      .collection('comments')
      .where('authorID', '==', userId)
      .get()
  ).docs
  for (const doc in comments) {
    if (comments.hasOwnProperty(doc)) {
      const comment = comments[doc]
      await comment.ref.update({ authorPhotoURL })
    }
  }
}
