

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PK_SET_SPARAM_2625K58.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PK_SET_SPARAM_2625K58 ***

  CREATE OR REPLACE PROCEDURE BARS.PK_SET_SPARAM_2625K58 (p_acc number) IS
-- p_acc - счет технического овердрафта
  l_s080  varchar2(1) := '1';
  l_s180  varchar2(1) := '1';
  l_s240  varchar2(2) := '1';
  l_s260  varchar2(2) := '06';
  l_r013  varchar2(1) := '1';
  l_ob22  varchar2(2);

begin

  -- заносим значения в specparam
  update specparam
     set s080 = l_s080,
         s180 = l_s180,
         s240 = l_s240,
         s260 = l_s260,
         r013 = l_r013
   where acc = p_acc;
  if sql%rowcount = 0 then
     insert into specparam (acc, s080, s180, s240, s260, r013)
     values (p_acc, l_s080, l_s180, l_s240, l_s260, l_r013);
  end if;

  begin
     --определение значений спецпараметра ob22 по 2625(карт.счет)
     select i.ob22 into l_ob22
       from bpk_acc b, specparam_int i
      where b.acc_tovr = p_acc
        and b.acc_pk   = i.acc(+);

     --заносим значения в specparam_int
     if l_ob22 is not null then
        update specparam_int set ob22 = l_ob22
         where acc = p_acc;
        if sql%rowcount = 0 then
           insert into specparam_int (acc, ob22)
           values (p_acc, l_ob22);
        end if;
     end if;
  exception when no_data_found then null;
  end;

exception
  when others then bars_audit.trace('PK_SET_SPARAM_2625K58 - ERROR '||CHR(13)||CHR(10)|| SQLERRM );
end;
/
show err;

PROMPT *** Create  grants  PK_SET_SPARAM_2625K58 ***
grant EXECUTE                                                                on PK_SET_SPARAM_2625K58 to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PK_SET_SPARAM_2625K58.sql ========
PROMPT ===================================================================================== 
