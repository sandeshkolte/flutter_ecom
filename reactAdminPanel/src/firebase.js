import { initializeApp } from "firebase/app";
import {getStorage} from 'firebase/storage';

const firebaseConfig = {
  apiKey: "AIzaSyDXOrlnC6FL0sYoUi1UI98CcupV8b_Bhxg",
  authDomain: "comrade-ec6f7.firebaseapp.com",
  projectId: "comrade-ec6f7",
  storageBucket: "comrade-ec6f7.appspot.com",
  messagingSenderId: "468108977786",
  appId: "1:468108977786:web:fa44ea9492eb420240fdc3"
};

// Initialize Firebase
export const app = initializeApp(firebaseConfig)
export const storage = getStorage(app)