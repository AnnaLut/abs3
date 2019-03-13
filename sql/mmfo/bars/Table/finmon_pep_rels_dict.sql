prompt table (IOT) FINMON_PEP_RELS_DICT
begin
    bpa.alter_policy_info('FINMON_PEP_RELS_DICT', 'WHOLE', null, null, null, null);
    bpa.alter_policy_info('FINMON_PEP_RELS_DICT', 'FILIAL', null, null, null, null);
end;
/
begin
    execute immediate '
create table finmon_pep_rels_dict
(
pep_id number,
relationship_type varchar2(150),
relationship_type_en varchar2(150),
person_uk varchar2(150),
person_en varchar2(150),
search_name varchar2(150),
constraint XPK_FINMON_PEP_RELS_DICT primary key (search_name, pep_id)
)
organization index
tablespace brsdyni
';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
comment on table finmon_pep_rels_dict is '���������� ��������� ��� ����. �������� (pep.org.ua)';
comment on column finmon_pep_rels_dict.pep_id is '������������ ����� ��� ������������� � �����������';
comment on column finmon_pep_rels_dict.search_name is '������������ ���� ��� ������';

begin
    execute immediate 'alter table finmon_pep_rels_dict drop constraint R_FINMON_PEP_RELS_ID';
exception
    when others then
        if sqlcode = -2443 then null; else raise; end if;
end;
/