

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SERVICES.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SERVICES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SERVICES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SERVICES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SERVICES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SERVICES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SERVICES 
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




PROMPT *** ALTER_POLICIES to WCS_SERVICES ***
 exec bpa.alter_policies('WCS_SERVICES');


COMMENT ON TABLE BARS.WCS_SERVICES IS 'Службы';
COMMENT ON COLUMN BARS.WCS_SERVICES.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.WCS_SERVICES.NAME IS 'Наименование';




PROMPT *** Create  constraint PK_WCSSERVICES ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SERVICES ADD CONSTRAINT PK_WCSSERVICES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSSERVICES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SERVICES MODIFY (NAME CONSTRAINT CC_WCSSERVICES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSSERVICES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSSERVICES ON BARS.WCS_SERVICES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SERVICES ***
grant SELECT,UPDATE                                                          on WCS_SERVICES    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SERVICES    to BARS_DM;
grant SELECT                                                                 on WCS_SERVICES    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SERVICES.sql =========*** End *** 
PROMPT ===================================================================================== 
