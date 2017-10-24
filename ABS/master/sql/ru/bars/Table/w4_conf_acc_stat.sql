begin
  bpa.alter_policy_info(p_table_name    => 'W4_CONF_ACC_STAT',
                        p_policy_group  => 'WHOLE',
                        p_select_policy => null,
                        p_insert_policy => null,
                        p_update_policy => null,
                        p_delete_policy => null);
end;
/

begin
    execute immediate 'create table w4_conf_acc_stat
(
  acc   NUMBER,
  state INTEGER,
  kf    VARCHAR2(6) default sys_context(''bars_context'',''user_mfo'')
)
tablespace BRSDYND';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table W4_CONF_ACC_STAT
  is '/ Переведення рахунку із статусу «Зарезервований» в статус «Відкритий';
-- Add comments to the columns 
comment on column W4_CONF_ACC_STAT.state
  is 'Статус рахунку 1- Підтвердженно, 0 - відхилено';