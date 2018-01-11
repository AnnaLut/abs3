

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KP_TTS.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KP_TTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KP_TTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KP_TTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KP_TTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KP_TTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.KP_TTS 
   (	TT CHAR(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KP_TTS ***
 exec bpa.alter_policies('KP_TTS');


COMMENT ON TABLE BARS.KP_TTS IS 'Справочник операций для комунальных платежей';
COMMENT ON COLUMN BARS.KP_TTS.TT IS 'Код операции';



PROMPT *** Create  grants  KP_TTS ***
grant SELECT                                                                 on KP_TTS          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KP_TTS          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KP_TTS          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KP_TTS          to START1;
grant SELECT                                                                 on KP_TTS          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KP_TTS          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KP_TTS.sql =========*** End *** ======
PROMPT ===================================================================================== 
