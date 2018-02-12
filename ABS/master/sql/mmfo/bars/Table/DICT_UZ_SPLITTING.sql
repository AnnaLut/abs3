begin
  execute immediate 'begin bpa.alter_policy_info(''DICT_UZ_SPLITTING'', ''WHOLE'',  null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/
 begin
  execute immediate 'begin bpa.alter_policy_info(''DICT_UZ_SPLITTING'', ''FILIAL'', null, null, null , null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/ 
BEGIN
   execute immediate 'create table DICT_UZ_SPLITTING (
ID number(5),
NLS varchar2(15),
MFO varchar2(12),
KV INTEGER,
ACC_TYPE NUMBER(2),
ACC_TYPE_N VARCHAR2(255),
SP_KOEF NUMBER,
constraint PK_DICT_UZ_SPLITTING primary key (ID)
) tablespace BRSSMLD';
  exception when others then
  if sqlcode = -955 then null;
  else raise;
  end if;
 END;
/
COMMENT ON TABLE DICT_UZ_SPLITTING IS 'Довідник розщеплення коштів по рахунку ПАТ «Укрзалізниця»';
/
COMMENT ON COLUMN DICT_UZ_SPLITTING.NLS IS 'Рахунок';
/
COMMENT ON COLUMN DICT_UZ_SPLITTING.MFO IS 'MFO';
/
COMMENT ON COLUMN DICT_UZ_SPLITTING.KV IS 'Код валюти';
/
COMMENT ON COLUMN DICT_UZ_SPLITTING.ACC_TYPE IS 'Тип запису';
/
COMMENT ON COLUMN DICT_UZ_SPLITTING.ACC_TYPE_N IS 'Назва типу запису';
/
COMMENT ON COLUMN DICT_UZ_SPLITTING.SP_KOEF IS 'Коефіціент розщеплення';
/
begin
  execute immediate 'begin BARS_POLICY_ADM.ALTER_POLICIES(''DICT_UZ_SPLITTING''); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/
grant all on DICT_UZ_SPLITTING to bars_access_defrole;
/
grant all on DICT_UZ_SPLITTING to bars;
/
commit;
/
