

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PK_SET_SPARAM_9129.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PK_SET_SPARAM_9129 ***

  CREATE OR REPLACE PROCEDURE BARS.PK_SET_SPARAM_9129 (p_acc NUMBER) IS
  l_tip   char(3);
  l_s080  varchar2(1);
  l_s180  varchar2(1);
  l_s240  varchar2(2);
  l_r013  varchar2(1) := '1';
  l_ob22  varchar2(2);

begin

  --определение значений спецпараметров s080, s180, s240 - по 2202(кред. счет), ob22 - по 2625(карт.счет)
  select s.s080, s.s180, s.s240, a.tip
    into l_s080, l_s180, l_s240, l_tip
    from bpk_acc b, specparam s, accounts a
   where b.acc_9129 = p_acc
     and b.acc_ovr  = s.acc(+)
     and b.acc_pk   = a.acc;

  if l_tip in ('PK1', 'PK2', 'PK3', 'PK4', 'PKB', 'PKC') then
     l_ob22 := '05';
  elsif l_tip in ('PK5', 'PK6', 'PK8', 'PK9', 'PKA') then
     l_ob22 := '07';
  end if;

  --заносим значения в specparam
  update specparam
     set s080 = l_s080,
         s180 = l_s180,
         s240 = l_s240,
         r013 = l_r013
   where acc = p_acc;
  if sql%rowcount = 0 then
     insert into specparam (acc, s080, s180, s240, r013)
     values (p_acc, l_s080, l_s180, l_s240, l_r013);
  end if;

  --заносим значения в specparam_int
  if l_ob22 is not null then
     update specparam_int set ob22 = l_ob22
      where acc = p_acc;
     if sql%rowcount = 0 then
        insert into specparam_int (acc, ob22)
        values (p_acc, l_ob22);
     end if;
  end if;

exception
  when no_data_found then null;
  when others then bars_audit.trace('PK_SET_SPARAM_9129 - ERROR '||CHR(13)||CHR(10)|| SQLERRM );
end;
 
/
show err;

PROMPT *** Create  grants  PK_SET_SPARAM_9129 ***
grant EXECUTE                                                                on PK_SET_SPARAM_9129 to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PK_SET_SPARAM_9129.sql =========**
PROMPT ===================================================================================== 
