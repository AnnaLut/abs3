

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REF_KODDZ.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REF_KODDZ ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REF_KODDZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_REF_KODDZ 
   (	REF NUMBER, 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_REF_KODDZ ***
 exec bpa.alter_policies('TMP_REF_KODDZ');


COMMENT ON TABLE BARS.TMP_REF_KODDZ IS '';
COMMENT ON COLUMN BARS.TMP_REF_KODDZ.REF IS '';
COMMENT ON COLUMN BARS.TMP_REF_KODDZ.KF IS '';



PROMPT *** Create  grants  TMP_REF_KODDZ ***
grant SELECT                                                                 on TMP_REF_KODDZ   to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_REF_KODDZ   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REF_KODDZ.sql =========*** End ***
PROMPT ===================================================================================== 
