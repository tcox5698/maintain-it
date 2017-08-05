# Run local postgres in docker:

    docker run --name some-postgres -e POSTGRES_PASSWORD=password -d postgres
    
# Run local host-installed postgres:
    
    postgres -D /Users/thomascox/dev/postgres_data
    
## Create DB user if necessary
    
    su - postgres
    
Then create a user (or a "role", as Postgres calls it):
    
    create role maintainit with createdb login password 'password';
    
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