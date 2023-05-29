# Utilisez une image de base Node.js
FROM node:14.17.0-alpine

# Définissez le répertoire de travail dans le conteneur
WORKDIR /app

# Copiez les fichiers package.json et package-lock.json dans le conteneur
COPY package*.json ./

# Installez les dépendances du projet
RUN npm install

# Installez inotify-tools
RUN apk --no-cache add inotify-tools

# Copiez le script d'exécution personnalisé dans le conteneur
COPY script.sh /usr/local/bin/script.sh

# Rendez le script exécutable
RUN chmod +x /usr/local/bin/script.sh

# Copiez tous les fichiers du projet dans le conteneur
COPY . .

# Exposez le port sur lequel l'application Vue.js s'exécute
EXPOSE 8080

# Démarrez l'application Vue.js lorsque le conteneur est lancé
CMD [ "npm", "run", "serve" ]