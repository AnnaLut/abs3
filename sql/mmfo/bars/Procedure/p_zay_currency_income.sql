

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ZAY_CURRENCY_INCOME.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ZAY_CURRENCY_INCOME ***

  CREATE OR REPLACE PROCEDURE BARS.P_ZAY_CURRENCY_INCOME (p_dat date, p_mode number default null) is
-- ============================================================================
--                    Формування переліку надходжень за дату
--                          VERSION 1.0 (31/10/2014)
-- ============================================================================

  l_title       varchar2(25) := 'p_zay_currency_income'; -- для трассировки

  l_time_start  varchar2(20);
  l_time_finish varchar2(20);
  nTmp_         number;
  ZZ            zay_currency_income%rowtype;

begin
  select to_char(sysdate, 'dd/mm/yyyy hh24:mi:ss') into l_time_start from dual;
  bars_audit.trace('%s TIME_Start: l_time_start=%s',l_title, l_time_start);

  bars_audit.trace('%s 0.Старт. Вх.пар-ры:p_dat=%s, p_mode=%s',l_title, to_char(p_dat), to_char(p_mode));

  if p_dat is null then
     return;
  end if;

  if nvl(p_mode, 0) = 0 then null;
  else
     -- почистим все
     delete from zay_currency_income;
  end if;

  for k in
     (select f_ourmfo() mfo, o.branch, o.pdat,  o.tt,
       o.ref, o.nazn,  o.kv,  t.lcv,
       c.rnk, c.okpo, c.nmk,  o.s/100 s,
       null s_obz, null txt
       from oper o, tabval t, customer c, accounts a
      where o.pdat between p_dat and p_dat+1-1/24/60
        and o.dk = 1
        and o.sos = 5
        and
           ( (o.nlsa like '2909%' and o.nlsb like '2603%') or
             ((substr(o.nlsa,1,4) in ('2600','2560','2650','2603') or substr(o.nlsa,1,2)='25') and o.nlsb like '2900%' and o.tt in ('100','BR3'))  or
			 ((o.nlsa like '2603%' and (o.nlsb like '3720%' or o.nlsb = '373980501061')) or (o.nlsb like '2603%' and (o.nlsa like '3720%' or o.nlsa = '373980501061')))
		   )
        and o.kv = o.kv2
        and o.kv <> 980
        and o.kv = t.kv
        and (o.nlsb = a.nls and o.kv2 = a.kv)
        and a.ob22 = iif_n(substr(o.nlsb,1,4), '2900','05','01',null)
        and a.rnk = c.rnk
        and not exists (select 1 from zay_currency_income where ref = o.ref))
  loop
    begin
     insert into zay_currency_income  (MFO, BRANCH, PDAT, TT, REF, NAZN, KV, LCV, RNK, OKPO, NMK,  S, S_OBZ, TXT)
       values (k.MFO, k.BRANCH, k.PDAT, k.TT, k.REF, k.NAZN, k.KV, k.LCV, k.RNK, k.OKPO, k.NMK,  k.S, k.S_OBZ, k.TXT);
    exception when dup_val_on_index then null;
    end;
  end loop;

  select to_char(sysdate, 'dd/mm/yyyy hh24:mi:ss') into l_time_finish from dual;
  bars_audit.trace('%s TIME_FINISH: l_time_finish=%s',l_title, l_time_finish);


end p_zay_currency_income ;
/
show err;

PROMPT *** Create  grants  P_ZAY_CURRENCY_INCOME ***
grant EXECUTE                                                                on P_ZAY_CURRENCY_INCOME to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_ZAY_CURRENCY_INCOME to START1;
grant EXECUTE                                                                on P_ZAY_CURRENCY_INCOME to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ZAY_CURRENCY_INCOME.sql ========
PROMPT ===================================================================================== 
