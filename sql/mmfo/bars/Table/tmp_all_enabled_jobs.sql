

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ALL_ENABLED_JOBS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ALL_ENABLED_JOBS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ALL_ENABLED_JOBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ALL_ENABLED_JOBS 
   (	OWNER VARCHAR2(20), 
	JOB_TYPE VARCHAR2(1), 
	JOB_NAME VARCHAR2(200)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ALL_ENABLED_JOBS ***
 exec bpa.alter_policies('TMP_ALL_ENABLED_JOBS');


COMMENT ON TABLE BARS.TMP_ALL_ENABLED_JOBS IS 'список включенных тригеров';
COMMENT ON COLUMN BARS.TMP_ALL_ENABLED_JOBS.OWNER IS '';
COMMENT ON COLUMN BARS.TMP_ALL_ENABLED_JOBS.JOB_TYPE IS '';
COMMENT ON COLUMN BARS.TMP_ALL_ENABLED_JOBS.JOB_NAME IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ALL_ENABLED_JOBS.sql =========*** 
PROMPT ===================================================================================== 
