

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CBIREP_QUERY_STATUSES_HISTORY.sql ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CBIREP_QUERY_STATUSES_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CBIREP_QUERY_STATUSES_HISTORY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CBIREP_QUERY_STATUSES_HISTORY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CBIREP_QUERY_STATUSES_HISTORY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CBIREP_QUERY_STATUSES_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.CBIREP_QUERY_STATUSES_HISTORY 
   (	ID NUMBER, 
	QUERY_ID NUMBER, 
	USERID NUMBER, 
	REP_ID NUMBER, 
	KEY_PARAMS VARCHAR2(1024), 
	STATUS_ID VARCHAR2(100), 
	SET_TIME DATE DEFAULT sysdate, 
	COMM VARCHAR2(4000)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSDYND 
  PARTITION BY RANGE (SET_TIME) INTERVAL (NUMTOYMINTERVAL(1,''MONTH'')) STORE IN (BRSBIGD) 
 (PARTITION P1  VALUES LESS THAN (TO_DATE('' 2012-08-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSDYND ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CBIREP_QUERY_STATUSES_HISTORY ***
 exec bpa.alter_policies('CBIREP_QUERY_STATUSES_HISTORY');


COMMENT ON TABLE BARS.CBIREP_QUERY_STATUSES_HISTORY IS 'История статусов заявки на формирование отчета';
COMMENT ON COLUMN BARS.CBIREP_QUERY_STATUSES_HISTORY.ID IS 'Ид записи';
COMMENT ON COLUMN BARS.CBIREP_QUERY_STATUSES_HISTORY.QUERY_ID IS 'Ид запроса';
COMMENT ON COLUMN BARS.CBIREP_QUERY_STATUSES_HISTORY.USERID IS 'Ид пользователя';
COMMENT ON COLUMN BARS.CBIREP_QUERY_STATUSES_HISTORY.REP_ID IS 'Ид отчета';
COMMENT ON COLUMN BARS.CBIREP_QUERY_STATUSES_HISTORY.KEY_PARAMS IS 'Ключ составленый из параметров вызова';
COMMENT ON COLUMN BARS.CBIREP_QUERY_STATUSES_HISTORY.STATUS_ID IS 'Статус';
COMMENT ON COLUMN BARS.CBIREP_QUERY_STATUSES_HISTORY.SET_TIME IS 'Время установки статуса';
COMMENT ON COLUMN BARS.CBIREP_QUERY_STATUSES_HISTORY.COMM IS 'Комментарий';




PROMPT *** Create  constraint PK_CBIREPQSTSHIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_QUERY_STATUSES_HISTORY ADD CONSTRAINT PK_CBIREPQSTSHIST PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CBIQSHIST_CBIQSTS_STSID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_QUERY_STATUSES_HISTORY ADD CONSTRAINT FK_CBIQSHIST_CBIQSTS_STSID FOREIGN KEY (STATUS_ID)
	  REFERENCES BARS.CBIREP_QUERY_STATUSES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CBIREPQSTSHIST_QUERYID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_QUERY_STATUSES_HISTORY MODIFY (QUERY_ID CONSTRAINT CC_CBIREPQSTSHIST_QUERYID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CBIREPQSTSHIST_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_QUERY_STATUSES_HISTORY MODIFY (USERID CONSTRAINT CC_CBIREPQSTSHIST_USERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CBIREPQSTSHIST_REPID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_QUERY_STATUSES_HISTORY MODIFY (REP_ID CONSTRAINT CC_CBIREPQSTSHIST_REPID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CBIREPQSTSHIST_KEYPARS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_QUERY_STATUSES_HISTORY MODIFY (KEY_PARAMS CONSTRAINT CC_CBIREPQSTSHIST_KEYPARS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CBIREPQSTSHIST_STSID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_QUERY_STATUSES_HISTORY MODIFY (STATUS_ID CONSTRAINT CC_CBIREPQSTSHIST_STSID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CBIREPQSTSHIST_SETTIME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_QUERY_STATUSES_HISTORY MODIFY (SET_TIME CONSTRAINT CC_CBIREPQSTSHIST_SETTIME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_CBIREPQSTSHIST_QUERYID ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_CBIREPQSTSHIST_QUERYID ON BARS.CBIREP_QUERY_STATUSES_HISTORY (QUERY_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CBIREPQSTSHIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CBIREPQSTSHIST ON BARS.CBIREP_QUERY_STATUSES_HISTORY (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CBIREP_QUERY_STATUSES_HISTORY ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CBIREP_QUERY_STATUSES_HISTORY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CBIREP_QUERY_STATUSES_HISTORY to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CBIREP_QUERY_STATUSES_HISTORY to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CBIREP_QUERY_STATUSES_HISTORY.sql ====
PROMPT ===================================================================================== 
