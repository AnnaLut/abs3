PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TELLER_USERS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TELLER_USERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TELLER_USERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TELLER_USERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TELLER_USERS 
   (	USER_ID NUMBER(38,0), 
	USER_NAME VARCHAR2(60), 
	BRANCH VARCHAR2(30), 
	VALID_FROM DATE, 
	VALID_TO DATE, 
	SESSION_ID VARCHAR2(20), 
	BOSS_LIST VARCHAR2(100), 
	ID NUMBER, 
	TOX_FLAG integer
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


declare 
  v_num integer;
begin
  select count(1) into v_num
    from user_tab_columns 
    where table_name = 'TELLER_USERS'
      and column_name = 'TOX_FLAG';
  if v_num = 0 then
    execute immediate 'alter table teller_users add tox_flag integer';
  end if;
end;
/
update teller_users 
  set tox_flag = 1 
  where tox_flag is null;

PROMPT *** ALTER_POLICIES to TELLER_USERS ***
 exec bpa.alter_policies('TELLER_USERS');


COMMENT ON TABLE BARS.TELLER_USERS IS 'Довідник теллерів';
COMMENT ON COLUMN BARS.TELLER_USERS.ID IS 'ID запису. Для коректної роботи з метадовідниками';
COMMENT ON COLUMN BARS.TELLER_USERS.TOX_FLAG IS 'Можливість інкасувати АТМ (1-так, 0 - ні)';
COMMENT ON COLUMN BARS.TELLER_USERS.USER_ID IS 'Логін користувача';
COMMENT ON COLUMN BARS.TELLER_USERS.USER_NAME IS 'Найменування користувача';
COMMENT ON COLUMN BARS.TELLER_USERS.BRANCH IS 'Код філії/відділення';
COMMENT ON COLUMN BARS.TELLER_USERS.VALID_FROM IS 'Дата початку дії повноважень теллера для користувача';
COMMENT ON COLUMN BARS.TELLER_USERS.VALID_TO IS 'Дата закінчення дії повноважень теллера для користувача';
COMMENT ON COLUMN BARS.TELLER_USERS.SESSION_ID IS 'ID сесії для терміналу';
COMMENT ON COLUMN BARS.TELLER_USERS.BOSS_LIST IS '';




PROMPT *** Create  constraint FL_REL_USR ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_USERS ADD CONSTRAINT FL_REL_USR CHECK (valid_from<=nvl(valid_to,valid_from)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0027578 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_USERS MODIFY (VALID_FROM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0027579 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_USERS MODIFY (USER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0027580 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_USERS MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TELLER_USERS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TELLER_USERS    to BARS_ACCESS_DEFROLE;
grant FLASHBACK,SELECT                                                       on TELLER_USERS    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TELLER_USERS.sql =========*** End *** 
PROMPT ===================================================================================== 
