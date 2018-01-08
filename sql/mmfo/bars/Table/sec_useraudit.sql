

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SEC_USERAUDIT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SEC_USERAUDIT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SEC_USERAUDIT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SEC_USERAUDIT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SEC_USERAUDIT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SEC_USERAUDIT ***
begin 
  execute immediate '
  CREATE TABLE BARS.SEC_USERAUDIT 
   (	STAFF_ID NUMBER(38,0), 
	LOG_LEVEL VARCHAR2(10), 
	TRACE_OBJECT VARCHAR2(2000), 
	TRACE_STACK NUMBER(1,0), 
	UPDATE_TIME DATE DEFAULT sysdate, 
	UPDATE_COMMENT VARCHAR2(128)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 1 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SEC_USERAUDIT ***
 exec bpa.alter_policies('SEC_USERAUDIT');


COMMENT ON TABLE BARS.SEC_USERAUDIT IS 'Индивидуальный уровень протоколирования';
COMMENT ON COLUMN BARS.SEC_USERAUDIT.STAFF_ID IS 'Идентификатор пользователя из справочника персонала';
COMMENT ON COLUMN BARS.SEC_USERAUDIT.LOG_LEVEL IS 'Установленная детализация';
COMMENT ON COLUMN BARS.SEC_USERAUDIT.TRACE_OBJECT IS 'Список объектов для трассировки';
COMMENT ON COLUMN BARS.SEC_USERAUDIT.TRACE_STACK IS 'Признак сохранения полной трассы вызова';
COMMENT ON COLUMN BARS.SEC_USERAUDIT.UPDATE_TIME IS 'Время вставки или изменения строки';
COMMENT ON COLUMN BARS.SEC_USERAUDIT.UPDATE_COMMENT IS 'Комментарий для изменения строки';




PROMPT *** Create  constraint PK_SECUSERAUDIT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_USERAUDIT ADD CONSTRAINT PK_SECUSERAUDIT PRIMARY KEY (STAFF_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECUSERAUDIT_TRCSTACK ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_USERAUDIT ADD CONSTRAINT CC_SECUSERAUDIT_TRCSTACK CHECK (trace_stack in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECUSERAUDIT_STAFFID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_USERAUDIT MODIFY (STAFF_ID CONSTRAINT CC_SECUSERAUDIT_STAFFID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECUSERAUDIT_LOGLEVEL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_USERAUDIT MODIFY (LOG_LEVEL CONSTRAINT CC_SECUSERAUDIT_LOGLEVEL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECUSERAUDIT_TRCSTACK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_USERAUDIT MODIFY (TRACE_STACK CONSTRAINT CC_SECUSERAUDIT_TRCSTACK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECUSERAUD_UPDTIME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_USERAUDIT MODIFY (UPDATE_TIME CONSTRAINT CC_SECUSERAUD_UPDTIME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SECUSERAUDIT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SECUSERAUDIT ON BARS.SEC_USERAUDIT (STAFF_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SEC_USERAUDIT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SEC_USERAUDIT   to ABS_ADMIN;
grant SELECT                                                                 on SEC_USERAUDIT   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SEC_USERAUDIT   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SEC_USERAUDIT   to BARS_DM;
grant SELECT                                                                 on SEC_USERAUDIT   to START1;
grant SELECT                                                                 on SEC_USERAUDIT   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SEC_USERAUDIT   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SEC_USERAUDIT.sql =========*** End ***
PROMPT ===================================================================================== 
