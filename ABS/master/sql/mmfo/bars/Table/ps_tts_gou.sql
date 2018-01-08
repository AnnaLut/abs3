

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PS_TTS_GOU.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PS_TTS_GOU ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PS_TTS_GOU ***
begin 
  execute immediate '
  CREATE TABLE BARS.PS_TTS_GOU 
   (	TT CHAR(3), 
	NBS CHAR(4), 
	DK NUMBER(*,0), 
	OB22 CHAR(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PS_TTS_GOU ***
 exec bpa.alter_policies('PS_TTS_GOU');


COMMENT ON TABLE BARS.PS_TTS_GOU IS '';
COMMENT ON COLUMN BARS.PS_TTS_GOU.TT IS '';
COMMENT ON COLUMN BARS.PS_TTS_GOU.NBS IS '';
COMMENT ON COLUMN BARS.PS_TTS_GOU.DK IS '';
COMMENT ON COLUMN BARS.PS_TTS_GOU.OB22 IS '';




PROMPT *** Create  constraint SYS_C008972 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS_TTS_GOU MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008973 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS_TTS_GOU MODIFY (NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008974 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS_TTS_GOU MODIFY (DK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PS_TTS_GOU ***
grant SELECT                                                                 on PS_TTS_GOU      to BARSREADER_ROLE;
grant SELECT                                                                 on PS_TTS_GOU      to BARS_DM;
grant SELECT                                                                 on PS_TTS_GOU      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PS_TTS_GOU.sql =========*** End *** ==
PROMPT ===================================================================================== 
