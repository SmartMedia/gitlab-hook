# GitLab Hook
* If you're missing GitHub Twitter hook when using GitLab, you just found a solution.

## Installation
* Clone this repository: `git clone git@github.com:SmartMedia/gitlab-hook.git`
* Create Heroku Cedar application: `heroku create <APP_NAME> --stack cedar`
* Setup variables `heroku config:add SHORTENER_HOSTNAME='http://<APP_NAME>.heroku.com' SHORTENER_ACCESS_TOKEN='' TWITTER_CONSUMER_KEY='' TWITTER_CONSUMER_SECRET='' TWITTER_OAUTH_TOKEN='' TWITTER_OAUTH_TOKEN_SECRET=''`
* If you want to test localy, setup the same variables used by application in all `*.yml` files in `config` directory.

## GitLab
* Open your project.
* Select _Hooks_ tab.
* Fill out URL of your Heroku app with `access_token` parameter. (eg. __http://<APP_NAME>.herokuapp.com/?access_token=<SHORTENER_ACCESS_TOKEN__)
* Press _"Test Hook"_
* Enjoy your Twitter timeline.