exec bpa.alter_policy_info( 'DPA_PARAMS', 'WHOLE' , null, null, null, null ); 
exec bpa.alter_policy_info( 'DPA_PARAMS', 'FILIAL', null, null, null, null );
begin
  execute immediate 'CREATE TABLE DPA_PARAMS(
  PAR   VARCHAR2(10 BYTE),
  VAL   VARCHAR2(100 BYTE),
  COMM  VARCHAR2(100 BYTE),
  KF    VARCHAR2(6 BYTE)                        DEFAULT sys_context(''bars_context'',''user_mfo'') CONSTRAINT CC_DPA_PARAMS_KF_NN NOT NULL) tablespace BRSSMLD';
exception when others then if (sqlcode = -955) then null; else raise; end if;
end;
/

COMMENT ON TABLE DPA_PARAMS IS 'DPA. Параметри модуля';

COMMENT ON COLUMN DPA_PARAMS.PAR IS 'Код параметру';
COMMENT ON COLUMN DPA_PARAMS.VAL IS 'Значення';
COMMENT ON COLUMN DPA_PARAMS.COMM IS 'Назва параметру';
/

begin
  execute immediate 'CREATE UNIQUE INDEX PK_DPA_PARAMS ON DPA_PARAMS (PAR)';
exception when others then if (sqlcode = -955) then null; else raise; end if;
end;
/  
begin
  execute immediate 'ALTER TABLE DPA_PARAMS ADD (
  CONSTRAINT FK_DPA_PARAMS_KF 
  FOREIGN KEY (KF) 
  REFERENCES BANKS$BASE (MFO)
  ENABLE VALIDATE)';
exception when others then if (sqlcode = -02275) then null; else raise; end if;
end;
/


GRANT DELETE, INSERT, SELECT, UPDATE, FLASHBACK ON DPA_PARAMS TO BARS_ACCESS_DEFROLE;
/