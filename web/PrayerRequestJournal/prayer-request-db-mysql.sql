
-- Prayer Request tables

create table REQUESTOR
(
	REQUESTOR_ID INTEGER NOT NULL AUTO_INCREMENT,
	NAME VARCHAR(200) not null,
	EMAIL VARCHAR(200) not null,
	PASSWORD VARCHAR(50) not null,
	LAST_LOGON_DATE DATE,
	LAST_LOGON_TIME TIME,
	ISACTIVE INTEGER,
	ISADMIN INTEGER,
	PRIMARY KEY (REQUESTOR_ID)
);

create table REQUEST
(
	REQUEST_ID INTEGER NOT NULL AUTO_INCREMENT,
	REQUESTOR_ID INTEGER not null,
	REQUEST VARCHAR(500) not null,
	REQUEST_DATE DATE not null,
	REQUEST_TIME TIME not null,
	TITLE VARCHAR(100),
	PRIMARY KEY (REQUEST_ID),
	CONSTRAINT fk_RequestRequestors FOREIGN KEY (REQUESTOR_ID) REFERENCES REQUESTOR(REQUESTOR_ID)
);

create table RESPONSE
(
	RESPONSE_ID INTEGER NOT NULL AUTO_INCREMENT,,
	REQUEST_ID INTEGER not null,
	DETAIL VARCHAR(500) not null,
	DISPOSITION VARCHAR(100) not null,
	RESPONSE_DATE DATE not null,
	RESPONSE_TIME TIME not null,
	PRIMARY KEY (RESPONSE_ID),
	CONSTRAINT fk_ResponsRequests FOREIGN KEY (REQUEST_ID) REFERENCES REQUEST(REQUEST_ID)
);

create table LKUP_DISPOSITION
(
	DISPOSITION_ID INTEGER NOT NULL AUTO_INCREMENT,,
	DISPOSITION VARCHAR(100) not null
);

/* data */
insert into LKUP_DISPOSITION(DISPOSITION) VALUES('Yes');
insert into LKUP_DISPOSITION(DISPOSITION) VALUES('No');
insert into LKUP_DISPOSITION(DISPOSITION) VALUES('Waiting');

