

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_STAFFTIP_TTS_060317_MMFO2.sql ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_STAFFTIP_TTS_060317_MMFO2 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_STAFFTIP_TTS_060317_MMFO2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_STAFFTIP_TTS_060317_MMFO2 
   (	ID NUMBER(22,0), 
	TT CHAR(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_STAFFTIP_TTS_060317_MMFO2 ***
 exec bpa.alter_policies('TMP_STAFFTIP_TTS_060317_MMFO2');


COMMENT ON TABLE BARS.TMP_STAFFTIP_TTS_060317_MMFO2 IS '';
COMMENT ON COLUMN BARS.TMP_STAFFTIP_TTS_060317_MMFO2.ID IS '';
COMMENT ON COLUMN BARS.TMP_STAFFTIP_TTS_060317_MMFO2.TT IS '';




PROMPT *** Create  constraint SYS_C00110816 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFFTIP_TTS_060317_MMFO2 MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00110817 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFFTIP_TTS_060317_MMFO2 MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_STAFFTIP_TTS_060317_MMFO2 ***
grant SELECT                                                                 on TMP_STAFFTIP_TTS_060317_MMFO2 to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_STAFFTIP_TTS_060317_MMFO2 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_STAFFTIP_TTS_060317_MMFO2.sql ====
PROMPT ===================================================================================== 
