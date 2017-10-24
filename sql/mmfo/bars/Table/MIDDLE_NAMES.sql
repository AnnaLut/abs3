begin
  BPA.ALTER_POLICY_INFO( 'MIDDLE_NAMES', 'WHOLE' , NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'MIDDLE_NAMES', 'FILIAL', null, null, null, null );
end;
/

prompt ... 


-- Create table
begin
    execute immediate 'create table MIDDLE_NAMES
(
  middleid    NUMBER(10) not null,
  middleua    VARCHAR2(50),
  middleru    VARCHAR2(50),
  sexid       CHAR(1),
  firstid     NUMBER(10),
  middleuaof  VARCHAR2(50),
  middleuarod VARCHAR2(50),
  middleuadat VARCHAR2(50),
  middleuavin VARCHAR2(50),
  middleuatvo VARCHAR2(50),
  middleuapre VARCHAR2(50),
  middlerurod VARCHAR2(50),
  middlerudat VARCHAR2(50),
  middleruvin VARCHAR2(50),
  middlerutvo VARCHAR2(50),
  middlerupre VARCHAR2(50)
)
tablespace BRSDYND
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 128K
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table BARS.MIDDLE_NAMES
  is 'Довідник по-батькові';
-- Add comments to the columns 
comment on column BARS.MIDDLE_NAMES.middleid
  is 'ID';
comment on column BARS.MIDDLE_NAMES.middleua
  is 'По батькові (укр)';
comment on column BARS.MIDDLE_NAMES.middleru
  is 'По батькові (рос)';
comment on column BARS.MIDDLE_NAMES.sexid
  is 'Стать';
comment on column BARS.MIDDLE_NAMES.firstid
  is 'ссылка на FIRST_NAMES';
comment on column BARS.MIDDLE_NAMES.middleuaof
  is 'Звернення (укр)';
comment on column BARS.MIDDLE_NAMES.middleuarod
  is 'Родовий відмінок (укр)';
comment on column BARS.MIDDLE_NAMES.middleuadat
  is 'Давальний відмінок (укр)';
comment on column BARS.MIDDLE_NAMES.middleuavin
  is 'Знахідний відмінок (укр)';
comment on column BARS.MIDDLE_NAMES.middleuatvo
  is 'Орудний відмінок (укр)';
comment on column BARS.MIDDLE_NAMES.middleuapre
  is 'Місцевий відмінок (укр)';
comment on column BARS.MIDDLE_NAMES.middlerurod
  is 'Родовий відмінок (рос)';
comment on column BARS.MIDDLE_NAMES.middlerudat
  is 'Давальний відмінок (рос)';
comment on column BARS.MIDDLE_NAMES.middleruvin
  is 'Знахідний відмінок (рос)';
comment on column BARS.MIDDLE_NAMES.middlerutvo
  is 'Орудний відмінок (рос)';
comment on column BARS.MIDDLE_NAMES.middlerupre
  is 'Місцевий відмінок (рос)';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table MIDDLE_NAMES
  add constraint PK_MIDDLENAMES primary key (MIDDLEID)
  using index 
  tablespace BRSDYND
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 128K
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table MIDDLE_NAMES
  add constraint FK_MIDDLENAMES foreign key (SEXID)
  references BARS.SEX (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

