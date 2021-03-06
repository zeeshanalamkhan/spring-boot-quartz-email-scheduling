BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE QRTZ_FIRED_TRIGGERS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE QRTZ_PAUSED_TRIGGER_GRPS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE QRTZ_SCHEDULER_STATE';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE QRTZ_LOCKS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE QRTZ_SIMPLE_TRIGGERS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE QRTZ_SIMPROP_TRIGGERS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE QRTZ_CRON_TRIGGERS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE QRTZ_BLOB_TRIGGERS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE QRTZ_TRIGGERS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE QRTZ_JOB_DETAILS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE QRTZ_CALENDARS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE QRTZ_JOB_DETAILS(
SCHED_NAME VARCHAR2(120) NOT NULL,
JOB_NAME VARCHAR2(190) NOT NULL,
JOB_GROUP VARCHAR2(190) NOT NULL,
DESCRIPTION VARCHAR2(250) NULL,
JOB_CLASS_NAME VARCHAR2(250) NOT NULL,
IS_DURABLE VARCHAR2(1) NOT NULL,
IS_NONCONCURRENT VARCHAR2(1) NOT NULL,
IS_UPDATE_DATA VARCHAR2(1) NOT NULL,
REQUESTS_RECOVERY VARCHAR2(1) NOT NULL,
JOB_DATA BLOB NULL,
PRIMARY KEY (SCHED_NAME,JOB_NAME,JOB_GROUP))
;

CREATE TABLE QRTZ_TRIGGERS (
SCHED_NAME VARCHAR2(120) NOT NULL,
TRIGGER_NAME VARCHAR2(190) NOT NULL,
TRIGGER_GROUP VARCHAR2(190) NOT NULL,
JOB_NAME VARCHAR2(190) NOT NULL,
JOB_GROUP VARCHAR2(190) NOT NULL,
DESCRIPTION VARCHAR2(250) NULL,
NEXT_FIRE_TIME NUMBER(19) NULL,
PREV_FIRE_TIME NUMBER(19) NULL,
PRIORITY NUMBER(10) NULL,
TRIGGER_STATE VARCHAR2(16) NOT NULL,
TRIGGER_TYPE VARCHAR2(8) NOT NULL,
START_TIME NUMBER(19) NOT NULL,
END_TIME NUMBER(19) NULL,
CALENDAR_NAME VARCHAR2(190) NULL,
MISFIRE_INSTR NUMBER(5) NULL,
JOB_DATA BLOB NULL,
PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
FOREIGN KEY (SCHED_NAME,JOB_NAME,JOB_GROUP)
REFERENCES QRTZ_JOB_DETAILS(SCHED_NAME,JOB_NAME,JOB_GROUP))
;

CREATE TABLE QRTZ_SIMPLE_TRIGGERS (
SCHED_NAME VARCHAR2(120) NOT NULL,
TRIGGER_NAME VARCHAR2(190) NOT NULL,
TRIGGER_GROUP VARCHAR2(190) NOT NULL,
REPEAT_COUNT NUMBER(19) NOT NULL,
REPEAT_INTERVAL NUMBER(19) NOT NULL,
TIMES_TRIGGERED NUMBER(19) NOT NULL,
PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP))
;

CREATE TABLE QRTZ_CRON_TRIGGERS (
SCHED_NAME VARCHAR2(120) NOT NULL,
TRIGGER_NAME VARCHAR2(190) NOT NULL,
TRIGGER_GROUP VARCHAR2(190) NOT NULL,
CRON_EXPRESSION VARCHAR2(120) NOT NULL,
TIME_ZONE_ID VARCHAR2(80),
PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP))
;

CREATE TABLE QRTZ_SIMPROP_TRIGGERS
  (
    SCHED_NAME VARCHAR2(120) NOT NULL,
    TRIGGER_NAME VARCHAR2(190) NOT NULL,
    TRIGGER_GROUP VARCHAR2(190) NOT NULL,
    STR_PROP_1 VARCHAR2(512) NULL,
    STR_PROP_2 VARCHAR2(512) NULL,
    STR_PROP_3 VARCHAR2(512) NULL,
    INT_PROP_1 NUMBER(10) NULL,
    INT_PROP_2 NUMBER(10) NULL,
    LONG_PROP_1 NUMBER(19) NULL,
    LONG_PROP_2 NUMBER(19) NULL,
    DEC_PROP_1 NUMBER(13,4) NULL,
    DEC_PROP_2 NUMBER(13,4) NULL,
    BOOL_PROP_1 VARCHAR2(1) NULL,
    BOOL_PROP_2 VARCHAR2(1) NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
    REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP))
;

CREATE TABLE QRTZ_BLOB_TRIGGERS (
SCHED_NAME VARCHAR2(120) NOT NULL,
TRIGGER_NAME VARCHAR2(190) NOT NULL,
TRIGGER_GROUP VARCHAR2(190) NOT NULL,
BLOB_DATA BLOB NULL,
PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
,
FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP))
;

CREATE INDEX (SCHED_NAME,TRIGGER_NAME, TRIGGER_GROUP);

CREATE TABLE QRTZ_CALENDARS (
SCHED_NAME VARCHAR2(120) NOT NULL,
CALENDAR_NAME VARCHAR2(190) NOT NULL,
CALENDAR BLOB NOT NULL,
PRIMARY KEY (SCHED_NAME,CALENDAR_NAME))
;

CREATE TABLE QRTZ_PAUSED_TRIGGER_GRPS (
SCHED_NAME VARCHAR2(120) NOT NULL,
TRIGGER_GROUP VARCHAR2(190) NOT NULL,
PRIMARY KEY (SCHED_NAME,TRIGGER_GROUP))
;

CREATE TABLE QRTZ_FIRED_TRIGGERS (
SCHED_NAME VARCHAR2(120) NOT NULL,
ENTRY_ID VARCHAR2(95) NOT NULL,
TRIGGER_NAME VARCHAR2(190) NOT NULL,
TRIGGER_GROUP VARCHAR2(190) NOT NULL,
INSTANCE_NAME VARCHAR2(190) NOT NULL,
FIRED_TIME NUMBER(19) NOT NULL,
SCHED_TIME NUMBER(19) NOT NULL,
PRIORITY NUMBER(10) NOT NULL,
STATE VARCHAR2(16) NOT NULL,
JOB_NAME VARCHAR2(190) NULL,
JOB_GROUP VARCHAR2(190) NULL,
IS_NONCONCURRENT VARCHAR2(1) NULL,
REQUESTS_RECOVERY VARCHAR2(1) NULL,
PRIMARY KEY (SCHED_NAME,ENTRY_ID))
;

CREATE TABLE QRTZ_SCHEDULER_STATE (
SCHED_NAME VARCHAR2(120) NOT NULL,
INSTANCE_NAME VARCHAR2(190) NOT NULL,
LAST_CHECKIN_TIME NUMBER(19) NOT NULL,
CHECKIN_INTERVAL NUMBER(19) NOT NULL,
PRIMARY KEY (SCHED_NAME,INSTANCE_NAME))
;

CREATE TABLE QRTZ_LOCKS (
SCHED_NAME VARCHAR2(120) NOT NULL,
LOCK_NAME VARCHAR2(40) NOT NULL,
PRIMARY KEY (SCHED_NAME,LOCK_NAME))
;

CREATE INDEX IDX_QRTZ_J_REQ_RECOVERY ON QRTZ_JOB_DETAILS(SCHED_NAME,REQUESTS_RECOVERY);
CREATE INDEX IDX_QRTZ_J_GRP ON QRTZ_JOB_DETAILS(SCHED_NAME,JOB_GROUP);

CREATE INDEX IDX_QRTZ_T_J ON QRTZ_TRIGGERS(SCHED_NAME,JOB_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_T_JG ON QRTZ_TRIGGERS(SCHED_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_T_C ON QRTZ_TRIGGERS(SCHED_NAME,CALENDAR_NAME);
CREATE INDEX IDX_QRTZ_T_G ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_GROUP);
CREATE INDEX IDX_QRTZ_T_STATE ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_N_STATE ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_N_G_STATE ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_GROUP,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_NEXT_FIRE_TIME ON QRTZ_TRIGGERS(SCHED_NAME,NEXT_FIRE_TIME);
CREATE INDEX IDX_QRTZ_T_NFT_ST ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_STATE,NEXT_FIRE_TIME);
CREATE INDEX IDX_QRTZ_T_NFT_MISFIRE ON QRTZ_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME);
CREATE INDEX IDX_QRTZ_T_NFT_ST_MISFIRE ON QRTZ_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_NFT_ST_MISFIRE_GRP ON QRTZ_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_GROUP,TRIGGER_STATE);

CREATE INDEX IDX_QRTZ_FT_TRIG_INST_NAME ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,INSTANCE_NAME);
CREATE INDEX IDX_QRTZ_FT_INST_JOB_REQ_RCVRY ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,INSTANCE_NAME,REQUESTS_RECOVERY);
CREATE INDEX IDX_QRTZ_FT_J_G ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,JOB_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_FT_JG ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_FT_T_G ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP);
CREATE INDEX IDX_QRTZ_FT_TG ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,TRIGGER_GROUP);

commit;
