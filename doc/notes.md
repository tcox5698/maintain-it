# Run local postgres in docker:

    docker run --name some-postgres -e POSTGRES_PASSWORD=mysecretpassword -d postgres
    
# Run local host-installed postgres:
    
    postgres -D /Users/thomascox/dev/postgres_data/Users/thomascox/dev/postgres_data
    
## Create DB user if necessary
    
    su - postgres
    
Then create a user (or a "role", as Postgres calls it):
    
    create role maintainit with createdb login password 'password';
    
# Deploying to Test

Assuming you named your git remote for test environment "herokutest"

    git push herokutest master 
    
    heroku run rake db:migrate --app maintainit-test
    
# Environments
    
## TEST

    $ git remote -v    
    herokutest	https://git.heroku.com/maintainit-test.git (fetch)
    herokutest	https://git.heroku.com/maintainit-test.git (push)    