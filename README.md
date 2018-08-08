# Project Installation

1. Ruby 2.3.7, Rails 5.2.0 and SQL Server database.

2. Install your dependencies with the command:

```
$ bundle install
```

3. Creates the database for the application with the command:

```
$ rake db:setup

### Execution

1. Run the installed server with the command:
  
```
$ rails server
```

#### Available resources

The following resources are available for API consumption:

##### Individual Resource

###### Access Points

```
Métodos                URI
GET                    /v1/physical_people
POST                   /v1/physical_people
GET                    /v1/physical_people/:id
PATCH                  /v1/physical_people/:id
PUT                    /v1/physical_people/:id
```

###### JSON Valid

```
{
    "physical_people":  {
        "id": 1,
        "cpf": "55690177872",
        "name": "Ms. Dodie Lindgren",
        "birthdate": "2018-08-05",
        "created_at": "2018-08-06T21:58:18.141Z",
        "updated_at": "2018-08-06T21:58:18.141Z"
    }
}
```
###### Validations

:cpf 

* Must be present
* Must be numeric
* Must be 11 characters.

:nome:

* Must be present

:birthdate

* Must be present

##### Legal Entity Resource

###### Access Points

```
Métodos                URI
GET                    /v1/legal_people
POST                   /v1/legal_people
GET                    /v1/legal_people/:id
PATCH                  /v1/legal_people/:id
PUT                    /v1/legal_people/:id
```

###### JSON Valid

```
{
    "lega_people": {
        "id": 1,
        "cnpj": "99074624783199",
        "company_name": "Smitham, Ondricka and Baumbach",
        "fantasy_name": "Satterfield-Waters",
        "created_at": "2018-08-06T21:58:22.266Z",
        "updated_at": "2018-08-06T21:58:22.266Z"
    }
}
```
:CNPJ

* Must be present
* Must be numeric
* Must be 14 characters

: company_name

* Must be present

:fantasy_name

* Must be present

##### Account Feature

###### Access Points

```
Métodos                URI
GET                    /v1/accounts
POST                   /v1/accounts
GET                    /v1/accounts/:id
PATCH                  /v1/accounts/:id
PUT                    /v1/accounts/:id
DELETE                 /v1/accounts/:id
```

###### JSON Valid

```
{
    "account": {
        "id": 1,
        "name": "Carlton Cartwright Jr.",
        "balance": "320.0",
        "status": "active",
        "person_type": "LegalPerson",
        "person_id": 6,
        "created_at": "2018-08-06T21:58:33.018Z",
        "updated_at": "2018-08-06T23:22:23.573Z",
        "ancestry": null
    }
}

```

###### Validations

:name

* Must be present

:balance

* Must be present
* Must be numeric

:status

* Must be present
* Must be "cancelled", "active" or "blocked"

: person_type

* Must be present
* Must be "PhysicalPerson" or "LegalPerson"
        
:ancestry

* When informed must be a number of an account already registered.

##### Transaction Feature

###### Access Points


```
Métodos                URI
GET                    /v1/transactions
POST                   /v1/transactions
GET                    /v1/transactions/:id
```

###### JSON Valid

```
{
  "transaction":{
        "id": 1,
        "transaction_type": "charge",
        "value": "100.0",
        "origin_account_id": 1,
        "origin_account_before_transaction": "100.0",
        "destination_account_id": 5,
        "destination_account_before_transaction": "0.0",
        "created_at": "2018-08-06T22:01:55.729Z",
        "updated_at": "2018-08-06T22:01:55.729Z"
    }
}


{
  "transaction": {
        "id": 14,
        "transaction_type": "transfer",
        "value": "100.0",
        "origin_account_id": 1,
        "origin_account_before_transaction": "320.0",
        "destination_account_id": 5,
        "destination_account_before_transaction": "0.0",
        "created_at": "2018-08-06T23:12:14.805Z",
        "updated_at": "2018-08-06T23:13:37.930Z"
    }
}

```

##### Validations

:transaction_type

* Must be present
* Must be "charge", "transfer"

:value

* When transaction of type "charge" or "transfer" must have a value greater than 0

: origin_account_id

* Must be present when transaction is of type "load" or "transfer"

: destination_account_id

* Must be present when transaction is of the "transfer" type

## Tests
    
1. Quantifying the tests

    3.1 In this version of the project there are 35 tests available:

    ```
		Testing the controllers.
    Tests on models.
    ```
    
### Running the tests

1. To execute the tests, execute the following command:

    ```
    $ rspec spec
    ```