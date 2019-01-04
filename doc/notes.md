# Run local postgres in docker:

    docker run --name some-postgres -p 5432:5432 -e POSTGRES_PASSWORD= -d postgres
    
## Create DB user if necessary
    
    $ psql -h localhost -U postgres
    # create role maintainit with createdb login password 'password'
    
# Environments

## LOCAL DEV

Run the `./script/build.sh` to execute rspec and cucumber tests.

Cucumber tests will execute in headless chrome by default. To run full chrome for visual inspection, use:

    `FULL_CHROME=true ./script/build.sh`
    
    
    
## TEST/STAGE

On merge to master, Codeship will automagically run tests and push to maintainit-test heroku app.

Assuming you named your git remote for test environment "herokutest"

    $ git remote -v    
    herokutest	https://git.heroku.com/maintainit-test.git (fetch)
    herokutest	https://git.heroku.com/maintainit-test.git (push)    
    
Then just push to herokutest master:

    git push herokutest master 
    
    heroku run rake db:migrate --app maintainit-test    
    
## PRODUCTION     

On merge to release, Codeship will automagically push to maintainit heroku app.

### Manually deploying to production


Assuming you named your git remote for test environment "heroku"

    $ git remote -v    
    heroku	https://git.heroku.com/maintainit.git (fetch)
    heroku	https://git.heroku.com/maintainit.git (push)

Then just push to heroku master:

    git push heroku master 
    
    heroku run rake db:migrate --app maintainit
    
# Annotating Models

Using the annotate gem from ctran. After changing models, execute:

`annotate --exclude tests,fixtures,factories,serializers`    
