

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REF_USER110.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REF_USER110 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REF_USER110 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_REF_USER110 
   (	REF NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_REF_USER110 ***
 exec bpa.alter_policies('TMP_REF_USER110');


COMMENT ON TABLE BARS.TMP_REF_USER110 IS '';
COMMENT ON COLUMN BARS.TMP_REF_USER110.REF IS '';



PROMPT *** Create  grants  TMP_REF_USER110 ***
grant SELECT                                                                 on TMP_REF_USER110 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REF_USER110.sql =========*** End *
PROMPT ===================================================================================== 
