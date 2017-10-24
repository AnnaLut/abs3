begin
 bpa.alter_policy_info('OW_SALARY_DATA', 'WHOLE',  null, 'E', 'E', 'E');
end;
/
begin
 bpa.alter_policy_info('OW_SALARY_DATA', 'FILIAL', 'M', 'M', 'M', 'M');
end;
/

begin 
  execute immediate 
    'create table ow_salary_data
     ( id             number(22),
       idn            number(22),
       okpo           varchar2(14),
       first_name     varchar2(70),
       last_name      varchar2(70),
       middle_name    varchar2(70),
       type_doc       number(22),
       paspseries     varchar2(16),
       paspnum        varchar2(16),
       paspissuer     varchar2(128),
       paspdate       date,
       bday           date,
       country        varchar2(3),
       resident       varchar2(1),
       gender         varchar2(1),
       phone_home     varchar2(12),
       phone_mob      varchar2(12),
       email          varchar2(30),
       eng_first_name varchar2(30),
       eng_last_name  varchar2(30),
       mname          varchar2(20),
       addr1_cityname varchar2(100),
       addr1_pcode    varchar2(10),
       addr1_domain   varchar2(48),
       addr1_region   varchar2(48),
       addr1_street   varchar2(100),
       addr2_cityname varchar2(100),
       addr2_pcode    varchar2(10),
       addr2_domain   varchar2(48),
       addr2_region   varchar2(48),
       addr2_street   varchar2(100),
       work           varchar2(32),
       office         varchar2(32),
       date_w         date,
       okpo_w         varchar2(14),
       pers_cat       varchar2(2),
       aver_sum       number(12),
       tabn           varchar2(32),
       str_err        varchar2(254),
       rnk            number(22),
       nd             number(22),
       flag_open      number(1),
	   pasp_end_date  date,
	   pasp_eddrid_id varchar2(14),
       kf             varchar2(6),
       constraint pk_owsalarydata primary key (id, idn),
       constraint cc_owsalarydata_kf_nn check (kf is not null),
       constraint cc_owsalarydata_flagopen check (flag_open in (0,1,2,3,4)),
       constraint fk_owsalarydata_owsalaryfiles foreign key (id, kf) references ow_salary_files (id, kf)
     ) tablespace brssmld';
  execute immediate 
    'alter table OW_SALARY_DATA add max_term number';
exception when others then 
  if sqlcode=-955 then null; elsif sqlcode=-1430 then null; else raise; end if;
end;
/

begin
    execute immediate 'alter table ow_salary_data add kf varchar2(6)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'alter table ow_salary_data modify kf varchar2(6) default sys_context(''bars_context'',''user_mfo'')';
 exception when others then 
    if sqlcode = -904 then null; else raise; 
    end if; 
end;
/
begin
    execute immediate 'alter table OW_SALARY_DATA add pasp_end_date date';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table OW_SALARY_DATA add pasp_eddrid_id varchar2(14)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the columns 
comment on column OW_SALARY_DATA.pasp_end_date
  is 'Дійсний до/термін дії';
comment on column OW_SALARY_DATA.pasp_eddrid_id
  is 'Унікальний номер запису в ЄДДР';

comment on table ow_salary_data is 'OpenWay. Імпортовані файли зарплатних проектів';
comment on column ow_salary_data.id        is 'Ід.';
comment on column ow_salary_data.flag_open is 'Флаг открытия: 0-не открывать счет, 1-открывать счет, 2-спросить';
comment on column OW_SALARY_DATA.max_term  is 'Срок действия карты в месяцах';

begin
 bpa.alter_policies('OW_SALARY_DATA');
end;
/

grant select, insert on ow_salary_data to ow;
