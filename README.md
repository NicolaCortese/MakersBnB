# Makersbnb

Makersbnb is a web application in which users can interact with one another listing and booking available spaces.

## Getting Started

- Fork this repo
- Clone it to your local machine
- And presto you have it on your machine
- Ready to install

### Prerequisites

- You will need
- An IDE like "VSCode" https://code.visualstudio.com/
- Ruby vesion manager RVM https://rvm.io/rvm/install

### Installing

- Run the command "bundle" on your terminal to install all the gems necessary
- Now we are going to create the "makersbnb" database and the "makersbnb_test' database
- Enter the "PostgreSQL" terminal by running the command "psql" in your terminal
- Open the "db/migration" folder
- Open the "01_creating_databases.sql" file
- In your "PostgreSQL" terminal, run each line of code
- Next we are going to create the user table, space table and booking table for both the "makersbnb" and "makersbnb_test" databases.
- Open the "02_creating_user_tables.sql" file
- In your "PostgreSQL" terminal, run each line of code
- Open the "03_creating_spaces_table.sql" file
- In your "PostgreSQL" terminal, run each line of code
- Open the "04_creating_bookings_table.sql" file
- Run each line of code
- Exit "PostgreSQL" by running the command "\q" in the "PostgreSQL" terminal
- Presto! you are ready to use the web application.

## Running the tests

- To run the automated "RSpec" tests, in your teminal run the command "rspec"

## Deployment

- To deploy run the command "rackup" in your teminal
- <img width="534" alt="Screenshot 2022-03-25 at 15 17 06" src="https://user-images.githubusercontent.com/92959738/160151865-f09a7f1d-b0ca-4040-b39b-70dc6d3d113c.png">
- remember your 4 digit number "port", in my case 9292.
- In your web browser input "localhost:" followed by your "port" 4 digit number, in my case 9292.
- <img width="141" alt="Screenshot 2022-03-25 at 15 27 10" src="https://user-images.githubusercontent.com/92959738/160157116-fd2a9066-03e4-43e4-b12b-3d19c3db4f94.png">
- You should have the home page infront of you!

## Built With

- Sinatra http://sinatrarb.com/
- Active Record https://guides.rubyonrails.org/active_record_basics.html
- Ruby https://www.ruby-lang.org/en/
- Capybara https://teamcapybara.github.io/capybara/

---

## User stories

```
As a User
So that I can store my details
I want to be able to sign into Makersbnb
```

```
As a User
So that I know what properties I can rent
I want to see a list of properties
```

```
As a User with an account
So that I can let my property
I want to be able to list my property
```

```
As a User with multiple properties
So that I can let out all of them
I want to be able to list multiple properties
```

```
As a property owner
So that I can make my property stand out
I want to provide a short decription of the property
```

```
As a property owner
So that people can identify my property
I want to provide a name for it
```

```
As a renter
So that I know how much it costs to rent a bnb
I want a price listed with the property
```

```
As a property owner
So that users can see the availability of my property
I want list available dates
```

```
As a renter
So that I can rent the bnb for a night
I want to be able to request to book the bnb
```

```
As a property owner
So that I can select who rents my property
I want to be able to approve or deny a booking request
```

```
As a user
So that I don't book a date that is not available
I want to only see available dates
```

```
As a property owner
Until I have confirmed a booking
I want users to be able to send me requests to book for that same night
```

```
As a renter
So I know who I am renting from
I want to see who listed a property
```

```
As a property owner
So that I can track my properties
I want to be able to view all my listings
```

```
As a property owner
So that I can manage my listings
I want to be able to edit and delete my listings
```

```
As a renter
So that I know the status of my booking requests
I want to be able to see if I have  had my bookings confirmed
```

```
As a renter
So that I know what bookings I have
I want to be able to see a list of my bookings
```

## MVP

```
As a User
So that I can store my details
I want to be able to sign up to Makersbnb
```

```
As a user
So that I can manage bookings
I want to be able to sign in
```

```
As a User
So that I know what properties I can rent
I want to see a list of properties
```

```
As a User with an account
So that I can let my property
I want to be able to list my property
```

```
As a property owner
So that people can identify my property
I want to provide a name for it
```

```
As a renter
So that I know how much it costs to rent a bnb
I want a price listed with the property
```

```
As a renter
So that I can rent the bnb for a night
I want to be able to request to book the bnb
```

---

## Acknowledgments

- Ourselves, it was great to work as a team :D
