

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_DPT_VIDD_EXTDESC_BCK.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_DPT_VIDD_EXTDESC_BCK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_DPT_VIDD_EXTDESC_BCK ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_DPT_VIDD_EXTDESC_BCK 
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




PROMPT *** ALTER_POLICIES to TMP_DPT_VIDD_EXTDESC_BCK ***
 exec bpa.alter_policies('TMP_DPT_VIDD_EXTDESC_BCK');


COMMENT ON TABLE BARS.TMP_DPT_VIDD_EXTDESC_BCK IS '';
COMMENT ON COLUMN BARS.TMP_DPT_VIDD_EXTDESC_BCK.TYPE_ID IS '';
COMMENT ON COLUMN BARS.TMP_DPT_VIDD_EXTDESC_BCK.EXT_NUM IS '';
COMMENT ON COLUMN BARS.TMP_DPT_VIDD_EXTDESC_BCK.TERM_MNTH IS '';
COMMENT ON COLUMN BARS.TMP_DPT_VIDD_EXTDESC_BCK.TERM_DAYS IS '';
COMMENT ON COLUMN BARS.TMP_DPT_VIDD_EXTDESC_BCK.INDV_RATE IS '';
COMMENT ON COLUMN BARS.TMP_DPT_VIDD_EXTDESC_BCK.OPER_ID IS '';
COMMENT ON COLUMN BARS.TMP_DPT_VIDD_EXTDESC_BCK.BASE_RATE IS '';
COMMENT ON COLUMN BARS.TMP_DPT_VIDD_EXTDESC_BCK.METHOD_ID IS '';




PROMPT *** Create  constraint SYS_C00138504 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPT_VIDD_EXTDESC_BCK MODIFY (TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00138505 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPT_VIDD_EXTDESC_BCK MODIFY (EXT_NUM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00138506 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPT_VIDD_EXTDESC_BCK MODIFY (TERM_MNTH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00138507 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPT_VIDD_EXTDESC_BCK MODIFY (TERM_DAYS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_DPT_VIDD_EXTDESC_BCK ***
grant SELECT                                                                 on TMP_DPT_VIDD_EXTDESC_BCK to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_DPT_VIDD_EXTDESC_BCK.sql =========
PROMPT ===================================================================================== 
