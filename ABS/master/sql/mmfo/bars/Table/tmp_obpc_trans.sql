

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OBPC_TRANS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OBPC_TRANS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OBPC_TRANS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OBPC_TRANS 
   (	TRAN_TYPE CHAR(2), 
	NAME VARCHAR2(45), 
	BOF NUMBER(38,0), 
	DK NUMBER(1,0), 
	NAME_RUSS VARCHAR2(40)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OBPC_TRANS ***
 exec bpa.alter_policies('TMP_OBPC_TRANS');


COMMENT ON TABLE BARS.TMP_OBPC_TRANS IS '';
COMMENT ON COLUMN BARS.TMP_OBPC_TRANS.TRAN_TYPE IS '';
COMMENT ON COLUMN BARS.TMP_OBPC_TRANS.NAME IS '';
COMMENT ON COLUMN BARS.TMP_OBPC_TRANS.BOF IS '';
COMMENT ON COLUMN BARS.TMP_OBPC_TRANS.DK IS '';
COMMENT ON COLUMN BARS.TMP_OBPC_TRANS.NAME_RUSS IS '';




PROMPT *** Create  constraint SYS_C00119216 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OBPC_TRANS MODIFY (TRAN_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119218 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OBPC_TRANS MODIFY (DK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119217 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OBPC_TRANS MODIFY (BOF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OBPC_TRANS.sql =========*** End **
PROMPT ===================================================================================== 
