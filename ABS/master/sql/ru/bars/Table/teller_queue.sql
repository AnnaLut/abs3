

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TELLER_QUEUE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TELLER_QUEUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TELLER_QUEUE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TELLER_QUEUE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TELLER_QUEUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TELLER_QUEUE 
   (	ID NUMBER, 
	REF NUMBER, 
	MSG_STATUS VARCHAR2(25), 
	MSG_TIME DATE DEFAULT sysdate, 
	ERR_TEXT VARCHAR2(2000), 
	STATUS_TELL NUMBER DEFAULT 1
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TELLER_QUEUE ***
 exec bpa.alter_policies('TELLER_QUEUE');


COMMENT ON TABLE BARS.TELLER_QUEUE IS 'Черга повідомлень на синхронізацію';
COMMENT ON COLUMN BARS.TELLER_QUEUE.ID IS '';
COMMENT ON COLUMN BARS.TELLER_QUEUE.REF IS 'Референс';
COMMENT ON COLUMN BARS.TELLER_QUEUE.MSG_STATUS IS 'Статус передачі';
COMMENT ON COLUMN BARS.TELLER_QUEUE.MSG_TIME IS 'Дата';
COMMENT ON COLUMN BARS.TELLER_QUEUE.ERR_TEXT IS 'Помилка';
COMMENT ON COLUMN BARS.TELLER_QUEUE.STATUS_TELL IS 'Теллер';




PROMPT *** Create  constraint SYS_C003125443 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_QUEUE MODIFY (MSG_STATUS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003125442 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_QUEUE MODIFY (REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003125441 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_QUEUE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003178352 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_QUEUE MODIFY (STATUS_TELL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TELLER_QUEUE ***
grant INSERT,SELECT,UPDATE                                                   on TELLER_QUEUE    to BARS_ACCESS_DEFROLE;
grant INSERT,SELECT,UPDATE                                                   on TELLER_QUEUE    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TELLER_QUEUE.sql =========*** End *** 
PROMPT ===================================================================================== 
