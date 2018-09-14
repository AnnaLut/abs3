PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/bars/table/zp_payroll_doc.sql =========*** Run *** ===
PROMPT ===================================================================================== 

exec bars.bpa.alter_policy_info( 'ZP_PAYROLL_DOC', 'WHOLE' , null, null, null, null ); 

exec bars.bpa.alter_policy_info( 'ZP_PAYROLL_DOC', 'FILIAL', null, null, null, null );

begin execute immediate'create table bars.zp_payroll_doc  (
   id_pr         number                                              not null,
   id            number                                              not null,
   ref           number,
   s             number(24),
   okpob         varchar2(14),
   namb          varchar2(38),
   mfob          varchar2(12),
   nlsb          varchar2(15),   
   source        number,
   nazn          varchar2(160),
   crt_date      date,
   id_file       number                                             default null,
   key_id        varchar2(256), 
   sign          varchar2(4000), 
   signed        varchar2(1),
   constraint xpk_zp_payroll_doc_id_pr      primary key (id,id_pr),
   constraint cc_zp_payroll_doc_source      check (source in (1,2,3,4,5)),  
   constraint fk_zp_payroll_doc_id_pr       foreign key (id_pr)  references bars.zp_payroll(id)
  )';
exception when others then  
  if sqlcode = -00955 then null;   else raise; end if;   
end;
/
begin
    execute immediate 'create index idx_zp_payroll_doc_id_pr on BARS.zp_payroll_doc (id_pr)';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/
begin
    execute immediate 'create index idx_zp_payroll_doc_ref on BARS.zp_payroll_doc (ref)';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/
begin
    execute immediate 'alter table zp_payroll_doc add (key_id varchar2(256), sign varchar2(4000) , signed varchar2(1))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/
begin
    execute immediate 'alter table zp_payroll_doc add (id_file number)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/
begin
    execute immediate 'create index idx_zp_payroll_doc_id_file on BARS.zp_payroll_doc (id_file)';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/
begin
    execute immediate 'alter table zp_payroll_doc add ( signed_user number)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/
begin
    execute immediate 'alter table zp_payroll_doc add ( corp2_id number)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/
begin
    execute immediate 'alter table zp_payroll_doc add ( corp2_nlsa varchar2(20))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/
begin
    execute immediate 'alter table zp_payroll_doc drop constraint cc_zp_payroll_doc_source';
 exception when others then 
    if sqlcode = -2443 then null; else raise; 
    end if; 
end;
/
begin
    execute immediate 'alter table zp_payroll_doc add constraint cc_zp_payroll_doc_source  check (source in (1,2,3,4,5))';
 exception when others then 
    if sqlcode = -2264 then null; else raise; 
    end if; 
end;
/
begin
    execute immediate 'alter table zp_payroll_doc add passp_serial varchar2(2)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/
begin
    execute immediate 'alter table zp_payroll_doc add passp_num varchar2(6)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/
begin
    execute immediate 'alter table zp_payroll_doc add doc_comment varchar2(4000)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/
-- Change type on column zp_payroll_doc.sign varchar2 -> clob
declare
  l_data_type varchar2(30);
begin
  select data_type 
  into l_data_type 
  from all_tab_columns 
  where owner = 'BARS' and table_name = 'ZP_PAYROLL_DOC' and column_name = 'SIGN';
  
  if l_data_type in ('VARCHAR2') then
    execute immediate 'alter table zp_payroll_doc add sign1 clob';
    execute immediate 'update zp_payroll_doc set sign1 = sign';
    execute immediate 'alter table zp_payroll_doc rename column sign to sign2';
    execute immediate 'alter table zp_payroll_doc rename column sign1 to sign';
    execute immediate 'alter table zp_payroll_doc drop column sign2';
  end if;
exception
  when no_data_found then
    null;
  when others then
    raise;
end;
/
comment on column bars.zp_payroll_doc.passp_serial is 'Серія паспорту';
comment on column bars.zp_payroll_doc.passp_num is 'Номер паспорту';
exec  bars.bpa.alter_policies('ZP_PAYROLL_DOC'); 

comment on table  bars.ZP_PAYROLL_DOC is 'Документи  ЗП відомості';
comment on column bars.ZP_PAYROLL_DOC.id_pr is 'id ЗП відомості';

begin
    execute immediate 'alter table zp_payroll_doc add idcard_num varchar2(9 char)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/
comment on column bars.zp_payroll_doc.idcard_num is 'Номер паспорта нового зразка';

grant select,delete,update,insert on bars.ZP_PAYROLL_DOC to bars_access_defrole;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/table/zp_payroll_doc.sql =========*** End *** ===
PROMPT ===================================================================================== 

