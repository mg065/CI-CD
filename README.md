# CI-CD
Repository for AWS Code Commit  Code Deploy and Code pipeline for CI-CD implementation, also bash scripts for personal CI-CD setups without external services.

First Step:
 Run the below command in the linux machine to define your application path

For BASH: 
$ echo APP_PATH="path-goes-here" >> ~/.bashrc

For ZSH:
$ echo APP_PATH="path-goes-here" >> ~/.zshrc

Run the scripts with arguments.

For Deployment e.g: 
$ sudo bash deploy-testing.sh <env> >> deployment.logs 
  
For Commmit reset e.g:
WRT Time:
  $ sudo bash commit-reset.sh <env> time <reset_type(soft/hard/mixed)> <time_unit1> <time_unit2> >> ~/scripts/commit-reset.logs
  $ awk 'FNR <= 25' ~/scripts/commit-reset.logs 

WRT Commit id:
  $ sudo bash commit-reset.sh <env> commit_id <reset_type(soft/hard/mixed)> <commit_id> >> ~/scripts/commit-reset.logs
  $ awk 'FNR <= 25' ~/scripts/commit-reset.logs 

For Testing/Staging, deployment takes place by handling scenarios.
For production, script will create a new backup branch with date and followed by completing the deployment.
 
WRT env:
  $ bash ~/scripts/deploy-testing.sh env >> ~/scripts/deployment.logs; tail -n 25 ~/scripts/deployment.logs 

  
  
