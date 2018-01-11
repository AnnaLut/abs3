

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_NLS_KRM.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_NLS_KRM ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_NLS_KRM ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_NLS_KRM 
   (	NLS VARCHAR2(20), 
	KV NUMBER(*,0), 
	REF NUMBER, 
	NLS_2903 VARCHAR2(14)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_NLS_KRM ***
 exec bpa.alter_policies('TMP_NLS_KRM');


COMMENT ON TABLE BARS.TMP_NLS_KRM IS '';
COMMENT ON COLUMN BARS.TMP_NLS_KRM.NLS IS '';
COMMENT ON COLUMN BARS.TMP_NLS_KRM.KV IS '';
COMMENT ON COLUMN BARS.TMP_NLS_KRM.REF IS '';
COMMENT ON COLUMN BARS.TMP_NLS_KRM.NLS_2903 IS '';



PROMPT *** Create  grants  TMP_NLS_KRM ***
grant SELECT                                                                 on TMP_NLS_KRM     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_NLS_KRM.sql =========*** End *** =
PROMPT ===================================================================================== 
