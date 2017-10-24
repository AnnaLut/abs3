begin
  bpa.alter_policy_info(p_table_name    => 'W4_INSTANT_BATCHES',
                        p_policy_group  => 'WHOLE',
                        p_select_policy => null,
                        p_insert_policy => null,
                        p_update_policy => null,
                        p_delete_policy => null);
end;
/
prompt ... 


-- Create table
begin
    execute immediate 'create table W4_INSTANT_BATCHES
(
  id          NUMBER not null,
  name        VARCHAR2(100),
  card_code   VARCHAR2(32) not null,
  numbercards NUMBER not null,
  regdate     DATE default sysdate not null,
  user_id     NUMBER not null,
  kf          VARCHAR2(6) default sys_context(''bars_context'',''user_mfo'') not null
)
tablespace BRSDYND';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table W4_INSTANT_BATCHES
  is 'Пачки карт інстант';
-- Add comments to the columns 
comment on column W4_INSTANT_BATCHES.id
  is 'Ідентифікатор';
comment on column W4_INSTANT_BATCHES.name
  is 'Імя пакету';
comment on column W4_INSTANT_BATCHES.card_code
  is 'Код карткового продукту';
comment on column W4_INSTANT_BATCHES.numbercards
  is 'Количество карт';
comment on column W4_INSTANT_BATCHES.regdate
  is 'Дата реєстрації';
comment on column W4_INSTANT_BATCHES.user_id
  is 'Ідентифікатор коритсувача';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table W4_INSTANT_BATCHES
  add constraint PK_W4_ACC_INSTANT primary key (ID)
  using index 
  tablespace BRSDYND';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/
