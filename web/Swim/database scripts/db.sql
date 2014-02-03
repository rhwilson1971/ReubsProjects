create table swim_user
(
	swim_user_ID INTEGER NOT NULL AUTO_INCREMENT,
	first_name VARCHAR(200) not null,
	last_name VARCHAR(200) not null,
	password VARCHAR(50) not null,
	is_active INTEGER,
	is_admin INTEGER,
	PRIMARY KEY (swim_user_ID)
);

create table swim_user_profile
(
	swim_user_profile_id INTEGER NOT NULL AUTO_INCREMENT,
	swim_user_id INTEGER NOT NULL,
	height INTEGER NOT NULL,
	weight INTEGER NOT NULL,
	base_heart_rate INTEGER,
	age INTEGER,
	dob DATETIME,
	PRIMARY KEY (swim_user_profile_id),
	CONSTRAINT fk_UserProfile FOREIGN KEY (swim_user_id) REFERENCES swim_user(swim_user_id)
);

create table swim_user_goal
(
	swim_user_goal_id INTEGER NOT NULL AUTO_INCREMENT,
	swim_user_id INTEGER NOT NULL,
	goal_weight INTEGER not null,
	date_start DATETIME not null,
	date_end DATETIME not null,
	PRIMARY KEY (swim_user_goal_id),
	CONSTRAINT fk_UserUserGoal FOREIGN KEY (swim_user_id) REFERENCES swim_user(swim_user_id)
);

create table swim_user_audit
(
	swim_user_audit_id INTEGER NOT NULL AUTO_INCREMENT,
	swim_user_id INTEGER NOT NULL,
	last_login_date DATETIME NOT NULL,
	
);

create table swim_execises
(
	swim_exercise_id INTEGER NOT NULL AUTO_INCREMENT,
	name varchar(200) NOT NULL,
	PRIMARY KEY (swim_exercise_id)
);

create table swim_meals(
	swim_meal_id INTEGER NOT NULL AUTO_INCREMENT,
	name varchar(200) NOT NULL,
	PRIMARY KEY (swim_meal_id)
);

create table swim_exercise_journal(

	swim_exercise_journal_id INTEGER NOT NULL AUTO_INCREMENT,
	swim_exercise_id INTEGER NOT NULL,
	duration integer not null,
	time_performed DATETIME NOT NULL,
	
	PRIMARY KEY (swim_exercise_journal_id),
	
	CONSTRAINT fk_ExercisesJournal FOREIGN KEY (swim_exercise_id) REFERENCES swim_exercises(swim_exercise_id)
);

create table swim_meals_journal(
	
	swim_meal_journal_id INTEGER NOT NULL AUTO_INCREMENT,
	swim_meal_id INTEGER NOT NULL,
	meal_time DATETIME NOT NULL,
	
	calories INTEGER NOT NULL,
	
	PRIMARY KEY (swim_meal_journal_id),
	
	CONSTRAINT fk_MealsJournal FOREIGN KEY (swim_meal_id) REFERENCES swim_meals(swim_meal_id)
);

