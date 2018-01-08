

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_R013_NEW.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_R013_NEW ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_R013_NEW ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_R013_NEW 
   (	R020 VARCHAR2(4), 
	R013 VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_R013_NEW ***
 exec bpa.alter_policies('TMP_R013_NEW');


COMMENT ON TABLE BARS.TMP_R013_NEW IS '';
COMMENT ON COLUMN BARS.TMP_R013_NEW.R020 IS '';
COMMENT ON COLUMN BARS.TMP_R013_NEW.R013 IS '';




PROMPT *** Create  index I1_TMP_R013_NEW ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.I1_TMP_R013_NEW ON BARS.TMP_R013_NEW (R020, R013) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_R013_NEW.sql =========*** End *** 
PROMPT ===================================================================================== 
