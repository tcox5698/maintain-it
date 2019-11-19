# Set up the postgres database 

    $ ./script/bootstrap_db.sh
    
# Environments

## LOCAL DEV

Run the `./script/build.sh` to execute rspec and cucumber tests.

Cucumber tests will execute in headless chrome by default. To run full chrome for visual inspection, use:

    `FULL_CHROME=true ./script/build.sh`
    
    
    
## TEST/STAGE

On merge to master, Codeship will automagically run tests and push to maintainit-test heroku app.

### if codeship breaks down, manual steps here

Assuming you named your git remote for test environment "herokutest"

    $ git remote -v    
    herokutest	https://git.heroku.com/maintainit-test.git (fetch)
    herokutest	https://git.heroku.com/maintainit-test.git (push)    
    
Then just push to herokutest master:

    git push herokutest master 
    
    heroku run rake db:migrate --app maintainit-test    
    
## PRODUCTION     

Heroku pipeline "maintain-it-pipeline" provides a single click promotion from the test app to the production app.

https://dashboard.heroku.com/apps

### Manually deploying to production (if heroku pipeline breaks down)

Assuming you named your git remote for test environment "heroku"

    $ git remote -v    
    heroku	https://git.heroku.com/maintainit.git (fetch)
    heroku	https://git.heroku.com/maintainit.git (push)

Then just push to heroku master:

    git push heroku master 
    
    heroku run rake db:migrate --app maintainit
    
## Tasks and DB

### Access db

`heroku pg:psql --app maintainit-test`

### Run rake tasks

`heroku run rake chores:schedule --app maintainit-test`    
    
# Annotating Models

Using the annotate gem from ctran. After changing models, execute:

`annotate --exclude tests,fixtures,factories,serializers`    

