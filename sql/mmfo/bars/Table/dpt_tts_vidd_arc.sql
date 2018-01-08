

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_TTS_VIDD_ARC.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_TTS_VIDD_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_TTS_VIDD_ARC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_TTS_VIDD_ARC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_TTS_VIDD_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_TTS_VIDD_ARC 
   (	VIDD NUMBER(38,0), 
	TT CHAR(3), 
	ISMAIN NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_TTS_VIDD_ARC ***
 exec bpa.alter_policies('DPT_TTS_VIDD_ARC');


COMMENT ON TABLE BARS.DPT_TTS_VIDD_ARC IS 'Допустимые операции по видам вкладов';
COMMENT ON COLUMN BARS.DPT_TTS_VIDD_ARC.VIDD IS 'Код вида вклада';
COMMENT ON COLUMN BARS.DPT_TTS_VIDD_ARC.TT IS 'Код операции';
COMMENT ON COLUMN BARS.DPT_TTS_VIDD_ARC.ISMAIN IS '';




PROMPT *** Create  constraint CC_DPTTTSVIDDA_VIDD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TTS_VIDD_ARC MODIFY (VIDD CONSTRAINT CC_DPTTTSVIDDA_VIDD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTTTSVIDDA_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TTS_VIDD_ARC MODIFY (TT CONSTRAINT CC_DPTTTSVIDDA_TT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_TTS_VIDD_ARC ***
grant SELECT                                                                 on DPT_TTS_VIDD_ARC to BARSREADER_ROLE;
grant SELECT                                                                 on DPT_TTS_VIDD_ARC to BARS_DM;
grant SELECT                                                                 on DPT_TTS_VIDD_ARC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_TTS_VIDD_ARC.sql =========*** End 
PROMPT ===================================================================================== 
