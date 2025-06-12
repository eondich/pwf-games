import { createApp } from 'vue';
import { createMemoryHistory, createRouter } from 'vue-router';

import App from './components/App/App';
import Dnd5e2024Generator from './components/CharacterGenerators/5e/Dnd5e2024Generator';

const routes = [
  { path: '/', component: Dnd5e2024Generator },
];

const router = createRouter({
  history: createMemoryHistory(),
  routes
});

createApp(App).use(router).mount('#app');
