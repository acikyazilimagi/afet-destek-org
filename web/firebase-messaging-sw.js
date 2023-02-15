importScripts(
  "https://www.gstatic.com/firebasejs/9.17.1/firebase-app-compat.js"
);
importScripts(
  "https://www.gstatic.com/firebasejs/9.17.1/firebase-messaging-compat.js"
);

// firebase.initializeApp({
//   apiKey: "AIzaSyAwga9Tzl9ODSGdVRNtw8lgAS5MoIl16Ck",
//   authDomain: "env-deprem-destek-org.firebaseapp.com",
//   projectId: "env-deprem-destek-org",
//   storageBucket: "env-deprem-destek-org.appspot.com",
//   messagingSenderId: "643767075935",
//   appId: "1:643767075935:web:3cc9d6c4658af4ded7c7ea",
//   measurementId: "G-G552720SJK",
// });

// prod
firebase.initializeApp({
  apiKey: "AIzaSyASFP7KxEb8f1JbiDkXDzsj1-e7bPRoaw0",
  authDomain: "deprem-destek-org.firebaseapp.com",
  projectId: "deprem-destek-org",
  storageBucket: "deprem-destek-org.appspot.com",
  messagingSenderId: "529071733784",
  appId: "1:529071733784:web:dfa3729d7ed5c5494c976d",
  measurementId: "G-07GG7EL2P8",
});
// Necessary to receive background messages:
const messaging = firebase.messaging();
