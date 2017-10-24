prompt -------------------------------------
prompt  создание таблицы dpt_vidd_scheme_arc
prompt  Статусы депозитных договоров
prompt -------------------------------------
/

exec bpa.alter_policy_info( 'DPT_VIDD_SCHEME_ARC', 'WHOLE' , null, null, null, null ); 
exec bpa.alter_policy_info( 'DPT_VIDD_SCHEME_ARC', 'FILIAL', null, null, null, null );

begin
  execute immediate 'CREATE TABLE DPT_VIDD_SCHEME_ARC(
  TYPE_ID  NUMBER CONSTRAINT CC_DPTVIDDSCHEME_ARC_TID_NN NOT NULL,
  VIDD     NUMBER,
  FLAGS    NUMBER                               DEFAULT 1 CONSTRAINT CC_DPTVIDDSCHEME_ARC_FLAGS_NN NOT NULL,
  ID       VARCHAR2(100 BYTE),
  ID_FR    VARCHAR2(100 BYTE)
) TABLESPACE brsmdld';
exception when others then if (sqlcode = -955) then null; else raise; end if;
end;
/

COMMENT ON TABLE DPT_VIDD_SCHEME_ARC IS 'Код вида дополнительного соглашения';
COMMENT ON COLUMN DPT_VIDD_SCHEME_ARC.TYPE_ID IS 'Код продукту';
COMMENT ON COLUMN DPT_VIDD_SCHEME_ARC.VIDD IS 'Код виду вкладу (субпордукту)';
COMMENT ON COLUMN DPT_VIDD_SCHEME_ARC.FLAGS IS 'Код додаткової угоди';
COMMENT ON COLUMN DPT_VIDD_SCHEME_ARC.ID IS 'Ідентифікатор шаблону';
COMMENT ON COLUMN DPT_VIDD_SCHEME_ARC.ID_FR IS 'Ідентифікатор шаблону (FastReports)';
/

GRANT ALL ON DPT_VIDD_SCHEME_ARC TO BARS_ACCESS_DEFROLE;
/
