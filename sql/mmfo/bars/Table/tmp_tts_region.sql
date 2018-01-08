

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_TTS_REGION.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_TTS_REGION ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_TTS_REGION ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_TTS_REGION 
   (	TT VARCHAR2(3), 
	NLS_TYPE VARCHAR2(30), 
	KF VARCHAR2(6), 
	NLS_STMT VARCHAR2(2000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_TTS_REGION ***
 exec bpa.alter_policies('TMP_TTS_REGION');


COMMENT ON TABLE BARS.TMP_TTS_REGION IS '';
COMMENT ON COLUMN BARS.TMP_TTS_REGION.TT IS '';
COMMENT ON COLUMN BARS.TMP_TTS_REGION.NLS_TYPE IS '';
COMMENT ON COLUMN BARS.TMP_TTS_REGION.KF IS '';
COMMENT ON COLUMN BARS.TMP_TTS_REGION.NLS_STMT IS '';




PROMPT *** Create  constraint PK_TTS_REGION ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TTS_REGION ADD CONSTRAINT PK_TTS_REGION PRIMARY KEY (TT, NLS_TYPE, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TTS_REGION ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TTS_REGION ON BARS.TMP_TTS_REGION (TT, NLS_TYPE, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_TTS_REGION ***
grant SELECT                                                                 on TMP_TTS_REGION  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_TTS_REGION.sql =========*** End **
PROMPT ===================================================================================== 
