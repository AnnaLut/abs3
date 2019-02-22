prompt table (IOT) FINMON_PEP_NAMES_DICT
begin
    bpa.alter_policy_info('FINMON_PEP_NAMES_DICT', 'WHOLE', null, null, null, null);
    bpa.alter_policy_info('FINMON_PEP_NAMES_DICT', 'FILIAL', null, null, null, null);
end;
/
begin
    execute immediate '
create table finmon_pep_names_dict
(
pep_id number,
search_name varchar2(150),
constraint XPK_FINMON_PEP_NAMES_DICT primary key (search_name, pep_id),
constraint R_FINMON_PEP_NAMES_ID foreign key (pep_id) references finmon_pep_dict (id)
)
organization index
tablespace BRSDYNI
';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
comment on table finmon_pep_names_dict is 'Справочник альтернативных имен/названий публ. деятелей (pep.org.ua)';
comment on column finmon_pep_names_dict.pep_id is 'Искуственный номер для идентификации в справочнике';
comment on column finmon_pep_names_dict.search_name is 'Искуственное поле для поиска';