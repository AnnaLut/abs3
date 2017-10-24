exec bpa.alter_policy_info('compen_portfolio_rebran', 'filial',  'M', 'M', 'M', 'M');
exec bpa.alter_policy_info('compen_portfolio_rebran', 'whole',  null,  'E', 'E', 'E');

begin
  execute immediate '
create table compen_portfolio_rebran
(
  branch_from varchar2(30),
  branch_to   varchar2(30),
  regdate     date default sysdate,
  user_id     NUMBER default sys_context(''bars_global'', ''user_id''),
  err_cnt     number,
  succ_compen number,
  succ_act    number
)
tablespace BRSMDLD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table compen_portfolio_rebran
  is 'Історія по ребранчінгу вкладів';
-- Add comments to the columns 
comment on column compen_portfolio_rebran.err_cnt
  is 'Невдала спроба, кількість вкладів. ';
comment on column compen_portfolio_rebran.succ_compen
  is 'Кількість вкладів (по branch_crkr)';
comment on column compen_portfolio_rebran.succ_act
  is 'Кількість актуалізованних (по branch_act )';