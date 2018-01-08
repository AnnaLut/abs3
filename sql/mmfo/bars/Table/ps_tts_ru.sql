

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PS_TTS_RU.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PS_TTS_RU ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PS_TTS_RU ***
begin 
  execute immediate '
  CREATE TABLE BARS.PS_TTS_RU 
   (	ID NUMBER(38,0), 
	TT CHAR(3), 
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




PROMPT *** ALTER_POLICIES to PS_TTS_RU ***
 exec bpa.alter_policies('PS_TTS_RU');


COMMENT ON TABLE BARS.PS_TTS_RU IS '';
COMMENT ON COLUMN BARS.PS_TTS_RU.ID IS '';
COMMENT ON COLUMN BARS.PS_TTS_RU.TT IS '';
COMMENT ON COLUMN BARS.PS_TTS_RU.NBS IS '';
COMMENT ON COLUMN BARS.PS_TTS_RU.DK IS '';
COMMENT ON COLUMN BARS.PS_TTS_RU.OB22 IS '';




PROMPT *** Create  constraint SYS_C008760 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS_TTS_RU MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008761 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS_TTS_RU MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008762 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS_TTS_RU MODIFY (NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008763 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS_TTS_RU MODIFY (DK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PS_TTS_RU ***
grant SELECT                                                                 on PS_TTS_RU       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PS_TTS_RU       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PS_TTS_RU       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on PS_TTS_RU       to START1;
grant SELECT                                                                 on PS_TTS_RU       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PS_TTS_RU.sql =========*** End *** ===
PROMPT ===================================================================================== 
