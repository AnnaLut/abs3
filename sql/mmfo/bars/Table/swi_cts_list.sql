

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SWI_CTS_LIST.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SWI_CTS_LIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SWI_CTS_LIST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SWI_CTS_LIST'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SWI_CTS_LIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SWI_CTS_LIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.SWI_CTS_LIST 
   (	ID VARCHAR2(30), 
	NAME VARCHAR2(256), 
	CTS_URL VARCHAR2(2000), 
	CTS_IMG VARCHAR2(2000), 
	PARAMS VARCHAR2(2000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SWI_CTS_LIST ***
 exec bpa.alter_policies('SWI_CTS_LIST');


COMMENT ON TABLE BARS.SWI_CTS_LIST IS 'Список постачальників касових операцій';
COMMENT ON COLUMN BARS.SWI_CTS_LIST.ID IS 'Ідентифікатор постачальника';
COMMENT ON COLUMN BARS.SWI_CTS_LIST.NAME IS 'Назва постачальника';
COMMENT ON COLUMN BARS.SWI_CTS_LIST.CTS_URL IS 'Вхідна адреса сайту постачальника';
COMMENT ON COLUMN BARS.SWI_CTS_LIST.CTS_IMG IS 'Адреса логотипу постачальника';
COMMENT ON COLUMN BARS.SWI_CTS_LIST.PARAMS IS 'Додаткові параметри вигляду par1=val';




PROMPT *** Create  constraint PK_SWICTSLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.SWI_CTS_LIST ADD CONSTRAINT PK_SWICTSLIST PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWICTSLIST_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SWI_CTS_LIST MODIFY (ID CONSTRAINT CC_SWICTSLIST_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWICTSLIST_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SWI_CTS_LIST MODIFY (NAME CONSTRAINT CC_SWICTSLIST_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWICTSLIST_URL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SWI_CTS_LIST MODIFY (CTS_URL CONSTRAINT CC_SWICTSLIST_URL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWICTSLIST_IMG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SWI_CTS_LIST MODIFY (CTS_IMG CONSTRAINT CC_SWICTSLIST_IMG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWICTSLIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWICTSLIST ON BARS.SWI_CTS_LIST (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SWI_CTS_LIST ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SWI_CTS_LIST    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SWI_CTS_LIST    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SWI_CTS_LIST    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SWI_CTS_LIST.sql =========*** End *** 
PROMPT ===================================================================================== 
