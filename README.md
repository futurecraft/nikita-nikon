###### Nikita Nikon's test task for N26
### Description

Simple Ruby-driven framework to verify API endpoints work as expected:
Cucumber is used as DSL - see feature files for test cases designed in Gherkin.
I was focused on covering 'happy paths', verifying that CRUD operations work as expected 
for all entities: store (orders), users, pets.
FactoryBot is used to create unique test entities and avoid hardcoding test data.
OpenStruct Config is used to store settings.
Warehouse module is responsible for storing / retrieving test data.
Custom API wrappers are dealing with Microservice endpoints - StoreAPI, UserAPI, PetAPI.
All test entities are deleted from API after test run not to clutter the env. 
RAKE is used to invoke tests.
Dockerfile includes settings to execute tests in docker container.

Feel free to lurk through files - most of them include descriptive comments. 

### Docker execution

This framework is designed to be executed against localhost. 
First I wanted it to hit https://petstore3.swagger.io directly,
but lots of endpoints there are broken.
So, first you'll have to deploy the MS locally:

`docker pull swaggerapi/petstore3:unstable`

`docker run  --name swaggerapi-petstore3 -d -p 8080:8080 swaggerapi/petstore3:unstable`

Then clone this framework and execute the following from project folder:

`docker build -t petstoredemo .`
  
To execute the tests within the container (against MS on your localhost) run the following:

`docker run --network="host" petstoredemo rake 'run_cukes[all]'`

**'run_cukes'** raketask invokes the tests and accepts the following params:
- **all** - executing all tests
- **user** - executing only user tests
- **pet** - executing only pet tests
- **store** - executing only store tests

After the test is executed you can retrieve the HTML report from the docker container.
Now export it to your local filesystem by executing:

`docker cp wonderful_goldberg:/app/results/reports/cukes_report_28.03_15:42:12.html /path/in/your/local/filesystem`

where
- `'wonderful_goldberg'` is the name of the container (use 'docker ps -a' to find out yours)
- `'/app/results/reports/cukes_report_28.03_15:42:12.html'` is a path to the report. After running the tests, search console output for 'REPORT PATH' (in the beginning of output)
- `'/path/in/your/local/filesystem'` is a path you want to save the report (e.g. /Users/username/Desktop)
