

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_AUTHORIZATIONS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_AUTHORIZATIONS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_AUTHORIZATIONS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_AUTHORIZATIONS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_AUTHORIZATIONS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_AUTHORIZATIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_AUTHORIZATIONS 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_AUTHORIZATIONS ***
 exec bpa.alter_policies('WCS_AUTHORIZATIONS');


COMMENT ON TABLE BARS.WCS_AUTHORIZATIONS IS 'Карты авторизации';
COMMENT ON COLUMN BARS.WCS_AUTHORIZATIONS.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.WCS_AUTHORIZATIONS.NAME IS 'Наименование';




PROMPT *** Create  constraint PK_AUTHORIZATIONS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_AUTHORIZATIONS ADD CONSTRAINT PK_AUTHORIZATIONS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AUTHORIZATIONS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_AUTHORIZATIONS MODIFY (NAME CONSTRAINT CC_AUTHORIZATIONS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_AUTHORIZATIONS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_AUTHORIZATIONS ON BARS.WCS_AUTHORIZATIONS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_AUTHORIZATIONS ***
grant SELECT                                                                 on WCS_AUTHORIZATIONS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_AUTHORIZATIONS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_AUTHORIZATIONS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_AUTHORIZATIONS to START1;
grant SELECT                                                                 on WCS_AUTHORIZATIONS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_AUTHORIZATIONS.sql =========*** En
PROMPT ===================================================================================== 
