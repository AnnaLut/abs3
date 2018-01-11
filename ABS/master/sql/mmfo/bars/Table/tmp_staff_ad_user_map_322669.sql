

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_STAFF_AD_USER_MAP_322669.sql =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_STAFF_AD_USER_MAP_322669 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_STAFF_AD_USER_MAP_322669 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_STAFF_AD_USER_MAP_322669 
   (	BRANCH VARCHAR2(30 CHAR), 
	BARS_LOGIN VARCHAR2(30 CHAR), 
	AD_LOGIN VARCHAR2(300 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_STAFF_AD_USER_MAP_322669 ***
 exec bpa.alter_policies('TMP_STAFF_AD_USER_MAP_322669');


COMMENT ON TABLE BARS.TMP_STAFF_AD_USER_MAP_322669 IS '';
COMMENT ON COLUMN BARS.TMP_STAFF_AD_USER_MAP_322669.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_STAFF_AD_USER_MAP_322669.BARS_LOGIN IS '';
COMMENT ON COLUMN BARS.TMP_STAFF_AD_USER_MAP_322669.AD_LOGIN IS '';




PROMPT *** Create  constraint SYS_C00138040 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFF_AD_USER_MAP_322669 MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00138041 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFF_AD_USER_MAP_322669 MODIFY (AD_LOGIN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_STAFF_AD_USER_MAP_322669 ***
grant SELECT                                                                 on TMP_STAFF_AD_USER_MAP_322669 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_STAFF_AD_USER_MAP_322669.sql =====
PROMPT ===================================================================================== 
