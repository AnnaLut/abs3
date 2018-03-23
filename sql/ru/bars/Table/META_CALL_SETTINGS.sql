prompt ... 
begin 
  BPA.ALTER_POLICY_INFO( 'META_CALL_SETTINGS', 'WHOLE' , null, null, null, null );
  BPA.ALTER_POLICY_INFO( 'META_CALL_SETTINGS', 'FILIAL', null, null, null, null );
end;
/

prompt ... 


-- Create table
begin
    execute immediate 'create table META_CALL_SETTINGS
(
  id              NUMBER(38) not null,
  code            VARCHAR2(30),
  call_from       VARCHAR2(30),
  web_form_name   VARCHAR2(400),
  tabid           NUMBER(38),
  funcid          NUMBER(38),
  accesscode      NUMBER(2),
  show_dialog     VARCHAR2(30),
  link_type       VARCHAR2(30),
  insert_after    NUMBER(1) default 0,
  edit_mode       VARCHAR2(30) default ''ROW_EDIT'',
  summ_visible    NUMBER(1) default 0,
  conditions      CLOB,
  excel_opt       VARCHAR2(30),
  add_with_window NUMBER(1) default 0,
  switch_of_deps  NUMBER(1) default 0,
  show_count      NUMBER(1) default 0,
  save_column     VARCHAR2(30),
  codeapp         VARCHAR2(30 CHAR),
  base_options    VARCHAR2(1000)
)
tablespace BRSDYND
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table META_CALL_SETTINGS
  is '�������� ������ ����������';
-- Add comments to the columns 
comment on column META_CALL_SETTINGS.id
  is '�������������';
comment on column META_CALL_SETTINGS.code
  is '��������� ���������� ������������� ��� ������ �� ���� ������ ����������.';
comment on column META_CALL_SETTINGS.call_from
  is '��������� ����, ���������� ��� ����������� �������������. �.�. ������ ��������� ��� ���������� ����.';
comment on column META_CALL_SETTINGS.web_form_name
  is '��� url, ���� ��� ������������ ������ ������, ���� �� ����� ���� �������� �� ��������� ������� ��������� � �������.';
comment on column META_CALL_SETTINGS.tabid
  is '���� ���� ��������� before - ��������� � � meta_nsifunction ����� �����,';
comment on column META_CALL_SETTINGS.funcid
  is '���� ���� ��������� before - ��������� � � meta_nsifunction ����� �����';
comment on column META_CALL_SETTINGS.accesscode
  is '������������ ������� ACCESSCODE.';
comment on column META_CALL_SETTINGS.show_dialog
  is '���������� �� ���� � ��������� � ����� ������.';
comment on column META_CALL_SETTINGS.link_type
  is '��������� � �������� � ����� ����������. OPEN_IN_WINDOW - ����� ������ � ��������� ����(�� ��������� � ����� �������). OPEN_IN_TUBE - � ����� �������. ';
comment on column META_CALL_SETTINGS.insert_after
  is '���������� ����� ������ �� � ������, � ����� �����';
comment on column META_CALL_SETTINGS.edit_mode
  is '��� �������������� MULTI_EDIT - ������������� �������������� ROW_EDIT - ����������(�� ���������)';
comment on column META_CALL_SETTINGS.summ_visible
  is '������� �������� ������ �� ������� ������� 0 - �� ���� �������(�� ���������).';
comment on column META_CALL_SETTINGS.conditions
  is '������� ������';
comment on column META_CALL_SETTINGS.excel_opt
  is '������������ ��� ��������� �������� � EXCEL WITHOUT_EXCEL , XLSX, XLSX_XLS, XLS';
comment on column META_CALL_SETTINGS.add_with_window
  is '���������� ����� ������ ����� � ������� ����, 0 - ������� ������ � ����.';
comment on column META_CALL_SETTINGS.switch_of_deps
  is '��������� ��� ONLINE �����������.';
comment on column META_CALL_SETTINGS.show_count
  is '���������� ���-�� ������� � ������� 0 - �� ����������';
comment on column META_CALL_SETTINGS.save_column
  is '���������, ��������� �������, ����������� ';
comment on column META_CALL_SETTINGS.codeapp
  is '��� ������ �����������, ��������� ����. ������ � TABID.';
comment on column META_CALL_SETTINGS.base_options
  is '���������, ������� ����� ����������� ��������� �������� ��������� ����';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table META_CALL_SETTINGS
  add constraint PK_METACALLSETTINGS primary key (ID)
  using index 
  tablespace BRSDYND
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table META_CALL_SETTINGS
  add constraint UK_METACALLSETTINGS_CODE unique (CODE)
  using index 
  tablespace BRSDYND
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table META_CALL_SETTINGS
  add constraint FK_METACALLSETTINGS_CALLFROM foreign key (CALL_FROM)
  references CALL_TAB_NAME (NAME)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table META_CALL_SETTINGS
  add constraint FK_METACALLSETTINGS_CODEAPP foreign key (TABID, CODEAPP)
  references REFAPP (TABID, CODEAPP)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table META_CALL_SETTINGS
  add constraint FK_METACALLSETTINGS_FUNCID foreign key (TABID, FUNCID)
  references META_NSIFUNCTION (TABID, FUNCID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table META_CALL_SETTINGS
  add constraint FK_METACALLSETTINGS_TABID foreign key (TABID)
  references META_TABLES (TABID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 




