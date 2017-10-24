

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OVR_3600.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OVR_3600 ***

  CREATE OR REPLACE PROCEDURE BARS.OVR_3600 (p_dat2 date) is
-------------------------------------------------------------------
--
--  Разблокировка лимита нового договора Овердрафта при поступлении
--  суммы разовой комиссии (Дисконта) на 3600
--        ( TIP 2600:  "BLD" -> "ODB"  )
-------------------------------------------------------------------
Begin

  FOR k IN  ( Select o.ACC acc2600, o.ACC_3600 acc3600, d.OSTC OSTC3600,
                     o.S_3600 S_3600
              FROM   ACC_OVER o, ACCOUNTS a, ACCOUNTS d
              WHERE
                     nvl(o.FLAG_3600,0)=1
                and  nvl(o.ACC_3600 ,0)>0
                and  nvl(o.S_3600   ,0)>0
                and  o.ACC=a.ACC          --- a: 2600
                and  a.TIP='BLD'
                and  o.ACC_3600=d.ACC     --- d: 3600
                ---and  d.OSTC>=o.S_3600
            )

  LOOP

    If k.OSTC3600>=k.S_3600 then
       UPDATE Accounts set TIP='ODB'   where ACC=k.acc2600 ;
       UPDATE ACC_OVER set FLAG_3600=0 where ACC=k.acc2600 ;
    End If;

    --- Проставляем счету 3600 спецпараметр OB22='09':
    Begin
      INSERT into Specparam_Int (ACC,OB22) values (k.acc3600,'09');
    EXCEPTION WHEN OTHERS then
      UPDATE Specparam_Int  SET OB22='09' where ACC=k.acc3600 ;
    End;


  END LOOP;

END OVR_3600;
/
show err;

PROMPT *** Create  grants  OVR_3600 ***
grant EXECUTE                                                                on OVR_3600        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on OVR_3600        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OVR_3600.sql =========*** End *** 
PROMPT ===================================================================================== 
