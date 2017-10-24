

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ELT_OB22.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ELT_OB22 ***

  CREATE OR REPLACE PROCEDURE BARS.P_ELT_OB22      (p_dat date default null, p_days int default 10)
is

-- Абонплата. Дозаповнення OB22 для рах-в 3570, 3579 по НЕ закритих угодах
--  ***  v.1.2 від 22/04-14    11/04-14

l_dat date;
l_id int;
l_ob22_3570 varchar2(2); l_ob22_3579 varchar2(2);
begin
l_dat:=p_dat;
if p_dat is null then l_dat:=bankdate; end if;
for k in (
select e.acc26, a26.nbs nbs26, a26.nls nls26, a26.kv kv26,
       a26.ob22 ob22_26, a26.daos, a26.branch,
       e.acc36, a36.nbs nbs36, a36.nls nls36,
       e.accd, a79.nbs nbs79, a79.nls nls79,
       e.nd, a36.ob22 ob22_36
from accounts a26, e_deal e, accounts a36, accounts a79
where 1=1
and a26.acc=e.acc26 and a36.acc=e.acc36 and a79.acc(+)=e.accd
and e.sos!=15
and a26.dazs is null
--and a26.ob22 is not null
--and a36.ob22 is     null
--and a36.dapp is not null
and a36.daos >= l_dat - p_days)
loop
      --- for 3570
l_OB22_3570:=null; l_ob22_3579:=null;
begin    -- 1
   select ob22_3570, ob22_3579 into l_OB22_3570, l_ob22_3579
   from e_tar_nd d, e_tarif t
        where d.nd=k.nd and d.id=t.id
              and (ob22_3570 is not null or ob22_3579 is not null)
              and rownum=1;

begin
  update specparam_int set ob22=l_ob22_3570
  where acc=k.acc36 and (ob22 is null or ob22 != l_ob22_3570);
  if sql%rowcount=0 then
    begin
      insert into  specparam_int (acc,ob22) values (k.acc36,l_ob22_3570);
    logger.info('ELT_OB22: ins '||k.nls36||'/'||k.acc36||' ob22='||l_ob22_3570);
    exception when dup_val_on_index then
      null;
    end;
  end if;
end;

  exception when NO_DATA_FOUND then NULL;
        end;  -- 1

      --- for 3579
if k.accd is not NULL and l_ob22_3579 is not NULL then
begin
  update specparam_int set ob22=l_ob22_3579
  where acc=k.accd and (ob22 is null or ob22 != l_ob22_3579);
  if sql%rowcount=0 then
    begin
      insert into  specparam_int (acc,ob22) values (k.accd,l_ob22_3579);
    logger.info('ELT_OB22: ins '||k.nls79||'/'||k.accd||' ob22='||l_ob22_3579);
    exception when dup_val_on_index then
      null;
    end;
  end if;
end;
end if;

end loop;
commit;
end; -- p_elt_ob22
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ELT_OB22.sql =========*** End **
PROMPT ===================================================================================== 
