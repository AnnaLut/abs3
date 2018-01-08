

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TTS_KOMP.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TTS_KOMP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TTS_KOMP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TTS_KOMP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TTS_KOMP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TTS_KOMP ***
begin 
  execute immediate '
  CREATE TABLE BARS.TTS_KOMP 
   (	TT CHAR(3), 
	NFILE VARCHAR2(12)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TTS_KOMP ***
 exec bpa.alter_policies('TTS_KOMP');


COMMENT ON TABLE BARS.TTS_KOMP IS '';
COMMENT ON COLUMN BARS.TTS_KOMP.TT IS '';
COMMENT ON COLUMN BARS.TTS_KOMP.NFILE IS '';




PROMPT *** Create  constraint XPK_TTS_KOMP ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_KOMP ADD CONSTRAINT XPK_TTS_KOMP PRIMARY KEY (TT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_TTS_KOMP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_TTS_KOMP ON BARS.TTS_KOMP (TT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TTS_KOMP ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TTS_KOMP        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TTS_KOMP        to REF0000;
grant FLASHBACK,SELECT                                                       on TTS_KOMP        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TTS_KOMP.sql =========*** End *** ====
PROMPT ===================================================================================== 
