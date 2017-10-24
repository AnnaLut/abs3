
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_int_nazn.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_INT_NAZN 
    (p_type  CHAR,     -- код маски
     p_nlsM  VARCHAR2, -- основной счет
     p_kvM   VARCHAR2, -- валюта основного счета
     p_nlsP  VARCHAR2, -- счет начисленных %%
     p_kvP   VARCHAR2) -- валюта счета начисленных %%
RETURN
  VARCHAR2
IS
  l_acc     NUMBER;
  l_nazn    VARCHAR2(160);
  l_nd      VARCHAR2(10);
  l_datd    VARCHAR2(10);
  l_nd_add  VARCHAR2(10);
  l_dat_add VARCHAR2(10);
  l_type    CHAR(3);
  l_nlsK    accounts.nls%type;
BEGIN

  IF p_type = 'SEB' THEN  /*  всякие разности для SEB(AGIO)  */
    IF substr(p_nlsM,1,4) = '9129' THEN
      l_nazn := 'Нарахована комiсiя за невикористаний лiмiт по рахунку '
              ||p_nlsM||'/'||p_kvM||' за перiод ';
    END IF;
    RETURN l_nazn;
  END IF;

  -- депозиты юридических лиц (операция %DU)

  IF p_type = 'DPU' THEN

    BEGIN
      SELECT substr(g.nd,1,35), to_char(g.dat_z,'dd.MM.yyyy'),
             to_char(nvl(d.dpu_add,0)), to_char(d.dat_z,'dd.MM.yyyy')
        INTO l_nd, l_datD, l_nd_add, l_dat_add
        FROM dpt_u d, dpt_u g
       WHERE d.dpu_gen = g.dpu_id AND d.nls = p_nlsM AND d.kv = p_kvM;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        l_nazn := '%% по рах. '||trim(p_nlsM)||' за перiод';
        RETURN l_nazn;
    END;

    IF l_nd_add <> '0' THEN
       l_nazn := 'Відсотки згiдно дод.угоди №'||trim(l_nd_add)||
                 ' вiд '||l_dat_add||
                 ' до ген.угоди №'||trim(l_nd)||' вiд '||l_datd||
                 ' за перiод';
    ELSE
       l_nazn := 'Нараховані відсотки згiдно договору №'||trim(l_nd)||
                 ' вiд '||l_datd||' за перiод';
    END IF;

  -- кредиты юридических и физических лиц (операция %CC)

  ELSIF p_type = 'CCK' THEN

    BEGIN
      SELECT substr(c.cc_id,1,20), to_char(c.sdate,'dd.MM.yyyy')
        INTO l_nd, l_datD
        FROM cc_deal c, nd_acc n, accounts a
       WHERE c.vidd < 1000  AND nvl(c.sos,0) <> 15
         AND c.nd = n.nd    AND n.acc = a.acc
         AND a.nls = p_nlsm AND a.kv = p_kvm;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        l_nazn := '%% по рах. '||trim(p_nlsM)||' за перiод';
        RETURN l_nazn;
    END;

--  BEGIN
--    SELECT tip INTO l_type FROM accounts
--     WHERE nls = p_nlsp AND kv = to_number(p_kvp);
--  EXCEPTION
--    WHEN NO_DATA_FOUND THEN l_type := 'ODB';
--  END;

    IF substr(p_nlsp,1,4) = '3578' THEN
       l_type := 'SK0';
    ELSE
       l_type := 'ODB';
    END IF;

    l_nazn := ' згiдно договору №'||trim(l_nd)||' вiд '||l_datd||' за перiод';
    IF l_type = 'SK0' THEN
       l_nazn := 'Нарахована комiсiя'||l_nazn;
    ELSE
       l_nazn := 'Нараховані відсотки'||l_nazn;
    END IF;

  -- начисление процентов по внесистемному счету

  ELSIF p_type = 'ACCC' THEN

    BEGIN
       SELECT p.nls INTO l_nlsK
         FROM accounts p, accounts a
        WHERE a.accc = p.acc AND a.nls = p_nlsM AND a.kv = p_kvM;
     EXCEPTION
       WHEN NO_DATA_FOUND THEN
         l_nazn := '%% по рах. '||trim(p_nlsM)||' за перiод';
         RETURN l_nazn;
     END;

     l_nazn := '%% по рах. '||trim(l_nlsK)||' ('||trim(p_nlsM)||') за перiод';

  -- случайно залетели
  ELSE

     l_nazn := '%% по рах. '||trim(p_nlsM)||' за перiод';

  END IF;

  RETURN TRIM(l_nazn);
END;
/
 show err;
 
PROMPT *** Create  grants  F_INT_NAZN ***
grant EXECUTE                                                                on F_INT_NAZN      to BARS010;
grant EXECUTE                                                                on F_INT_NAZN      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_INT_NAZN      to RCC_DEAL;
grant EXECUTE                                                                on F_INT_NAZN      to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_int_nazn.sql =========*** End ***
 PROMPT ===================================================================================== 
 