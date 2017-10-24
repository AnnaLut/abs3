

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/FOR_2625_22.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure FOR_2625_22 ***

  CREATE OR REPLACE PROCEDURE BARS.FOR_2625_22 
(p_TIP_2906  accounts.tip%type,  -- = NLA
 p_NBS_2625  accounts.nbs%type,  -- = 2625
 p_ob22_2625 accounts.ob22%type  -- = 22
 ) Is

/*
19.11.2012 Более одного кл с одним и тем же  RVRNK
           Это возможно после процедуры "Слияния клиентов".
27-06-2012 Sta  Оптимизировано для поиска РНК-ЦРВ и РНК в АБС
26-06-2012 Sta  Промежуточный сommit на 200 записей
12-06-2012 Sta

Пропозицiя вiд Черн_вецького ОБУ:
 для всiх операцiй, що порожуються автоматично при застосуваннi
 "Компенс-2012.Автомат 2906/16->2625/22"
 додавати допреквiзит SK_ZB = 88
 для #13 файлу
*/

  r_oper   oper%ROWTYPE   ;
  l_TAG    CUSTOMERW.tag%type   := 'RVRNK';
  l_RVRNK  CUSTOMERW.value%type ;
  l_RNK    CUSTOMERW.rnk%type   ;

  l_nls26  oper.nlsb%type ;
  l_nms26  oper.nam_b%type;
  l_okpo26 oper.id_b%type ;
  l_ref    oper.ref%type  ;
  l_tt     oper.tt%type   := 'W4V';
  l_FL     char(1)        ;
  l_count  number := 0    ;
  l_count_total  NUMBER   := 0;
  l_sk_zb  number := 88   ;
 -----------------------------------------------------------------------------------------
begin
  begin
     select substr(flags,38,1) into l_FL from tts where tt= l_tt;
  EXCEPTION WHEN NO_DATA_FOUND THEN
     raise_application_error(-20100,'Не описано операцiю '|| l_TT );
  end;

  begin
     select to_number(trim(val)) into l_sk_zb from op_rules
     where tt = l_tt and tag = 'SK_ZB';
  EXCEPTION WHEN NO_DATA_FOUND THEN null;
  end;

  -- считаем общее кол-во документов к оплате
  SELECT COUNT (*) INTO l_count_total
  FROM accounts a, nlk_ref n
  WHERE a.acc = n.acc
    AND a.tip = p_TIP_2906
    AND a.ostc > 0
    AND n.ref1 IS NOT NULL
    AND n.ref2 IS NULL ;



for k in (select a.nls, substr(a.nms,1,38) NMS, n.ref1, a.kv , a.acc
          from accounts a, nlk_ref n
          where a.acc  = n.acc and a.tip  = p_TIP_2906
            and a.ostc > 0     and n.ref1 is not null  and n.ref2 is null
        )
loop
   begin
     select ref2 into l_ref from nlk_ref
     where acc= k.acc and ref1 = k.ref1 and ref2 is null
       FOR UPDATE OF REF2 NOWAIT;
   exception  when others then GOTO RecNext;
   end;

   begin
     -- чистые поступления из ВПС
     select o.*  into r_oper from oper o where o.ref  = k.REF1 ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
     -- возможно из картотеки 3720 ("невыясненные")
     begin
       select o.*  into r_oper from oper o, operw w
       where w.ref = k.REF1  and w.tag = 'REF92' and o.ref = w.value ;
     EXCEPTION WHEN NO_DATA_FOUND THEN GOTO RecNext;
     end;
   end;

   -- РНК в ЦРВ
   l_RVRNK := trim (replace ( substr( r_oper.d_rec, 15 ),'#','')) ;

---19.11.2012 Более одного кл с одним и тем же  RVRNK
   l_rnk := null;
   -------------------------------------------------------------------------
   for R in (select  * from CUSTOMERW   where tag = l_tag and value = l_RVRNK)
   loop
       begin
         select a.nls, substr(a.nms,1,38), c.okpo
         into l_nls26, l_nms26 , l_okpo26
         from  customer c, accounts a
          where c.rnk  = R.RNK   and c.rnk  = a.rnk  and a.nbs  = p_NBS_2625   and a.ob22 = p_ob22_2625
            and a.dazs is null and a.kv = k.kv       AND ROWNUM = 1;
         l_rnk := R.rnk;
         EXIT;
       EXCEPTION WHEN NO_DATA_FOUND THEN null;
       end;
   end loop;
   ---
   If l_rnk  is null then
      GOTO RecNext ;
   end if;
  ---------------------------------------------------------------------------
/*   так было ранее.*****************
   begin
--27-06-2012 Sta  Оптимизировано для поиска РНК-ЦРВ и РНК в АБС

     select rnk into l_rnk from CUSTOMERW   where tag = l_tag and value = l_RVRNK;

     select a.nls, substr(a.nms,1,38), c.okpo  into l_nls26, l_nms26 , l_okpo26
     from  customer c, accounts a
     where c.rnk  = l_RNK       and c.rnk  = a.rnk                   and a.nbs  = p_NBS_2625
       and a.ob22 = p_ob22_2625 and a.dazs is null and a.kv = k.kv   AND ROWNUM = 1;

   EXCEPTION WHEN NO_DATA_FOUND THEN GOTO RecNext;
   end;
*/
   -- оплата
   gl.ref (l_ref);
   gl.in_doc3(ref_ => l_ref,
            tt_    => l_TT ,
            vob_   => 6,
            nd_    => r_oper.nd,
            pdat_  => SYSDATE ,
            vdat_  => gl.BDATE,
            dk_    => 1,
            kv_    => k.kv,
            s_     => r_oper.S,
            kv2_   => k.kv,
            s2_    => r_oper.S,
            sk_    => null,
            data_  => gl.BDATE,
            datp_  => gl.bdate,
            nam_a_ => k.nms,
            nlsa_  => k.nls,
            mfoa_  => gl.aMfo,
            nam_b_ => l_nms26,
            nlsb_  => l_nls26,
            mfob_  => gl.aMfo,
            nazn_  => r_oper.nazn,
            d_rec_ => r_oper.d_rec,
            id_a_  => r_oper.id_b,
            id_b_  => l_okpo26,
            id_o_  => null,
            sign_  => null,
            sos_   => 1,
            prty_  => null,
            uid_   => null);

   PAYTT(flg_ => 0,        --SMALLINT,  -- флаг оплаты
         ref_ => l_ref,    --INTEGER,   -- референция
         datv_=> gl.bdate, -- DATE,      -- дата валютировния
         tt_  => l_tt,     -- CHAR,      -- тип транзакции
         dk0_ => 1   ,     -- NUMBER,    -- признак дебет-кредит
         kva_ => k.kv,     -- SMALLINT,  -- код валюты А
         nls1_=> k.nls,    -- VARCHAR2,  -- номер счета А
         sa_  => r_oper.s, --DECIMAL,   -- сумма в валюте А
         kvb_ => k.kv ,    --SMALLINT,  -- код валюты Б
         nls2_=>l_nls26,   -- VARCHAR2,  -- номер счета Б
         sb_  =>r_oper.s   --DECIMAL    -- сумма в валюте Б
         ) ;

   Insert into OPERW (REF,TAG,VALUE) Values (l_ref, 'SK_ZB', to_char(l_sk_zb) );
   update nlk_ref set ref2 = l_REF where acc = k.acc and ref1 = k.ref1;

   If l_FL = '1' then  gl.pay(2, l_REF, gl.bdate);  end if;
   --------------------------------------------------------

   -- COMMIT порциями по 200
   l_count := l_count + 1;

   IF (MOD (l_count, 200) = 0)   THEN
      COMMIT;
      DBMS_APPLICATION_INFO.set_client_info (
       'CRV2012:'||TO_CHAR(l_count)|| ' of '|| TO_CHAR(l_count_total) || ' docs');
   END IF;
   --------------------------------------------------------
   <<RecNext>> null;

end loop;

  commit;

end for_2625_22;
/
show err;

PROMPT *** Create  grants  FOR_2625_22 ***
grant EXECUTE                                                                on FOR_2625_22     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FOR_2625_22     to DPT_ADMIN;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/FOR_2625_22.sql =========*** End *
PROMPT ===================================================================================== 
