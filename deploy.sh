#!/bin/bash
figaro heroku:set -e production
heroku maintenance:on
git push heroku master
heroku run rake db:migrate
heroku maintenance:off
heroku restart
