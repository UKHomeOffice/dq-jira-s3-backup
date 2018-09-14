module.exports = {
  apps : [
    {
    	name	: "Jira-bacup-to-s3",
	   	script	: "/scripts/s3-backup.sh",
    	exec_interpreter: "bash",
    	env: {
    	  START_HOUR_1: 06,
    	  START_HOUR_2: 18,
    	  DATABASE_HOST: process.argv[5],
    	  DATABASE_NAME: process.argv[6],
    	  PGPASSWORD: process.argv[7],
    	  DATABASE_PORT: process.argv[8],
    	  DATABASE_USERNAME: process.argv[9],
    	  BUCKET_NAME: process.argv[10],
    	  AWS_ACCESS_KEY_ID: process.argv[11],
    	  AWS_SECRET_ACCESS_KEY: process.argv[12]
    	}
    }
  ]
}
