# URLockBox

### What is it?

This is part one of the Mod 4 final project. It a is a rails application that uses ajax and client-side logic to store bookmarked links. It has has the following features:

* Authentication with bcrypt
* Ability to submit links without reloading the page
* Ability to mark links as read or unread
* Url validation for links
* Ability to edit existing links
* Ability to filter links by text, read and unread

In addition to these features, URLockbox communicates with a service application called HotReads. HotReads tracks when links are marked as read and ranks them by popularity. If a link is in the top ten most read links, ranked by HotReads, it will have special styling when viewed on URLockbox. The single most read link will also have styling of its own.

### Links and Repos:

* [URLockBox Production](https://secret-ocean-16532.herokuapp.com)
* [HotReads Production](https://ndj-hot-reads.herokuapp.com/)
* [HotReads Repo](https://github.com/NicholasJacques/hot_reads)

### Setup:

URLock box is built with:

* `Rails v5.0.0`
* `Ruby v2.3.1`

To install this application:

```bash
$ git clone git@github.com:NicholasJacques/URLockbox.git
$ cd URLockbox
$ bundle install
$ rake db:create
$ rake db:migrate
```

To run the tests you will need to have Mozilla Firefox v46 installed.
Testing suite uses RSpec, Capybara and Selenium Webdriver.

Run tests with:
```bash
$ rspec
```

### Author
Nicholas Jacques