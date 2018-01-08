

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_DPT_VIDD_EXTYPES_BCK.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_DPT_VIDD_EXTYPES_BCK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_DPT_VIDD_EXTYPES_BCK ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_DPT_VIDD_EXTYPES_BCK 
   (	ID NUMBER(38,0), 
	NAME VARCHAR2(100), 
	BONUS_PROC VARCHAR2(3000), 
	BONUS_RATE VARCHAR2(3000), 
	EXT_CONDITION VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_DPT_VIDD_EXTYPES_BCK ***
 exec bpa.alter_policies('TMP_DPT_VIDD_EXTYPES_BCK');


COMMENT ON TABLE BARS.TMP_DPT_VIDD_EXTYPES_BCK IS '';
COMMENT ON COLUMN BARS.TMP_DPT_VIDD_EXTYPES_BCK.ID IS '';
COMMENT ON COLUMN BARS.TMP_DPT_VIDD_EXTYPES_BCK.NAME IS '';
COMMENT ON COLUMN BARS.TMP_DPT_VIDD_EXTYPES_BCK.BONUS_PROC IS '';
COMMENT ON COLUMN BARS.TMP_DPT_VIDD_EXTYPES_BCK.BONUS_RATE IS '';
COMMENT ON COLUMN BARS.TMP_DPT_VIDD_EXTYPES_BCK.EXT_CONDITION IS '';




PROMPT *** Create  constraint SYS_C00138502 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPT_VIDD_EXTYPES_BCK MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00138503 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPT_VIDD_EXTYPES_BCK MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_DPT_VIDD_EXTYPES_BCK ***
grant SELECT                                                                 on TMP_DPT_VIDD_EXTYPES_BCK to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_DPT_VIDD_EXTYPES_BCK.sql =========
PROMPT ===================================================================================== 
