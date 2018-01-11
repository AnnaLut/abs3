

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_W4_PRODUCT_GROUPS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_W4_PRODUCT_GROUPS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_W4_PRODUCT_GROUPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_W4_PRODUCT_GROUPS 
   (	CODE VARCHAR2(32), 
	NAME VARCHAR2(100), 
	SCHEME_ID NUMBER(22,0), 
	DATE_OPEN DATE, 
	DATE_CLOSE DATE, 
	CLIENT_TYPE NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_W4_PRODUCT_GROUPS ***
 exec bpa.alter_policies('TMP_W4_PRODUCT_GROUPS');


COMMENT ON TABLE BARS.TMP_W4_PRODUCT_GROUPS IS '';
COMMENT ON COLUMN BARS.TMP_W4_PRODUCT_GROUPS.CODE IS '';
COMMENT ON COLUMN BARS.TMP_W4_PRODUCT_GROUPS.NAME IS '';
COMMENT ON COLUMN BARS.TMP_W4_PRODUCT_GROUPS.SCHEME_ID IS '';
COMMENT ON COLUMN BARS.TMP_W4_PRODUCT_GROUPS.DATE_OPEN IS '';
COMMENT ON COLUMN BARS.TMP_W4_PRODUCT_GROUPS.DATE_CLOSE IS '';
COMMENT ON COLUMN BARS.TMP_W4_PRODUCT_GROUPS.CLIENT_TYPE IS '';




PROMPT *** Create  constraint SYS_C00119200 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_W4_PRODUCT_GROUPS MODIFY (CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119201 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_W4_PRODUCT_GROUPS MODIFY (CLIENT_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_W4_PRODUCT_GROUPS ***
grant SELECT                                                                 on TMP_W4_PRODUCT_GROUPS to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_W4_PRODUCT_GROUPS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_W4_PRODUCT_GROUPS.sql =========***
PROMPT ===================================================================================== 
