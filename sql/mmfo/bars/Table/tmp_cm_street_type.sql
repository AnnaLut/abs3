

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CM_STREET_TYPE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CM_STREET_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CM_STREET_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CM_STREET_TYPE 
   (	ID NUMBER(10,0), 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CM_STREET_TYPE ***
 exec bpa.alter_policies('TMP_CM_STREET_TYPE');


COMMENT ON TABLE BARS.TMP_CM_STREET_TYPE IS '';
COMMENT ON COLUMN BARS.TMP_CM_STREET_TYPE.ID IS '';
COMMENT ON COLUMN BARS.TMP_CM_STREET_TYPE.NAME IS '';



PROMPT *** Create  grants  TMP_CM_STREET_TYPE ***
grant SELECT                                                                 on TMP_CM_STREET_TYPE to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_CM_STREET_TYPE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CM_STREET_TYPE.sql =========*** En
PROMPT ===================================================================================== 
