

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SV_OZN.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SV_OZN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SV_OZN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SV_OZN'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SV_OZN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SV_OZN ***
begin 
  execute immediate '
  CREATE TABLE BARS.SV_OZN 
   (	ID NUMBER(2,0), 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SV_OZN ***
 exec bpa.alter_policies('SV_OZN');


COMMENT ON TABLE BARS.SV_OZN IS 'ќзнака особи';
COMMENT ON COLUMN BARS.SV_OZN.ID IS '»д.';
COMMENT ON COLUMN BARS.SV_OZN.NAME IS 'ќзнака особи';




PROMPT *** Create  constraint PK_SVOZN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_OZN ADD CONSTRAINT PK_SVOZN PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVOZN_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_OZN MODIFY (ID CONSTRAINT CC_SVOZN_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVOZN_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_OZN MODIFY (NAME CONSTRAINT CC_SVOZN_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SVOZN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SVOZN ON BARS.SV_OZN (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SV_OZN ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SV_OZN          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SV_OZN          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SV_OZN          to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SV_OZN.sql =========*** End *** ======
PROMPT ===================================================================================== 
