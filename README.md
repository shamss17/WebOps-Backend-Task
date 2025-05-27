# README

This README would normally document whatever steps are necessary to get the
application up and running.

* Ruby version: ruby 3.2.8

* Deployment instructions  

* * WebOps Backend Dev Task - Full Setup & Usage Guide 

This is a full-featured Ruby on Rails API backend project for the WebOps Backend Developer task. It includes:

User authentication (JWT-based)

Posts and comments

Tags and ownership checks

Auto-deletion of posts after 24 hours via Sidekiq

Fully containerized setup using Docker Compose

 1. Getting Started with Docker

* Prerequisites

Docker installed

Git installed

Basic terminal familiarity (Git Bash or VS Code Terminal preferred)

* Clone and Set Up the Project

git clone https://github.com/shamss17/webops-backend-task.git
cd webops-backend-task

* Start the App

docker-compose up

This command will:

Build the app and install dependencies

Set up PostgreSQL and Redis

Run Rails server on http://localhost:3000

Start Sidekiq for background jobs

 2. Authentication (Signup & Login)

Use Postman or curl to interact with the API.

* Signup

Endpoint: POST /signup

Body (JSON):

{
  "name": "Test User",
  "email": "test@example.com",
  "password": "password123",
  "password_confirmation": "password123",
  "image": "https://example.com/avatar.jpg"
}

Returns:

Created user

JWT token

* Login

Endpoint: POST /login

Body (JSON):

{
  "email": "test@example.com",
  "password": "password123"
}

Returns:

User info

JWT token

3. Use the JWT Token

For all protected routes, add this HTTP header:

Authorization: Bearer YOUR_JWT_TOKEN

You get the token from the login response.

    * Authentication test 

    Create a GET request with  http://localhost:3000/auth_test 
    Ufter createing a header Authentication with the JWT Token

4. Working with Posts

* Create a Post

Endpoint: POST /posts

{
  "title": "First Post",
  "body": "This post will auto-delete after 24h",
  "tags": ["rails", "docker"]
}

Requires JWT header. Returns the created post.

* View Posts

GET /posts

* Update Post

PATCH /posts/:id — Only the post's author can edit.

* Delete Post

DELETE /posts/:id — Only the post's author can delete.

- Auto-Deletion

Every post is auto-deleted 24 hours after creation using Sidekiq + Redis.

5. Comments

* Add Comment

Endpoint: POST /posts/:post_id/comments

{
  "body": "Nice post!"
}

* Edit Comment

PATCH /comments/:id — only comment's author can edit

* Delete Comment

DELETE /comments/:id — only comment's author can delete

6. Background Jobs with Sidekiq

Sidekiq runs automatically inside Docker and handles:

Post deletion 24 hours after creation

No extra setup needed. Redis is also managed via Docker.

7. Environment & Config

* Docker Services

web – Rails app (port 3000)

db – PostgreSQL (default URL configured via DATABASE_URL)

redis – For Sidekiq queueing

sidekiq – Background job processor


* * Running Tests

1. Make sure your Docker containers are up:

docker-compose up -d

2. Run RSpec inside the web service container:

docker-compose exec web bundle exec rspec

You should see output like:

15 examples, 0 failures, 9 pending


* Author

Built by @shamss17 for the WebOps Backend Developer Assessment