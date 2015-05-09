#Like this (or like that)

##Contents

Simple voting tool to build consensus among a team where indecision threatens action. Nominate items and liberally cast votes upon this or that. 

Use cases included:
- Deciding what to order for dinner
- Where to go for an outing
- What time to do something

Use consensus to bootstrap the items within the database or flatten votes to 0 (requires a majority or over 50% of users). 

##Setup

Currently only avaliable locally in beta. 

``` 
git clone https://github.com/Tkwon123/like_this.git
cd like_this
rails s
```

Also fully deployable with [heroku](www.heroku.com)

```
cd like_this
git init
git push heroku master
heroku run rake db:reset
heroku run rake db:migrate
```
