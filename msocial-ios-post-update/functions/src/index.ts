import * as admin from 'firebase-admin'

admin.initializeApp()
admin.firestore().settings({ ignoreUndefinedProperties: true })

export { handleChatMsg } from './chat_msg'
export { handleGroupMsg } from './group_msg'
export { editProfile } from './profile_edit'
export { banUser } from './ban_user'
export { onEmailSignup } from './on_signup'
