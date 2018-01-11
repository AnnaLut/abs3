

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CHECK_TIME_TTS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CHECK_TIME_TTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CHECK_TIME_TTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CHECK_TIME_TTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CHECK_TIME_TTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CHECK_TIME_TTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CHECK_TIME_TTS 
   (	TT CHAR(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CHECK_TIME_TTS ***
 exec bpa.alter_policies('CHECK_TIME_TTS');


COMMENT ON TABLE BARS.CHECK_TIME_TTS IS '';
COMMENT ON COLUMN BARS.CHECK_TIME_TTS.TT IS '';



PROMPT *** Create  grants  CHECK_TIME_TTS ***
grant SELECT                                                                 on CHECK_TIME_TTS  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CHECK_TIME_TTS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CHECK_TIME_TTS  to BARS_DM;
grant SELECT                                                                 on CHECK_TIME_TTS  to START1;
grant SELECT                                                                 on CHECK_TIME_TTS  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CHECK_TIME_TTS.sql =========*** End **
PROMPT ===================================================================================== 
