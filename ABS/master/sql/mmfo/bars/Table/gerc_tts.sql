

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GERC_TTS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GERC_TTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GERC_TTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''GERC_TTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GERC_TTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.GERC_TTS 
   (	TT CHAR(3), 
	NAME VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GERC_TTS ***
 exec bpa.alter_policies('GERC_TTS');


COMMENT ON TABLE BARS.GERC_TTS IS 'Операции, доступные для приема из ГЕРЦ';
COMMENT ON COLUMN BARS.GERC_TTS.TT IS 'Код операции';
COMMENT ON COLUMN BARS.GERC_TTS.NAME IS 'Описние операции/название';




PROMPT *** Create  constraint PK_GERC_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GERC_TTS ADD CONSTRAINT PK_GERC_TTS PRIMARY KEY (TT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_GERC_TTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_GERC_TTS ON BARS.GERC_TTS (TT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GERC_TTS ***
grant SELECT                                                                 on GERC_TTS        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GERC_TTS        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GERC_TTS.sql =========*** End *** ====
PROMPT ===================================================================================== 
