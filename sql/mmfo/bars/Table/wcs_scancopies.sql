

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SCANCOPIES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SCANCOPIES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SCANCOPIES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SCANCOPIES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SCANCOPIES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SCANCOPIES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SCANCOPIES 
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




PROMPT *** ALTER_POLICIES to WCS_SCANCOPIES ***
 exec bpa.alter_policies('WCS_SCANCOPIES');


COMMENT ON TABLE BARS.WCS_SCANCOPIES IS 'Карты сканкопий';
COMMENT ON COLUMN BARS.WCS_SCANCOPIES.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.WCS_SCANCOPIES.NAME IS 'Наименование';




PROMPT *** Create  constraint PK_SCANCOPIES ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCANCOPIES ADD CONSTRAINT PK_SCANCOPIES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCANCOPIES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCANCOPIES MODIFY (NAME CONSTRAINT CC_SCANCOPIES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SCANCOPIES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SCANCOPIES ON BARS.WCS_SCANCOPIES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SCANCOPIES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SCANCOPIES  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SCANCOPIES  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SCANCOPIES  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SCANCOPIES.sql =========*** End **
PROMPT ===================================================================================== 
