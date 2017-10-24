

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ZAYDEBT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ZAYDEBT ***

  CREATE OR REPLACE PROCEDURE BARS.P_ZAYDEBT 
( mod_            INT
, acc_            INT
, ref_            NUMBER
, s1_             NUMBER
, s2_             NUMBER
, d27_1           CHAR
, d27_2           CHAR
, namekb_         VARCHAR2
, idkb_           VARCHAR2
, nazn_           VARCHAR2
, soper_          NUMBER
) IS
---
-- version 11/11/2016
---
-- mod_ - 1-Зачислить на расч.счет
--      - 2-Оформить заявку + Зачислить на расч.счет
--      - 3-Оформить заявку на ОБЯЗАТЕЛЬНУЮ продажу на СВОБОДНУЮ сумму
---
  mfo_            VARCHAR2(12); -- МФО банка
  okpo_           VARCHAR2(15); -- код ОКПО банка
  tt_             CHAR(3); -- код операции 2603 -> 2600
  vob_            NUMBER; -- вид документа
  kv_             NUMBER; -- валюта
  nls_            VARCHAR2(15); -- номер счета 2603/ВАЛ
  nms_            VARCHAR2(38); -- наименование счета 2603/ВАЛ
  rnk_            NUMBER; -- рег.№ клиента
  acc26_          INT; -- АСС счета 2600/ВАЛ
  nls26_          VARCHAR2(15); -- номер счета 2600/ВАЛ
  nms26_          VARCHAR2(38); -- наименование счета 2600/ВАЛ
  okpo26_         VARCHAR2(15); -- код ОКПО клиента
  refd_           INT := null; -- референс операции 2603 -> 2600
  kurs_           NUMBER; -- курс продажи валюты
  kom_            NUMBER; -- процент комисиии
  nd_             VARCHAR2(10); -- номер документа
  acc980_         INT; -- АСС счета 2600/ГРН
  mfo980_         VARCHAR2(12); -- МФО счета 2600/ГРН
  nls980_         VARCHAR2(15); -- номер счета 2600/ГРН
  l_zay           zay_debt_klb%rowtype;
  l_reqid         number;
  l_nls0          accounts.nls%type;
  l_nls1          accounts.nls%type;
  l_d020          char(2);
--------------------------------------------------------------------
  ern             CONSTANT POSITIVE := 208;
  err             EXCEPTION;
  erm             VARCHAR2(160);
BEGIN
  
  bars_audit.trace( $$PLSQL_UNIT||': Entry with ( mod_=%s, acc_=%s, ref_=%s, s1_=%s, s2_=%s, nazn_=%s, d27_1=%s, d27_2=%s ).'
                  , to_char(mod_), to_char(acc_), to_char(ref_), to_char(s1_), to_char(s2_)
                  , to_char(nazn_), d27_1, d27_2 );
  /*
  case
    when ( mod_ = 1 and nvl(s2_,0) = 0 )
    then
      erm := '';
      raise err;
    when ( mod_ = 2 and nvl(s1_,0) = 0 and nvl(s2_,0) = 0 )
    then
      erm := '';
      raise err;
    when ( mod_ = 3 and nvl(s1_,0) = 0 )
    then
      erm := '';
      raise err;
    else
      null;
  end case;
  */
  
  mfo_  := f_get_params('MFO');
  okpo_ := f_get_params('OKPO');
  tt_   := 'GO8';
  
  BEGIN
    select to_number(val)
      into vob_ 
      from BARS.PARAMS
     where par='MBK_VZAL' 
       and val IS NOT NULL;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      vob_ := 6;
  END;
  
  IF nvl(s2_,0) <> 0 
  THEN -- ищем счет только если сумма зачисления ненулевая
    
    BEGIN
       -- 1. Поиск расчетного валютного счета клиента (2600,2650)
       SELECT a1.kv,  a1.nls, substr(a1.nms,1,38), c.rnk,
              a2.acc, a2.nls, substr(a2.nms,1,38), c.okpo
         INTO kv_,nls_,nms_,rnk_,acc26_,nls26_,nms26_,okpo26_
         FROM accounts a1, customer c, accounts a2 
        WHERE a1.acc = acc_            
          AND a1.kv  = a2.kv 
          AND a1.rnk = c.rnk  
          AND a1.rnk = a2.rnk 
          AND a2.nbs IN ('2600', '2650', '2530', '2541', '2542', '2544', '2545', '2555')
          AND a2.tip = 'ODB' 
          AND a2.dazs IS NULL 
          AND substr(a1.nls,6,9)=substr(a2.nls,6,9);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          SELECT a1.kv,  a1.nls, substr(a1.nms,1,38), c.rnk,
                 a2.acc, a2.nls, substr(a2.nms,1,38), c.okpo
            INTO kv_,nls_,nms_,rnk_,acc26_,nls26_,nms26_,okpo26_
            FROM accounts a1, customer c, accounts a2
           WHERE a1.acc = acc_   
             AND a1.kv  = a2.kv 
             AND a1.rnk = c.rnk   
             AND a1.rnk = a2.rnk 
             AND a2.nbs IN ('2600', '2650', '2530', '2541', '2542', '2544', '2545', '2555')
             AND a2.tip = 'ODB' 
             AND a2.dazs IS NULL
             AND rownum = 1
           GROUP
              BY a1.kv, a1.nls,substr(a1.nms,1,38),c.rnk,
                 a2.acc,a2.nls,substr(a2.nms,1,38),c.okpo;
        --HAVING count(*)=1;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            erm := 'Расчетный валютный счет клиента не найден!';
            RAISE err;
        END;
     END;
  -- иначе берем параметры того счета, что передается
  ELSE 
    SELECT a.kv, a.nls, a.rnk, c.okpo
      INTO kv_, nls_, rnk_, okpo26_
      FROM accounts a
         , customer c
     WHERE a.acc = acc_ 
       AND a.rnk = c.rnk;
  END IF;

  bars_audit.trace( $$PLSQL_UNIT||': 1. kv_=%s, nls_=%s, nms_=%s, rnk_=%s, acc26_=%s,nls26_=%s'
                  , to_char(kv_), to_char(kv_), to_char(nms_), to_char(rnk_), to_char(acc26_), to_char(nls26_) );

  -- 2. Зачисление валюты на расчетный счет
  IF mod_ in (1, 2) and nvl(s2_,0) <> 0 
  THEN
    
    SELECT nd INTO nd_ FROM oper WHERE ref = ref_;
    
    BEGIN
      
      gl.ref (refd_);
      
      gl.in_doc3( ref_   => refd_
                , tt_    => tt_      , dk_    => 1
                , vob_   => vob_     , nd_    => nd_
                , pdat_  => sysdate  , data_  => gl.bdate
                , vdat_  => gl.bdate , datp_  => gl.bdate
                , kv_    => kv_      , kv2_   => kv_
                , s_     => s2_      , s2_    => s2_
                , mfoa_  => mfo_     , mfob_  => mfo_
                , nlsa_  => nls_     , nlsb_  => nls26_
                , nam_a_ => nms_     , nam_b_ => nms26_
                , id_a_  => okpo26_  , id_b_  => okpo26_
                , nazn_  => nazn_    , uid_   => null -- USER_ID()
                , d_rec_ => null     , sk_    => null
                , id_o_  => null     , sign_  => null
                , sos_   => 1        , prty_  => null );
      
      gl.pay2(null,refd_,gl.bdate,tt_,kv_,0,acc_,  s2_,0,1,'Перерахування коштів на поточний рахунок');
      gl.pay2(null,refd_,gl.bdate,tt_,kv_,1,acc26_,s2_,0,0,'Перерахування коштів на поточний рахунок');
      
      gl.pay2(0,refd_,gl.bdate);

      if ( d27_2 IS NOT NULL )
      then
        insert
          into OPERW (REF, TAG, VALUE) 
        values ( refd_, 'D#27 ', d27_2 );
      end if;
      
    END;
    
  END IF;

  -- 3. Оформление ОБЫЧНОЙ заявки на обязательную продажу
  IF mod_ in (2, 3) and nvl(s1_,0) <> 0 
  THEN
    
    -- Курс продажи
    BEGIN
      SELECT kurs_s 
        INTO kurs_ 
        FROM DILER_KURS
       WHERE kv  = kv_ 
         AND dat = ( select max(dat) 
                       from DILER_KURS
                      where kv = kv_ 
                        and dat >=trunc(sysdate) );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN kurs_ := NULL;
    END;

     -- Счет для зачисления ГРН
    BEGIN
      
      SELECT mfo26, nls26, okpo26, kom2 
        INTO mfo980_,nls980_,okpo26_,kom_ 
        FROM cust_zay 
       WHERE rnk = rnk_;
        
      if mfo_ = mfo980_ 
      then
        
        begin
          select acc 
            into acc980_ 
            from accounts
           where nls = nls980_
             and kv  = 980;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            erm :='Расчетный счет (грн) из параметров клиента не найден!';
            RAISE err;
        end;
        
      end if;
      
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
           SELECT a.acc, a.nls INTO acc980_,nls980_
             FROM accounts a
            WHERE a.rnk = rnk_    
              AND a.kv  = 980  
              AND a.nbs IN ('2600', '2650', '2530', '2541', '2542', '2544', '2545', '2555') 
              AND a.dazs IS NULL 
              AND substr(a.nls,6,9) = substr(nls_,6,9)
              and rownum = 1;
        EXCEPTION 
          WHEN NO_DATA_FOUND THEN
            BEGIN
              SELECT a.acc, a.nls INTO acc980_, nls980_
                FROM accounts a
               WHERE a.rnk = rnk_ 
                 AND a.kv  = 980    
                 AND a.nbs IN ('2600', '2650', '2530', '2541', '2542', '2544', '2545', '2555')
                 AND a.dazs IS NULL 
                 --and not exists (select 1 from accounts where nls = a.nls and kv <> a.kv)
                 and rownum = 1;
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                erm :='Расчетный счет (грн) не найден!';
                RAISE err;
            END;
        END;
     END;
     
     bars_audit.trace( $$PLSQL_UNIT||': 3. mfo980_=%s, nls980_=%s, okpo26_=%s, kom_=%s, acc980_=%s'
                     , to_char(mfo980_), to_char(nls980_), to_char(okpo26_), to_char(kom_), to_char(acc980_) );

     -- Заявка, поступившая по системе Клиент-Банк
     IF namekb_ IS NOT NULL AND idkb_ IS NOT NULL 
     THEN

        select * into l_zay from zay_debt_klb where fnamekb=namekb_ and identkb=idkb_;
        
        begin
          select nls into l_nls0 from accounts 
           where acc = l_zay.acc0;
        exception
          when no_data_found then
           l_nls0 := null;
        end;
        
        begin
           select nls into l_nls1 from accounts
            where acc = acc_;
        exception
          when no_data_found then
           l_nls1 := null;
        end;

        bars_zay.create_request_ex 
           (p_reqtype       => 2,                        -- тип заявки (1-покупка, 2-продажа, 3-конверсия)
            p_custid        => l_zay.rnk,                -- регистр.№ клиента
            p_curid         => l_zay.kv2,                -- числ.код валюты (для dk(1,3) - которая покупается, для 2 - которая продается)
            p_curconvid     => null,                     -- числ.код валюты за которую покупается (для dk = 3)
            p_amount        => l_zay.s2/100,             -- сумма заявленной валюты ("приведенная")
            p_reqnum        => l_zay.nd,                 -- номер заявки
            p_reqdate       => l_zay.datz,               -- дата заявки
            p_reqrate       => nvl(l_zay.kurs_z,kurs_),  -- курс заявки
            p_nls_acc1      => l_nls1,                   -- № счета в ин.вал. (для 1 - вал счет зачисления, для 2 - вал счет списания, для 3 - вал счет зачисления)
            p_nls_acc0      => l_nls0,                   -- № счета в нац.вал.(для 1 - грн счет списания, для 2 - грн счет зачисления(при зачислении выруч.грн на межбанк - поле пустует,зато заполняются поля mfo0, nls0,okpo0), для 3 - вал счет для списания)
            p_nataccnum     => l_zay.nls0,               -- счет в нац.валюте в др.банке     (для dk = 2)
            p_natbnkmfo     => l_zay.mfo0,               -- МФО банка счета в нац.валюте     (для dk = 2)
            p_cmsprc        => kom_,                     -- процент (%) комиссии
            p_cmssum        => null,                     -- фикс.сумма комиссии
            p_taxflg        => 1,                        -- признак отчисления в ПФ          (для dk = 1) 
            p_taxacc        => null,                     -- счет клиента для отчисления в ПФ (для dk = 1) 
            p_aimid         => null,                     -- код цели покупки/продажи
            p_contractid    => null,                     -- идентификатор контракта
            p_contractnum   => null,                     -- номер контракта/кред.договора
            p_contractdat   => null,                     -- дата контракта/кред.договора
            p_custdeclnum   => null,                     -- номер последней тамож.декларации
            p_custdecldat   => null,                     -- дата последней тамож.декларации
            p_prevdecldat   => null,                     -- даты предыдущ.тамож.деклараций    (для dk = 1)
            p_basis         => null,                     -- основание для покупки валюты      (для dk = 1)
            p_countryid     => null,                     -- код страны перечисления валюты    (для dk = 1)
            p_bnfcountryid  => null,                     -- код страны бенефициара            (для dk = 1)
            p_bnfbankcode   => null,                     -- код банка (B010)                  (для dk = 1)
            p_bnfbankname   => null,                     -- название банка                    (для dk = 1)
            p_productgrp    => null,                     -- код товарной группы               (для dk = 1)
            p_details       => null,                     -- подробности заявки
            p_flag          => 0,                        -- признак Кл-Б (Олег)
            p_fio           => null,                     -- ПИБ уполномоченного
            p_tel           => null,                     -- тел уполномоченного
            p_branch        => null,                     -- бранч заявки
            p_operid_nokk   => null,                     -- Унікальний номер операції в системі Клієнт-Банк (Олег, Надра) 
            p_req_type      => null,                     -- Тип заявки
            p_vdateplan     => null,                     -- Плановая дата валютирования
            p_obz           => 1,                        -- Признак заявки на обязательную продажу (1)
            p_reqid         => l_reqid);

        update zayavka
           set okpo0     = l_zay.okpo0,
               rnk_pf    = d27_1,
               priority  = 0,
               fnamekb   = l_zay.fnamekb,
               identkb   = l_zay.identkb,
               tipkb     = l_zay.tipkb,
               datedokkb = l_zay.datedokkb,
               datt      = l_zay.datt,
               soper     = soper_,
               refoper   = ref_ 
         where id = l_reqid;

        DELETE FROM zay_debt_klb WHERE fnamekb=namekb_ AND identkb=idkb_;

     -- Обычная заявка на ОБЯЗАТ.продажу валюты
     ELSE
        bars_audit.trace( $$PLSQL_UNIT||': zayavka. rnk_=%s, acc980_=%s, nls980_=%s, okpo26_=%s, acc_=%s'
                        , to_char(rnk_), to_char(acc980_), to_char(okpo26_), to_char(okpo26_), to_char(acc_) );

        begin
          select nls into l_nls0 from accounts 
           where acc = acc980_;
        exception
          when no_data_found then
           l_nls0 := null;
        end;
        
        begin
          select nls into l_nls1 from accounts
           where acc = acc_;
        exception
          when no_data_found then
           l_nls1 := null;
        end;

        bars_zay.create_request_ex 
           (p_reqtype       => 2,                        -- тип заявки (1-покупка, 2-продажа, 3-конверсия)
            p_custid        => rnk_,                     -- регистр.№ клиента
            p_curid         => kv_,                      -- числ.код валюты (для dk(1,3) - которая покупается, для 2 - которая продается)
            p_curconvid     => null,                     -- числ.код валюты за которую покупается (для dk = 3)
            p_amount        => s1_/100,                  -- сумма заявленной валюты ("приведенная")
            p_reqnum        => null,                     -- номер заявки
            p_reqdate       => gl.bdate,                 -- дата заявки
            p_reqrate       => kurs_,                    -- курс заявки
            p_nls_acc1      => l_nls1,                   -- № счета в ин.вал. (для 1 - вал счет зачисления, для 2 - вал счет списания, для 3 - вал счет зачисления)
            p_nls_acc0      => l_nls0,                   -- № счета в нац.вал.(для 1 - грн счет списания, для 2 - грн счет зачисления(при зачислении выруч.грн на межбанк - поле пустует,зато заполняются поля mfo0, nls0,okpo0), для 3 - вал счет для списания)
            p_nataccnum     => nls980_,                  -- счет в нац.валюте в др.банке     (для dk = 2)
            p_natbnkmfo     => nvl(mfo980_,mfo_),        -- МФО банка счета в нац.валюте     (для dk = 2)
            p_cmsprc        => kom_,                     -- процент (%) комиссии
            p_cmssum        => null,                     -- фикс.сумма комиссии
            p_taxflg        => 1,                        -- признак отчисления в ПФ          (для dk = 1) 
            p_taxacc        => null,                     -- счет клиента для отчисления в ПФ (для dk = 1) 
            p_aimid         => null,                     -- код цели покупки/продажи
            p_contractid    => null,                     -- идентификатор контракта
            p_contractnum   => null,                     -- номер контракта/кред.договора
            p_contractdat   => null,                     -- дата контракта/кред.договора
            p_custdeclnum   => null,                     -- номер последней тамож.декларации
            p_custdecldat   => null,                     -- дата последней тамож.декларации
            p_prevdecldat   => null,                     -- даты предыдущ.тамож.деклараций    (для dk = 1)
            p_basis         => null,                     -- основание для покупки валюты      (для dk = 1)
            p_countryid     => null,                     -- код страны перечисления валюты    (для dk = 1)
            p_bnfcountryid  => null,                     -- код страны бенефициара            (для dk = 1)
            p_bnfbankcode   => null,                     -- код банка (B010)                  (для dk = 1)
            p_bnfbankname   => null,                     -- название банка                    (для dk = 1)
            p_productgrp    => null,                     -- код товарной группы               (для dk = 1)
            p_details       => null,                     -- подробности заявки
            p_flag          => 0,                        -- признак Кл-Б (Олег)
            p_fio           => null,                     -- ПИБ уполномоченного
            p_tel           => null,                     -- тел уполномоченного
            p_branch        => null,                     -- бранч заявки
            p_operid_nokk   => null,                     -- Унікальний номер операції в системі Клієнт-Банк (Олег, Надра) 
            p_req_type      => null,                     -- Тип заявки
            p_vdateplan     => null,                     -- Плановая дата валютирования
            p_obz           => 1,                        -- Признак заявки на обязательную продажу (1)
            p_reqid         => l_reqid);

        update zayavka
           set okpo0   = okpo26_,
               rnk_pf  = d27_1,
               soper   = soper_,
               refoper = ref_
         where id = l_reqid;

     END IF;

  END IF;
  
  case
    when ( mod_ = 1 )
    then
      
      if ( refd_ Is not Null )
      then
        insert into BARS.ZAY_DEBT
          ( REF, REFD, TIP, ZAY_SUM, SOS )
        values
          ( ref_, refd_, 1, null, case when s2_ = soper_ then 2 else 0 end );
      end if;
      
    when ( mod_ = 2 )
    then
      
      if ( refd_ Is not Null )
      then
        insert into BARS.ZAY_DEBT
          ( REF, REFD, TIP, ZAY_SUM, SOS )
        values
          ( ref_, refd_, 2, s1_, 2 );
      end if;
      
    when ( mod_ = 3 )
    then
      
      if nvl(s1_,0) > 0 
      then
        
        insert into BARS.ZAY_DEBT
          ( REF, REFD, ZAY_SUM, TIP, SOS )
        values
          ( ref_, null, s1_, 2, 0 );
        
      end if;
      
    else
      null;
    
  end case;

EXCEPTION
  when ERR then
    raise_application_error( -(20000+ern),'\'||erm, true );
END P_ZAYDEBT;
/
show err;

PROMPT *** Create  grants  P_ZAYDEBT ***
grant EXECUTE                                                                on P_ZAYDEBT       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_ZAYDEBT       to START1;
grant EXECUTE                                                                on P_ZAYDEBT       to WR_ALL_RIGHTS;
grant EXECUTE                                                                on P_ZAYDEBT       to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ZAYDEBT.sql =========*** End ***
PROMPT ===================================================================================== 
