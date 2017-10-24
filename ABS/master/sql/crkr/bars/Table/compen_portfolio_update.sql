exec bpa.alter_policy_info('COMPEN_PORTFOLIO_UPDATE', 'filial',  'M', 'M', 'M', 'M');
exec bpa.alter_policy_info('COMPEN_PORTFOLIO_UPDATE', 'whole',  null,  'E', 'E', 'E');

-- Create table
begin
    execute immediate 'create table COMPEN_PORTFOLIO_UPDATE
(
  idupd                NUMBER,
  id                   NUMBER(14),
  fio                  VARCHAR2(256),
  country              INTEGER,
  postindex            VARCHAR2(256),
  obl                  VARCHAR2(256),
  rajon                VARCHAR2(256),
  city                 VARCHAR2(256),
  address              VARCHAR2(512),
  fulladdress          VARCHAR2(999),
  icod                 VARCHAR2(128),
  doctype              INTEGER,
  docserial            VARCHAR2(16),
  docnumber            VARCHAR2(32),
  docorg               VARCHAR2(256),
  docdate              DATE,
  clientbdate          DATE,
  clientbplace         VARCHAR2(256),
  clientsex            CHAR(1),
  clientphone          VARCHAR2(128),
  registrydate         DATE,
  nsc                  VARCHAR2(32),
  ida                  VARCHAR2(32),
  nd                   VARCHAR2(256),
  sum                  NUMBER,
  ost                  NUMBER,
  dato                 DATE,
  datl                 DATE,
  attr                 VARCHAR2(10),
  card                 NUMBER(2),
  datn                 DATE,
  ver                  NUMBER(4),
  stat                 VARCHAR2(6),
  tvbv                 CHAR(3),
  branch               VARCHAR2(30),
  kv                   NUMBER(6),
  status               INTEGER,
  date_import          DATE,
  dbcode               VARCHAR2(32),
  percent              NUMBER,
  kkname               VARCHAR2(256),
  ob22                 CHAR(2),
  rnk                  NUMBER,
  branchact            VARCHAR2(30),
  reason_change_status VARCHAR2(255),
  user_id              NUMBER,
  user_fio             VARCHAR2(100),
  lastedit             DATE default sysdate
)
tablespace BRSMDLD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table COMPEN_PORTFOLIO_UPDATE add rnk_bur NUMBER';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_PORTFOLIO_UPDATE add branchact_bur VARCHAR2(30)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_PORTFOLIO_UPDATE add ostasvo NUMBER';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table COMPEN_PORTFOLIO_UPDATE add branch_crkr VARCHAR2(30)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table COMPEN_PORTFOLIO_UPDATE add status_prev INTEGER';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table COMPEN_PORTFOLIO_UPDATE add type_person number(1) default 0';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_PORTFOLIO_UPDATE add name_person varchar2(255)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_PORTFOLIO_UPDATE add edrpo_person varchar2(10)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

