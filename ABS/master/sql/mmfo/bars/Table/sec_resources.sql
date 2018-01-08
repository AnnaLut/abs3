

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SEC_RESOURCES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SEC_RESOURCES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SEC_RESOURCES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SEC_RESOURCES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SEC_RESOURCES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SEC_RESOURCES ***
begin 
  execute immediate '
  CREATE TABLE BARS.SEC_RESOURCES 
   (	RES_ID NUMBER(38,0), 
	RES_NAME VARCHAR2(100), 
	RES_CODE VARCHAR2(30), 
	RES_TYPE CHAR(1) DEFAULT ''U'', 
	RES_PARENTID NUMBER(38,0), 
	RES_GRNTVIEWNAME VARCHAR2(30), 
	RES_ACCSVIEWNAME VARCHAR2(30), 
	RES_TABNAME VARCHAR2(30), 
	RES_USERCOL VARCHAR2(30), 
	RES_APPROVE CHAR(1), 
	RES_CONDITION VARCHAR2(2000), 
	RES_AFTERPROC VARCHAR2(90), 
	RES_LIST VARCHAR2(30), 
	RES_TIPSTABNAME VARCHAR2(30), 
	RES_TIPSGRNTVIEWNAME VARCHAR2(30), 
	RES_TIPSACCSVIEWNAME VARCHAR2(30), 
	RES_ADDTABCONDITION VARCHAR2(254)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SEC_RESOURCES ***
 exec bpa.alter_policies('SEC_RESOURCES');


COMMENT ON TABLE BARS.SEC_RESOURCES IS 'Справочник ресурсов комплекса';
COMMENT ON COLUMN BARS.SEC_RESOURCES.RES_ID IS 'Ид. ресурса';
COMMENT ON COLUMN BARS.SEC_RESOURCES.RES_NAME IS 'Наименование ресурса';
COMMENT ON COLUMN BARS.SEC_RESOURCES.RES_CODE IS 'Мнемонический код ресурса';
COMMENT ON COLUMN BARS.SEC_RESOURCES.RES_TYPE IS 'Тип ресурса (Системный/Прикладной)';
COMMENT ON COLUMN BARS.SEC_RESOURCES.RES_PARENTID IS 'Ид. родительского ресурса';
COMMENT ON COLUMN BARS.SEC_RESOURCES.RES_GRNTVIEWNAME IS 'Имя представления выданных ресурсов';
COMMENT ON COLUMN BARS.SEC_RESOURCES.RES_ACCSVIEWNAME IS 'Имя представления доступных ресурсов';
COMMENT ON COLUMN BARS.SEC_RESOURCES.RES_TABNAME IS 'Имя таблицы выданных ресурсов';
COMMENT ON COLUMN BARS.SEC_RESOURCES.RES_USERCOL IS 'Имя колонки с ид. пользователя в таблице выданных ресурсов';
COMMENT ON COLUMN BARS.SEC_RESOURCES.RES_APPROVE IS 'Признак подтверждаемого ресурса';
COMMENT ON COLUMN BARS.SEC_RESOURCES.RES_CONDITION IS '';
COMMENT ON COLUMN BARS.SEC_RESOURCES.RES_AFTERPROC IS '';
COMMENT ON COLUMN BARS.SEC_RESOURCES.RES_LIST IS 'Имя таблицы-списка ресурсов';
COMMENT ON COLUMN BARS.SEC_RESOURCES.RES_TIPSTABNAME IS 'Имя таблицы выданных типовым пользователям ресурсов';
COMMENT ON COLUMN BARS.SEC_RESOURCES.RES_TIPSGRNTVIEWNAME IS 'Имя представления выданных типовым пользователям ресурсов';
COMMENT ON COLUMN BARS.SEC_RESOURCES.RES_TIPSACCSVIEWNAME IS 'Имя представления доступных типовым пользователям ресурсов';
COMMENT ON COLUMN BARS.SEC_RESOURCES.RES_ADDTABCONDITION IS '';




PROMPT *** Create  constraint PK_SECRES ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_RESOURCES ADD CONSTRAINT PK_SECRES PRIMARY KEY (RES_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_SECRES ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_RESOURCES ADD CONSTRAINT UK_SECRES UNIQUE (RES_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECRES_APPROVE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_RESOURCES MODIFY (RES_APPROVE CONSTRAINT CC_SECRES_APPROVE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECRES_RESPARENTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_RESOURCES MODIFY (RES_PARENTID CONSTRAINT CC_SECRES_RESPARENTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECRES_RESTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_RESOURCES MODIFY (RES_TYPE CONSTRAINT CC_SECRES_RESTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECRES_RESNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_RESOURCES MODIFY (RES_NAME CONSTRAINT CC_SECRES_RESNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECRES_RESTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_RESOURCES ADD CONSTRAINT CC_SECRES_RESTYPE CHECK (res_type in (''S'', ''U'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECRES_APPROVE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_RESOURCES ADD CONSTRAINT CC_SECRES_APPROVE CHECK (res_approve in (''Y'', ''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SECRES_SECRES ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_RESOURCES ADD CONSTRAINT FK_SECRES_SECRES FOREIGN KEY (RES_PARENTID)
	  REFERENCES BARS.SEC_RESOURCES (RES_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECRES_RESID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_RESOURCES MODIFY (RES_ID CONSTRAINT CC_SECRES_RESID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SECRES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SECRES ON BARS.SEC_RESOURCES (RES_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_SECRES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_SECRES ON BARS.SEC_RESOURCES (RES_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SEC_RESOURCES ***
grant SELECT                                                                 on SEC_RESOURCES   to ABS_ADMIN;
grant SELECT                                                                 on SEC_RESOURCES   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SEC_RESOURCES   to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SEC_RESOURCES   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SEC_RESOURCES.sql =========*** End ***
PROMPT ===================================================================================== 
