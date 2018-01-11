

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/BANK_PF.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure BANK_PF ***

  CREATE OR REPLACE PROCEDURE BARS.BANK_PF (P_MODE    INT,
                                          p_dat1    DATE,
                                          p_dat2    DATE)
IS
  l_dat1 date ;
  l_dat2 date ;
   -- единая для РУ ОБ, ГОУ ОБ, НАДРА
   /*
   20.10.2016 MMFO для P_MODE in (1, 3, 4) додано цикл по КF (МФО), return замінено на continue;
   20.11.2015 ing 3622/38 перечисляется как видно на єкране из v_pdfo (а не иначе)
   29.05.2015 Sta Від кого:  Демкович М.С.  Дата 27.05.2015  REF №: 13/3-03/301
                  Просимо : для  всіх РУ та ЦА :
                  Налаштувати авто-формування пл.док для перерахування військового збору в бюджет
                  з рахунку 3622/38 = "військовий збір, утриманий з доходів ФО»  на рахунки УДК
                  аналогічно функції перекриття/перерахування військового збору з рах.3622/36  - з тамими ж самими платіжними реквізитами отримувача.
                  Відмінність - відсутній зеркальний 3522 рахунок.


   19-02-2015 Sta Від Костенко Г.С., Дата: 18.02.2015, Вих. № 13/1-03/74
   09-01-2015 Sta Перекриття, перерахування сум ПДФО та ВЗ до бюджету по Бранчам  ank_PF ( 2, DATETIME_Null, DATETIME_Null )
   18-09-2014 Sta Присоединение ФОРЕКС для 300465
   18-08-2014 Sta Тестирует Винница
   13-08-2014 Sta Назн пл от МС Демкович
   11-08-2014 Sta Перекриття, перерахування сум ПДФО до бюджету по Бранчам (3522/29,3622/37)
                  p_mode = 2
   01-07-2014 Sta При перечислении с 2902 наверх и РУ ОБ исключить БЕК-операции
   24.04.2014 Все  хорошо С уважением, Хихлуха Дмитрий. Ощадбанк.тел. (044) 247-8578
   nvl(P_MODE,0) = 0 - только отчет по операциям покупки вал
                 = 1 - проводки по операциям покупки вал
                 = 2 - Перекриття, перерахування сум ПДФО до бюджету по Бранчам (3522/29,3622/37)
   */
   -------------------------------------------------------------
   Q5_        NUMBER := 0;
   oo         oper%ROWTYPE;
   A12        ACCOUNTS%ROWTYPE;
   A35        ACCOUNTS%ROWTYPE;
   nls7_      accounts.nls%TYPE;
   rat_       NUMBER;
   ob36_nal   CHAR (2);
   ob36_bez   CHAR (2);
   ob29_nal   CHAR (2);
   ob29_bez   CHAR (2);
   ob74_      CHAR (2);
   MFOP_      VARCHAR2 (6);
   z_         INT;
-- nTmp_      INT;
   sDet_      VARCHAR2 (30);
   sMes_      VARCHAR2 (30);
   sSql_      VARCHAR2 (2000);
   l_dat3     DATE;

   title    constant varchar2(50) := 'Bank_PF:';
-------------------
BEGIN
  execute immediate 'alter session set NLS_DATE_FORMAT=''dd.mm.yyyy''';
  l_dat3:=to_date(PUL.GET('WDAT'),'dd.mm.yyyy');
  PUL_DAT(l_dat3,'');

  l_dat1 := nvl( p_dat1, to_date( pul.Get_Mas_Ini_Val('sFdat1'), 'dd.mm.yyyy' ) ) ;
  l_dat2 := nvl( p_dat2, to_date( pul.Get_Mas_Ini_Val('sFdat2'), 'dd.mm.yyyy' ) ) ;

   IF NVL (P_MODE, 0) NOT IN (0, 1, 2, 3, 4)
   THEN
      RETURN;
   END IF;

   -------------------------------------------------------------
   IF p_mode = 2
   THEN
      --Перекриття, перерахування сум ПДФО до бюджету по Бранчам (3522/29,3622/37)
      --Перекриття, перерахування сум ВЗ   до бюджету по Бранчам (3522/30,3622/36+38)

      SELECT ' за ' || NAME_PLAIN || ' ' || to_char( extract( year from l_dat3 ) )
        INTO sMes_
        FROM META_MONTH
       WHERE N = extract( month from l_dat3 );

      oo.id_a := gl.aOkpo;
      oo.dk   := 1;
      oo.kv   := gl.baseval;
      oo.mfoa := gl.aMfo;
      oo.id_a := gl.aOkpo;

      FOR k IN (SELECT *
                  FROM (SELECT nls6 NLS6,
                               a6.nms NMS6,
                               nls5 NLS5,
                               a5.nms NMS5,
                               a6.BRANCH,
                               V100 as V,
                               P100 as P,
                               a6.nbs B6,
                               a6.ob22 O6,
                               a5.nbs B5,
                               a5.ob22 O5
                          FROM V_PDFO v, accounts a5, accounts a6
                         WHERE a5.acc(+) = v.acc5 AND a6.acc = v.acc6)
                 WHERE (v > 0 OR p > 0))
      LOOP
         BEGIN
            SELECT SUBSTR (val, 1, 06)
              INTO oo.mfob
              FROM BRANCH_PARAMETERS
             WHERE branch = k.branch AND tag = 'PDFOMFO' AND val IS NOT NULL;

            SELECT SUBSTR (val, 1, 08)
              INTO oo.id_b
              FROM BRANCH_PARAMETERS
             WHERE branch = k.branch AND tag = 'PDFOID' AND val IS NOT NULL;

            SELECT SUBSTR (val, 1, 38)
              INTO oo.nam_b
              FROM BRANCH_PARAMETERS
             WHERE branch = k.branch AND tag = 'PDFONAM' AND val IS NOT NULL;

            /*
              19-02-2015
            - для перерахування військового збору – відповідно значення /11011000/.
            - для перерахування ПДФО – проставляти значення /11010800/;
            */
        if (INSTR (oo.nam_b, '/') != 0)
            then
              oo.nam_b := SUBSTR (oo.nam_b, 1, INSTR (oo.nam_b, '/') - 1);
            end if;

            IF k.B6 = '3622' AND k.o6 IN ('36', '38')
            THEN
               sDet_ := 'Військовий збір';
               oo.nam_b := SUBSTR ('/11011000/'||oo.nam_b, 1, 38);

               SELECT SUBSTR (val, 1, 14)
                 INTO oo.nlsb
                 FROM BRANCH_PARAMETERS
                WHERE branch = k.branch
                  AND tag = 'PDFOVZB'
                  AND val IS NOT NULL;
            ELSE
               sDet_ := 'ПДФО';
               oo.nam_b := SUBSTR ('/11010800/' || oo.nam_b, 1, 38);

               SELECT SUBSTR (val, 1, 14)
                 INTO oo.nlsb
                 FROM BRANCH_PARAMETERS
                WHERE branch = k.branch
                  AND tag = 'PDFONLS'
                  AND val IS NOT NULL;
            END IF;

            SELECT SUBSTR ('. ' || name, 1, 160)
              INTO oo.nazn
              FROM branch
             WHERE branch = k.branch;

            gl.REF (oo.REF);
            oo.nd := TRIM (SUBSTR ('     ' || TO_CHAR (oo.REF), -10));
            oo.nlsa := k.nls6;
            oo.nam_a := SUBSTR (k.nms6, 1, 38);

            SELECT SUBSTR (k.nmkk, 1, 38)
              INTO oo.nam_a
              FROM customer k, accounts a
             WHERE k.rnk = a.rnk AND a.kv = 980 AND a.nls = oo.nlsa;

            IF k.p > 0
            THEN
               oo.tt := 'PS2';
               oo.s := k.P;
               oo.vob := 1;
               oo.nazn := SUBSTR ('*;101;' || gl.aOkpo || ';' || sDet_ || ' з процентних доходів ' || sMes_ || ';;;' || oo.nazn, 1, 160);
            /*
            --13-08-2014 Sta Назн пл от МС Демкович
            *;101;<gl.aOkpo>;ПДФО з процентних доходів <sMes_>;;;
            -- 09.01.2015
            Як приклад для Луганська: ідентиф код 09304612
            *;101;09304612;ПДФО з процентних доходів  за__________ 2014;;;
            *;101;09304612;Військовий збір з процентних доходів за__________ 2014;;;

            */
            ELSE
               oo.tt   := 'PS1';
               oo.s    := k.V;
               oo.vob  := 6;
               oo.nazn := SUBSTR ('Перекриття сум ' || sDet_ || '.' || sMes_ || oo.nazn, 1, 160);
               oo.id_b := gl.aOkpo;
               oo.mfob := gl.aMfo;
               oo.nlsb := k.nls5;
               oo.nam_b := SUBSTR (k.nms5, 1, 38);
            END IF;

            gl.in_doc3 (ref_     => oo.REF,
                        tt_      => oo.tt,
                        vob_     => oo.vob,
                        nd_      => oo.nd,
                        pdat_    => SYSDATE,
                        vdat_    => gl.bdate,
                        dk_      => oo.dk,
                        kv_      => oo.kv,
                        s_       => oo.S,
                        kv2_     => oo.kv,
                        s2_      => oo.s,
                        sk_      => NULL,
                        data_    => gl.bdate,
                        datp_    => gl.bdate,
                        nam_a_   => oo.nam_a,
                        nlsa_    => oo.nlsa,
                        mfoa_    => oo.Mfoa,
                        nam_b_   => oo.nam_b,
                        nlsb_    => oo.nlsb,
                        mfob_    => oo.mfob,
                        nazn_    => oo.nazn,
                        d_rec_   => NULL,
                        id_a_    => oo.id_a,
                        id_b_    => oo.id_b,
                        id_o_    => NULL,
                        sign_    => NULL,
                        sos_     => 1,
                        prty_    => NULL,
                        uid_     => NULL);
            PAYTT (0,
                   oo.REF,
                   gl.bdate,
                   oo.tt,
                   oo.dk,
                   oo.kv,
                   oo.nlsa,
                   oo.s,
                   oo.kv,
                   oo.nlsb,
                   oo.s);

            IF k.p > 0 AND k.v > 0
            THEN
               gl.payv (0,
                        oo.REF,
                        gl.bdate,
                        'PS1',
                        oo.dk,
                        oo.kv,
                        oo.nlsa,
                        k.V,
                        oo.kv,
                        K.NLS5,
                        oo.s);
            END IF;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN NULL;                                                        --
                 raise_application_error (-20000,'Не знайдено пл.реквiзити для ПДФО/ВЗ для бранчу='|| k.branch);
         END;
      END LOOP;
      RETURN;
   END IF;
   ---------------------------------------------------------------------------
   PUL_DAT (TO_CHAR (l_DAT1, 'DD.MM.YYYY'), TO_CHAR (l_DAT2, 'DD.MM.YYYY'));

   EXECUTE IMMEDIATE 'truncate table CCK_AN_TMP ';

   IF NVL (P_MODE, 0) IN (0)
   THEN
      -- только  отчет
      INSERT INTO CCK_AN_TMP (branch, kv, n1, pr, nd, Name, name1, n2, n3, n4)
         SELECT branch, kv,
                ROUND (q * 5 / 1000, 0) n1,
                nal, REF, tt, tt1, s, q, q / s
           FROM (SELECT NVL (T.NAL, 0) NAL,
                        a.kv,
                        p.branch,
                        p.REF,
                        p.tt tt,
                        o.tt tt1,
                        o.s,
                        NVL (
                           (SELECT ROUND (o.s * RATE_B / BSUM, 0)
                              FROM cur_rates$base
                             WHERE kv = a.kv
                               AND branch = a.branch
                               AND vdate = o.fdat),
                           gl.p_icurval (a.kv, o.s, o.fdat))        q
                   FROM opldok o,
                        accounts a,
                        PF_TT3800 T,
                        oper p
                  WHERE o.dk = 1
                    AND o.fdat >= l_dat1
                    AND o.fdat <= l_dat2
                    AND o.acc = a.acc
                    AND a.nbs IN ('3800')
                    AND ob22 IN ('10', '20')
                    AND T.tt = o.tt
                    AND p.REF = o.REF
                    AND p.sos = 5
                    AND o.s > 0);

      -- присоединим ФОРЕКС - для отчета
      IF gl.aMfo = '300465'
      THEN
         sSql_ :=
            'insert into CCK_AN_TMP ( branch, kv   ,   n1,pr,   nd, Name, name1, n2 , n3                 , n4 )
          select                 p.branch, f.kva,  o.s, 0,o.ref, p.tt, o.tt , f.S, round(f.S*f.KURS,0), f.kurs
          from oper p, (select * from opldok where fdat >= :l_dat1 and fdat <= :l_dat2 and tt =''PS1'' and dk=1 and sos=5   ) o,
              (select x.ref, x.kva, x.sumb/x.suma kurs, (x.suma-to_number(y.value)) S
               from  fx_deal x, operw y
               where x.dat >= :l_dat1 and x.dat <= :l_dat2 and x.kva<>980 and x.kvb=980 and x.ref=y.ref and y.tag= ''SUMKL'' ) f
          where p.ref = o.ref and o.ref = f.ref ';

         --logger.info ('PF*'||sSql_);
         EXECUTE IMMEDIATE sSql_
            USING l_dat1,
                  l_dat2,
                  l_dat1,
                  l_dat2;
      END IF;

      RETURN;
   END IF;

   -------------------------------------
   IF p_mode IN (1, 3, 4)
   THEN                                           -- начисление и перечисление
   for k in (SELECT SUBSTR (TRIM (val), 1, 6) as MFOP_, SUBSTR (TRIM (KF), 1, 6) as KF FROM params$base WHERE par = 'MFOP') -- додано цикл по таблиці params$base для перебору доступних MFO
  loop
    begin
        bc.go(k.KF);
        bars_audit.info('Представилися МФО: '||to_char(k.KF));
        bars_context.set_policy_group(p_policy_group => 'FILIAL'); -- включили політики
    end;
    bars_audit.trace('%s Старт с параметром p_mode = %s',title,p_mode);

   /*   BEGIN
         SELECT SUBSTR (TRIM (val), 1, 6)
           INTO MFOP_
           FROM params$base
          WHERE par = 'MFOP';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN raise_application_error (-20000, 'Не знайдено пар.MFOP');
      END; */

      bars_audit.trace('%s MFOP_= %s',title,K.MFOP_);
      IF '300465' IN (K.MFOP_, gl.aMfo)
      THEN
         ob36_nal := '12';
         ob36_bez := '35';
         ob29_nal := '09';
         ob29_bez := '15';
         ob74_ := '07';                                                  -- ОБ
      ELSE
         ob36_nal := '16';
         ob36_bez := '15';
         ob29_nal := '06';
         ob29_bez := '07';
         ob74_ := '09';                         -- NADRA If gl.aMfo = '380764'
      END IF;
      bars_audit.trace('%s ob36_nal= %s',title,ob36_nal);
      -- только итоговые проводки - и реестр итогов по начислению
      oo.vob := 6;

      BEGIN
         SELECT *
           INTO A12
           FROM accounts
          WHERE LENGTH (branch) = 8
            AND kv = 980
            AND dazs IS NULL
            AND nbs = '3622'
            AND ob22 = ob36_nal;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN bars_audit.info('bank_pf: Не знайдено рах 3622/' || ob36_nal || ' на МФО');
		       return;
      END;
       bars_audit.trace('%s A12= %s',title,to_char(A12.nls));
      BEGIN
         SELECT *
           INTO A35
           FROM accounts
          WHERE LENGTH (branch) = 8
            AND kv = 980
            AND dazs IS NULL
            AND nbs = '3622'
            AND ob22 = ob36_bez;
      EXCEPTION
         WHEN NO_DATA_FOUND then
           bars_audit.info('bank_pf:  Не знайдено рах 3622/' || ob36_bez || ' на МФО');
      END;
      bars_audit.trace('%s ob36_bez= %s, A35 = %s',title,to_char(ob36_bez),to_char(A35.nls));
      -- расчеты по мультивалютніх операциях по списку PF_TT3800  - кроме ФОРЕКС
      FOR k
         IN (SELECT NVL (T.NAL, 0) NAL,
                    a.kv,
                    SUBSTR (a.branch, 1, 15) BRANCH,
                    o.s,
                    NVL (
                       (SELECT ROUND (o.s * RATE_B / BSUM, 0)
                          FROM cur_rates$base
                         WHERE kv = a.kv
                           AND branch = a.branch
                           AND vdate = o.fdat),
                       gl.p_icurval (a.kv, o.s, o.fdat))                       q
               FROM opldok o,
                    accounts a,
                    PF_TT3800 T,
                    oper p
              WHERE o.dk = 1
                AND o.fdat = l_dat1
                AND o.acc = a.acc
                AND a.nbs IN ('3800')
                AND ob22 IN ('10', '20')
                AND T.tt = o.tt
                AND p.REF = o.REF
                AND p.sos = 5
                AND o.s > 0)
      LOOP
         rat_ := k.q / k.s;
         q5_ := ROUND (k.q * 5 / 1000, 0);
         bars_audit.trace('%s rat_= %s, q5_ = %s',title,to_char(rat_), to_char(q5_));
         IF k.q > 0
         THEN
            UPDATE CCK_AN_TMP
               SET n1 = n1 + q5_,                -- искомая сумма налога в грн
                                 n2 = n2 + k.s,            -- номинал операций
                                               n3 = n3 + k.q -- эквивалент операций
             WHERE branch = k.branch AND pr = k.nal AND kv = k.kv;

            IF SQL%ROWCOUNT = 0
            THEN
            bars_audit.trace('%s k.nal= %s',title,k.nal);
               IF k.nal = 1
               THEN OO.NLSA := A12.NLS;
               ELSE OO.NLSA := A35.NLS;
               END IF;

               --        OP_BS_OB1 (PP_BRANCH => k.branch, P_BBBOO => '7419'|| ob74_  );
               nls7_ := SUBSTR (nbs_ob22_null ('7419', ob74_, k.branch), 1, 14);
               bars_audit.trace('%snls7_= %s',title,nls7_);
               INSERT INTO CCK_AN_TMP (kv, branch, n1, NLS, NLSALT, PR, n2, n3, n4)
                    VALUES (k.kv,                                           --
                            k.branch,                               -- бранч-2
                            q5_,            -- n1 = искомая сумма налога в грн
                            nls7_,                               -- сч 7419/07
                            OO.NLSA,                                -- сч 3622
                            K.NAL,                   -- PR =1 - признак наличн
                            k.s,                      -- n2 = номинал операций
                            k.q,                   -- n3 = эквивалент операций
                            rat_                        -- n4 = расчетный курс
                                );
            END IF;
         END IF;
      END LOOP;                                                           -- k

      -------------------------------------------------------------------------------
      --Присоединение уже сделанных начислений по ФОРЕКС
      IF gl.aMfo = '300465'
      THEN
         sSql_ :=
            'insert into CCK_AN_TMP ( branch, kv   , n1,pr, n2 , n3                 , n4 ,          NLS, NLSALT )
             select                 a.branch, f.kva,o.s, 0, f.S, round(f.S*f.KURS,0), f.kurs, null, a.nls
             from accounts a,
                  (select * from opldok where fdat >= :l_dat1 and fdat <= :l_dat2 and tt =''PS1'' and dk=1 and sos=5   ) o,
                  (select x.ref, x.kva, x.sumb/x.suma kurs, (x.suma-to_number(y.value)) S
                   from  fx_deal x, operw y
                   where x.dat >= :l_dat1 and x.dat <= :l_dat2 and x.kva<>980 and x.kvb=980 and x.ref=y.ref and y.tag= ''SUMKL'' ) f
             where o.ref = f.ref and a.acc= o.acc ';

         --logger.info ('PF*'||sSql_);
         EXECUTE IMMEDIATE sSql_
            USING l_dat1,
                  l_dat2,
                  l_dat1,
                  l_dat2;
         bars_audit.trace('%s sSql_= %s',title,sSql_);
      END IF;

      --Общие суммы Присоединений
      FOR Z IN (  SELECT PR, NLSALT, SUM (N1) S
                    FROM CCK_AN_TMP
                   WHERE n1 > 0
                GROUP BY pr, nlsalt)
      LOOP
         gl.REF (oo.REF);
         bars_audit.trace('%s oo.REF= %s, z.pR = %s, z.nlsalt = %s',title,to_char(oo.REF), to_char(z.pr),to_char(z.nlsalt));
         UPDATE CCK_AN_TMP
            SET nd = oo.REF
          WHERE pr = z.pR AND nlsalt = z.nlsalt;

         IF Z.PR = 1
         THEN
            OO.NLSA := A12.NLS;
            OO.NAM_A := SUBSTR (A12.NMS, 1, 38);
         ELSE
            OO.NLSA := A35.NLS;
            OO.NAM_A := SUBSTR (A35.NMS, 1, 38);
         END IF;

         -- пл.реквизиты для перечисления сумм "наверх" в ЦА (Об) или прямо в ПФ (Надра)
         IF '300465' IN (K.MFOP_, gl.aMfo)
         THEN
            oo.mfob := '300465';
            oo.id_b := '00032129';                     -- РУ ОБ в ГOУ Ощадбанк

            IF Z.PR = 1
            THEN
               OO.NLSB := '36228012017';
               OO.NAM_B := 'Операцiї з Готiвкою';
            ELSE
               OO.NLSB := '36227035017';
               OO.NAM_B := 'Операцiї з Без/Готiвкою';
            END IF;

            OO.NAZN := 'Авто-Збір на обов’язк. держ. пенс. страх. від купів. ІВ за ' || TO_CHAR (l_dat1, 'dd.mm.yyyy');
         ELSE
            oo.mfob  := '820019';
            oo.id_b  := '37995466'; -- Головне управління Державної казначейської служби України в м. Києві
            oo.nlsb  := '31217222700011';
            OO.NAM_B := 'УДКСУ у Шевченківському р-ні м.Києва';

            IF z.PR = 1
            THEN oo.nazn := SUBSTR ('*;101;20025456;24140100;222;0.5% з купівлі готівкової іноземної валюти ПАТ "КБ"НАДРА" код ЄДРПОУ 20025456;;;', 1, 160);
            ELSE oo.nazn := SUBSTR ('*;101;20025456;24140100;222;0.5% з купівлі безготівкової іноземної валюти ПАТ "КБ"НАДРА" код ЄДРПОУ 20025456;;;', 1, 160);
            END IF;
         END IF;

         oo.nd := TRIM (SUBSTR ('     ' || TO_CHAR (oo.REF), -10));
         bars_audit.trace('%s oo.nd= %s',title,to_char(oo.nd));

         IF gl.aMfo = oo.mfob
         THEN oo.tt := '420';
         ELSE oo.tt := 'PS6';
         END IF;

         IF p_mode IN (1, 4)
         THEN
            gl.in_doc3 (ref_     => oo.REF,
                        tt_      => oo.tt,
                        vob_     => oo.vob,
                        nd_      => oo.nd,
                        pdat_    => SYSDATE,
                        vdat_    => gl.bdate,
                        dk_      => 1,
                        kv_      => 980,
                        s_       => Z.S,
                        kv2_     => 980,
                        s2_      => Z.S,
                        sk_      => NULL,
                        data_    => gl.bdate,
                        datp_    => gl.bdate,
                        nam_a_   => oo.nam_a,
                        nlsa_    => oo.nlsa,
                        mfoa_    => gl.aMfo,
                        nam_b_   => oo.nam_b,
                        nlsb_    => oo.nlsb,
                        mfob_    => oo.mfob,
                        nazn_    => oo.nazn,
                        d_rec_   => NULL,
                        id_a_    => gl.aOkpo,
                        id_b_    => oo.id_b,
                        id_o_    => NULL,
                        sign_    => NULL,
                        sos_     => 1,
                        prty_    => NULL,
                        uid_     => NULL);

            IF gl.aMfo = '300465'
            THEN             -- ГOУ Ощадбанк, консолидирующей проводки не надо
               UPDATE oper
                  SET nlsa = '74196007010000',
                      nam_a = 'Cплата податкiв в ПФ від купів.вал.'
                WHERE REF = oo.REF;
            ELSE
               paytt (0,
                      oo.REF,
                      gl.bdate,
                      oo.tt,
                      1,
                      980,
                      oo.nlsa,
                      z.s,
                      980,
                      oo.NLSb,
                      z.s);
            END IF;
         END IF;

         IF p_mode IN (3)
         THEN
           bars_audit.trace('%s IF p_mode IN (3) %s',title,to_char(oo.REF));
            gl.in_doc3 (
               ref_     => oo.REF,
               tt_      => '420',
               vob_     => oo.vob,
               nd_      => oo.nd,
               pdat_    => SYSDATE,
               vdat_    => gl.bdate,
               dk_      => 1,
               kv_      => 980,
               s_       => Z.S,
               kv2_     => 980,
               s2_      => Z.S,
               sk_      => NULL,
               data_    => gl.bdate,
               datp_    => gl.bdate,
               nam_a_   => oo.nam_a,
               nlsa_    => nls7_,
               mfoa_    => gl.aMfo,
               nam_b_   => 'Cплата податкiв в ПФ від купів.вал.',
               nlsb_    => oo.nlsa,
               mfob_    => gl.aMfo,
               nazn_    => oo.nazn,
               d_rec_   => NULL,
               id_a_    => gl.aOkpo,
               id_b_    => gl.aOkpo,
               id_o_    => NULL,
               sign_    => NULL,
               sos_     => 1,
               prty_    => NULL,
               uid_     => NULL);
         END IF;

         IF p_mode IN (1, 3)
         THEN
            FOR k IN (SELECT kv,
                             branch,
                             n1,
                             n2,
                             n3,
                             n4,
                             nls
                        FROM CCK_AN_TMP
                       WHERE n1 > 0 AND pr = z.pr        --and nls is not null
                                                 )
            LOOP
             bars_audit.trace('%s k.nls = %s',title,to_char(k.nls));
               IF k.nls IS NULL
               THEN raise_application_error ( -20000, 'Не знайдено NLS для бранчу=' || k.branch);
               END IF;

               gl.payv (0,
                        oo.REF,
                        gl.bdate,
                        '420',
                        0,
                        980,
                        oo.nlsa,
                        k.n1,
                        980,
                        K.NLS,
                        k.n1);

               UPDATE opldok
                  SET txt = SUBSTR ( 'Вал=' || k.kv || ', ном=' || k.n2 || ', екв=' || k.n3 || ', курс=' || k.n4, 1, 50)
                WHERE REF = oo.REF
                  AND stmt = gl.aStmt;
            END LOOP;                                     -- оплата 1 проводки

            IF p_mode IN (3)
            THEN
               gl.pay2 (2, oo.REF, l_dat1);
            END IF;
         END IF;
      END LOOP;                                                           -- Z

      -- блочок для Жени - продажа клиентам
      IF gl.aMfo = '300465'
      THEN                   -- ГOУ Ощадбанк, консолидирующей проводки не надо
         --RETURN;
         continue;
      END IF;

      --------------------
      IF p_mode = 3
      THEN                   -- ГOУ Ощадбанк, консолидирующей проводки не надо
       bars_audit.trace('%s ГOУ Ощадбанк, консолидирующей проводки не надо',title);
       --RETURN;
       continue;
      END IF;

      FOR z_ IN 0 .. 1
      LOOP
         IF Z_ = 1
         THEN
            BEGIN
               SELECT *
                 INTO A12
                 FROM accounts
                WHERE LENGTH (branch) = 8
                  AND kv = 980
                  AND dazs IS NULL
                  AND nbs = '2902'
                  AND ob22 = ob29_nal;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN raise_application_error (-20000, 'Не знайдено рах 2902/' || ob29_nal || ' на МФО');
            END;
         ELSE
            BEGIN
               SELECT *
                 INTO A12
                 FROM accounts
                WHERE LENGTH (branch) = 8
                  AND kv = 980
                  AND dazs IS NULL
                  AND nbs = '2902'
                  AND ob22 = ob29_bez;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN raise_application_error ( -20000, 'Не знайдено рах 2902/' || ob29_bez || ' на МФО');
            END;
         END IF;

         OO.NLSA := A12.NLS;
         OO.NAM_A := SUBSTR (A12.NMS, 1, 38);

         -- пл.реквизиты для перечисления сумм "наверх" в ЦА (Об) или прямо в ПФ (Надра)
         IF K.MFOP_ = '300465'
         THEN
            oo.mfob := K.MFOP_;
            oo.id_b := '00032129';                             -- ГOУ Ощадбанк

            IF Z_ = 1
            THEN
               OO.NLSB := '29022009017';
               OO.NAM_B := 'Операцiї з Готiвкою';
            ELSE
               OO.NLSB := '29027015017';
               OO.NAM_B := 'Операцiї з Без/Готiвкою';
            END IF;

            OO.NAZN := 'Авто-Перерахування на обов’язк. держ. пенс. страх. від продажу ІВ за ' || TO_CHAR (l_dat1, 'dd.mm.yyyy');
         ELSE
            oo.mfob  := '820019';
            oo.id_b  := '37995466'; -- Головне управління Державної казначейської служби України в м. Києві
            oo.nlsb  := '31217222700011';
            OO.NAM_B := 'УДКСУ у Шевченківському р-ні м.Києва';
            oo.nazn  := '*;101;00032129; збір з операцій купівлі-продажу іноземної валюти за гривню;;;';

            IF z_ = 1
            THEN oo.nazn := SUBSTR ('*;101;20025456;24140100;222;0.5% з продажу готівкової іноземної валюти ПАТ "КБ"НАДРА" код ЄДРПОУ 20025456;;;', 1, 160);
            ELSE oo.nazn := SUBSTR ('*;101;20025456;24140100;222;0.5% з продажу безготівкової іноземної валюти ПАТ "КБ"НАДРА" код ЄДРПОУ 20025456;;;', 1, 160);
            END IF;
         END IF;

         -- Миниус Все Беки-Дебеты
         SELECT NVL (SUM (s), 0)
           INTO oo.s
           FROM opldok
          WHERE acc = a12.acc
            AND fdat = l_dat1
            AND tt = 'BAK'
            AND dk = 0;

         -- Плюс Все Кредиты
         oo.s := (-oo.s) + fkos (a12.acc, l_dat1, l_dat1);
         -- но не более, чем остаток
         oo.s := LEAST (oo.s, a12.ostc);

         IF gl.amfo = '380764'
         THEN                             -- в НАДРАХ счета 2902 на 2-е уровне
            SELECT NVL (SUM (LEAST (fkos (acc, l_dat1, l_dat1), ostc)), 0)
              INTO oo.s
              FROM accounts
             WHERE nbs = a12.nbs
               AND ob22 = a12.ob22
               AND branch <> a12.branch;
         END IF;

         IF oo.s > 0
         THEN
            gl.REF (oo.REF);
            oo.nd := TRIM (SUBSTR ('    ' || TO_CHAR (oo.REF), -10));

            IF gl.aMfo = oo.mfob
            THEN oo.tt := '420';
            ELSE oo.tt := 'PS6';
            END IF;

            gl.in_doc3 (ref_     => oo.REF,
                        tt_      => oo.tt,
                        vob_     => oo.vob,
                        nd_      => oo.nd,
                        pdat_    => SYSDATE,
                        vdat_    => gl.bdate,
                        dk_      => 1,
                        kv_      => 980,
                        s_       => oo.S,
                        kv2_     => 980,
                        s2_      => oo.S,
                        sk_      => NULL,
                        data_    => gl.bdate,
                        datp_    => gl.bdate,
                        nam_a_   => oo.nam_a,
                        nlsa_    => oo.nlsa,
                        mfoa_    => gl.aMfo,
                        nam_b_   => oo.nam_b,
                        nlsb_    => oo.nlsb,
                        mfob_    => oo.mfob,
                        nazn_    => oo.nazn,
                        d_rec_   => NULL,
                        id_a_    => gl.aOkpo,
                        id_b_    => oo.id_b,
                        id_o_    => NULL,
                        sign_    => NULL,
                        sos_     => 1,
                        prty_    => NULL,
                        uid_     => NULL);

            IF gl.amfo = '380764'
            THEN
               FOR k
                  IN (SELECT nls, LEAST (fkos (acc, l_dat1, l_dat1), ostc) s
                        FROM accounts
                       WHERE nbs = a12.nbs
                         AND ob22 = a12.ob22
                         AND branch <> a12.branch)
               LOOP
                  IF k.s > 0
                  THEN
                     gl.payv (0,
                              oo.REF,
                              gl.bdate,
                              'PS6',
                              0,
                              980,
                              oo.nlsa,
                              k.s,
                              980,
                              K.NLS,
                              k.s);
                  END IF;
               END LOOP;
            END IF;

            paytt (0,
                   oo.REF,
                   gl.bdate,
                   oo.tt,
                   1,
                   980,
                   oo.nlsa,
                   oo.s,
                   980,
                   oo.NLSb,
                   oo.s);

            UPDATE oper
               SET s = oo.s, s2 = oo.s
             WHERE REF = oo.REF;
         END IF;
      END LOOP;                                                         --- z_
    end loop; --закінчення циклу по таблиці params$base
   END IF;

END Bank_PF;
/
show err;

PROMPT *** Create  grants  BANK_PF ***
grant DEBUG,EXECUTE                                                          on BANK_PF         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BANK_PF         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/BANK_PF.sql =========*** End *** =
PROMPT ===================================================================================== 
