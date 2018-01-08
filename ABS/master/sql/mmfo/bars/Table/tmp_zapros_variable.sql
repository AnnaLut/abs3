

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ZAPROS_VARIABLE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ZAPROS_VARIABLE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ZAPROS_VARIABLE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ZAPROS_VARIABLE 
   (	TAG VARCHAR2(30), 
	NAME VARCHAR2(160), 
	VALUE VARCHAR2(50), 
	USERID NUMBER, 
	KODZ NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ZAPROS_VARIABLE ***
 exec bpa.alter_policies('TMP_ZAPROS_VARIABLE');


COMMENT ON TABLE BARS.TMP_ZAPROS_VARIABLE IS '';
COMMENT ON COLUMN BARS.TMP_ZAPROS_VARIABLE.TAG IS '';
COMMENT ON COLUMN BARS.TMP_ZAPROS_VARIABLE.NAME IS '';
COMMENT ON COLUMN BARS.TMP_ZAPROS_VARIABLE.VALUE IS '';
COMMENT ON COLUMN BARS.TMP_ZAPROS_VARIABLE.USERID IS '';
COMMENT ON COLUMN BARS.TMP_ZAPROS_VARIABLE.KODZ IS '';



PROMPT *** Create  grants  TMP_ZAPROS_VARIABLE ***
grant SELECT                                                                 on TMP_ZAPROS_VARIABLE to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_ZAPROS_VARIABLE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ZAPROS_VARIABLE.sql =========*** E
PROMPT ===================================================================================== 
