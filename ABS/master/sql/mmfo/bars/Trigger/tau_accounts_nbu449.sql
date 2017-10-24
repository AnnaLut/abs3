

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_ACCOUNTS_NBU449.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_ACCOUNTS_NBU449 ***

  CREATE OR REPLACE TRIGGER BARS.TAU_ACCOUNTS_NBU449 
  after update of ostb
  on BARS.ACCOUNTS
  for each row
 WHEN (
old.NBS in ('1001','1002') and
        new.ostb> old.ostb
      ) declare
  KOS_ number    ;
  KOS_ALL number :=0;
  r_oper oper%rowtype;
  type t_limits_list  is table of number;
  l_list   t_limits_list:=t_limits_list();
  l_list_acc   t_limits_list:=t_limits_list();
  l_cnt number :=1;
  s_ number;
  function get_list_acc_a(p_nls accounts.nls%type, p_kv accounts.kv%type) return t_limits_list
  is
   l_cnt number :=1;
  pragma autonomous_transaction;
  begin
       begin
           for k in(select * from accounts where rnk = (select rnk from accounts where nls=p_nls and kv=p_kv) and dazs is null and pap=2)
                  loop
                    l_list_acc.extend;
                    l_list_acc(l_cnt):=k.acc;
                    l_cnt:=l_cnt+1;
                  end loop;
       end;
    return l_list_acc;
  end;

function get_list_acc_b(p_nls accounts.nls%type, p_kv accounts.kv%type) return t_limits_list
  is
    l_cnt number :=1;
  pragma autonomous_transaction;
  begin
       begin
           for k in(select * from accounts where rnk = (select rnk from accounts where nls=p_nls and kv=p_kv) and dazs is null and pap=2)
                  loop
                    l_list_acc.extend;
                    l_list_acc(l_cnt):=k.acc;
                    l_cnt:=l_cnt+1;
                  end loop;
       end;
    return l_list_acc;
  end;

begin
 if gl.aTt in('DP1','DP4','PKF','EDP') then

  select * into r_oper from oper where ref=gl.aRef;

  s_:=:new.ostb - :old.ostb;


       if substr(r_oper.nlsa,1,4) in('1001', '1002') and r_oper.dk=0 then
         l_list:=get_list_acc_a(r_oper.nlsb, r_oper.kv);
       else
          l_list:=get_list_acc_b(r_oper.nlsa, r_oper.kv);
       end if;

  for i in 1..l_list.count loop
     BEGIN

       select nvl(sum(p.S),0) into KOS_
       from   opldok p, oper o
       where  o.pdat between trunc(sysdate) and sysdate
          and p.fdat=gl.bd
          and p.acc=l_list(i)
          and p.dk=0
          and p.SOS>0
          and o.ref=p.ref
          and o.kv=980
          and o.sk is not null;
     EXCEPTION WHEN NO_DATA_FOUND THEN
       KOS_:=0;
     End;
     KOS_ALL:=KOS_ALL+KOS_;

   end loop;


 s_:=KOS_ALL;
/*
 if s_ >=50000000 then
-- Ia?ooaii iinoaiiaeaiea IAO ?449 io 29.07.2014 (150000 a?i a aaiu)
   bars_error.raise_nerror('BRS', 'POSTANOVA_449');
 end if;
*/
end if;
end tau_accounts_NBU449;
/
ALTER TRIGGER BARS.TAU_ACCOUNTS_NBU449 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_ACCOUNTS_NBU449.sql =========***
PROMPT ===================================================================================== 
