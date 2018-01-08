

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/APPLIST.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to APPLIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''APPLIST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''APPLIST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''APPLIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table APPLIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.APPLIST 
   (	CODEAPP VARCHAR2(30), 
	NAME VARCHAR2(140), 
	HOTKEY CHAR(1), 
	FRONTEND NUMBER(38,0) DEFAULT 0, 
	ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to APPLIST ***
 exec bpa.alter_policies('APPLIST');


COMMENT ON TABLE BARS.APPLIST IS 'Справочник приложений комплекса';
COMMENT ON COLUMN BARS.APPLIST.CODEAPP IS 'Код приложения
';
COMMENT ON COLUMN BARS.APPLIST.NAME IS 'Наименование приложения';
COMMENT ON COLUMN BARS.APPLIST.HOTKEY IS 'Клавиша';
COMMENT ON COLUMN BARS.APPLIST.FRONTEND IS 'Идентификатор фронтального интерфейса';
COMMENT ON COLUMN BARS.APPLIST.ID IS '';




PROMPT *** Create  constraint PK_APPLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.APPLIST ADD CONSTRAINT PK_APPLIST PRIMARY KEY (CODEAPP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_APPLIST_FRONTEND ***
begin   
 execute immediate '
  ALTER TABLE BARS.APPLIST ADD CONSTRAINT FK_APPLIST_FRONTEND FOREIGN KEY (FRONTEND)
	  REFERENCES BARS.FRONTEND (FID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_APPLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.APPLIST ADD CONSTRAINT UK_APPLIST UNIQUE (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006699 ***
begin   
 execute immediate '
  ALTER TABLE BARS.APPLIST MODIFY (CODEAPP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_APPLIST_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.APPLIST MODIFY (NAME CONSTRAINT CC_APPLIST_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_APPLIST_FRONTEND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.APPLIST MODIFY (FRONTEND CONSTRAINT CC_APPLIST_FRONTEND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_APPLIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_APPLIST ON BARS.APPLIST (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_APPLIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_APPLIST ON BARS.APPLIST (CODEAPP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  APPLIST ***
grant DELETE,INSERT,SELECT,UPDATE                                            on APPLIST         to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on APPLIST         to APPLIST;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on APPLIST         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on APPLIST         to BARS_DM;
grant SELECT                                                                 on APPLIST         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on APPLIST         to WR_ALL_RIGHTS;
grant SELECT                                                                 on APPLIST         to WR_DIAGNOSTICS;
grant FLASHBACK,SELECT                                                       on APPLIST         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/APPLIST.sql =========*** End *** =====
PROMPT ===================================================================================== 
