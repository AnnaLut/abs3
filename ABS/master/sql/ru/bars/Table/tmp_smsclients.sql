

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SMSCLIENTS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SMSCLIENTS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SMSCLIENTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_SMSCLIENTS 
   (	ACC NUMBER(38,0), 
	PHONE VARCHAR2(20), 
	ONOPER NUMBER(1,0) DEFAULT 0, 
	ANYOPER NUMBER(1,0) DEFAULT 0, 
	ONDAY NUMBER(1,0) DEFAULT 0, 
	ANYDAY NUMBER(1,0) DEFAULT 0
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SMSCLIENTS ***
 exec bpa.alter_policies('TMP_SMSCLIENTS');


COMMENT ON TABLE BARS.TMP_SMSCLIENTS IS 'Довідник клієнтських рахунків для створення SMS - повідомлень (приложення SmsGuard.exe)';
COMMENT ON COLUMN BARS.TMP_SMSCLIENTS.ACC IS 'Ідентифікатор рахунку';
COMMENT ON COLUMN BARS.TMP_SMSCLIENTS.PHONE IS 'Номер мобільного телефону';
COMMENT ON COLUMN BARS.TMP_SMSCLIENTS.ONOPER IS 'Ознака - поопераційний режим';
COMMENT ON COLUMN BARS.TMP_SMSCLIENTS.ANYOPER IS 'Ознака - sms на кожну операцію для поопераційного режиму';
COMMENT ON COLUMN BARS.TMP_SMSCLIENTS.ONDAY IS 'Ознака - виписка (в кінці операційного дня)';
COMMENT ON COLUMN BARS.TMP_SMSCLIENTS.ANYDAY IS 'Ознака - sms щодня, навіть при відсутності оборотів (для режиму - виписка)';




PROMPT *** Create  constraint TMP_SMSCLIENTS_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SMSCLIENTS ADD CONSTRAINT TMP_SMSCLIENTS_PK PRIMARY KEY (ACC, PHONE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002217390 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SMSCLIENTS MODIFY (ANYDAY NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002217389 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SMSCLIENTS MODIFY (ONDAY NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002217388 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SMSCLIENTS MODIFY (ANYOPER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002217387 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SMSCLIENTS MODIFY (ONOPER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002217386 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SMSCLIENTS MODIFY (PHONE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002217385 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SMSCLIENTS MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index TMP_SMSCLIENTS_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.TMP_SMSCLIENTS_PK ON BARS.TMP_SMSCLIENTS (ACC, PHONE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SMSCLIENTS.sql =========*** End **
PROMPT ===================================================================================== 
