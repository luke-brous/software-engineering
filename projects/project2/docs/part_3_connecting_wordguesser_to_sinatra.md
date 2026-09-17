# Part 3: Connecting WordGuesserGame to Sinatra
You've already met Sinatra.  Here's what's new in the Sinatra app skeleton [`app.rb`](../app.rb) that we provide for Wordguesser:

* `before do...end` is a block of code executed *before* every SaaS request

* `after do...end` is executed *after* every SaaS request

* The calls  `erb :` *action* cause Sinatra to look for the file `views/`*action*`.erb` and run them through the Embedded Ruby processor, which looks for constructions `<%= like this %>`, executes the Ruby code inside, and substitutes the result.  The code is executed in the same context as the call to `erb`, so the code can "see" any instance variables set up in the `get` or `post` blocks.

#### Self Check Question

<details>
  <summary><code>@game</code> in this context is an instance variable of what
class?  (Careful-- tricky!)</summary>
  <p><blockquote>It's an instance variable of the <code>WordGuesserApp</code> class in the app.rb file.  Remember we are dealing with two Ruby classes here: the <code>WordGuesserGame</code> class encapsulates the game logic itself (that is, the Model in model-view-controller), whereas <code>WordGuesserApp</code> encapsulates the logic that lets us deliver the game as SaaS (you can roughly think of it as the Controller logic plus the ability to render the views via <code>erb</code>).</blockquote></p>
</details>

The Session
-----------

We've already identified the items necessary to maintain game state, and encapsulated them in the game class.  Since HTTP is stateless, when a new HTTP request comes in, there is no notion of the "current game".  What we need to do, therefore, is save the game object in some way between requests.

If the game object were large, we'd probably store it in a database on the server, and place an identifier to the correct database record into the cookie.  (In fact, as we'll see, this is exactly what Rails apps do.)  But since our game state is small, we can just put the whole thing in the cookie.  Sinatra's `session` library lets us do this: in the context of the Sinatra app, anything we place into the special "magic" hash `session[]` is preserved across requests.  In fact, objects placed there are *serialized* into a text-friendly form that is preserved for us.  This behavior is switched on by the Sinatra call `enable :sessions` in `app.rb`.

There is one other session-like object we will use.  In some cases above, one action will perform some state change and then redirect to another action, such as when the Guess action (triggered by `POST /guess`) redirects to the Show action (`GET /show`) to redisplay the game state after each guess.  But what if the Guess action wants to display a message to the player, such as to inform them that they have erroneously repeated a guess?  The problem is that since every request is stateless, we need to get that message "across" the redirect, just as we need to preserve game state "across" HTTP requests.

To do this, we use the `sinatra-flash` gem, which you can see in the Gemfile.  `flash[]` is a hash for remembering short messages that persist until the *very next* request (usually a redirect), and are then erased.

#### Self Check Question

<details>
  <summary>Why does this save work compared to just storing those
messages in the <code>session[]</code> hash?</summary>
  <p><blockquote>When we put something in <code>session[]</code> it stays there until we delete it.  The common case for a message that must survive a redirect is that it should only be shown once; <code>flash[]</code> includes the extra functionality of erasing the messages after the next request.</blockquote></p>
</details>

Running the Sinatra app
-----------------------

As before, run the shell command `bundle exec rackup --port 3000` to start the app, or `bundle exec rerun --background -- rackup --port 3000` if you want to rerun the app each time you make a code change.

#### Self Check Question

<details>
  <summary>Based on the output from running this command, what is the full URL you need to visit in order to visit the New Game page?</summary>
  <p><blockquote>The Ruby code <code>get '/new' do...</code> in <code>app.rb</code> renders the New Game page, so the full URL is in the form <code>http://localhost:3000/new</code></p>
</details>
<br />

Visit this URL and verify that the Start New Game page appears.

#### Self Check Question

<details>
  <summary>Where is the HTML code for this page?</summary>
  <p><blockquote>It's in <code>views/new.erb</code>, which is processed into HTML by the <code>erb :new</code> directive.</blockquote></p>
</details>
<br />

Verify that when you click the New Game button, you get an error.  This is because we've deliberately left the `<form>` that encloses this button incomplete: we haven't specified where the form should post to. We'll do that next, but we'll do it in a test-driven way.

Deploying to Render
----------
Before making significant changes to the starter code, deploy it in its current state. This gives you a working production baseline and confirms that your GitHub and Render accounts are configured correctly.

## 1. Prepare the local Git repository

Open a terminal, navigate to the project directory, and install the required gems:

```bash
bundle install
```

Initialize a Git repository and commit the starter code:

```bash
git init
git add .
git commit -m "Prepare starter code for deployment"
git branch -M main
```

The `bundle install` command also creates or updates `Gemfile.lock`. Make sure `Gemfile.lock` is included in your commit.

## 2. Create a GitHub repository

On GitHub:

1. Click **New repository**.
2. Give the repository a name, such as `cs457-project2-wordguesser`.
3. Set its visibility to **Private**.
4. Do **not** add a README, `.gitignore`, or license. The repository should be empty.
5. Click **Create repository**.

On the new repository’s page, click **Code**, select **HTTPS**, and copy the repository URL.

Connect your local repository to GitHub, replacing `[HTTPS_URL]` with the URL you copied:

```bash
git remote add origin [HTTPS_URL]
git push -u origin main
```

Your code should now appear on GitHub.
## 3. Deploy the application on Render

[Sign in to Render](https://render.com) using your GitHub account. When prompted, give Render permission to access your private repository.

From the Render dashboard:

1. Select **New → Web Service**.
2. Choose your `cs457-project2-wordguesser` GitHub repository.
3. Configure the service:

   - **Name:** Choose a unique name. It will become part of the application’s public URL.
   - **Language:** Ruby
   - **Branch:** `main`
   - **Build Command:** `bundle install`
   - **Start Command:** `bundle exec rackup config.ru --host 0.0.0.0 --port $PORT`
   - **Instance Type:** Free

4. Click **Create Web Service** or **Deploy Web Service**.

Render will clone the repository, install its gems, start the application, and assign it a public URL similar to:

```text
https://your-service-name.onrender.com
```

Follow the deployment progress in Render’s logs. When the deployment finishes, open the public URL and verify that the application loads.

Test the deployed application before continuing:

- Confirm that it behaves the same as your local version.
- Click **New Game** and confirm the existing broken functionality that you will repair in this assignment.

## 4. Create your development branch

Now that the starter application is safely committed and deployed from `main`, create a branch for your assignment work:

```bash
git switch -c cs457-project2
git push -u origin cs457-project2
```

Make all assignment changes on this branch. As you work, save checkpoints with:

```bash
git add .
git commit -m "Describe the changes made"
git push
```

Pushing this branch saves your work on GitHub, but it does not change the deployed application. Render will continue deploying from `main`.

## 5. Create and merge a pull request

After completing and testing the assignment, push your latest commits:

```bash
git push
```

Then create a pull request on GitHub:

1. Open your repository on GitHub.
2. Click **Pull requests**.
3. Click **New pull request**.
4. Set the branches as follows:
   - **Base:** `main`
   - **Compare:** `cs457-project2`
5. Review the changes shown by GitHub.
6. Click **Create pull request**.
7. Enter a descriptive title and briefly summarize the changes you made.
8. Click **Create pull request** again.
9. After the pull request has been reviewed and all automated tests pass, click **Merge pull request**.
10. Click **Confirm merge**.

Merging the pull request adds the work from `cs457-project2` to `main`.

## 6. Verify the new deployment

Render monitors the `main` branch. After the pull request is merged, Render will automatically detect the update and deploy the new version. No separate Render command is required.

After the deployment finishes:

1. Check the Render logs for errors.
2. Open the public application URL.
3. Test the application’s important features.
4. Confirm that the deployed application behaves the same as your local version.

Before beginning additional work, update your local `main` branch:

```bash
git switch main
git pull
```

If you need another development branch for future work, create it from the updated `main` branch:

```bash
git switch -c new-branch-name
git push -u origin new-branch-name
```
---

Next: [Part 4 - Cucumber](part_4_cucumber.md)