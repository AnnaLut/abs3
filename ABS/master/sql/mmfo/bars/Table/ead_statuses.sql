

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EAD_STATUSES.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EAD_STATUSES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EAD_STATUSES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EAD_STATUSES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EAD_STATUSES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EAD_STATUSES ***
begin 
  execute immediate '
  CREATE TABLE BARS.EAD_STATUSES 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(300)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EAD_STATUSES ***
 exec bpa.alter_policies('EAD_STATUSES');


COMMENT ON TABLE BARS.EAD_STATUSES IS 'Статуси повідомлення для відправки у ЕА';
COMMENT ON COLUMN BARS.EAD_STATUSES.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.EAD_STATUSES.NAME IS 'Найменування';




PROMPT *** Create  constraint PK_EADSTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_STATUSES ADD CONSTRAINT PK_EADSTS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADSTS_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_STATUSES MODIFY (ID CONSTRAINT CC_EADSTS_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADSTS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_STATUSES MODIFY (NAME CONSTRAINT CC_EADSTS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_EADSTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EADSTS ON BARS.EAD_STATUSES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EAD_STATUSES ***
grant SELECT                                                                 on EAD_STATUSES    to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EAD_STATUSES.sql =========*** End *** 
PROMPT ===================================================================================== 
