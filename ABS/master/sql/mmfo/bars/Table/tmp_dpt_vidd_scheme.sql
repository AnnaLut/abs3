

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_DPT_VIDD_SCHEME.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_DPT_VIDD_SCHEME ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_DPT_VIDD_SCHEME ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_DPT_VIDD_SCHEME 
   (	TYPE_ID NUMBER, 
	VIDD NUMBER, 
	FLAGS NUMBER, 
	ID VARCHAR2(100), 
	ID_FR VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_DPT_VIDD_SCHEME ***
 exec bpa.alter_policies('TMP_DPT_VIDD_SCHEME');


COMMENT ON TABLE BARS.TMP_DPT_VIDD_SCHEME IS '';
COMMENT ON COLUMN BARS.TMP_DPT_VIDD_SCHEME.TYPE_ID IS '';
COMMENT ON COLUMN BARS.TMP_DPT_VIDD_SCHEME.VIDD IS '';
COMMENT ON COLUMN BARS.TMP_DPT_VIDD_SCHEME.FLAGS IS '';
COMMENT ON COLUMN BARS.TMP_DPT_VIDD_SCHEME.ID IS '';
COMMENT ON COLUMN BARS.TMP_DPT_VIDD_SCHEME.ID_FR IS '';




PROMPT *** Create  constraint SYS_C00138508 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPT_VIDD_SCHEME MODIFY (TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00138509 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPT_VIDD_SCHEME MODIFY (FLAGS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_DPT_VIDD_SCHEME ***
grant SELECT                                                                 on TMP_DPT_VIDD_SCHEME to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_DPT_VIDD_SCHEME.sql =========*** E
PROMPT ===================================================================================== 
