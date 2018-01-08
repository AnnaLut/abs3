

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PHONE_CITY_CODE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PHONE_CITY_CODE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PHONE_CITY_CODE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PHONE_CITY_CODE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PHONE_CITY_CODE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PHONE_CITY_CODE ***
begin 
  execute immediate '
  CREATE TABLE BARS.PHONE_CITY_CODE 
   (	CITY_NAME VARCHAR2(100), 
	REGION VARCHAR2(100), 
	CITY_CODE VARCHAR2(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PHONE_CITY_CODE ***
 exec bpa.alter_policies('PHONE_CITY_CODE');


COMMENT ON TABLE BARS.PHONE_CITY_CODE IS 'Коди міст';
COMMENT ON COLUMN BARS.PHONE_CITY_CODE.CITY_NAME IS '';
COMMENT ON COLUMN BARS.PHONE_CITY_CODE.REGION IS '';
COMMENT ON COLUMN BARS.PHONE_CITY_CODE.CITY_CODE IS '';




PROMPT *** Create  constraint PK_PHONECITYCODE ***
begin   
 execute immediate '
  ALTER TABLE BARS.PHONE_CITY_CODE ADD CONSTRAINT PK_PHONECITYCODE PRIMARY KEY (CITY_CODE, CITY_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PHONECITYCODE_CITYNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PHONE_CITY_CODE MODIFY (CITY_NAME CONSTRAINT CC_PHONECITYCODE_CITYNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PHONECITYCODE_REGION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PHONE_CITY_CODE MODIFY (REGION CONSTRAINT CC_PHONECITYCODE_REGION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PHONECITYCODE_CITYCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PHONE_CITY_CODE MODIFY (CITY_CODE CONSTRAINT CC_PHONECITYCODE_CITYCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PHONECITYCODE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PHONECITYCODE ON BARS.PHONE_CITY_CODE (CITY_CODE, CITY_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PHONE_CITY_CODE ***
grant SELECT                                                                 on PHONE_CITY_CODE to BARSREADER_ROLE;
grant SELECT                                                                 on PHONE_CITY_CODE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PHONE_CITY_CODE to BARS_DM;
grant SELECT                                                                 on PHONE_CITY_CODE to CUST001;
grant SELECT                                                                 on PHONE_CITY_CODE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PHONE_CITY_CODE.sql =========*** End *
PROMPT ===================================================================================== 
