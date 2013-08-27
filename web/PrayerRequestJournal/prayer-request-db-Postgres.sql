-- Prayer Request tables

create table PRAYER_REQUESTOR
(
	REQUESTOR_ID SERIAL NOT NULL PRIMARY KEY,
	NAME VARCHAR(200) not null,
	EMAIL VARCHAR(200) not null,
	PASSWORD VARCHAR(50) not null,
	LAST_LOGON_DATE DATE,
	LAST_LOGON_TIME TIME,
	ISACTIVE INTEGER,
	ISADMIN INTEGER
);

create table PRAYER_REQUEST
(
	REQUEST_ID SERIAL NOT NULL PRIMARY KEY,
	REQUESTOR_ID INTEGER not null,
	REQUEST VARCHAR(500) not null,
	REQUEST_DATE DATE not null,
	REQUEST_TIME TIME not null,
	TITLE VARCHAR(100)
);

ALTER TABLE PRAYER_REQUEST ADD CONSTRAINT FK_PRAYER_REQUEST_PRAYER_REQUESTOR
Foreign Key (REQUESTOR_ID) REFERENCES PRAYER_REQUESTOR (REQUESTOR_ID);

create table PRAYER_RESPONSE
(
	RESPONSE_ID SERIAL NOT NULL PRIMARY KEY,
	REQUEST_ID INTEGER not null,
	DETAIL VARCHAR(500) not null,
	DISPOSITION VARCHAR(100) not null,
	RESPONSE_DATE DATE not null,
	RESPONSE_TIME TIME not null
);

ALTER TABLE PRAYER_RESPONSE ADD CONSTRAINT FK_PRAYER_RESPONSE_PRAYER_REQUEST
Foreign Key (REQUEST_ID) REFERENCES PRAYER_REQUEST (REQUEST_ID);

create table LKUP_DISPOSITION
(
	DISPOSITION_ID SERIAL NOT NULL PRIMARY KEY,
	DISPOSITION VARCHAR(100) not null
);

/* data */
insert into LKUP_DISPOSITION(DISPOSITION) VALUES('Yes');
insert into LKUP_DISPOSITION(DISPOSITION) VALUES('No');
insert into LKUP_DISPOSITION(DISPOSITION) VALUES('Waiting');

insert into prayer_requestor (NAME, EMAIL, PASSWORD, LAST_LOGON_DATE, LAST_LOGON_TIME, ISACTIVE, ISADMIN)
	values ('anonymous', 'anonymous@wilmss.com', 'anonymous', CURRENT_DATE, CURRENT_TIME, 1, 0);
	
insert into prayer_request (requestor_id, request, request_date, request_time, title)
values(1, 'My prayer today is for a healthy child that God has givent to us!', '04/09/2012', '17:09:00', 'Healthy Child');
insert into prayer_request (requestor_id, request, request_date, request_time, title)
VALUES(1,'Pray for the sanctitiy of marriage','04/11/2012','09:07:00','Marriate Purity');
insert into prayer_request (requestor_id, request, request_date, request_time, title)
VALUES(1,'Pray for my wife and my self to receive a job this week!','04/11/2012','09:09:00','New Job');
insert into prayer_request (requestor_id, request, request_date, request_time, title)
VALUES(1,'Asking for the will of God to be done in my life in all things!','04/11/2012','09:10:00','Gods Will');
insert into prayer_request (requestor_id, request, request_date, request_time, title)
VALUES(1,'Prayer for my neighbor who just got fired and needs a job.  Hes a great guy','04/11/2012','09:19:00','Employement');
insert into prayer_request (requestor_id, request, request_date, request_time, title)
VALUES(1,'I need money to pay rent!','03/01/2012','10:00:00','Money');
insert into prayer_request (requestor_id, request, request_date, request_time, title)
VALUES(1,'Expose my wife from her cheating ways!','04/11/2012','11:04:00','Cheating Wife');
insert into prayer_request (requestor_id, request, request_date, request_time, title)
VALUES(1,'Give me deliverance from sexual addictions','04/11/2012','09:23:00','Freedom From Addiction');
insert into prayer_request (requestor_id, request, request_date, request_time, title)
VALUES(1,'Tame my alcohol abuse','03/09/2012','02:10:00','alcohol abuse');
insert into prayer_request (requestor_id, request, request_date, request_time, title)
VALUES(1,'Help me Lord to forigve someone who has abused me','04/11/2012','09:10:00','Forgive Abuser');
insert into prayer_request (requestor_id, request, request_date, request_time, title)
VALUES(1,'I have 2 kids and they are out of control.  Help me lord with my children','04/11/2012','09:10:00','My Children');
insert into prayer_request (requestor_id, request, request_date, request_time, title)
VALUES(1,'Help me Lord to get a car','04/11/2012','09:30:00','A Car Or Reliable Transportation');
