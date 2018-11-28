prompt table file_archive
begin
    execute immediate q'[
create table file_archive
(
kf varchar2(6) default sys_context('bars_context', 'user_mfo'),
file_id number,
file_name varchar2(256),
description varchar2(4000),
file_data blob,
load_date date default sysdate,
file_status varchar2(2),
constraint xpk_file_archive primary key (file_id) using index tablespace brsmdli
)
tablespace brsmdld]';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
comment on table file_archive is '�������� �����';
comment on column file_archive.kf is '��� �������';
comment on column file_archive.file_id is '��';
comment on column file_archive.file_name is '��� �����';
comment on column file_archive.file_data is '������';
comment on column file_archive.load_date is '���� ��������';
comment on column file_archive.file_status is '������ �����';