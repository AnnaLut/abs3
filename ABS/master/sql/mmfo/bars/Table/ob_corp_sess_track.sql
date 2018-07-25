begin
  execute immediate 'begin bpa.alter_policy_info(''OB_CORP_SESS_TRACK'', ''WHOLE'',  null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/
 begin
  execute immediate 'begin bpa.alter_policy_info(''OB_CORP_SESS_TRACK'', ''FILIAL'', null, null, null , null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/ 
 
 BEGIN
   execute immediate 'create table OB_CORP_SESS_TRACK  (
   ID                   NUMBER(10)                      not null,
   SESS_ID              NUMBER(10)                      not null,
   STATE_ID             NUMBER(5)                       not null,
   ERR_SOURCE			VARCHAR2(255),
   ERR_REP              CLOB,
   ERR_ZIP				BLOB,
   ERR_XML				CLOB,
   SYS_TIME             DATE                            not null,
   USER_ID              NUMBER(5)                       not null
)
tablespace BRSDYND';
  exception when others then
  if sqlcode = -955 then null;
  else raise;
  end if;
 END;
/
begin
  execute immediate 'begin BARS_POLICY_ADM.ALTER_POLICIES(''OB_CORP_SESS_TRACK''); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/
grant all on OB_CORP_SESS_TRACK to bars_access_defrole;
/
grant all on OB_CORP_SESS_TRACK to bars;
/
commit;
/
comment on table OB_CORP_SESS_TRACK is 'Історія обробки сесій завантаження К-файлів';
/
comment on column OB_CORP_SESS_TRACK.ID is 'Ідентифікатор історії обробки';
/
comment on column OB_CORP_SESS_TRACK.SESS_ID is 'Сесія завантаження К-файлу';
/
comment on column OB_CORP_SESS_TRACK.STATE_ID is 'Стан обробки сесії';
/
comment on column OB_CORP_SESS_TRACK.ERR_REP is 'Сформована відповідь за результатами обробки файлу (звіт про прийняті дані та опис помилок)';
/
comment on column OB_CORP_SESS_TRACK.ERR_ZIP is 'Файл ZIP при обробці якого виникла помилка';
/
comment on column OB_CORP_SESS_TRACK.ERR_XML is 'Файл при обробці якого виникла помилка';
/
comment on column OB_CORP_SESS_TRACK.SYS_TIME is 'Системна дата/час зміни статусу';
/
comment on column OB_CORP_SESS_TRACK.USER_ID is 'Користувач, що виконав даний етап обробки файлу';
/
/*==============================================================*/
/* Index: OB_CORP_SESS_TRACK_IDX                                */
/*==============================================================*/
BEGIN
execute immediate '
CREATE UNIQUE INDEX BARS.PK_CORP_SESS_TRACK ON BARS.OB_CORP_SESS_TRACK(ID)
tablespace BRSDYNI';
exception when others then
  if sqlcode = -00955 then null; else raise; end if;
end;
/
BEGIN
execute immediate 'create index OB_CORP_SESS_TRACK_IDX on OB_CORP_SESS_TRACK(SESS_ID ASC)
tablespace BRSDYNI';
exception when others then
  if sqlcode = -00955 then null; else raise; end if;
end;
/
BEGIN
execute immediate '
ALTER TABLE BARS.OB_CORP_SESS_TRACK ADD (
  CONSTRAINT PK_CORP_SESS_TRACK
  PRIMARY KEY
  (ID)
  USING INDEX BARS.PK_CORP_SESS_TRACK
  ENABLE VALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

GRANT SELECT ON OB_CORP_SESS_TRACK TO BARS_ACCESS_DEFROLE;