

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OPERLIST.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OPERLIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OPERLIST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OPERLIST'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OPERLIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OPERLIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.OPERLIST 
   (	CODEOPER NUMBER(38,0), 
	NAME VARCHAR2(70), 
	DLGNAME VARCHAR2(35), 
	FUNCNAME VARCHAR2(4000), 
	SEMANTIC VARCHAR2(100), 
	RUNABLE NUMBER(1,0), 
	PARENTID NUMBER(38,0), 
	ROLENAME VARCHAR2(30), 
	FRONTEND NUMBER(1,0) DEFAULT 0, 
	USEARC NUMBER(1,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OPERLIST ***
 exec bpa.alter_policies('OPERLIST');


COMMENT ON TABLE BARS.OPERLIST IS 'ФУНКЦИИ';
COMMENT ON COLUMN BARS.OPERLIST.CODEOPER IS 'Код функции';
COMMENT ON COLUMN BARS.OPERLIST.NAME IS 'Название функции';
COMMENT ON COLUMN BARS.OPERLIST.DLGNAME IS 'Идентификатор формы';
COMMENT ON COLUMN BARS.OPERLIST.FUNCNAME IS 'Командная строка вызова';
COMMENT ON COLUMN BARS.OPERLIST.SEMANTIC IS 'Расширенный комментарий';
COMMENT ON COLUMN BARS.OPERLIST.RUNABLE IS '1 - да
0 - нет';
COMMENT ON COLUMN BARS.OPERLIST.PARENTID IS 'Код родителя';
COMMENT ON COLUMN BARS.OPERLIST.ROLENAME IS 'Имя роли';
COMMENT ON COLUMN BARS.OPERLIST.FRONTEND IS 'id фронтального интерфейса';
COMMENT ON COLUMN BARS.OPERLIST.USEARC IS 'Область работы ф-ции: 0-оперативная база, 1-оперативная+архивная, 2-архивная';




PROMPT *** Create  constraint PK_OPERLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST ADD CONSTRAINT PK_OPERLIST PRIMARY KEY (CODEOPER)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPERLIST_USEARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST ADD CONSTRAINT CC_OPERLIST_USEARC CHECK (usearc in (0,1,2)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPERLIST_RUNABLE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST ADD CONSTRAINT CC_OPERLIST_RUNABLE CHECK (runable IN (0,1,2,3)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPERLIST_CODEOPER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST MODIFY (CODEOPER CONSTRAINT CC_OPERLIST_CODEOPER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPERLIST_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST MODIFY (NAME CONSTRAINT CC_OPERLIST_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPERLIST_DLGNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST MODIFY (DLGNAME CONSTRAINT CC_OPERLIST_DLGNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPERLIST_FUNCNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST MODIFY (FUNCNAME CONSTRAINT CC_OPERLIST_FUNCNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPERLIST_FRONTEND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST MODIFY (FRONTEND CONSTRAINT CC_OPERLIST_FRONTEND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPERLIST_USEARC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST MODIFY (USEARC CONSTRAINT CC_OPERLIST_USEARC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_OPERLIST_FUNCNAME ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XIE_OPERLIST_FUNCNAME ON BARS.OPERLIST (FUNCNAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OPERLIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OPERLIST ON BARS.OPERLIST (CODEOPER) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OPERLIST ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OPERLIST        to ABS_ADMIN;
grant SELECT                                                                 on OPERLIST        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OPERLIST        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OPERLIST        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OPERLIST        to OPERLIST;
grant SELECT                                                                 on OPERLIST        to START1;
grant SELECT                                                                 on OPERLIST        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OPERLIST        to WR_ALL_RIGHTS;
grant SELECT                                                                 on OPERLIST        to WR_DIAGNOSTICS;
grant FLASHBACK,SELECT                                                       on OPERLIST        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OPERLIST.sql =========*** End *** ====
PROMPT ===================================================================================== 
