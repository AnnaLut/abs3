begin
bars_policy_adm.alter_policy_info('MOPER_ACCERTED_FILES','FILIAL',null, null, null, null);
end;
/
commit
/
begin
execute immediate 'CREATE TABLE MOPER_ACCERTED_FILES
(
  FNAME        VARCHAR2(100),
  FSUM         VARCHAR2(100),
  ACCDAT       DATE DEFAULT SYSDATE)';
  exception when others then
    if sqlcode=-955 then null; else raise; end if;
end;
/
COMMENT ON TABLE MOPER_ACCERTED_FILES IS 'Таблица оплаченых файлов MOPER'
/
COMMENT ON COLUMN MOPER_ACCERTED_FILES.FNAME IS 'Имя файла'
/
COMMENT ON COLUMN MOPER_ACCERTED_FILES.FSUM IS 'Контрольная сумма файла'
/
COMMENT ON COLUMN MOPER_ACCERTED_FILES.ACCDAT IS 'Дата оплаты'
/

begin
execute immediate 'ALTER TABLE MOPER_ACCERTED_FILES ADD CONSTRAINT XPK_MOPER_ACCERTED_FILES PRIMARY KEY (FNAME, FSUM)';
  exception when others then
    if sqlcode=-2260 then null; else raise; end if;
end;
/
    
CREATE OR REPLACE PUBLIC SYNONYM MOPER_ACCERTED_FILES FOR BARS.MOPER_ACCERTED_FILES
/