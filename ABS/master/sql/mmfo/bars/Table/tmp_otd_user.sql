

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OTD_USER.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OTD_USER ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OTD_USER ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OTD_USER 
   (	OTD NUMBER(38,0), 
	USERID NUMBER(38,0), 
	PR NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OTD_USER ***
 exec bpa.alter_policies('TMP_OTD_USER');


COMMENT ON TABLE BARS.TMP_OTD_USER IS '';
COMMENT ON COLUMN BARS.TMP_OTD_USER.OTD IS '';
COMMENT ON COLUMN BARS.TMP_OTD_USER.USERID IS '';
COMMENT ON COLUMN BARS.TMP_OTD_USER.PR IS '';




PROMPT *** Create  constraint SYS_C00132463 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OTD_USER MODIFY (OTD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132464 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OTD_USER MODIFY (USERID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_OTD_USER ***
grant SELECT                                                                 on TMP_OTD_USER    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OTD_USER.sql =========*** End *** 
PROMPT ===================================================================================== 
