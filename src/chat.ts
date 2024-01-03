import './assets/main.css'
import { createApp } from 'vue'
import App from './Chat.vue'

const el = document.createElement('div');
el.id = 'chat';
document.body.appendChild(el);

createApp(App).mount('#chat')
