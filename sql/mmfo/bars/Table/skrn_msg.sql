

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/skrn_msg.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to skrn_msg ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''skrn_msg'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''skrn_msg'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''skrn_msg'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END;  
/

PROMPT *** Create  table skrn_msg ***
begin 
  execute immediate 
    ' create table skrn_msg'||
    ' ('||
    '   msg_id      integer,'||
    '   change_time date default sysdate not null,'||
    '   branch      varchar2(30) not null,'||
    '   nd          number not null,'||
    '   type_sms    char(6) not null,'||
    '   state       number,'||
    '   error       varchar2(254)'||
    ' )';
exception when others then 
  if sqlcode=-955 then null; else raise; end if;
end;
/




PROMPT *** ALTER_POLICIES to skrn_msg ***
 exec bpa.alter_policies('skrn_msg');


comment on column skrn_msg.msg_id is '��� ���';
comment on column skrn_msg.change_time is '���� �������� � ������� ���';
comment on column skrn_msg.branch is '�����';
comment on column skrn_msg.nd is '����� ��������';
comment on column skrn_msg.type_sms is '��� ���';
comment on column skrn_msg.state is '������: 1-���������� � �������; 0 - �� ����������';
comment on column skrn_msg.error is '������';


PROMPT *** Create  constraint skrn_msg_id ***
begin 
  execute immediate 
    'alter table SKRN_MSG add constraint SKRN_MSG_PR primary key (BRANCH, ND)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  index skrn_msg_norm ***
begin 
  execute immediate 
    'create index skrn_msg_norm on skrn_msg (branch, nd, type_sms)';
exception when others then 
  if sqlcode=-955 then null; else raise; end if;
end;
/


PROMPT *** Create  grants  skrn_msg ***
grant select on skrn_msg to BARSREADER_ROLE;
grant select, insert, update, delete on skrn_msg to BARS_ACCESS_DEFROLE;
grant select on skrn_msg to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/skrn_msg.sql =========*** End *** =====
PROMPT ===================================================================================== 
