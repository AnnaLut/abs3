

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OW6_LOG.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OW6_LOG ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OW6_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OW6_LOG 
   (	REF NUMBER(38,0), 
	MSG VARCHAR2(100), 
	DAT_MSG DATE DEFAULT sysdate
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OW6_LOG ***
 exec bpa.alter_policies('TMP_OW6_LOG');


COMMENT ON TABLE BARS.TMP_OW6_LOG IS '';
COMMENT ON COLUMN BARS.TMP_OW6_LOG.REF IS '';
COMMENT ON COLUMN BARS.TMP_OW6_LOG.MSG IS '';
COMMENT ON COLUMN BARS.TMP_OW6_LOG.DAT_MSG IS '';




PROMPT *** Create  constraint SYS_C002951426 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OW6_LOG MODIFY (DAT_MSG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002951425 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OW6_LOG MODIFY (REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OW6_LOG.sql =========*** End *** =
PROMPT ===================================================================================== 
