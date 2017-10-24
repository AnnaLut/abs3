

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SMS_CONFIRM_AUDIT.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SMS_CONFIRM_AUDIT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SMS_CONFIRM_AUDIT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SMS_CONFIRM_AUDIT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SMS_CONFIRM_AUDIT ***
begin 
  execute immediate '
  CREATE TABLE BARS.SMS_CONFIRM_AUDIT 
   (	ID NUMBER(*,0), 
	DATESTAMP DATE, 
	USER_ID NUMBER(*,0), 
	NEW_VALUE NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SMS_CONFIRM_AUDIT ***
 exec bpa.alter_policies('SMS_CONFIRM_AUDIT');


COMMENT ON TABLE BARS.SMS_CONFIRM_AUDIT IS 'Журнал включення/виключення sms-підтвердження телефону при реєстрації клієнта ФО';
COMMENT ON COLUMN BARS.SMS_CONFIRM_AUDIT.ID IS 'ID запису в журналі';
COMMENT ON COLUMN BARS.SMS_CONFIRM_AUDIT.DATESTAMP IS 'Дата і час зміни параметру';
COMMENT ON COLUMN BARS.SMS_CONFIRM_AUDIT.USER_ID IS 'Користувач, що змінив параметр';
COMMENT ON COLUMN BARS.SMS_CONFIRM_AUDIT.NEW_VALUE IS 'Значення, яке діє з дати/часу';




PROMPT *** Create  constraint SYS_C003101148 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SMS_CONFIRM_AUDIT ADD PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003101147 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SMS_CONFIRM_AUDIT MODIFY (DATESTAMP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003101146 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SMS_CONFIRM_AUDIT MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SMS_CONFIRM_AUDIT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SMS_CONFIRM_AUDIT ON BARS.SMS_CONFIRM_AUDIT (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SMS_CONFIRM_AUDIT ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SMS_CONFIRM_AUDIT to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SMS_CONFIRM_AUDIT.sql =========*** End
PROMPT ===================================================================================== 
