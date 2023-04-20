importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: 'AIzaSyAmEmLsX30GRHNjfbY7yHNFvliU34EJnK8',
    appId: '1:928714007083:web:327020a4f1fdf1d5ee006e',
    messagingSenderId: '928714007083',
    projectId: 'cake-house-e56f0',
    authDomain: 'cake-house-e56f0.firebaseapp.com',
    databaseURL: 'https://cake-house-e56f0-default-rtdb.firebaseio.com',
    storageBucket: 'cake-house-e56f0.appspot.com',
    measurementId: 'G-B66YTECYGF',
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});