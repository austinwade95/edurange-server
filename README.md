# EDURange Documentation
## What is it?

EDURange is an NSF-funded project with the aim of building a platform for cloud-based interactive computer security exercises. 


## Developer Installation

To setup the developer server to run on your machine, there are five main steps.

1. Clone the repository from github
2. Install the rails and ruby packages necessary to run and manage EDURange 
  - RVM (Ruby Version Manager)
  - rails
  - rubygems
  - bundler
3. Create local settings for aws options.
  - In the config directory, copy settings.yml to settings.local.yml
  - Fill in blank fields in settings.local.yml with settings obtained from a developer
4. Add aws credentials to your machine's ENV variables.
5. Run the server, and create a new user

Please follow each step carefully. A small error will likely result in a rails environment that simply won't work. Contact a EDURange developer if you run into problems that you can't solve after google and a few tries.


####  I. Clone the git repository:
```
git clone https://github.com/edurange/edurange-server.git
```

####  II. Install RVM (Ruby Version Manager), rails, rubygems, and bundler

  Follow this guide: (https://rvm.io/rvm/install). This project uses Ruby 2.1.5 so use RVM to install and select the    correct   version of Ruby:
```
rvm install [ruby version number eg 2.2.1]
rvm use [ruby version number eg 2.2.1]
```

You may have to do something like: `bin/bash --login` in order to set the RVM ruby version (which doens't refer to the system ruby version).

Also, install bundler (to take care of gem dependencies) and the rails framework:

Debian/Ubuntu Linux:
```
sudo apt-get install rubygems
sudo apt-get install rails
sudo gem install bundler
```
Fedora/Red Hat Linux
```
sudo yum install rubygems
sudo yum install rubygem-{rails}
sudo gem install bundler
```

To finish up the installation, yank and update all the gem dependencies:
```
bundle update
bundle install
```

####  III. Contact the project aws administrator to get the credentials to place in your ENV variables.

Get your AWS\_ACCESS\_KEY_ID, AWS\_SECRET\_ACCESS\_KEY, and AWS\_REGION from your projects AWS administrator. Add the fields to your environment variables. A common way to do this is add the line below in ~/.bashrc and then reload the environment variables by running: ```source ~/.bashrc``` or by opening up a new terminal.

```
export AWS_ACCESS_KEY_ID='your-access-key-id'
export AWS_SECRET_ACCESS_KEY='you-secret-access-key'
export AWS_REGION='your-aws-region'
```


Now you should be all ready to start your server and create some users.

####  IV. Database and User setup

Edit the file "config/secrets.yml". Under 'development:' fill in "admin\_name", "admin\_email" and "admin\_password". Avoid using any spaces in those fields.

Now run ```rake db:setup```. This will create the database and admin account.

####  V. Run the server
  
You'll need to run the delayed jobs start script:
```
./delayed_job_start
```
Now bootup the developement server:
```
rails server
```
If you get a ruby version error, you might need to type 'rvm 2.2.1 [or current ruby version in Gemfile]'.
Point your web browser to localhost:3000 and you should see something like this:
![alt tag](http://i.imgur.com/2HR5k9K.jpg?1)

##### Booting a Scenario
Now that you have an admin user you can boot a scenario after some minor configurations. 

After doing that, go ahead and navigate to the "Scenarios" tab and load a new scenario. Choose from the default scenarios available. Once the scenario is loaded you should be brought to a detail view where you can boot the scenario.

##### Keeping things working
From time to time, you might find parts of your scenario stuck on "queued_boot". To fix this, run the delayed jobs
restart script.
```
./delayed_job_restart
```
After you pull changes from the github repository, if the database was changed you'll need to rake the database:
```
rake db:migrate
```
