

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_AUDIT_MIGR.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_AUDIT_MIGR ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_AUDIT_MIGR ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_AUDIT_MIGR 
   (	STRING_VALUE VARCHAR2(100), 
	DATE_VALUE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_AUDIT_MIGR ***
 exec bpa.alter_policies('TMP_AUDIT_MIGR');


COMMENT ON TABLE BARS.TMP_AUDIT_MIGR IS '';
COMMENT ON COLUMN BARS.TMP_AUDIT_MIGR.STRING_VALUE IS '';
COMMENT ON COLUMN BARS.TMP_AUDIT_MIGR.DATE_VALUE IS '';



PROMPT *** Create  grants  TMP_AUDIT_MIGR ***
grant SELECT                                                                 on TMP_AUDIT_MIGR  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_AUDIT_MIGR.sql =========*** End **
PROMPT ===================================================================================== 
