

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_NLSLIST3.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_NLSLIST3 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_NLSLIST3 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_NLSLIST3 
   (	NLS VARCHAR2(50), 
	DAZS VARCHAR2(50), 
	PASS_DATE VARCHAR2(50), 
	PASS_STATE VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_NLSLIST3 ***
 exec bpa.alter_policies('TMP_NLSLIST3');


COMMENT ON TABLE BARS.TMP_NLSLIST3 IS '';
COMMENT ON COLUMN BARS.TMP_NLSLIST3.NLS IS '';
COMMENT ON COLUMN BARS.TMP_NLSLIST3.DAZS IS '';
COMMENT ON COLUMN BARS.TMP_NLSLIST3.PASS_DATE IS '';
COMMENT ON COLUMN BARS.TMP_NLSLIST3.PASS_STATE IS '';



PROMPT *** Create  grants  TMP_NLSLIST3 ***
grant SELECT                                                                 on TMP_NLSLIST3    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_NLSLIST3.sql =========*** End *** 
PROMPT ===================================================================================== 
