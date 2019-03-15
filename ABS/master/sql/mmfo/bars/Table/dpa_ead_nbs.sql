prompt ===========================================
prompt = �������� ������� DPA_EAD_NBS
prompt = �������� ������� ��� ���������� ���� � ��
prompt ===========================================

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPA_EAD_NBS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPA_EAD_NBS ***
execute bpa.alter_policy_info( 'DPA_EAD_NBS', 'WHOLE' , null, null, null, null ); 
execute bpa.alter_policy_info( 'DPA_EAD_NBS', 'FILIAL', null, null, null, null );


-- Create table
begin
  execute immediate '
create table DPA_EAD_NBS
(
  struct_code varchar2(30) not null,
  nbs         varchar2(4)  not null,
  custtype    integer      not null,
  oper_type   number(1)    not null,
  tip         varchar2(30) not null,
  is_ddbo     number(1)    not null,
  agr_type    varchar2(100) not null,
  acc_type    varchar2(100),
  name        varchar2(256),
  id          number(38) not null
)
tablespace BRSSMLD';
exception when others then if (sqlcode = -955) then null; else raise; end if;
end;
/



PROMPT *** ALTER_POLICIES to DPA_EAD_NBS ***
execute bpa.alter_policies('DPA_EAD_NBS');


COMMENT ON TABLE DPA_EAD_NBS              IS '�������� ������� ��� ������������ � ��';
COMMENT ON COLUMN DPA_EAD_NBS.struct_code IS '��� ���������';
COMMENT ON COLUMN DPA_EAD_NBS.NBS         IS '���������� ������� �� ��������';
COMMENT ON COLUMN DPA_EAD_NBS.CUSTTYPE    IS '���������� ��� ����� ���� �볺���';
COMMENT ON COLUMN DPA_EAD_NBS.OPER_TYPE   IS '��� ��������: 1 - �������� �������, 2 - �������� �������';
COMMENT ON COLUMN DPA_EAD_NBS.TIP         IS '��� ������� (��� ����� -  TIP%)  � ����������� �������� TIPS';
COMMENT ON COLUMN DPA_EAD_NBS.IS_DDBO     IS '������ ��� 1 - ��� / 0 - ͳ';
COMMENT ON COLUMN DPA_EAD_NBS.AGR_TYPE    IS '��� �����, ���� ����������, ���� � ������ - �� �����������';
COMMENT ON COLUMN DPA_EAD_NBS.ACC_TYPE    IS '��� �������, ���� ����������, ���� � ������ - �� �����������';
COMMENT ON COLUMN DPA_EAD_NBS.NAME        IS '����� ���� ���������';
COMMENT ON COLUMN DPA_EAD_NBS.id          IS '��������� �������������';

PROMPT *** Create  index UK_DPAEADNBS ***
begin
--  execute immediate 'drop INDEX PK_EADNBS';
  execute immediate 'CREATE UNIQUE INDEX UK_DPAEADNBS ON DPA_EAD_NBS (struct_code,nbs,custtype,oper_type,tip,is_ddbo) TABLESPACE brssmli';
exception when others then if (sqlcode = -955) then null; else raise; end if;
end;
/

PROMPT *** Create constraint PK_DPAEADNBS_ID ***
begin
    execute immediate 'alter table DPA_EAD_NBS
                       add constraint PK_DPAEADNBS_ID primary key (ID)
                       using index';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

PROMPT *** Create  grants  DPA_EAD_NBS ***
GRANT SELECT ON DPA_EAD_NBS TO BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPA_EAD_NBS.sql =========*** End *** =====
PROMPT ===================================================================================== 
