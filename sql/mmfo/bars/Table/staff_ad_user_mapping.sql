

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFF_AD_USER_MAPPING.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFF_AD_USER_MAPPING ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAFF_AD_USER_MAPPING'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_AD_USER_MAPPING'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_AD_USER_MAPPING'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFF_AD_USER_MAPPING ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFF_AD_USER_MAPPING 
   (	BRANCH VARCHAR2(30 CHAR), 
	BARS_LOGIN VARCHAR2(30 CHAR), 
	AD_LOGIN VARCHAR2(300 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFF_AD_USER_MAPPING ***
 exec bpa.alter_policies('STAFF_AD_USER_MAPPING');


COMMENT ON TABLE BARS.STAFF_AD_USER_MAPPING IS '';
COMMENT ON COLUMN BARS.STAFF_AD_USER_MAPPING.BRANCH IS '';
COMMENT ON COLUMN BARS.STAFF_AD_USER_MAPPING.BARS_LOGIN IS '';
COMMENT ON COLUMN BARS.STAFF_AD_USER_MAPPING.AD_LOGIN IS '';




PROMPT *** Create  constraint CC_BARS_LOGIN_IN_UPPER_CASE ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_AD_USER_MAPPING ADD CONSTRAINT CC_BARS_LOGIN_IN_UPPER_CASE CHECK (bars_login = upper(bars_login)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AD_LOGIN_NO_SPACES ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_AD_USER_MAPPING ADD CONSTRAINT CC_AD_LOGIN_NO_SPACES CHECK (ad_login = replace(ad_login, '' '')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AD_LOGIN_IN_UPPER_CASE ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_AD_USER_MAPPING ADD CONSTRAINT CC_AD_LOGIN_IN_UPPER_CASE CHECK (ad_login = upper(ad_login)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0085194 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_AD_USER_MAPPING MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0085195 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_AD_USER_MAPPING MODIFY (AD_LOGIN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BARS_LOGIN_NO_SPACES ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_AD_USER_MAPPING ADD CONSTRAINT CC_BARS_LOGIN_NO_SPACES CHECK (bars_login = replace(bars_login, '' '')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_STAFF_AD_USER_MAP_BARS_LOGIN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.I_STAFF_AD_USER_MAP_BARS_LOGIN ON BARS.STAFF_AD_USER_MAPPING (BARS_LOGIN, CASE  WHEN BARS_LOGIN IS NULL THEN NULL ELSE BRANCH END ) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_STAFF_AD_USER_MAP_AD_LOGIN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.I_STAFF_AD_USER_MAP_AD_LOGIN ON BARS.STAFF_AD_USER_MAPPING (AD_LOGIN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFF_AD_USER_MAPPING.sql =========***
PROMPT ===================================================================================== 
