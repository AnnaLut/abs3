begin
  bpa.alter_policy_info(p_table_name    => 'INS_W4_DEALS_ARC',
                        p_policy_group  => 'WHOLE',
                        p_select_policy => null,
                        p_insert_policy => null,
                        p_update_policy => null,
                        p_delete_policy => null);
end;
/
exec bpa.alter_policy_info('INS_W4_DEALS_ARC', 'FILIAL',  'M', 'M', 'M', 'M');
/
-- Create table
begin
    execute immediate 'create table INS_W4_DEALS_ARC
(
  nd          NUMBER(22) not null,
  state       VARCHAR2(100),
  set_date    DATE default sysdate,
  err_msg     VARCHAR2(4000),
  request     CLOB,
  response    CLOB,
  ins_ext_id  NUMBER,
  ins_ext_tmp NUMBER,
  deal_id     VARCHAR2(100),
  date_from   DATE,
  date_to     DATE,
  requestxml  CLOB
)
tablespace BRSDYND';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

begin
-- Create/Rebegin
    execute immediate 'create index I_INS_W4_DEALS_ARC_ND on INS_W4_DEALS_ARC (ND)
  tablespace BRSDYND';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'alter table INS_W4_DEALS_ARC add kf varchar2(6)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'alter table INS_W4_DEALS_ARC modify kf varchar2(6) default sys_context(''bars_context'',''user_mfo'')';
 exception when others then 
    if sqlcode = -904 then null; else raise; 
    end if; 
end;
/ 
-- Grant/Revoke object privileges 
grant select on INS_W4_DEALS_ARC to BARS_ACCESS_DEFROLE;
/