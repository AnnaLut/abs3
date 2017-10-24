prompt -------------------------------------
prompt  �������� ������� dpt_vidd_scheme_arc
prompt  ������� ���������� ���������
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

COMMENT ON TABLE DPT_VIDD_SCHEME_ARC IS '��� ���� ��������������� ����������';
COMMENT ON COLUMN DPT_VIDD_SCHEME_ARC.TYPE_ID IS '��� ��������';
COMMENT ON COLUMN DPT_VIDD_SCHEME_ARC.VIDD IS '��� ���� ������ (�����������)';
COMMENT ON COLUMN DPT_VIDD_SCHEME_ARC.FLAGS IS '��� ��������� �����';
COMMENT ON COLUMN DPT_VIDD_SCHEME_ARC.ID IS '������������� �������';
COMMENT ON COLUMN DPT_VIDD_SCHEME_ARC.ID_FR IS '������������� ������� (FastReports)';
/

GRANT ALL ON DPT_VIDD_SCHEME_ARC TO BARS_ACCESS_DEFROLE;
/
