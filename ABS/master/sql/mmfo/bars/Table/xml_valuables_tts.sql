

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML_VALUABLES_TTS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML_VALUABLES_TTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML_VALUABLES_TTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''XML_VALUABLES_TTS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''XML_VALUABLES_TTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML_VALUABLES_TTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML_VALUABLES_TTS 
   (	TT VARCHAR2(3), 
	NBS VARCHAR2(4), 
	NLS VARCHAR2(14), 
	ALLOWED_NLS VARCHAR2(200)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML_VALUABLES_TTS ***
 exec bpa.alter_policies('XML_VALUABLES_TTS');


COMMENT ON TABLE BARS.XML_VALUABLES_TTS IS 'Таблица связки операций и счетов по ценностям оффл.,';
COMMENT ON COLUMN BARS.XML_VALUABLES_TTS.TT IS '';
COMMENT ON COLUMN BARS.XML_VALUABLES_TTS.NBS IS '';
COMMENT ON COLUMN BARS.XML_VALUABLES_TTS.NLS IS '';
COMMENT ON COLUMN BARS.XML_VALUABLES_TTS.ALLOWED_NLS IS '';




PROMPT *** Create  constraint XPK_XMLVALTTS_TT ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_VALUABLES_TTS ADD CONSTRAINT XPK_XMLVALTTS_TT PRIMARY KEY (TT, NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_XMLVALTTS_TT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_XMLVALTTS_TT ON BARS.XML_VALUABLES_TTS (TT, NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML_VALUABLES_TTS ***
grant SELECT                                                                 on XML_VALUABLES_TTS to BARSAQ;
grant SELECT                                                                 on XML_VALUABLES_TTS to BARS_DM;
grant SELECT                                                                 on XML_VALUABLES_TTS to KLBX;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML_VALUABLES_TTS.sql =========*** End
PROMPT ===================================================================================== 
