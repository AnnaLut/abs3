

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFF_ADDRESOURCE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFF_ADDRESOURCE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAFF_ADDRESOURCE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_ADDRESOURCE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_ADDRESOURCE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFF_ADDRESOURCE ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFF_ADDRESOURCE 
   (	ADDRES_ID NUMBER(38,0), 
	ADDRES_NAME VARCHAR2(100), 
	ADDRES_TABNAME VARCHAR2(30), 
	ADDRES_USERCOL VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFF_ADDRESOURCE ***
 exec bpa.alter_policies('STAFF_ADDRESOURCE');


COMMENT ON TABLE BARS.STAFF_ADDRESOURCE IS 'Ссылки на дополнительные ресурсы пользователя';
COMMENT ON COLUMN BARS.STAFF_ADDRESOURCE.ADDRES_ID IS 'Идентификатор польз. доп. ресурса';
COMMENT ON COLUMN BARS.STAFF_ADDRESOURCE.ADDRES_NAME IS 'Наименование польз. доп. ресурса';
COMMENT ON COLUMN BARS.STAFF_ADDRESOURCE.ADDRES_TABNAME IS 'Имя таблицы';
COMMENT ON COLUMN BARS.STAFF_ADDRESOURCE.ADDRES_USERCOL IS 'Имя колонки с ид. пользователя';




PROMPT *** Create  constraint PK_STAFFADDRES ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_ADDRESOURCE ADD CONSTRAINT PK_STAFFADDRES PRIMARY KEY (ADDRES_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_STAFFADDRES ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_ADDRESOURCE ADD CONSTRAINT UK_STAFFADDRES UNIQUE (ADDRES_TABNAME, ADDRES_USERCOL)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFADDRES_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_ADDRESOURCE MODIFY (ADDRES_ID CONSTRAINT CC_STAFFADDRES_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFADDRES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_ADDRESOURCE MODIFY (ADDRES_NAME CONSTRAINT CC_STAFFADDRES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFADDRES_TABNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_ADDRESOURCE MODIFY (ADDRES_TABNAME CONSTRAINT CC_STAFFADDRES_TABNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFADDRES_USERCOL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_ADDRESOURCE MODIFY (ADDRES_USERCOL CONSTRAINT CC_STAFFADDRES_USERCOL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STAFFADDRES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STAFFADDRES ON BARS.STAFF_ADDRESOURCE (ADDRES_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_STAFFADDRES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_STAFFADDRES ON BARS.STAFF_ADDRESOURCE (ADDRES_TABNAME, ADDRES_USERCOL) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAFF_ADDRESOURCE ***
grant SELECT                                                                 on STAFF_ADDRESOURCE to BARSREADER_ROLE;
grant SELECT                                                                 on STAFF_ADDRESOURCE to BARS_DM;
grant SELECT                                                                 on STAFF_ADDRESOURCE to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STAFF_ADDRESOURCE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFF_ADDRESOURCE.sql =========*** End
PROMPT ===================================================================================== 
