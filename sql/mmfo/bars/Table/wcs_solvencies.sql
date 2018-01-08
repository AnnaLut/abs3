

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SOLVENCIES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SOLVENCIES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SOLVENCIES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SOLVENCIES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SOLVENCIES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SOLVENCIES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SOLVENCIES 
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




PROMPT *** ALTER_POLICIES to WCS_SOLVENCIES ***
 exec bpa.alter_policies('WCS_SOLVENCIES');


COMMENT ON TABLE BARS.WCS_SOLVENCIES IS 'Карты кредитоспособности';
COMMENT ON COLUMN BARS.WCS_SOLVENCIES.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.WCS_SOLVENCIES.NAME IS 'Наименование';




PROMPT *** Create  constraint PK_SOLVENCIES ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SOLVENCIES ADD CONSTRAINT PK_SOLVENCIES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOLVENCIES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SOLVENCIES MODIFY (NAME CONSTRAINT CC_SOLVENCIES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SOLVENCIES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SOLVENCIES ON BARS.WCS_SOLVENCIES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SOLVENCIES ***
grant SELECT                                                                 on WCS_SOLVENCIES  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SOLVENCIES  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SOLVENCIES  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SOLVENCIES  to START1;
grant SELECT                                                                 on WCS_SOLVENCIES  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SOLVENCIES.sql =========*** End **
PROMPT ===================================================================================== 
