

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/META_NSIFUNCTION.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to META_NSIFUNCTION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''META_NSIFUNCTION'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''META_NSIFUNCTION'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''META_NSIFUNCTION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

prompt ... 


-- Create table
begin 
    execute immediate 'create table META_NSIFUNCTION
(
  tabid          NUMBER(38) not null,
  funcid         NUMBER(10) not null,
  descr          VARCHAR2(100),
  proc_name      VARCHAR2(254),
  proc_par       VARCHAR2(254),
  proc_exec      VARCHAR2(30),
  qst            VARCHAR2(254),
  msg            VARCHAR2(254),
  form_name      VARCHAR2(254),
  check_func     VARCHAR2(254),
  web_form_name  VARCHAR2(508),
  icon_id        NUMBER,
  custom_options CLOB
)
tablespace BRSSMLD
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 64K
    minextents 1
    maxextents unlimited
  )';
exception when others then       
    if sqlcode = -955 then null; else raise; 
    end if; 
end; 
/

begin 
   execute immediate('alter table META_NSIFUNCTION add custom_options clob ');
exception when others then 
   null; 
end;
/

-- Add comments to the table 
comment on table META_NSIFUNCTION
  is '�������� �������, ����������� �� ������������';
-- Add comments to the columns 
comment on column META_NSIFUNCTION.tabid
  is '��� �������';
comment on column META_NSIFUNCTION.funcid
  is '��. ������� ��� ����������';
comment on column META_NSIFUNCTION.descr
  is '�������� �������';
comment on column META_NSIFUNCTION.proc_name
  is 'Sql-��������� � �����������';
comment on column META_NSIFUNCTION.proc_par
  is '�������� ���������� ��� Sql-���������';
comment on column META_NSIFUNCTION.proc_exec
  is '�������� ��������� ���������';
comment on column META_NSIFUNCTION.qst
  is '������ ����� �����������';
comment on column META_NSIFUNCTION.msg
  is '��������� ����� �������� ���������� ���������';
comment on column META_NSIFUNCTION.form_name
  is '������� �������';
comment on column META_NSIFUNCTION.check_func
  is '������� ��������';
comment on column META_NSIFUNCTION.web_form_name
  is '������� WEB';
comment on column META_NSIFUNCTION.icon_id
  is '��� ������ ��� ������';
comment on column META_NSIFUNCTION.custom_options
  is '�������������� ��������� �������';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table META_NSIFUNCTION
  add constraint PK_METANSIFUNCTION primary key (TABID, FUNCID)
  using index 
  tablespace BRSSMLD
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 64K
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


PROMPT *** ADD COLUMN  custom_options***
begin 
   execute immediate('alter table META_NSIFUNCTION add custom_options clob ');
exception when others then 
   null; 
end;
/

COMMENT ON TABLE BARS.META_NSIFUNCTION IS '�������� �������, ����������� �� ������������';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.WEB_FORM_NAME IS '������� WEB';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.ICON_ID IS '��� ������ ��� ������';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.TABID IS '��� �������';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.FUNCID IS '��. ������� ��� ����������';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.DESCR IS '�������� �������';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.PROC_NAME IS 'Sql-��������� � �����������';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.PROC_PAR IS '�������� ���������� ��� Sql-���������';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.PROC_EXEC IS '�������� ��������� ���������';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.QST IS '������ ����� �����������';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.MSG IS '��������� ����� �������� ���������� ���������';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.FORM_NAME IS '������� �������';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.CHECK_FUNC IS '������� ��������';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.CUSTOM_OPTIONS IS '�������������� �����e��� �������';



PROMPT *** Create  constraint CC_METANSIFUNCTION_DESCR_NN ***
begin   
    execute immediate 'alter table META_NSIFUNCTION
  add constraint FK_METANSIFUNCTION_ICONID foreign key (ICON_ID)
  references META_ICONS (ICON_ID)
  novalidate';
exception when others then
    if sqlcode = -2275 then null; else raise; 
    end if; 
 end;
/


begin   
    execute immediate 'alter table META_NSIFUNCTION
  add constraint FK_METANSIFUNCTION_METATABLES foreign key (TABID)
  references META_TABLES (TABID)
  novalidate';
exception when others then
    if sqlcode = -2275 then null; else raise; 
    end if; 
 end;
/


-- Create/Recreate check constraints 
begin   
    execute immediate 'alter table META_NSIFUNCTION
  add constraint CC_METANSIFUNCTION_DESCR_NN
  check (descr is not null)
  novalidate';
exception when others then
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
 end;
/

-- Grant/Revoke object privileges 
grant select on META_NSIFUNCTION to BARSREADER_ROLE;
grant select, insert, update, delete on META_NSIFUNCTION to BARS_ACCESS_DEFROLE;
grant select on META_NSIFUNCTION to BARS_DM;
grant select, insert, update, delete on META_NSIFUNCTION to START1;
grant select on META_NSIFUNCTION to UPLD;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/META_NSIFUNCTION.sql =========*** End 
PROMPT ===================================================================================== 
