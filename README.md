<!--
*** Thanks for checking out this README Template. If you have a suggestion that would
*** make this better, please fork the repo and create a pull request or simply open
*** an issue with the tag "enhancement".
*** Thanks again! Now go create something AMAZING! :D
***
***
***
*** To avoid retyping too much info. Do a search and replace for the following:
*** github_username, repo_name, twitter_handle, email
-->
<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/davitomix/balance-ctrl-api">
    <img src="https://raw.githubusercontent.com/euqueme/toy-app/master/app/assets/images/mLogo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Balance Control API</h3>

  <p align="center">
    This is an API developed with rails in order to allow front end developers to access a backend with everything they need to start working in a simple and easy way.
    Some of the main features are: Admin user, Login, Sign Up, Token authentication, Serialization.
    For more further information please refer to the docs.
    <br />
    <br />
    <a target="_blank" href="https://bs-balance-ctrl-mx.herokuapp.com/api_docs"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    ·
    <a target="_blank" href="https://github.com/davitomix/balance-ctrl-api/issues">Report Bug</a>
    ·
    <a target="_blank" href="https://github.com/davitomix/balance-ctrl-api/issues">Request Feature</a>
  </p>
</p>

<!-- TABLE OF CONTENTS -->

## Table of Contents

- [About the Project](#about-the-project)
  - [Built With](#built-with)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)
- [Acknowledgements](#acknowledgements)

<!-- ABOUT THE PROJECT -->

## About The Project

[![Balance Control API][product-screenshot]](https://github.com/davitomix/balance-ctrl-api/)

This is an API to keep track of the incomings and expenses that a user makes.
The main goal of this API is to allow front-end developers to set up a backend in a quick and easy way in order to start consuming data and focus on the application client side logic not in the back.
Also, it is a good option to have a server running locally for the development stage, in this way you ensure that the access points are reliable and fast.

The main features of this API are:

- Admin user.
- Authentication via JWT Tokens restricting access to mutable data operations (create, update, destroy).
- Any user can get access to data from the endpoints either balances or operations.
- Only a logged in user can perform operations to their own operations (create, update, destroy).
- Only an admin user can perform operations to the balances, that are shared between all the users (create, update, destroy).

There are 3 type of object models on this API:

- Users. It can be an admin or a normal user.
- Balances. This field is like a categories switcher, in this case balances.
- Operations. Each incoming or expense registered by a user.

Access permissions:

- Any user can access to the data, either balances or operations of any user.
- Only logged in users can perform operations over their own operations.
- Only admin users can perform operations over balances.

#### ERD Diagram

[![ERD Diagram][erd-diagram]](https://github.com/davitomix/balance-ctrl-api/)

### Documentation

The documentation was built using raddocs.
<br />
<br />
[Documentation :rocket:](https://bs-balance-ctrl-mx.herokuapp.com/api_docs)

### Requierements

[Requierements :rocket:](https://www.notion.so/Final-Capstone-Project-Tracking-App-backend-only-variant-e943f483f1054e01b80d5bfc69c6cea9)

### Built With

- Postman, Newman.
- Rails.
- JWT auth.
- Serialization.

<!-- GETTING STARTED -->

### Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites

- Rails 5.2.4
- Rspec 3.9
- Ruby 2.6.4
- Newman 5.2.0
- npm 6.14.7

### Setup

To get started with the app, clone the repo and then install the needed gems:

```ruby
$ bundle
```

Next, migrate the database:

```ruby
$ rails db:migrate
```

Then, make some moc data to interaction:

```ruby
$ rails db:seed
```

Finally, run the test suite to verify that everything is working correctly:

```ruby
$ bundle exec rspec
```

If the test suite passes, you'll be ready to run the app in a local server:

```ruby
$ rails s
```

Install the HTTP client of your preference, I used [Postman](https://www.postman.com)

<!-- USAGE EXAMPLES -->

## Usage

### Newman - Postsman

Get the postman collection and environment from

```
./app/assets/docs/newman
```

#### Setting up newman CLI.

```sh
npm install -g newman
```

#### Running newman collections.

There are 4 cases collections, all of them try to perform the following operations over the balances and operations endpoints:

- GET
- POST
- PUT
- DELETE

The 4 cases are:

- Login as an admin user.
- Login as user.
- Signup new user.
- No logged in user.

After start the rails server, run:

LOGIN ADMIN COLLECTION

```sh
newman run ./app/assets/docs/newman/api-test-local-admin-login.postman_collection.json -e ./app/assets/docs/newman/bal-ctrl-api.postman_environment.json -n 2
```

<p align="center">
  <a href="#">
    <img src="./app/assets/images/admin-user.png" alt="Logo">
  </a>
</p>

LOGIN USER COLLECTION

```sh
newman run ./app/assets/docs/newman/api-test-local-user-login.postman_collection.json -e ./app/assets/docs/newman/bal-ctrl-api.postman_environment.json -n 2
```

<p align="center">
  <a href="#">
    <img src="./app/assets/images/login.png" alt="Logo">
  </a>
</p>

SIGN UP COLLECTION

```sh
newman run ./app/assets/docs/newman/api-test-local-user-signup.postman_collection.json -e ./app/assets/docs/newman/bal-ctrl-api.postman_environment.json -n 2
```

<p align="center">
  <a href="#">
    <img src="./app/assets/images/signup.png" alt="Logo">
  </a>
</p>

NOT AUTH USER COLLECTION

```sh
newman run ./app/assets/docs/newman/api-test-local-no-login.postman_collection.json -e ./app/assets/docs/newman/bal-ctrl-api.postman_environment.json -n 2
```

<p align="center">
  <a href="#">
    <img src="./app/assets/images/noauth.png" alt="Logo">
  </a>
</p>

The parameter "-n X" indicates the number of iterations.

<!-- ROADMAP -->

## Roadmap.

| TIMELINE | TODO                    | DESCRIPTION                                                                                                                                                           | OUTCOME                                        | STATUS  |
| -------- | ----------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------- | ------- |
| Day 1    | Deep into APIs in rails | Tutorials, articles, videos about APIS on Rails. Understanding database connections and requirements.                                                                 | Setup APi & ERD.                               | &#9745; |
| Day 2    | API Design              | Implement the ERD diagram of the API, set up the repository and tools, start building the basic functionality of the API and test the endpoints with Postman. Deploy. | Implement JWT                                  | &#9745; |
| Day 3    | API Development         | Added JWT to all actions, refactoring code to given requierements following TDD flow. Restricting access of certain operations.                                       | Verify behavior, setup collections on Postman. | &#9745; |
| Day 4    | API Testing             | Checking API responses on postman collections, add serialization, implementation of CORS.                                                                             | API Docs                                       | &#9745; |
| Day 5    | API Documentation       | Added documentation, finished Postman tests collections, tested API on production heroku.                                                                             | -                                              | &#9745; |

<!-- AUTHORS -->

## Author

👤 **David Martínez**

- Github: [@davomartinez-dev](https://github.com/davomartinez-dev)
- LinkedIn: [David Martinez.](https://www.linkedin.com/in/davidelimartinez/)

<!-- CONTRIBUTING -->

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](https://github.com/davitomix/balance-ctrl-api/issues/).

## Show your support

Give a ⭐️ if you like this project!

<!-- ACKNOWLEDGEMENTS -->

## Acknowledgements

- [Microverse](https://www.microverse.org/)
- [Heroku](https://www.heroku.com/)
- [The Best readme Template](https://github.com/othneildrew/Best-README-Template)
- [Austin Kabiru](https://scotch.io/tutorials/build-a-restful-json-api-with-rails-5-part-one)
- [A D Vishnu Prasad](https://advishnuprasad.com/blog/2016/02/07/api-docs-using-rspecs/)
- [How to document REST APIs with Swagger and Ruby on Rails](https://medium.com/@sushildamdhere/how-to-document-rest-apis-with-swagger-and-ruby-on-rails-ae4e13177f5d)

<!-- LICENSE -->

## 📝 License

This project is [MIT](https://opensource.org/licenses/MIT) licensed.

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[product-screenshot]: /app/assets/images/logo_transparent.png
[erd-diagram]: /app/assets/docs/BalanceCtrlAPI_ERD.png
