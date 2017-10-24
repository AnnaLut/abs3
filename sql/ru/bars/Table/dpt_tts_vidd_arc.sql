prompt -------------------------------------
prompt  создание таблицы DPT_TTS_VIDD
prompt -------------------------------------
/

exec bpa.alter_policy_info( 'DPT_TTS_VIDD_ARC', 'WHOLE' , null, null, null, null ); 
exec bpa.alter_policy_info( 'DPT_TTS_VIDD_ARC', 'FILIAL', null, null, null, null );

begin
  execute immediate 'CREATE TABLE DPT_TTS_VIDD_ARC
(
  VIDD    NUMBER(38) CONSTRAINT CC_DPTTTSVIDDA_VIDD_NN NOT NULL,
  TT      CHAR(3 BYTE) CONSTRAINT CC_DPTTTSVIDDA_TT_NN NOT NULL,
  ISMAIN  NUMBER(1)
)TABLESPACE brssmld';
exception when others then if (sqlcode = -955) then null; else raise; end if;
end;
/


COMMENT ON TABLE DPT_TTS_VIDD_ARC IS 'Допустимые операции по видам вкладов';
COMMENT ON COLUMN DPT_TTS_VIDD_ARC.VIDD IS 'Код вида вклада';
COMMENT ON COLUMN DPT_TTS_VIDD_ARC.TT IS 'Код операции'
/

