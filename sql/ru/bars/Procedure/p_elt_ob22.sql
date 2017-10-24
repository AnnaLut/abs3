

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ELT_OB22.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ELT_OB22 ***

  CREATE OR REPLACE PROCEDURE BARS.P_ELT_OB22 
( p_dat  date default null
, p_days int  default 10
) is
  --
  -- Абонплата. Дозаповнення OB22 для рах-в 3570, 3579 по НЕ закритих угодах
  --  ***  v.1.3 від 31.10.2016
  --
  l_dat date;
  l_id int;
  l_ob22_3570 varchar2(2);
  l_ob22_3579 varchar2(2);
begin

  if ( p_dat is null )
  then l_dat := bankdate;
  else l_dat := p_dat;
  end if;

  for k in (
  select e.nd, e.acc26, e.acc36, e.accd
       , a26.NBS  as nbs26
       , a26.NLS  as nls26
       , a26.KV   as kv26
       , a26.OB22 as ob22_26
       , a26.DAOS
       , a26.BRANCH
       , a36.NBS  as nbs36
       , a36.NLS  as nls36
       , a36.OB22 as SK0_OB22
       , a79.NBS  as nbs79
       , a79.NLS  as nls79
       , a79.OB22 as SK9_OB22
    from accounts a26
       , e_deal e
       , accounts a36
       , accounts a79
   where a26.acc=e.acc26
     and a36.acc=e.acc36
     and a79.acc(+)=e.accd
     and e.sos != 15
     and a26.dazs is null
     and a36.daos >= l_dat - p_days)
  loop

    l_OB22_3570 := null;
    l_ob22_3579 := null;

    -- for 3570
    begin

      select OB22_3570, OB22_3579
        into l_OB22_3570, l_ob22_3579
        from E_TAR_ND d
        join E_TARIF  t
          on ( t.id = d.id )
       where d.nd = k.nd
         and ( t.OB22_3570 is not null or t.OB22_3579 is not null )
         and rownum = 1;

      if ( l_ob22_3570 Is Not Null AND k.SK0_OB22 Is Null )
      then
        Accreg.setAccountSParam( k.ACC36, 'OB22', l_ob22_3570 );
      end if;

    exception
      when NO_DATA_FOUND then
         NULL;
    end;

    -- for 3579
    if ( k.ACCD Is Not Null AND l_ob22_3579 Is Not NULL AND k.SK9_OB22 Is Null )
    then
      Accreg.setAccountSParam( k.ACCD, 'OB22', l_ob22_3579 );
    end if;

  end loop;

  commit;

end P_ELT_OB22;
/
show err;

PROMPT *** Create  grants  P_ELT_OB22 ***
grant EXECUTE                                                                on P_ELT_OB22      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_ELT_OB22      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ELT_OB22.sql =========*** End **
PROMPT ===================================================================================== 
