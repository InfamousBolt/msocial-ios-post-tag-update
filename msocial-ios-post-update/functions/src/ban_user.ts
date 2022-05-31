import * as functions from "firebase-functions";
import * as admin from "firebase-admin";


export const banUser = functions.https.onCall(async param => {
    const userID = param['userID'];
    if (!userID) return;
    const userDoc = await admin.firestore().collection('users').doc(userID).get();
    const isBanned = !(userDoc.data()?.isBanned ?? false);
    await userDoc.ref.update({isBanned: isBanned});
    await admin.auth().updateUser(userID, {
        disabled: isBanned
    })
});