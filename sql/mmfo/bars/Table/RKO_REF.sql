--- 1). Policy

begin
    execute immediate 'insert into policy_table t (t.table_name, t.select_policy, t.insert_policy, t.update_policy, t.delete_policy, t.repl_type, t.policy_group,
t.owner, t.policy_comment, t.change_time, t.apply_time, t.who_alter, t.who_change) values (''RKO_REF'', ''M'', ''M'', ''M'', ''M'', null, ''FILIAL'',
''BARS'', null, null, sysdate, null, null)';
 exception when others then 
    if sqlcode = -955  then null; else raise; 
    end if; 
end;
/ 
commit;



-- 2). create table RKO_REF

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Table/RKO_REF.sql =====*** Run *** ===
PROMPT ===================================================================================== 

create table RKO_REF
(
  REF    NUMBER(38)
)
tablespace BRSSMLD;
-- Add comments to the table 
comment on table RKO_REF
  is 'Плата за РО: REF, по яких OSTB рахунку NLSA < oper.S';
-- Add comments to the columns 


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Table/RKO_REF.sql =====*** End *** ===
PROMPT ===================================================================================== 



PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Index/RKO_REF.sql =====*** Run *** ===
PROMPT ===================================================================================== 

-- Create/Recreate indexes 
create index IDX_RKO_REF on RKO_REF (REF)
  tablespace BRSSMLI;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Index/RKO_REF.sql =====*** End *** ===
PROMPT ===================================================================================== 



--  3).  Grant

begin
execute immediate 'grant select, insert, update, delete on BARS.RKO_REF to ABS_ADMIN';
execute immediate 'grant select, insert, update, delete on BARS.RKO_REF to BARS_ACCESS_DEFROLE';
execute immediate 'grant select, insert, update, delete on BARS.RKO_REF to START1';
end;
/

