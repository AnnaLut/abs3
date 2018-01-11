

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_USER.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_USER ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_USER ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_USER 
   (	USER_NAME VARCHAR2(100 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_USER ***
 exec bpa.alter_policies('TMP_USER');


COMMENT ON TABLE BARS.TMP_USER IS '';
COMMENT ON COLUMN BARS.TMP_USER.USER_NAME IS '';



PROMPT *** Create  grants  TMP_USER ***
grant SELECT                                                                 on TMP_USER        to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_USER        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_USER.sql =========*** End *** ====
PROMPT ===================================================================================== 
