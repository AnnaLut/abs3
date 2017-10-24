

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_PROC.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_PROC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_PROC ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_PROC 
   (	DPT_ID NUMBER(10,0), 
	PR NUMBER(22,2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_PROC ***
 exec bpa.alter_policies('TMP_PROC');


COMMENT ON TABLE BARS.TMP_PROC IS '';
COMMENT ON COLUMN BARS.TMP_PROC.DPT_ID IS '';
COMMENT ON COLUMN BARS.TMP_PROC.PR IS '';




PROMPT *** Create  index I1_TMPPROC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.I1_TMPPROC ON BARS.TMP_PROC (DPT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_PROC.sql =========*** End *** ====
PROMPT ===================================================================================== 
