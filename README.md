# GitLab Hook
* If you're missing GitHub Twitter hook when using GitLab, you just found a solution.

## Installation

### Twitter
* Log into https://dev.twitter.com/apps
* Click on _Create a new application_.
* Fill out everything needed and click on _Create your Twitter application_.
* Now in _Settings_ tab, set _Access:_ to _Read and Write_ and save it.
* Keep this page open or copy all the tokens and keys from _Details_ tab. You'll need them in a while.

### Bit.ly
* If you don't have account on bit.ly, create one.
* Log into your account, and copy your __Api Key__ from _Settings_ tab.

### Your computer
* Clone this repository: `git clone git@github.com:SmartMedia/gitlab-hook.git`
* Create Heroku Cedar application: `heroku create <APP_NAME> --stack cedar`
* Setup variables based on your _Twitter Details_ and _Bitly Settings_ tab:
* For `GITLAB_ACCESS_TOKEN` use some random string.

```bash
heroku config:add \
GITLAB_ACCESS_TOKEN='' \
BITLY_USERNAME='' \
BITLY_API_KEY='' \
TWITTER_CONSUMER_KEY='' \
TWITTER_CONSUMER_SECRET='' \
TWITTER_OAUTH_TOKEN='' \
TWITTER_OAUTH_TOKEN_SECRET=''
```

* Put your 
* If you want to test localy, setup the same variables used by application in all `*.yml.erb` files in `config` directory.
* `git push heroku`

### GitLab
* Open your project.
* Select _Hooks_ tab.
* Fill out URL of your Heroku app with `access_token` parameter.
(eg. `http://<APP_NAME>.herokuapp.com/?access_token=<GITLAB_ACCESS_TOKEN>`)
* Press _"Test Hook"_
* Enjoy your Twitter timeline.

### Setting this hook for every project in GitLab
* SSH to your GitLab server. Navigate to gitlab directory and run `rails c production`

```ruby
 # If you already have this hook on some project, you can use url = WebHook.first.url
url = 'http://<APP_NAME>.herokuapp.com/?access_token=<GITLAB_ACCESS_TOKEN>'
Project.all.each do |project|
  project.web_hooks << WebHook.create(url: url) if project.web_hooks.empty?
end
```
