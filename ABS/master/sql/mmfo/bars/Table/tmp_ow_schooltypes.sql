

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OW_SCHOOLTYPES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OW_SCHOOLTYPES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OW_SCHOOLTYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OW_SCHOOLTYPES 
   (	SCHOOLTYPEID NUMBER(*,0), 
	INFO VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OW_SCHOOLTYPES ***
 exec bpa.alter_policies('TMP_OW_SCHOOLTYPES');


COMMENT ON TABLE BARS.TMP_OW_SCHOOLTYPES IS '';
COMMENT ON COLUMN BARS.TMP_OW_SCHOOLTYPES.SCHOOLTYPEID IS '';
COMMENT ON COLUMN BARS.TMP_OW_SCHOOLTYPES.INFO IS '';



PROMPT *** Create  grants  TMP_OW_SCHOOLTYPES ***
grant SELECT                                                                 on TMP_OW_SCHOOLTYPES to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_OW_SCHOOLTYPES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OW_SCHOOLTYPES.sql =========*** En
PROMPT ===================================================================================== 
