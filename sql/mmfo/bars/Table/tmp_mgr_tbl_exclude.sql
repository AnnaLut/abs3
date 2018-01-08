

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_MGR_TBL_EXCLUDE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_MGR_TBL_EXCLUDE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_MGR_TBL_EXCLUDE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_MGR_TBL_EXCLUDE 
   (	TABLE_NAME VARCHAR2(30 CHAR), 
	COMM CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_MGR_TBL_EXCLUDE ***
 exec bpa.alter_policies('TMP_MGR_TBL_EXCLUDE');


COMMENT ON TABLE BARS.TMP_MGR_TBL_EXCLUDE IS '';
COMMENT ON COLUMN BARS.TMP_MGR_TBL_EXCLUDE.TABLE_NAME IS '';
COMMENT ON COLUMN BARS.TMP_MGR_TBL_EXCLUDE.COMM IS '';



PROMPT *** Create  grants  TMP_MGR_TBL_EXCLUDE ***
grant SELECT                                                                 on TMP_MGR_TBL_EXCLUDE to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_MGR_TBL_EXCLUDE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_MGR_TBL_EXCLUDE.sql =========*** E
PROMPT ===================================================================================== 
