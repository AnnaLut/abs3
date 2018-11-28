

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Table/OUT_DEST_USERS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  table OUT_DEST_USERS ***
begin 
  execute immediate '
  CREATE TABLE BARSTRANS.OUT_DEST_USERS 
   (	USERNAME VARCHAR2(50), 
	AUTH_TYPE VARCHAR2(255), 
	AUTH_STR VARCHAR2(255), 
	USER_ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSTRANS.OUT_DEST_USERS IS 'Довідник облікових даних для авторизації';
COMMENT ON COLUMN BARSTRANS.OUT_DEST_USERS.USERNAME IS 'Назва облікового запису';
COMMENT ON COLUMN BARSTRANS.OUT_DEST_USERS.AUTH_TYPE IS 'Тип автентифікації';
COMMENT ON COLUMN BARSTRANS.OUT_DEST_USERS.AUTH_STR IS 'Строка автентифікації';
COMMENT ON COLUMN BARSTRANS.OUT_DEST_USERS.USER_ID IS 'Ід користувача в АБС';




PROMPT *** Create  constraint PK_OUT_DEST_USERS ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_DEST_USERS ADD CONSTRAINT PK_OUT_DEST_USERS PRIMARY KEY (USERNAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OUT_DEST_USERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.PK_OUT_DEST_USERS ON BARSTRANS.OUT_DEST_USERS (USERNAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Table/OUT_DEST_USERS.sql =========*** E
PROMPT ===================================================================================== 

