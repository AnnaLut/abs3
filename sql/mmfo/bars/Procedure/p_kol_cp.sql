

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_KOL_CP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_KOL_CP ***

  CREATE OR REPLACE PROCEDURE BARS.P_KOL_CP (p_dat01 date,  p_mode integer) IS

/* Версия 4.0  26-04-2017   24-01-2017   18-01-2017
   Фін. стан по ЦП
   -------------------------------------
 3) 26-04-2017  - По ЦБ уточнение условия (d.active=1 or d.active = -1 and d.dazs >= p_dat01)
 2) 24-01-2017  - Добавлен параметр S080 в p_get_nd_val
 1) 18-01-2017  - В p_error_351 добавила ACC

*/
  l_s080    specparam.s080%type;

  L_KOL     integer; l_fIN_351 INTEGER; l_fin     INTEGER;  l_idf     integer; l_tip     INTEGER;
  l_accexpr INTEGER; l_fin23   INTEGER;

  l_txt     varchar2(1000);

begin
   for d in (SELECT a.rnk, a.acc, a.kv, d.id,  d.REF,  d.erat, a.nls, a.tobo, d.accs,kk.vncrr,kk.emi,kk.fin23,kk.cp_id,kk.datp,kk.dox,
                     c.custtype, substr( decode(c.custtype,3, c.nmk, nvl(c.nmkk,c.nmk) ) , 1,35) NMK, a.branch, F_RNK_gcif (c.okpo, c.rnk) okpo,
                     DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) RZ
              FROM cp_deal d,  accounts a, CP_KOD KK, customer c
              WHERE D.ID = KK.ID AND (d.acc = a.acc AND KK.DOX > 1    OR     d.accp = a.acc  AND KK.DOX = 1 ) and
                   (d.active=1 or d.active = -1 and d.dazs >= p_dat01) and a.rnk = c.rnk and substr(a.nls,1,4) not in ('3541')
             --SELECT a.acc, v.*, c.custtype, c.nmk, DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) RZ
             --FROM V_CP_MANY v,customer c,accounts a where v.rnk=c.rnk and v.nls=A.NLS and v.kv=a.kv
            )
   LOOP
      BEGIN
         select  accexpr into l_accexpr from cp_deal where ref = d.ref AND ACCEXPR IS NOT NULL;
         l_kol := f_days_past_due (p_dat01, l_accexpr,0);
      EXCEPTION WHEN NO_DATA_FOUND THEN l_KOL:=0;
      END;

      begin
         SELECT  fin_351 INTO l_fin_351 FROM cp_kod WHERE id = d.id;
      EXCEPTION WHEN NO_DATA_FOUND THEN l_fin_351 := NULL;
      END;

      if    d.custtype = 1 and d.RZ =2   THEN l_idf := 80; l_tip := 1;
      elsif d.custtype = 1 and d.RZ =1   THEN l_idf := 80; l_tip := 1;
      elsif d.custtype = 2               THEN l_idf := 50; l_tip := 2;
      elsif d.custtype = 3 and d.kv<>980 THEN l_idf := 60; l_tip := 1;
      else                                    l_idf := 60; l_tip := 1;
      end if;

      l_fin23 := d.fin23;
      l_fin   := l_fin_351;
      if l_fin is null THEN
         l_fin   := fin_nbu.zn_p_nd('CLS', l_idf, p_dat01, d.ref, d.rnk);
         if l_fin is null or l_fin = 0 and d.custtype = 2 THEN
            l_txt := 'ЦП';
            p_error_351( P_dat01, d.ref, user_id,15, d.acc, d.custtype, d.KV, d.branch, l_txt, d.rnk, d.nls);
            l_fin := l_fin23;
         end if;
         l_fin := nvl(l_fin,f_fin23_fin351(l_fin23,l_kol));
         if l_fin is null or l_fin=0 THEN
            l_fin := d.fin23;
         end if;
      end if;
      l_s080 := f_get_s080(p_dat01, l_tip, l_fin);
      p_get_nd_val(p_dat01 => p_dat01, p_nd   => d.ref , p_tipa => 15, p_kol => l_kol, p_rnk => d.rnk, p_tip_fin => l_tip, 
                   p_fin   => l_fin  , p_s080 => l_s080, p_okpo => d.okpo);


   end LOOP;
end ;
/
show err;

PROMPT *** Create  grants  P_KOL_CP ***
grant EXECUTE                                                                on P_KOL_CP        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_KOL_CP        to RCC_DEAL;
grant EXECUTE                                                                on P_KOL_CP        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_KOL_CP.sql =========*** End *** 
PROMPT ===================================================================================== 
