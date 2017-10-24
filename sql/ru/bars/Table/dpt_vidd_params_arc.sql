prompt -------------------------------------
prompt  создание таблицы DPT_VIDD_PARAMS_ARC
prompt  Значения доп.параметров видов вкладов
prompt -------------------------------------
/

exec bpa.alter_policy_info( 'DPT_VIDD_PARAMS_ARC', 'WHOLE' , null, null, null, null ); 
exec bpa.alter_policy_info( 'DPT_VIDD_PARAMS_ARC', 'FILIAL', null, null, null, null );

begin
  execute immediate 'CREATE TABLE DPT_VIDD_PARAMS_ARC(
  VIDD  NUMBER(38) CONSTRAINT CC_DPTVIDDPARAMS_VIDDa_NN NOT NULL,
  TAG   VARCHAR2(16 BYTE) CONSTRAINT CC_DPTVIDDPARAMSa_TAG_NN NOT NULL,
  VAL   VARCHAR2(3000 BYTE) CONSTRAINT CC_DPTVIDDPARAMSa_VAL_NN NOT NULL) TABLESPACE brsmdld';
exception when others then if (sqlcode = -955) then null; else raise; end if;
end;
/

COMMENT ON TABLE DPT_VIDD_PARAMS_ARC IS 'Значения доп.параметров видов вкладов';
COMMENT ON COLUMN DPT_VIDD_PARAMS_ARC.VIDD  IS 'Код вида вклада';
COMMENT ON COLUMN DPT_VIDD_PARAMS_ARC.TAG   IS 'Код доп.параметра';
COMMENT ON COLUMN DPT_VIDD_PARAMS_ARC.VAL   IS 'Значение доп.параметра';
/ 

GRANT ALL ON DPT_VIDD_PARAMS_ARC TO BARS_ACCESS_DEFROLE;
/
