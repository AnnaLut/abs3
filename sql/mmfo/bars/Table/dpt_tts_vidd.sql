

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_TTS_VIDD.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_TTS_VIDD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_TTS_VIDD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_TTS_VIDD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_TTS_VIDD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_TTS_VIDD ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_TTS_VIDD 
   (	VIDD NUMBER(38,0), 
	TT CHAR(3), 
	ISMAIN NUMBER(1,0), 
	 CONSTRAINT PK_DPTTTSVIDD PRIMARY KEY (VIDD, TT) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_TTS_VIDD ***
 exec bpa.alter_policies('DPT_TTS_VIDD');


COMMENT ON TABLE BARS.DPT_TTS_VIDD IS 'Допустимые операции по видам вкладов';
COMMENT ON COLUMN BARS.DPT_TTS_VIDD.VIDD IS 'Код вида вклада';
COMMENT ON COLUMN BARS.DPT_TTS_VIDD.TT IS 'Код операции';
COMMENT ON COLUMN BARS.DPT_TTS_VIDD.ISMAIN IS '';




PROMPT *** Create  constraint CC_DPTTTSVIDD_VIDD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TTS_VIDD MODIFY (VIDD CONSTRAINT CC_DPTTTSVIDD_VIDD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTTTSVIDD_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TTS_VIDD MODIFY (TT CONSTRAINT CC_DPTTTSVIDD_TT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTTTSVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TTS_VIDD ADD CONSTRAINT PK_DPTTTSVIDD PRIMARY KEY (VIDD, TT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTTTSVIDD_ISMAIN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TTS_VIDD ADD CONSTRAINT CC_DPTTTSVIDD_ISMAIN CHECK (ISMAIN = 1) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTTTSVIDD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTTTSVIDD ON BARS.DPT_TTS_VIDD (VIDD, TT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_TTS_VIDD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_TTS_VIDD    to ABS_ADMIN;
grant REFERENCES,SELECT                                                      on DPT_TTS_VIDD    to BARSAQ with grant option;
grant REFERENCES,SELECT                                                      on DPT_TTS_VIDD    to BARSAQ_ADM with grant option;
grant SELECT                                                                 on DPT_TTS_VIDD    to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_TTS_VIDD    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_TTS_VIDD    to BARS_DM;
grant DELETE,INSERT,SELECT                                                   on DPT_TTS_VIDD    to DPT;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_TTS_VIDD    to DPT_ADMIN;
grant SELECT                                                                 on DPT_TTS_VIDD    to DPT_ROLE;
grant SELECT                                                                 on DPT_TTS_VIDD    to KLBX;
grant SELECT                                                                 on DPT_TTS_VIDD    to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_TTS_VIDD    to VKLAD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_TTS_VIDD    to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DPT_TTS_VIDD    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_TTS_VIDD.sql =========*** End *** 
PROMPT ===================================================================================== 
