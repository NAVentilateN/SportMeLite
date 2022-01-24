# SportMe

A marketplace app that connects users and sports coaches.

## Description

Users of this app will be able to find and book lessons based on their preference for location, price and coach profile. Users have access to a responsive map which displays lessons based on these preferences. Users are also able to search for coach profiles, bookmark, review, and chat with coaches in real time.

Users can be coaches themselves, and gain access to additional features available to coaches. Coaches are able to create, edit and delete lessons with the use of an interactive calendar. Coaches signed in with googleauth are also able to interact with their personal google calendar. Coaches are also able to track their revenue from lessons and display them on charts.


## Getting Started

### Dependencies

* ruby v 2.7.4
* rails v 6.1.4
* bundle 
* yarn 


### Installing

##### 1. Check out the repository

```bash
git clone git@github.com:NAVentilateN/SportMeLite.git
```

##### 2. Install gems and Javascript dependencies

Copy the sample database.yml file and edit the database configuration as required.

```bash
yarn install
bundle install
```

##### 3. Create and setup the database

Run the following commands to create and setup the database.

```ruby
rails db:create
rails db:migrate
rails db:seed
```

##### 4. Start the Rails server

You can start the rails server using the command given below.

```ruby
rails server
```

And now you can visit the site with the URL http://localhost:3000

## Help



## Authors/Contributors

* [Valentine](https://github.com/NAVentilateN)
* [Liwen](https://github.com/suulightly)
* [Nicholas](https://github.com/chewonithard)
* [Daniel](https://github.com/chukulert)


## Acknowledgments

* [Light/Dark Mode switch](https://codepen.io/bheberer/pen/BaNZKmq)
