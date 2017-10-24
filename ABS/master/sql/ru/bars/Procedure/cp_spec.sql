

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CP_SPEC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CP_SPEC ***

  CREATE OR REPLACE PROCEDURE BARS.CP_SPEC      (p_dat date default null, p_days int default 5)
is

-- Дозаповнення спецпараметрів для нових рах-в портфеля ЦП
--  ***    v.2.1 від 21/03-16     -- 1.2  11/06-14

l_dat date;
l_s180 varchar2(1); l_r011 varchar2(1); l_r013 varchar2(1);
l_r016 varchar2(2); l_s080 varchar2(1); l_s580 varchar2(1);
l_ob22 char(2);
l_s130 specparam.s130%type;

begin
l_dat:=p_dat;
if p_dat is null then l_dat:=bankdate; end if;
logger.info('CP_SPEC: start l_dat='||l_dat||' days='||p_days);

for k0 in (select id,c.ref,dat_ug from cp_deal c, oper o
           where 1=1 and dat_ug > l_dat - p_days and op in (1,3)
                 and c.ref=o.ref and o.sos>0
           order by c.ref)
loop
for k in (
SELECT c.ACC,c.ref,a.nls,a.kv,a.accc FROM CP_DEAL c, accounts a
       WHERE ref=k0.ref and c.acc is not NULL and a.acc=c.acc and a.dazs is null
UNION ALL
SELECT c.ACCD,c.ref,a.nls,a.kv,a.accc FROM CP_DEAL c, accounts a
       WHERE ref=k0.ref and c.accd is not NULL and a.acc=c.accd(+) and a.dazs is null
UNION ALL
SELECT c.ACCP,c.ref,a.nls,a.kv,a.accc FROM CP_DEAL c, accounts a
       WHERE ref=k0.ref and c.accp is not NULL and a.acc=c.accp(+) and a.dazs is null
UNION ALL
SELECT c.ACCr,c.ref,a.nls,a.kv,a.accc FROM CP_DEAL c, accounts a
       WHERE ref=k0.ref and c.accr is not NULL and a.acc=c.accr(+) and a.dazs is null
UNION ALL
SELECT c.ACCR2,c.ref,a.nls,a.kv,a.accc FROM CP_DEAL c, accounts a
       WHERE ref=k0.ref and c.accr2 is not NULL and a.acc=c.accr2(+) and a.dazs is null
UNION ALL
SELECT c.ACCS,c.ref,a.nls,a.kv,a.accc FROM CP_DEAL c, accounts a
       WHERE ref=k0.ref and c.accs is not NULL and a.acc=c.accs(+) and a.dazs is null
       order by ref,1)
loop

begin
  select ob22 into l_ob22 from accounts where acc=k.accc;
  if l_ob22 is not null then
  update specparam_int set ob22=l_ob22 where acc=k.acc and ob22 is null;
  if sql%rowcount=0 then
    begin
    insert into specparam_int (acc,ob22) values(k.acc,l_ob22);
    logger.info('CP_OB22: ins '||k.nls||'/'||k.acc||' ob22='||l_ob22);
    exception when dup_val_on_index then
      null;
    end;
  end if;
  end if;
exception when NO_DATA_FOUND then null; l_ob22:=null;
end;

begin
select r011, r013, r016, s080, s180, s580, s130
into l_r011, l_r013, l_r016, l_s080, l_s180, l_s580, l_s130
from specparam where acc=k.accc;
exception when NO_DATA_FOUND then null;
l_r011:=null; l_r013:=null; l_r016:=null; l_s080:=null; l_s180:=null; l_s580:=null;
l_s130:=null;
end;

if 1=1  /*and k.acc is not null*/ then
begin
  update specparam set
  r011=nvl(r011,l_r011), r013=nvl(r013,l_r013), r016=nvl(r016,l_r016),
  s080=nvl(s080,l_s080), s180=nvl(s180,l_s180), s580=nvl(s580,l_s580),
  s130=nvl(s130,l_s130)
  where acc=k.acc;
  if sql%rowcount=0 then
    begin
    insert into specparam (acc, r011, r013, r016, s080, s180, s580, s130)
    values (k.acc, l_r011, l_r013, l_r016, l_s080, l_s180, l_s580, l_s130);
    logger.info('CP_SPEC: ins '||k.nls||'/'||k.acc||' spec=...');
    exception when dup_val_on_index then
      null;
    end;
  end if;
null;
end;
end if;

end loop;
end loop; -- k0
--commit;
logger.info('CP_SPEC: finish');
end; -- cp_spec
/
show err;

PROMPT *** Create  grants  CP_SPEC ***
grant EXECUTE                                                                on CP_SPEC         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CP_SPEC.sql =========*** End *** =
PROMPT ===================================================================================== 
