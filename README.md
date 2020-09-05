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
    This is an api developed with rails in order to allow front end developers to access a backend with everything they need to start working in a simple and fast way.
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

This is an API to keep track of the incomings and expenses that a user makes, it can be by day, week, month or by category.
The main goal of this API is to let the front end developers set up a backend in a quick and easy way to start an building the app and getting data.

The main features of the API are:

- Admin user.
- Authentication via JTW Token for modification operations (create, update, destroy).
- Any user can access to the get data from the endpoints either balances or operations.
- Only a logged in user can perform operations to their own operations (create, update, destroy).
- Only an admin user cna perform operations to the balances, that are shared between all the users (create, update, destroy).

There are 3 models on this API:

- Users. It can be an admin or a normal user.
- Balances. This filed its like the categories, it can be, day, week, month or whatever you want.
- Operations. Each incoming or expense registered by a user.

Access permissions:

- Any user can access to the data, either balances or operations of any user.
- Only logged in users can perform operations over their own operations.
- Only admin users can perform operations over balances.

#### ERD Diagram

[![ERD Diagram][erd-diagram]](https://github.com/davitomix/balance-ctrl-api/)

### Documentation

The documentation was built using raddocs.
Please refer to it to further information.
You can find it here [docs :rocket:](https://bs-balance-ctrl-mx.herokuapp.com/api_docs)

### Built With

- Postman, Newman.
- Rails.
- JWT auth.
- Serialization.

<!-- GETTING STARTED -->

## Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites

This is an example of how to list things you need to use the software and how to install them.

- Rails 5.2.4
- Ruby 2.6.4
- Postman
- Newman 5.2.0

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

```
$ rails server
```

Install the HTTP client of your preference, I used [Postman](https://www.postman.com)

<!-- USAGE EXAMPLES -->

## Usage

#### Signup

<!-- ROADMAP -->

## Roadmap.

| TIMELINE |          TODO           |                                                                         DESCRIPTION                                                                         |              OUTCOME               | STATUS  |
| :------- | :---------------------: | :---------------------------------------------------------------------------------------------------------------------------------------------------------: | :--------------------------------: | :-----: |
| Day 1    | Deep into APIs in rails |                                      Obtain leads, knowledge and the syntax necessary for the development of the API.                                       | Understanding Rails API framework. | &#9745; |
| Day 2    |       API Design        | Design the ERD diagram of the API, set up the repository and tools, start building the basic functionality of the project and test the basics using Postman | Set objectives for remaining days. | &#9745; |
| Day 3    |     API Development     |                              API Development following the defined design, as well as add user authentication and unit testing                              |             API Logic              | &#9745; |
| Day 4    |       API Testing       |                                                           Do a thorough Test of the completed API                                                           |            API Testing             | &#9745; |
| Day 5    |    API Documentation    |                                                       API Documentation following the defined design                                                        |         API Documentation          | &#9745; |

---

<!-- AUTHORS -->

## Author

👤 **David Eli Martinez Garcia**

- Github: [@davitomix](https://github.com/davitomix)
- Linkedin: [linkedin](https://linkedin.com/linkedinhandle)

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
[erd-diagram]: /docs/balancectrlapi_erd.png
