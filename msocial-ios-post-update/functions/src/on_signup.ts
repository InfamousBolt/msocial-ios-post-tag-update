import * as functions from 'firebase-functions'
import { firestore } from 'firebase-admin'

export const onEmailSignup = functions.auth.user().onCreate(async (user) => {
  if (!user.email) return

  await firestore().doc(`users/${user.uid}`).set(
    {
      id: user.uid,
      email: user.email,
      username: 'admin',
      firstName: 'Admin',
      lastName: '',
      isAdmin: true,
      createdAt: new Date(),
      updatedAt: new Date(),
    },
    {
      merge: true,
    }
  )
})
