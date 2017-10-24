

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ZAYDEBT_KV.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ZAYDEBT_KV ***

  CREATE OR REPLACE PROCEDURE BARS.P_ZAYDEBT_KV 
  ( mod_ INT, acc_ INT, ref_ NUMBER, s1_ NUMBER, s2_ NUMBER,
    d27_1 CHAR, d27_2 CHAR, nazn_ VARCHAR2 )
IS
 ------------------------------------------------------------------
 -- Процедура разбора поступления валюты на 2603-счета клиентов ---
 -------------------ВЕРСИЯ банка КИЕВ -----------------------------
 ----- при порождении заявки на обз.продажу формируется ордер -----
 -------- Дебет 2603-счет клиента  Кредит 2900-счет клиента -------
 ------------------------------------------------------------------
 mfo_    VARCHAR2(12);  -- МФО банка
 okpo_   VARCHAR2(15);  -- код ОКПО банка
 tt_     CHAR(3);       -- код операции 2603 -> 2600
 kv_     NUMBER;        -- валюта
 nls_    VARCHAR2(15);  -- номер счета 2603/ВАЛ
 nms_    VARCHAR2(38);  -- наименование счета 2603/ВАЛ
 rnk_    NUMBER;        -- рег.№ клиента
 acc26_  INT;           -- АСС счета 2600/ВАЛ
 nls26_  VARCHAR2(15);  -- номер счета 2600/ВАЛ
 nms26_  VARCHAR2(38);  -- наименование счета 2600/ВАЛ
 okpo26_ VARCHAR2(15);  -- код ОКПО клиента
 refd_   INT;           -- референс операции 2603 -> 2600
 kurs_   NUMBER;        -- курс продажи валюты
 kom_    NUMBER;        -- процент комисиии
 acc980_ INT;           -- АСС счета 2600/ГРН
 mfo980_ VARCHAR2(12);  -- МФО счета 2600/ГРН
 nls980_ VARCHAR2(15);  -- номер счета 2600/ГРН
 refz_   INT;           -- референс операции 2603 -> 2900
 acc29_  INT;           -- АСС счета 2900/ВАЛ
 nls29_  VARCHAR2(15);  -- номер счета 2900/ВАЛ
 nms29_  VARCHAR2(38);  -- наименование счета 2900/ВАЛ
 tmp_    NUMBER;
 grp_    NUMBER;
 isp_    NUMBER;
 nmk_    VARCHAR2(70);
--------------------------------------------------------------------
 ern  CONSTANT POSITIVE := 208;
 err  EXCEPTION;
 erm VARCHAR2(80);

BEGIN
  SELECT val INTO mfo_  FROM PARAMS WHERE PAR='MFO';
  SELECT val INTO okpo_ FROM PARAMS WHERE PAR='OKPO';
  tt_:='GO8';
  -- 1. Поиск расчетного валютного счета клиента (2600,2650)
  BEGIN
    SELECT a1.kv,  a1.nls, substr(a1.nms,1,38),
           a2.acc, a2.nls, substr(a2.nms,1,38),
		   c.rnk,  c.okpo, c.nmk, a2.grp, a2.isp
      INTO kv_,nls_,nms_,acc26_,nls26_,nms26_,rnk_,okpo26_,nmk_,grp_,isp_
      FROM accounts a1, cust_acc ca1, customer c,
           accounts a2, cust_acc ca2
     WHERE a1.acc=acc_               AND a1.kv=a2.kv     AND
           ca1.rnk=c.rnk             AND ca1.rnk=ca2.rnk AND
           ca1.acc=a1.acc            AND a2.acc=ca2.acc  AND
	       a2.nbs IN ('2600','2650') AND a2.dazs IS NULL AND
           substr(a1.nls,6,9)=substr(a2.nls,6,9);
  EXCEPTION WHEN NO_DATA_FOUND THEN
     BEGIN
	   SELECT a1.kv,  a1.nls, substr(a1.nms,1,38), c.rnk,
              a2.acc, a2.nls, substr(a2.nms,1,38), c.okpo
         INTO kv_,nls_,nms_,rnk_,acc26_,nls26_,nms26_,okpo26_
         FROM accounts a1, cust_acc ca1, customer c,
              accounts a2, cust_acc ca2
        WHERE a1.acc=acc_               AND a1.kv=a2.kv     AND
              ca1.rnk=c.rnk             AND ca1.rnk=ca2.rnk AND
              ca1.acc=a1.acc            AND a2.acc=ca2.acc  AND
	          a2.nbs IN ('2600','2650') AND a2.dazs IS NULL
     GROUP BY a1.kv,a1.nls,substr(a1.nms,1,38),c.rnk,
              a2.acc,a2.nls,substr(a2.nms,1,38),c.okpo
       HAVING count(*)=1;
     EXCEPTION WHEN NO_DATA_FOUND THEN
              erm :='Расчетный валютный счет клиента не найден!'; RAISE err;
     END;
  END;

  -- 2. Зачисление валюты на расчетный счет
  IF nvl(s2_,0) <> 0 THEN
    BEGIN
      gl.ref (refd_);
      INSERT INTO oper
        (ref, tt, vob, nd, dk, pdat, vdat, datd, nazn, userid, sos,
	     nam_a, nlsa, mfoa, id_a, kv, s, nam_b, nlsb, mfob, id_b, kv2, s2)
      VALUES
        (refd_, tt_, 46, refd_, 1, gl.bdate, gl.bdate, gl.bdate, nazn_, USER_ID, 1,
	     nms_, nls_, mfo_, okpo26_, kv_, s2_, nms26_, nls26_, mfo_, okpo26_, kv_, s2_);
      gl.pay2(null,refd_,gl.bdate,tt_,kv_,0,acc_,  s2_,0,1,'Перерахування коштів на поточний рахунок');
      gl.pay2(null,refd_,gl.bdate,tt_,kv_,1,acc26_,s2_,0,0,'Перерахування коштів на поточний рахунок');
      gl.pay2(0,refd_,gl.bdate);

      INSERT INTO zay_debt (ref, refd, tip) VALUES (ref_, refd_, mod_);
      IF d27_2 IS NOT NULL THEN
	     INSERT INTO operw (ref, tag, value) VALUES (refd_, 'D#27 ', d27_2);
	  END IF;
    END;
  END IF;

  -- 3. Оформление ОБЫЧНОЙ заявки на обязательную продажу
  IF mod_ = 2 AND nvl(s1_,0) <> 0 THEN

     -- Курс продажи
     BEGIN
       SELECT kurs_b INTO kurs_ FROM diler_kurs
       WHERE kv=kv_ AND dat=
              (SELECT max(dat) FROM diler_kurs
			   WHERE kv=kv_ AND trunc(dat)=trunc(sysdate));
     EXCEPTION WHEN NO_DATA_FOUND THEN kurs_ := NULL;
     END;

     -- Расчетный счет для зачисления ГРН
     BEGIN
       SELECT mfo26, nls26, okpo26, kom2 INTO mfo980_,nls980_,okpo26_,kom_
         FROM cust_zay WHERE rnk=rnk_;
     EXCEPTION WHEN NO_DATA_FOUND THEN
       BEGIN
         SELECT a.acc, a.nls INTO acc980_,nls980_
           FROM accounts a, cust_acc ca
          WHERE ca.rnk=rnk_    AND a.acc=ca.acc             AND
		        a.kv=980       AND a.nbs IN ('2600','2650') AND
	            a.dazs IS NULL AND substr(a.nls,6,9)=substr(nls_,6,9);
       EXCEPTION WHEN NO_DATA_FOUND THEN
         BEGIN
           SELECT a.acc, a.nls INTO acc980_, nls980_
             FROM accounts a, cust_acc ca
            WHERE ca.rnk=rnk_ AND a.acc=ca.acc AND a.dazs IS NULL AND
			      a.kv=980    AND a.nbs IN ('2600','2650')
            GROUP BY a.acc,a.nls HAVING count(*)=1;
         EXCEPTION WHEN NO_DATA_FOUND THEN
                  erm :='Расчетный счет (грн) не найден!'; RAISE err;
         END;
       END;
     END;

     -- Торговый ВАЛ счет для формирования предоплаты на ОБЗ-заявку
     BEGIN
       SELECT a.acc, a.nls, substr(a.nms,1,38) INTO acc29_,nls29_,nms29_
         FROM cust_zay z, accounts a
		WHERE a.nls=z.nls29 AND a.kv=kv_ AND a.dazs IS NULL AND z.rnk=rnk_;
     EXCEPTION WHEN NO_DATA_FOUND THEN
        BEGIN
        -- поиск вал.торгового счета по хвосту 2900+K+RNK(5)
          SELECT a.acc, a.nls, substr(a.nms,1,38) INTO acc29_,nls29_, nms29_
            FROM accounts a, cust_acc ca
           WHERE ca.rnk=rnk_ AND a.kv=kv_ AND a.acc=ca.acc AND a.dazs IS NULL AND
	             a.nbs='2900' AND substr(a.nls,6,9)=substr('00000'||rnk_,-5,5);
        EXCEPTION WHEN NO_DATA_FOUND THEN
           -- поиск вал.торгового счета вообще
           BEGIN
	         SELECT a.acc, a.nls, substr(a.nms,1,38) INTO acc29_,nls29_, nms29_
               FROM accounts a, cust_acc ca
              WHERE ca.rnk=rnk_ AND a.acc=ca.acc AND a.kv=kv_ AND a.nbs='2900' AND a.dazs IS NULL;
           EXCEPTION WHEN NO_DATA_FOUND THEN
		      nls29_ := '2900'||'0'||substr('00000'||rnk_,-5,5);
			  nls29_ := VKRZN(substr(mfo_,1,5),nls29_);
			  nms29_ := substr('Торг.рах. '||nmk_,1,38);
              -- открытие валютного торгового счета
              op_reg(99, 0, 0, grp_, tmp_, rnk_, nls29_, kv_, nms29_, 'ODB', isp_, acc29_);
           END;
        END;
     END;

     -- % комиссии
     IF  mfo_ = '300175' THEN kom_:=0; END IF;
	 IF  mfo_ = '322498' THEN kom_:=0.05; END IF;

     -- Заявка на ОБЯЗАТ.продажу валюты
	 INSERT INTO zayavka
	  (rnk, dk, obz, fdat, s2, kurs_z, kv2, kom, sos, viza,
	   acc0, mfo0, nls0, okpo0, acc1)
	 VALUES
	  (rnk_, 2, 1,  gl.bdate, s1_, kurs_, kv_, kom_, 0, 0,
	   acc980_, nvl(mfo980_,mfo_), nls980_, okpo26_, acc29_ );

     -- формирование ордера на предоплату с 2603 на 2900
     gl.ref (refz_);
     INSERT INTO oper
        (ref, tt, vob, nd, dk, vdat, pdat, datd, nazn, userid, sos,
	     nam_a, nlsa, mfoa, id_a, kv, s, nam_b, nlsb, mfob, id_b, kv2, s2)
     VALUES
        (refz_, tt_, 46, refz_, 1, gl.bdate, gl.bdate, gl.bdate, 'Перерахування коштів на обов''язковий продаж', USER_ID, 1,
	     nms_, nls_, mfo_, okpo26_, kv_, s1_,
		 nms29_, nls29_, mfo_, okpo26_, kv_, s1_);
     gl.pay2(null,refz_,gl.bdate,tt_,kv_,0,acc_,  s1_,0,1,'Перерахування коштів на обов''язковий продаж');
     gl.pay2(null,refz_,gl.bdate,tt_,kv_,1,acc29_,s1_,0,0,'Перерахування коштів на обов''язковий продаж');
     gl.pay2(0,refz_,gl.bdate);

      IF d27_1 IS NOT NULL THEN
	     INSERT INTO operw (ref, tag, value) VALUES (refz_, 'D#27 ', d27_1);
	  END IF;

    -- INSERT INTO zay_debt (ref, refd, tip) VALUES (ref_, refz_, mod_);
	 INSERT INTO zay_debt (ref, refd, zay_sum, tip) VALUES (ref_, ref_, s1_, mod_);
  END IF;

  EXCEPTION
  WHEN err    THEN  raise_application_error(-(20000+ern),'\'||erm,TRUE);
  WHEN OTHERS THEN  raise_application_error(-(20000+ern),SQLERRM,TRUE);
END p_zaydebt_kv;
/
show err;

PROMPT *** Create  grants  P_ZAYDEBT_KV ***
grant EXECUTE                                                                on P_ZAYDEBT_KV    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ZAYDEBT_KV.sql =========*** End 
PROMPT ===================================================================================== 
