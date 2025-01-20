# FROM node:lts-alpine
# WORKDIR /app
# COPY package.json ./
# RUN npm install
# COPY . .
# EXPOSE 3000
# CMD ["npm", "start"]

# First Stage
FROM node:10.14.0 AS installer
WORKDIR /app

# Copying package.json & package-lock.json.
COPY package*.json .

# Running npm install now. As you can in this stage we only copied package.json & package-lock.json files
RUN npm install

# Second Stage
# Using Alpine images to curb down the image size
FROM node:lts-alpine as release

WORKDIR /app

# Copying all the contents from previous stage(used - - from) into current stage
COPY --from=installer /app /app

# Copying all the repo content into our Docker environment
COPY . .

# Triggering the start command to run the application
CMD ["npm", "start"]