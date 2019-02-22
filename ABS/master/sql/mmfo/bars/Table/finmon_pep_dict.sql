prompt table FINMON_PEP_DICT
begin
    bpa.alter_policy_info('FINMON_PEP_DICT', 'WHOLE', null, null, null, null);
    bpa.alter_policy_info('FINMON_PEP_DICT', 'FILIAL', null, null, null, null);
end;
/
begin
    execute immediate '
create table finmon_pep_dict
(
id number,
first_name varchar2(150),
last_name varchar2(150),
full_name varchar2(300),
first_name_en varchar2(150),
last_name_en varchar2(150),
full_name_en varchar2(300),
is_pep number(1),
type_of_official varchar2(100),
type_of_official_en varchar2(100),
patronymic varchar2(40),
patronymic_en varchar2(40),
date_of_birth varchar2(64),
died number(1),
last_job_title varchar2(4000),
last_workplace varchar2(4000),
url varchar2(512),
load_date date default sysdate,
search_name varchar2(150),
constraint XPK_FINMON_PEP_DICT primary key (id) using index tablespace BRSDYNI
)
tablespace BRSDYND
';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
alter table finmon_pep_dict modify last_job_title varchar2(4000);
alter table finmon_pep_dict modify last_workplace varchar2(4000);
alter table finmon_pep_dict modify first_name varchar2(150);
alter table finmon_pep_dict modify last_name varchar2(150);
alter table finmon_pep_dict modify first_name_en varchar2(150);
alter table finmon_pep_dict modify last_name_en varchar2(150);
alter table finmon_pep_dict modify full_name varchar2(300);
alter table finmon_pep_dict modify full_name_en varchar2(300);

alter table finmon_pep_dict modify patronymic varchar2(40);
alter table finmon_pep_dict modify patronymic_en varchar2(40);
alter table finmon_pep_dict modify url varchar2(512);


prompt index I_FINMON_PEP_DICT_SEARCHNAME
begin
    execute immediate 'create unique index I_FINMON_PEP_DICT_SEARCHNAME on finmon_pep_dict(search_name, id) tablespace brsdyni';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
prompt modify date_of_birth to varchar2 (if other type)
declare
l_dtype varchar2(64);
begin
    select DATA_TYPE into l_dtype from user_tab_columns t where table_name = 'FINMON_PEP_DICT' and column_name = 'DATE_OF_BIRTH';
    if l_dtype != 'VARCHAR2' then
        delete from finmon_pep_names_dict;
        delete from finmon_pep_rels_dict;
        delete from finmon_pep_dict;
        execute immediate 'alter table finmon_pep_dict modify date_of_birth varchar2(64)';
    end if;
end;
/
comment on table finmon_pep_dict is 'Справочник публичных деятелей (ПЕП) с pep.org.ua - осн. таблица';
comment on column finmon_pep_dict.id is 'Искуственный номер для идентификации в справочнике';
comment on column finmon_pep_dict.search_name is 'Искуственное поле для поиска';
comment on column finmon_pep_dict.load_date is 'Дата загрузки справочника';