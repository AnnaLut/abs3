

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_DPT_VIDD_EXTDESC.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_DPT_VIDD_EXTDESC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_DPT_VIDD_EXTDESC ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_DPT_VIDD_EXTDESC 
   (	TYPE_ID NUMBER(38,0), 
	EXT_NUM NUMBER(38,0), 
	TERM_MNTH NUMBER(38,0), 
	TERM_DAYS NUMBER(38,0), 
	INDV_RATE NUMBER(20,4), 
	OPER_ID NUMBER(38,0), 
	BASE_RATE NUMBER(38,0), 
	METHOD_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_DPT_VIDD_EXTDESC ***
 exec bpa.alter_policies('TMP_DPT_VIDD_EXTDESC');


COMMENT ON TABLE BARS.TMP_DPT_VIDD_EXTDESC IS '';
COMMENT ON COLUMN BARS.TMP_DPT_VIDD_EXTDESC.TYPE_ID IS '';
COMMENT ON COLUMN BARS.TMP_DPT_VIDD_EXTDESC.EXT_NUM IS '';
COMMENT ON COLUMN BARS.TMP_DPT_VIDD_EXTDESC.TERM_MNTH IS '';
COMMENT ON COLUMN BARS.TMP_DPT_VIDD_EXTDESC.TERM_DAYS IS '';
COMMENT ON COLUMN BARS.TMP_DPT_VIDD_EXTDESC.INDV_RATE IS '';
COMMENT ON COLUMN BARS.TMP_DPT_VIDD_EXTDESC.OPER_ID IS '';
COMMENT ON COLUMN BARS.TMP_DPT_VIDD_EXTDESC.BASE_RATE IS '';
COMMENT ON COLUMN BARS.TMP_DPT_VIDD_EXTDESC.METHOD_ID IS '';




PROMPT *** Create  constraint SYS_C00119353 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPT_VIDD_EXTDESC MODIFY (TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119356 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPT_VIDD_EXTDESC MODIFY (TERM_DAYS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119355 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPT_VIDD_EXTDESC MODIFY (TERM_MNTH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119354 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPT_VIDD_EXTDESC MODIFY (EXT_NUM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_DPT_VIDD_EXTDESC.sql =========*** 
PROMPT ===================================================================================== 
