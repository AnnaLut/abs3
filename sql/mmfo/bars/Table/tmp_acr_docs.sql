

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ACR_DOCS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ACR_DOCS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ACR_DOCS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ACR_DOCS 
   (	ACC NUMBER(38,0), 
	ID NUMBER(1,0), 
	INT_DATE DATE, 
	INT_REF NUMBER(38,0), 
	INT_REST NUMBER, 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ACR_DOCS ***
 exec bpa.alter_policies('TMP_ACR_DOCS');


COMMENT ON TABLE BARS.TMP_ACR_DOCS IS '';
COMMENT ON COLUMN BARS.TMP_ACR_DOCS.ACC IS '';
COMMENT ON COLUMN BARS.TMP_ACR_DOCS.ID IS '';
COMMENT ON COLUMN BARS.TMP_ACR_DOCS.INT_DATE IS '';
COMMENT ON COLUMN BARS.TMP_ACR_DOCS.INT_REF IS '';
COMMENT ON COLUMN BARS.TMP_ACR_DOCS.INT_REST IS '';
COMMENT ON COLUMN BARS.TMP_ACR_DOCS.KF IS '';




PROMPT *** Create  constraint SYS_C00136977 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ACR_DOCS MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00136978 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ACR_DOCS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00136979 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ACR_DOCS MODIFY (INT_REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00136980 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ACR_DOCS MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_ACR_DOCS ***
grant SELECT                                                                 on TMP_ACR_DOCS    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ACR_DOCS.sql =========*** End *** 
PROMPT ===================================================================================== 
