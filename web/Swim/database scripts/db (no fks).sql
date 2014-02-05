create table swim_users
(
    swim_user_id INTEGER NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(200) not null,
    last_name VARCHAR(200) not null,
    password VARCHAR(50) not null,
    email VARCHAR(200) not null,
    login_authentication_type INTEGER NOT NULL,
    is_active INTEGER,
    is_admin INTEGER,
    PRIMARY KEY (swim_user_id)
);

create table swim_measurements
(
    swim_measurement_id INTEGER NOT NULL AUTO_INCREMENT,
    date_recorded DATETIME NOT NULL,
    chest_size DOUBLE,
    waist_size DOUBLE,
    hips_size DOUBLE,
    skin_fold DOUBLE,
    weight DOUBLE,
    heart_rate DOUBLE,
    bp_diastolic DOUBLE,
    bp_systolic DOUBLE,
    
    PRIMARY KEY (swim_measurement_id)
);

create table swim_user_profiles
(
    swim_user_profile_id INTEGER NOT NULL AUTO_INCREMENT,
    swim_user_id INTEGER NOT NULL,
    swim_measurement_id INTEGER NOT NULL,
    height DOUBLE NOT NULL,
    base_heart_rate INTEGER,
    age INTEGER,
    dob DATETIME,
    PRIMARY KEY (swim_user_profile_id)
);



create table swim_user_goals
(
    swim_user_goal_id INTEGER NOT NULL AUTO_INCREMENT,
    swim_user_id INTEGER NOT NULL,
    goal_weight INTEGER not null,
    date_start DATETIME not null,
    date_end DATETIME not null,
    PRIMARY KEY (swim_user_goal_id)
);

create table swim_user_audits
(
    swim_user_audit_id INTEGER NOT NULL AUTO_INCREMENT,
    swim_user_id INTEGER NOT NULL,
    last_login_date DATETIME NOT NULL,
    PRIMARY KEY (swim_user_audit_id)
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

create table swim_exercise_journal
(
    swim_exercise_journal_id INTEGER NOT NULL AUTO_INCREMENT,
    swim_exercise_id INTEGER NOT NULL,
    duration integer not null,
    time_performed DATETIME NOT NULL,
    PRIMARY KEY (swim_exercise_journal_id)
    
);

create table swim_meals_journal
(
    swim_meal_journal_id INTEGER NOT NULL AUTO_INCREMENT,
    swim_meal_id INTEGER NOT NULL,
    meal_time DATETIME NOT NULL,
    calories INTEGER NOT NULL,
    PRIMARY KEY (swim_meal_journal_id)
);


