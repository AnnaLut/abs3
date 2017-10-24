

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PAY_FACT_OB.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PAY_FACT_OB ***

  CREATE OR REPLACE PROCEDURE BARS.PAY_FACT_OB (p_mode IN int ) is
  -- педаль-оплата
begin
  for o in (select * from oper where exists (select 1 from ref_que where ref_que.ref = oper.ref) and oper.sos=1)
  loop
     If o.tt in ('%%1','ASG','ASP') and
 ( o.nlsa like '22%'  or
   o.nlsb like '22%'  or
   o.nlsa like '357%' or
   o.nlsb like '357%'
 )
--   OR ---здессь можно добавлять любые др условия
--   OR ---здессь можно добавлять любые др условия
--   or o.tt='I01'
     then

        savepoint FRONT_PAY;
        --------------------
        begin
          gl.pay (2, o.ref, gl.bdate);
          delete from ref_que where ref= o.ref;
        exception when others then rollback to FRONT_PAY;
        end;

     end if;
  end loop;
end PAY_FACT_OB;
/
show err;

PROMPT *** Create  grants  PAY_FACT_OB ***
grant EXECUTE                                                                on PAY_FACT_OB     to ABS_ADMIN;
grant EXECUTE                                                                on PAY_FACT_OB     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PAY_FACT_OB.sql =========*** End *
PROMPT ===================================================================================== 
