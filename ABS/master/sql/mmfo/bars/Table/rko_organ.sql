

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RKO_ORGAN.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RKO_ORGAN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RKO_ORGAN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''RKO_ORGAN'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''RKO_ORGAN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RKO_ORGAN ***
begin 
  execute immediate '
  CREATE TABLE BARS.RKO_ORGAN 
   (	ID NUMBER(10,0), 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RKO_ORGAN ***
 exec bpa.alter_policies('RKO_ORGAN');


COMMENT ON TABLE BARS.RKO_ORGAN IS 'Орган управління';
COMMENT ON COLUMN BARS.RKO_ORGAN.ID IS '';
COMMENT ON COLUMN BARS.RKO_ORGAN.NAME IS '';




PROMPT *** Create  constraint PK_RKOORGAN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_ORGAN ADD CONSTRAINT PK_RKOORGAN PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RKOORGAN_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_ORGAN MODIFY (ID CONSTRAINT CC_RKOORGAN_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RKOORGAN_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_ORGAN MODIFY (NAME CONSTRAINT CC_RKOORGAN_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_RKOORGAN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_RKOORGAN ON BARS.RKO_ORGAN (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RKO_ORGAN ***
grant SELECT                                                                 on RKO_ORGAN       to BARSREADER_ROLE;
grant SELECT                                                                 on RKO_ORGAN       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RKO_ORGAN       to BARS_DM;
grant SELECT                                                                 on RKO_ORGAN       to CUST001;
grant SELECT                                                                 on RKO_ORGAN       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RKO_ORGAN.sql =========*** End *** ===
PROMPT ===================================================================================== 
