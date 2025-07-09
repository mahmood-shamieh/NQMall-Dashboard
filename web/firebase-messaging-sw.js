importScripts('https://www.gstatic.com/firebasejs/9.0.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.0.0/firebase-messaging-compat.js');

firebase.initializeApp({
  // Your web app's Firebase configuration
  // You can get this from the Firebase Console
  apiKey: "AIzaSyD5ioDMmAL97aHVBqBOHmrQ3U2virA3lss",
    authDomain: "fcm-test-71bc6.firebaseapp.com",
    projectId: "fcm-test-71bc6",
    storageBucket: "fcm-test-71bc6.firebasestorage.app",
    messagingSenderId: "716979128456",
    appId: "1:716979128456:web:f14329008be819ba8eb73d",
    measurementId: "G-8BCNWH0W04"
});

const messaging = firebase.messaging();

// Handle background messages
messaging.onBackgroundMessage((payload) => {
  console.log('Received background message:', payload);

  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
    icon: '/icons/Icon-192.png' // Make sure this icon exists in your web assets
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
}); 