# Utilisez une image de base Node.js
FROM node:14.17.0-alpine

# Définissez le répertoire de travail dans le conteneur
WORKDIR /app

# Copiez les fichiers package.json et package-lock.json dans le conteneur
COPY package*.json ./

# Installez les dépendances du projet
RUN npm install

# Copiez tous les fichiers du projet dans le conteneur
COPY . .

# Exposez le port sur lequel l'application Vue.js s'exécute
EXPOSE 8080

# Démarrez l'application Vue.js lorsque le conteneur est lancé
CMD [ "npm", "run", "serve" ]