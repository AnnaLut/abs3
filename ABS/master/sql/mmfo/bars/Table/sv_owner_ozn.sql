

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SV_OWNER_OZN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SV_OWNER_OZN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SV_OWNER_OZN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SV_OWNER_OZN'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SV_OWNER_OZN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SV_OWNER_OZN ***
begin 
  execute immediate '
  CREATE TABLE BARS.SV_OWNER_OZN 
   (	ID NUMBER(1,0), 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SV_OWNER_OZN ***
 exec bpa.alter_policies('SV_OWNER_OZN');


COMMENT ON TABLE BARS.SV_OWNER_OZN IS 'Тип істотної участі';
COMMENT ON COLUMN BARS.SV_OWNER_OZN.ID IS 'Ід.';
COMMENT ON COLUMN BARS.SV_OWNER_OZN.NAME IS 'Тип істотної участі';




PROMPT *** Create  constraint CC_SVOWNEROZN_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_OWNER_OZN ADD CONSTRAINT CC_SVOWNEROZN_ID_NN CHECK (ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVOWNEROZN_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_OWNER_OZN ADD CONSTRAINT CC_SVOWNEROZN_NAME_NN CHECK (NAME IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SV_OWNER_OZN ***
grant SELECT                                                                 on SV_OWNER_OZN    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SV_OWNER_OZN    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SV_OWNER_OZN    to RPBN002;
grant SELECT                                                                 on SV_OWNER_OZN    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SV_OWNER_OZN.sql =========*** End *** 
PROMPT ===================================================================================== 
