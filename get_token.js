// get_token.js - jalankan: node get_token.js
const { GoogleAuth } = require('google-auth-library');

async function getAccessToken() {
  const auth = new GoogleAuth({
    // Ganti path dengan lokasi file service account JSON Anda
    keyFile: 'E:/workspace/grand_library/serviceAccountKey.json',
    scopes: ['https://www.googleapis.com/auth/firebase.messaging'],
  });
  const client = await auth.getClient();
  const tokenResponse = await client.getAccessToken();
  console.log('Access Token:');
  console.log(tokenResponse.token);
}

getAccessToken();
