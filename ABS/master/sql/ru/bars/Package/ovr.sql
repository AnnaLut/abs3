CREATE OR REPLACE PACKAGE BARS.ovr
IS
   g_header_version   CONSTANT VARCHAR2 (64) := 'version 33  19/06/2009';
   --15/06/2009 Sta Плавающая ставка в РУ ОБ

   PROCEDURE p_ovr8z ( nmode_     INT,acc_2000   INT,    sum_       INT DEFAULT NULL,      sum_pr_    INT DEFAULT NULL   );
   PROCEDURE p_oversob ( acc_     NUMBER,   nd_      NUMBER,   ref_     NUMBER,    sob_     NUMBER,     s_       NUMBER,    mdate_   DATE  );
   PROCEDURE check_ovr (acc_ NUMBER, nnd_ OUT NUMBER, ndc_ OUT VARCHAR2);
   PROCEDURE check_ovr2 (acc_ NUMBER, nls_ OUT VARCHAR2, kv_ OUT NUMBER);
   PROCEDURE p_tmp_agx (dat1_ DATE, dat2_ DATE);
   FUNCTION ovr_par_val (par_ VARCHAR)      RETURN VARCHAR2;
   FUNCTION int_per (dat_ DATE, acc_ INT, br_id_ INT)      RETURN NUMBER;
   FUNCTION f_nbs (acc_ INT, nbs_par INT)      RETURN VARCHAR;
   FUNCTION getpo (tt_ VARCHAR2)      RETURN NUMBER;
   PROCEDURE int_ovrp (  nacc_          INT,    nid    INT,   ddat1      DATE,    ddat2_         DATE,     nint     OUT   NUMBER,      nost  NUMBER,    nmode    INT  );
   PROCEDURE mdate_9129 (aa_ NUMBER);
   Function pay_date  ( p_date  in  fdat.fdat%type,     p_pday  in  acc_over.pr_2600a%type  default null   ) return date;
   FUNCTION header_version      RETURN VARCHAR2;
   FUNCTION body_version      RETURN VARCHAR2;
-------------------
END ovr;
/
show err

CREATE OR REPLACE PACKAGE BODY BARS.ovr IS    g_body_version   CONSTANT VARCHAR2 (64) := 'version 4.0  16/11/2017';
/*
 16.11.2017 Тип счета для просроченной фин.деб. '3579' tip := 'OFR' 
                                                '2067' tip := 'SP '  
                                                '2069' tip := 'SPN' 

 15.11.2017 Transfer-2017  2067.01 => 2063.33 -- короткостроковў кредити в поточну дўяльнўсть
                           2069.04 => 2068.46 -- простроченў нарахованў доходи за короткостроковими кредитами в поточну дўяльнўсть
                           6111.05 => 6511.05 -- за супроводження кредитів, наданих юридичним особам та іншим суб`єктам підприємницької діяльності
                           3579.91 => 3578.66 -- --прострочені нараховані доходи за кредитами овердрафт, що неотримані від суб"єктів господарювання	


 15/06/2009 Sta  Плавающая ставка в РУ ОБ
*/
   G_2017 int;
   SB_2067 SB_OB22%rowtype;
   SB_2069 SB_OB22%rowtype;
   SB_6020 SB_OB22%rowtype;
   SB_6111 SB_OB22%rowtype;
   SB_3579 SB_OB22%rowtype;
   ------------------------
   PROCEDURE p_ovr8z (
      nmode_     INT,
      acc_2000   INT,
      sum_       INT DEFAULT NULL,
      sum_pr_    INT DEFAULT NULL
   )
   IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :   Процедура выдачи-погашения овердрафта
% COPYRIGHT   :   Copyright UNITY-BARS Limited, 1998.  All Rights Reserved.
% VERSION     : 25-05-2006
%
% 1). Аргументы ВЫЗОВА:
%     -  NMODE_   - параметр вызова,
%     -  ACC_2000 - счет (при работе по одному договору);
%                   если ACC_2000 = 0, то процедура используются по ВСЕМ счетам
%                   портфеля.
%
% 2). Выполняемые действия при различных параметрах вызова:
%
%   1 - Стягнення % в останнiй день    (D2600-K2607)
%   2 - Перенос на просрочку           (D2067-K2600,  D2069-K2607)
%   3 - Авто-гашение нач. % по овердрафту
%   4 - Стягнення суми просрочки       (D-2600,K-2067)
%   8 - Закрытие договора
%  11 - Стягнення % по просрочцi       (D-2600,K-2069)
%
%  12 - Перенос на просрочку только %% (D2069-K2607)   +
%       Проставляем OB22:
%       2607/01
%       9129/04
%       2067/01
%       2069/04
%       3578/36
%       3579/91
%
%  14 - Блокировка Лимита при просрочке (превышении MDATE)  - для "НАДР" !!!
%
%  31 - Погашение комиссии одного дня
%  33 - Погашение ВСЕХ долгов по овердрафту
%  62 - Начисл.комiсiї (D2607 - K6*) за одноденний овердр. (по макс.активному залишку за день)
%  61 - Начисл.комiсiї (D2607 - K6*) за одноденний овердр. (по суме дебетових оборотов в активному залишку)
%  91 - Невикористаний овердрафт 9129  
%                 +  Запись счетов в ND_ACC
%
%  96 - Перенос на сомнительную задолженность (D-2096,K-2067,D-2096,K2069)
%
%  72 - Блокировка ЛИМИТА (TIP='BLD'), если это "кред.линия" и счет 
%       больше 30 дней был в овердрафте.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
      id_             INT;
      s_              NUMBER;
      s2_             NUMBER;
      ref_            INT;
      naz_            VARCHAR2 (160);
      acc_            INT;
      ret1_           NUMBER;
      nls_            VARCHAR2 (15);
      nms_            VARCHAR2 (70);
      acc67_          NUMBER;
      nbs_            CHAR (4);
      mfo5_           VARCHAR2 (12);
      nbs9_           CHAR (4);
      nbs3_           CHAR (4);
      acc9_           INT;
      nls9_           VARCHAR2 (55);
      tobo_a          tobo.tobo%type;-- код ТОБО счета 2600
      nms9_           VARCHAR2 (70);
      ir_             NUMBER;
      br_             NUMBER;
      op_             VARCHAR2 (15);
      s8000_          NUMBER;
      dk_             INT;
      nazn1_          VARCHAR2 (70);
      acc8_           INT;
      acc_2008_       INT;
      nls_2008_       VARCHAR2 (15);
      nms_2008_       VARCHAR2 (70);
      ost_2008_       NUMBER;
      ost_2008_1      NUMBER;
      kos_2008_       NUMBER;
      s_per2008_      NUMBER;    --- переносимая сумма %%  (2607 -> 2069)
      acc_2607_       INT;
      nls_2607_       VARCHAR2 (15);
      nms_2607_       VARCHAR2 (70);
      acc_2067_       INT;
      nls_2067_       VARCHAR2 (15);
      nms_2067_       VARCHAR2 (70);
      ost_2067_       NUMBER;
      acc_2069_       INT;
      nls_2069_       VARCHAR2 (15);
      nms_2069_       VARCHAR2 (70);
      ost_2069_       NUMBER;
      acc_2096_       INT;
      nls_2096_       VARCHAR2 (15);
      nms_2096_       VARCHAR2 (70);
      ost_2096_       NUMBER;

      acc_9500_       NUMBER;
      ost_9500_       NUMBER;

      acc_2480_       INT;
      nls_2480_       VARCHAR2 (15);
      nms_2480_       VARCHAR2 (70);
      ost_2480_       NUMBER;
      acc_3578_       INT;
      ost_3578_       NUMBER;
      nls_3578_       VARCHAR2 (15);
      nms_3578_       VARCHAR2 (70);
      acc_3579_       INT;
      nls_3579_       VARCHAR2 (15);
      nms_3579_       VARCHAR2 (70);
      nls_8008_       VARCHAR2 (15);
      nms_8008_       VARCHAR2 (70);
      acc_8008_       INT;
      tt9_   CONSTANT CHAR (3)       := 'OV-';
      b9129_          CHAR (4);
      dtxt_           VARCHAR2 (160);
      txt_            VARCHAR2 (35);
      ntemp_          NUMBER;
      flags_          VARCHAR2 (50);                        -- флаг из params
      flagrlim_       NUMBER;
      -- фл.восстановления лим.овердр.после пог.проср.
      tlim_           NUMBER;
      ts_             NUMBER;
      ts2_            NUMBER;
      dat2_           DATE;
      okpo_           VARCHAR2 (14);
      tt_             CHAR (3);
      pr_2600_        NUMBER;
      pr_komis_       NUMBER;
      pr_9129_        NUMBER;
      pr_2069_        NUMBER;
      acc_8000_       NUMBER;
      nls_8000_       VARCHAR2 (15);
      acc_9129_       NUMBER;
      acc_2001_       NUMBER;
      nls_2001_       VARCHAR2 (15);
      nms_2001_       VARCHAR2 (70);
      ost_2001_       NUMBER;
      openday_        CHAR (1);
      ndoc_           VARCHAR2 (30);
      datd_           DATE;
      kv_             NUMBER;
      dazs_           DATE;
      basey_          INTEGER;
      nday_           INTEGER;
      som_prc_        INTEGER;
      s080_           INTEGER;
      nbs2600_        VARCHAR (4);
      nbs2000_        VARCHAR (4);
      nbs2607_        VARCHAR (4);
      nbs2067_        VARCHAR (4);
      nbs2069_        VARCHAR (4);
      nbs2096_        VARCHAR (4);
      nbs2480_        VARCHAR (4);
      vob_            NUMBER;
      a_grp_          NUMBER;
      max_sob         NUMBER;
      idr_            INT;
      ir_max          number(20,4);
      
      kol_9500        INTEGER;



      ern    CONSTANT POSITIVE       := 208;
      err             EXCEPTION;
      erm             VARCHAR2 (80);

--------------------------------------------------------------

  Procedure GASH (acc_s NUMBER, acc_d NUMBER, use_lim INT, naz VARCHAR2)
         IS
         ostc_s_   NUMBER;
         ostb_s_   NUMBER;
         nls_s_    VARCHAR2 (15);
         nms_s_    VARCHAR2 (70);
         ostc_d_   NUMBER;
         ostb_d_   NUMBER;
         nls_d_    VARCHAR2 (15);
         nms_d_    VARCHAR2 (70);
         pap_d_    NUMBER;
         s_        NUMBER;
         ref_      NUMBER;
         lim_      NUMBER;
         kv_s_     INT;
         kv_d_     INT;
      BEGIN
      ---  Гасящий счет  (счет-Дт):
         SELECT ostc, ostb, kv, nls, nms, lim
           INTO ostc_s_, ostb_s_, kv_s_, nls_s_, nms_s_, lim_
           FROM accounts
          WHERE acc = acc_s;

      ---  Счет, который гасится (счет-Кт):
         SELECT ostc, ostb, kv, pap, nls, nms
           INTO ostc_d_, ostb_d_, kv_d_, pap_d_, nls_d_, nms_d_
           FROM accounts
          WHERE acc = acc_d;

      --- Гасятся только Дебетовые остатки: 
         IF    ostc_d_ >= 0
            OR SUBSTR (nls_d_, 1, 1) = '9'
     --     OR pap_d_ != 1
     --     OR ostc_s_ != ostb_s_
     --     OR ostc_d_ != ostb_d_
         THEN
            RETURN;
         END IF;

         gl.REF (ref_);

         IF use_lim = 1
         THEN
            IF ostc_s_ + lim_ >= ABS (ostc_d_)
            THEN
               s_ := ABS (ostc_d_);
            ELSE
               s_ := GREATEST (ostc_s_ + lim_, 0);
            END IF;
         ELSE
            IF ostc_s_ >= ABS (ostc_d_)
            THEN
               s_ := ABS (ostc_d_);
            ELSE
               s_ := GREATEST (ostc_s_, 0);
            END IF;
         END IF;

         IF s_ = 0
         THEN
            RETURN;
         END IF;

         INSERT INTO oper
                     (s, s2, dk, REF, tt, vob, nd, pdat, vdat,
                      datd, datp, nam_a, nlsa,
                      mfoa, kv, nam_b, nlsb,
                      mfob, kv2, nazn, userid, SIGN, id_a,
                      id_b
                     )
              VALUES (s_, s_, 1, ref_, 'OVR', 6, ref_, SYSDATE, gl.bdate,
                      gl.bdate, gl.bdate, SUBSTR (nms_s_, 1, 38), nls_s_,
                      gl.amfo, kv_s_, SUBSTR (nms_d_, 1, 38), nls_d_,
                      gl.amfo, kv_d_, naz, user_id, getautosign, gl.aokpo,
                      gl.aokpo
                     );


         gl.payv (NULL,
                  ref_,
                  gl.bdate,
                  'OVR',
                  1,
                  kv_s_,
                  nls_s_,
                  s_,
                  kv_d_,
                  nls_d_,
                  s_
                 );
  END gash;              ---   END procedure GASH

------------------------------------------------------------------

   BEGIN
      id_ := user_id;

      SELECT val
        INTO mfo5_
        FROM params
       WHERE par = 'MFO';

      SELECT val
        INTO okpo_
        FROM params
       WHERE par = 'OKPO';

      DELETE FROM tmp_ovr
            WHERE dat <= gl.bdate - 3;

      --commit;
      gl.bdate := bankdate;

      --  опр. флаги из params
      IF ovr.ovr_par_val ('RESTLIM') = 'TRUE'
      THEN
         flagrlim_ := 1;
      ELSE
         flagrlim_ := 0;
      END IF;

      IF ovr.ovr_par_val ('SOM_PRC') = '1'
      THEN
         som_prc_ := 1;
      ELSE
         som_prc_ := 0;
      END IF;

      IF ovr.ovr_par_val ('A_GRP') is not NULL
      THEN
         a_grp_ := to_number(ovr.ovr_par_val ('A_GRP'));
      ELSE
         a_grp_ := -1;
      END IF;

      BEGIN
         SELECT val
           INTO openday_
           FROM params
          WHERE UPPER (par) = 'RRPDAY';
      EXCEPTION
         WHEN OTHERS
         THEN
            openday_ := '0';
      END;

-- если банковский день открыт
      IF openday_ = '1'
      THEN
------------------------------------------------------------------------------

-----  Погашение проср. %% 2069 по овердрафту

         IF nmode_ = 11  THEN

for k in (select o.ndoc, o.datd, o.nd, o.uselim, i.ACRA,
                 o.acc_3739, o.ACC    
          from   acc_over o, int_accn i
          where o.tipo <> 200
            AND (acc_2000 = 0 OR acc_2000 = i.acc)
            AND o.ACC_2067 = i.acc                         --- 2067
            AND MOD(i.ID,2) = 0
            AND i.ACRA is not null                         --- 2069
            AND o.SOS is NULL 
            AND o.ACC_2067 is not NULL --- это осн.запись
         )
loop

   SAVEPOINT do_provodki_11;

   declare
      l_acc  accounts.acc%type  ;
      l_ost8 accounts.ostc%type ;
      l_ost6 accounts.ostc%type ;
      l_lim  accounts.lim%type  ;
      l_s    oper.s%type        ;
      l_s3   oper.s%type        ;
      l_kv   accounts.kv%type   ;
      l_nls6 accounts.nls%type  ;
      l_nms6 accounts.nms%type  ;
      l_nls8 accounts.nls%type  ;
      l_nms8 accounts.nms%type  ; 
      l_okpo customer.okpo%type ;

   begin
      l_acc  := nvl(k.acc_3739, k.acc); -- счет, с которого будем списывать
      l_ost8 := fost(k.acra, gl.bdate); -- остаток на 2067
      l_ost6 := fost(l_acc , gl.bdate); -- остаток на 2600 (3739)

      If l_ost8 >= 0 then GOTO kin_11  ; end if;
      --------------------------------------
      l_s  := LEAST (l_ost6, -l_ost8 ) ;
      l_s3 := l_ost6 ;

      --- использовать лимит
      IF k.uselim = 1  and  k.acc_3739 is null THEN    
         select lim into l_lim from accounts where acc =k.ACC;
         l_s := LEAST (l_ost6 + l_lim, -l_ost8 ) ;

         -- опр необх оборот по 8000 на сумму исп лимита
         IF l_s3 < l_s   THEN  ts2_ := l_s;
            IF l_s3 > 0  THEN  ts2_ := ts2_ - l_s3;
            END IF;
         END IF;
      END IF;

      If  l_s <= 0   then GOTO kin_11  ; end if;
      -----------------------------------------

      select a.kv, a.nls, substr(a.nms,1,38), s.okpo
      into l_kv, l_nls6, l_nms6, l_okpo
      from accounts a, customer s
      where a.acc= l_acc and a.rnk =s.rnk;

      select nls, substr(nms,1,38) into l_nls8, l_nms8
      from accounts  where acc= k.acra;

      gl.REF (ref_);
      naz_ := 'Погашення %%, нарахованих на просроч.овердрафт. Угода № '
              || RTRIM (k.ndoc)|| ' вiд '  || TO_CHAR (k.datd, 'dd.mm.yyyy');

      gl.in_doc3 (ref_, 'OVR', 6, ref_ , SYSDATE,   gl.bdate, 1,
                  l_kv,  l_s, l_kv, l_s,    NULL,   gl.bdate, gl.bdate,
                  l_nms6, l_nls6, mfo5_, l_nms8 , l_nls8,  mfo5_, naz_,
                   NULL, l_okpo,  l_okpo,   NULL,   NULL,  NULL,  NULL, null );
 
      paytt (ovr.getpo ('OVR'),
             ref_, 
             gl.bdate, 
             'OVR', 
             1,
             l_kv, 
             l_nls6,
             l_s,
             l_kv, 
             l_nls8,
             l_s
            );

   EXCEPTION  WHEN OTHERS  THEN  
      ROLLBACK TO do_provodki_11;
      BEGIN
        GOTO kin_11;
      END;
   END;
   <<kin_11>>   NULL;
END LOOP;

RETURN;

------------------------------------------------------------------------------

         ELSIF nmode_ = 4
         THEN
            -- 4.OVR-F2: Погашення просрочки    (D-2600,K-2067)

            naz_ := 'Погашення суми боргу просроч. овердрафту.';

            FOR k IN (SELECT a.acc acc2600, a.nls, SUBSTR (a.nms, 1, 38) nms,
                             LEAST (a.ost, -p.ost) s, p.nls nlsp,
                             SUBSTR (p.nms, 1, 38) nmsp, a.kv, c.okpo,
                             o.ndoc, o.datd, o.ACC acc_2600 
                        FROM sal a,
                             sal p,
                             acc_over o,
                             cust_acc ca,
                             customer c
                       WHERE 
                             a.ost > 0
                         AND a.fdat = gl.bdate
                         AND p.ost < 0
                         AND p.fdat = gl.bdate
               ----          AND a.acc = o.acc
                         AND a.acc = nvl(o.acc_3739, o.acc)
                         AND o.acco = p.acc
                         AND MOD(NVL(o.flag,0),2) = 0
                         AND (acc_2000 = 0 OR acc_2000 = p.acc)
                         AND ca.acc = a.acc
                         AND ca.rnk = c.rnk
                         AND o.tipo <> 200
                     )
            LOOP
               SAVEPOINT do_provodki_4;

               BEGIN
                  gl.REF (ref_);

                  SELECT datd, ndoc
                    INTO datd_, ndoc_
                    FROM acc_over
                   WHERE acc = k.acc_2600 AND NVL (sos, 0) <> 1;

                  dtxt_ :=
                        ' Угода № '
                     || RTRIM (ndoc_)
                     || ' вiд '
                     || TO_CHAR (datd_, 'dd.mm.yyyy');
                     
                  gl.in_doc3 (ref_,
                              'OVR',
                              6,
                              ref_,
                              SYSDATE,
                              gl.bdate,
                              1,
                              k.kv,
                              k.s,
                              k.kv,
                              k.s,
                              NULL,
                              gl.bdate,
                              gl.bdate,
                              k.nms,
                              k.nls,
                              mfo5_,
                              k.nmsp,
                              k.nlsp,
                              mfo5_,
                              naz_ || dtxt_,
                              NULL,
                              k.okpo,
                              k.okpo,
                              NULL,
                              NULL,
                              NULL,
                              NULL,
                              NULL
                             );

                  paytt (ovr.getpo ('OVR'),
                         ref_,
                         gl.bdate,
                         'OVR',
                         1,
                         k.kv,
                         k.nls,
                         k.s,
                         k.kv,
                         k.nlsp,
                         k.s
                        );

                  --- Восстановление лимита для Петрокоммерца
                  IF flagrlim_ = 1
                  THEN
                     SELECT NVL (lim, 0)
                       INTO tlim_
                       FROM accounts
                      WHERE acc = k.acc_2600;
                
                     UPDATE accounts
                        SET lim = tlim_ + ABS (k.s)
                      WHERE acc = k.acc_2600;
                  END IF;

               EXCEPTION WHEN OTHERS THEN
               
                     ROLLBACK TO do_provodki_4;
               
                     BEGIN
                        INSERT INTO tmp_ovr
                                    (dat, ID, dk, nlsa, nlsb, s,
                                     txt
                                    )
                             VALUES (gl.bdate, 4, 1, k.nls, k.nlsp, k.s,
                                     'Погашення просрочки'
                                    );
               
                        GOTO kin_4;
                     END;
               END;

               <<kin_4>>
               NULL;
            END LOOP;

            RETURN;
------------------------------------------------------------------------------

         ELSIF nmode_ = 61
         THEN
            --OVR-F6: Комiсiя за овердрафт ОДНОГО дня
            FOR k IN (SELECT s8.acc acc8, s6.acc acc6,
                             LEAST (s8.dos, s6.kos) s, c.okpo, o.ndoc,
                             o.datd, c.nmk, a.kv
                        FROM saldoa s8,
                             saldoa s6,
                             cust_acc u,
                             customer c,
                             acc_over o,
                             accounts a
                       WHERE o.acc = o.acco
                         AND (acc_2000 = 0 OR acc_2000 = o.acc)
                         AND s8.acc = o.acc_8000
                         AND s8.fdat = gl.bdate
                         AND s8.dos > 0
                         AND s8.trcn > 0
                         AND s6.acc = o.acc
                         AND s6.fdat = gl.bdate
                         AND s6.kos > 0
                         AND a.acc = o.acc
                         AND a.nbs = ovr.f_nbs (o.acc, 2600)
                         AND u.acc = a.acc
                         AND u.rnk = c.rnk
                         AND o.tipo <> 200)
            LOOP
               SAVEPOINT do_provodki_61;

               BEGIN
                  -- счета
                  BEGIN
                     SELECT a.nls, SUBSTR (a.nms, 1, 38), b.nls,
                            SUBSTR (b.nms, 1, 38)
                       INTO nls_2067_, nms_2067_, nls_,
                            nms_
                       FROM int_accn i, accounts a, accounts b
                      WHERE i.acc = k.acc8
                        AND i.ID = 0
                        AND i.acra = a.acc
                        AND i.acrb = b.acc;
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                        BEGIN
                           SELECT a.nls, SUBSTR (a.nms, 1, 38), b.nls,
                                  SUBSTR (b.nms, 1, 38)
                             INTO nls_2067_, nms_2067_, nls_,
                                  nms_
                             FROM int_accn i, accounts a, accounts b
                            WHERE i.acc = k.acc6
                              AND i.ID = 0
                              AND i.acra = a.acc
                              AND i.acrb = b.acc;
                        EXCEPTION
                           WHEN NO_DATA_FOUND
                           THEN
                              nls_2067_ := NULL;
                        END;
                  END;

                  -- % ставка
                  BEGIN
                     SELECT i.ir, n.tt, n.basey
                       INTO ir_, tt_, basey_
                       FROM int_ratn i, int_accn n
                      WHERE i.acc = k.acc8
                        AND i.ID = 0
                        AND i.acc = n.acc
                        AND i.ID = n.ID
                        AND bdat =
                               (SELECT MAX (bdat)
                                  FROM int_ratn i
                                 WHERE acc = k.acc8
                                   AND ID = 0
                                   AND bdat <= gl.bdate);
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                        BEGIN
                           SELECT ir, n.tt, n.basey
                             INTO ir_, tt_, basey_
                             FROM int_ratn i, int_accn n
                            WHERE i.acc = k.acc6
                              AND i.ID = 0
                              AND i.acc = n.acc
                              AND i.ID = n.ID
                              AND bdat =
                                     (SELECT MAX (bdat)
                                        FROM int_ratn
                                       WHERE acc = k.acc6
                                         AND ID = 0
                                         AND bdat <= gl.bdate);
                        EXCEPTION
                           WHEN NO_DATA_FOUND
                           THEN
                              ir_ := 0;
                        END;

                        BEGIN
                           SELECT vob
                             INTO vob_
                             FROM tts_vob
                            WHERE tt = tt_ AND ROWNUM = 1;
                        EXCEPTION
                           WHEN NO_DATA_FOUND
                           THEN
                              vob_ := 6;
                        END;
                  END;

                  -- начислить проценты
                  IF basey_ = 0
                  THEN
                     nday_ :=
                          TO_DATE ('01/01/'
                                   || (TO_CHAR (gl.bdate, 'YYYY') + 1),
                                   'dd/mm/yyyy'
                                  )
                        - TO_DATE ('01/01/' || TO_CHAR (gl.bdate, 'YYYY'),
                                   'dd/mm/yyyy'
                                  );
                  ELSIF basey_ = 1
                  THEN
                     nday_ := 365;
                  ELSIF basey_ = 2
                  THEN
                     nday_ := 360;
                  ELSIF basey_ = 3
                  THEN
                     nday_ := 360;
                  END IF;

                  s_ := ROUND (k.s * ir_ / (100 * nday_), 0);

                  IF s_ > 0 AND ir_ > 0 AND nls_2067_ IS NOT NULL
                  THEN
                     gl.REF (ref_);
                     dtxt_ :=
                           ' пр.ст. '
                        || TO_CHAR (ir_)
                        || ' Угода № '
                        || RTRIM (k.ndoc)
                        || ' вiд '
                        || TO_CHAR (k.datd, 'dd.mm.yyyy');

                     naz_ :=
                        SUBSTR (   'Комic.за ООД: '
                                || dtxt_
                                || ' '
                                || k.nmk
                                || ' на суму:'
                                || TO_CHAR (k.s, '99999999999,99'),
                                1,
                                160
                               );

                     gl.in_doc3 (ref_,
                                 tt_,
                                 vob_,
                                 ref_,
                                 SYSDATE,
                                 gl.bdate,
                                 1,
                                 k.kv,
                                 s_,
                                 980,
                                 p_icurval (k.kv, s_, gl.bdate),
                                 NULL,
                                 gl.bdate,
                                 gl.bdate,
                                 nms_2067_,
                                 nls_2067_,
                                 mfo5_,
                                 nms_,
                                 nls_,
                                 mfo5_,
                                 naz_,
                                 NULL,
                                 k.okpo,
                                 okpo_,
                                 NULL,
                                 NULL,
                                 NULL,
                                 NULL,
                                 NULL
                                );
                     gl.payv (ovr.getpo (tt_),
                              ref_,
                              gl.bdate,
                              tt_,
                              1,
                              k.kv,
                              nls_2067_,
                              s_,
                              980,
                              nls_,
                              p_icurval (k.kv, s_, gl.bdate)
                             );

                     UPDATE opldok
                        SET txt = SUBSTR (naz_, 1, 70)
                      WHERE REF = ref_ AND stmt = gl.astmt;

                     UPDATE saldoa
                        SET trcn = 0
                      WHERE fdat = gl.bdate AND acc = k.acc8;
                  END IF;
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     ROLLBACK TO do_provodki_61;

                     BEGIN
                        INSERT INTO tmp_ovr
                                    (dat, ID, dk, nlsa, nlsb, s,
                                     txt
                                    )
                             VALUES (gl.bdate, 61, 1, nls_2067_, nls_, s_,
                                     'Комiсiя за овр.ОДНОГО дня'
                                    );

                        GOTO kin_61;
                     END;
               END;

               <<kin_61>>
               NULL;
            END LOOP;

            RETURN;
---------------------------------------------------------------------------
         ELSIF nmode_ = 62
         THEN
            --OVR-F6: Комiсiя за овердрафт ОДНОГО дня
            FOR k IN (SELECT o.acc acc6,
                             ABS (c.SUM)+LEAST (s6.ostf - s6.dos + s6.kos, 0) S,
                             o.acc_8000 acc8, o.ndoc, o.datd, cu.okpo,
                             cu.nmk, a.kv, 
                             a.OSTC,           --  Исход.остаток
                             s6.OSTF           --  Вход.остаток
                        FROM acc_over_comis c,
                             acc_over o,
                             saldoa s6,
                             cust_acc u,
                             customer cu,
                             accounts a
                       WHERE o.acc = c.acc
                         AND o.acc = s6.acc
                         AND c.fdat = gl.bdate
                         AND s6.fdat = gl.bdate
                         AND u.acc = o.acc
                         AND u.rnk = cu.rnk
                         AND a.acc = o.acc
                         AND NVL (o.sos, 0) != 1
                         AND c.worked = 0)
            LOOP
               SAVEPOINT do_provodki_62;


               BEGIN
               -- Находим счета ACRA, ACRB из Проц.Карточки счета 8000
                  BEGIN
                     SELECT a.nls, SUBSTR (a.nms, 1, 38), b.nls,
                            SUBSTR (b.nms, 1, 38)
                       INTO nls_2607_, nms_2607_, nls_,
                            nms_
                       FROM int_accn i, accounts a, accounts b
                       WHERE i.acc = k.acc8
                        AND i.ID = 0
                        AND i.acra = a.acc
                        AND i.acrb = b.acc;

                  EXCEPTION WHEN NO_DATA_FOUND THEN
                        nls_2607_ := NULL;
                  END;


                  -- % определяем:  ir_, tt_, basey_
                  BEGIN

                     SELECT i.ir, n.tt, n.basey
                     INTO   ir_, tt_, basey_
                     FROM   int_ratn i, int_accn n
                     WHERE  i.acc = k.acc8
                        AND i.ID = 0
                        AND i.acc = n.acc
                        AND i.ID = n.ID
                        AND bdat =
                               (SELECT MAX (bdat)
                                  FROM int_ratn i
                                 WHERE acc = k.acc8
                                   AND ID = 0
                                   AND bdat <= gl.bdate);


                     vob_ := 6;
                     

               --      IF basey_ = 0
               --      THEN
               --
               --         nday_ :=
               --              TO_DATE ('01/01/'
               --                       || (TO_CHAR (gl.bdate, 'YYYY') + 1),
               --                       'dd/mm/yyyy'
               --                     )
               --            - TO_DATE ('01/01/' || TO_CHAR (gl.bdate, 'YYYY'),
               --                       'dd/mm/yyyy'
               --                      );
               --
               --      ELSIF basey_ = 1
               --      THEN

                          nday_ := 365;

               --      ELSIF basey_ = 2
               --      THEN
               --         nday_ := 360;
               --      ELSIF basey_ = 3
               --      THEN
               --         nday_ := 360;
               --      END IF;
               
                  EXCEPTION WHEN NO_DATA_FOUND THEN
                       ir_ := 0;
                  END;


                  IF  ir_ > 0  and  nls_2607_ is not NULL  THEN

                    s_ := ROUND (k.s * ir_ / (100 * nday_), 0);


                    If k.OSTC>=0  then    --      Для "ОЩАДБАНКА" !          
                                          --  Комисия за ООД берется только  
                                          --  тогда, когда счет закончил день 
                                          --  НЕ в овер-те (k.OSTC>=0)
                       gl.REF (ref_);

                       dtxt_ :=
                             TO_CHAR (ir_/nday_,'0D99')
                          || '% вiд макс.досягнутого овердрафту '
                          || TRIM(TO_CHAR (k.s/100, '99999999D99'))
                          || '. Угода № '
                          || RTRIM (k.ndoc);
                       
                       naz_ :=
                          SUBSTR ( 'Комiciя за ООД: '
                                   || TRIM(dtxt_)
                                   || '. '
                                   || k.nmk,
                                    1,
                                    160
                                 );
                       
                       gl.in_doc3 (ref_,
                                   tt_,
                                   vob_,
                                   ref_,
                                   SYSDATE,
                                   gl.bdate,
                                   1,
                                   k.kv,
                                   s_,
                                   980,
                                   p_icurval (k.kv, s_, gl.bdate),
                                   NULL,
                                   gl.bdate,
                                   gl.bdate,
                                   nms_2607_,
                                   nls_2607_,
                                   mfo5_,
                                   nms_,
                                   nls_,
                                   mfo5_,
                                   naz_,
                                   NULL,
                                   k.okpo,
                                   okpo_,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL
                                  );
                       gl.payv (ovr.getpo (tt_),
                                ref_,
                                gl.bdate,
                                tt_,
                                1,
                                k.kv,
                                nls_2607_,
                                s_,
                                980,
                                nls_,
                                p_icurval (k.kv, s_, gl.bdate)
                               );
                       
                       UPDATE opldok
                          SET txt = SUBSTR (naz_, 1, 70)
                       WHERE REF = ref_ AND stmt = gl.astmt;

                    End If;              --<-*** 

                    UPDATE acc_over_comis  SET worked = 1
                           WHERE fdat = gl.bdate AND acc = k.acc6;

                  END IF;
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     ROLLBACK TO do_provodki_62;

                     BEGIN
                        INSERT INTO tmp_ovr
                                    (dat, ID, dk, nlsa, nlsb, s,
                                     txt
                                    )
                             VALUES (gl.bdate, 62, 1, nls_2607_, nls_, s_,
                                     'Комiсiя за овр.ОДНОГО дня'
                                    );

                        GOTO kin_62;
                     END;
               END;

               <<kin_62>>
               NULL;
            END LOOP;

            RETURN;
-----------------------------------------------------------------------------
         ELSIF nmode_ = 1
         THEN
            -- 1.OVR-F4: Стягнення % в останнiй день (D-2600,K-2607) с реального остатка, без учета лимита
            FOR k IN (SELECT a.nls, a.kv, LEAST (a.ostc, -p.ostc) s,
                             LEAST (a.ostc + a.lim, -p.ostc) s2, a.ostc s3,
                             SUBSTR (a.nms, 1, 38) nms, a.acc, p.nls nlsp,
                             SUBSTR (p.nms, 1, 38) nmsp, c.okpo, o.ndoc,
                             o.datd, NVL (o.sos, 0) sos,
                             NVL (o.uselim, 0) uselim, a8.nls nls8000
                        FROM acc_over o,
                             accounts a,
                             accounts p,
                             int_accn i,
                             customer c,
                             cust_acc ca,
                             accounts a8
                       WHERE (acc_2000 = 0 OR acc_2000 = i.acc)
                         AND o.acc = i.acc
                         AND i.acra = p.acc
                         AND o.acc = a.acc
                         AND o.acc_8000 = a8.acc
                         AND MOD (i.ID, 2) = 0
                         AND MOD (NVL (o.flag, 0), 2) = 0
                         AND ca.rnk = c.rnk
                         AND ca.acc = p.acc
                         AND a.nbs = ovr.f_nbs (o.acc, 2600)
                         AND p.ostc < 0
                         AND a.mdate <= gl.bdate
                         AND o.tipo <> 200)
            LOOP
               SAVEPOINT do_provodki_1;

               BEGIN
                  gl.REF (ref_);

                  IF k.sos = 1
                  THEN
                     naz_ :=
                        'Погашення нарах. % на суму просроченого овердрафта ';
                  ELSE
                     naz_ :=
                        'Погашення нарах. % на суму овердрафта по датi закiнчення ';
                  END IF;

                  dtxt_ :=
                        'Угода '
                     || RTRIM (k.ndoc)
                     || ' вiд '
                     || TO_CHAR (k.datd, 'dd.mm.yyyy');

                  IF k.uselim = 1
                  THEN
                     ts_ := k.s2;

                     -- опр необх оборот по 8000 на сумму исп лимита
                     IF k.s3 < ts_
                     THEN
                        ts2_ := ts_;

                        IF k.s3 > 0
                        THEN
                           ts2_ := ts2_ - k.s3;
                        END IF;
                     END IF;
                  ELSE
                     ts_ := k.s;
                  END IF;

                  IF ts_ > 0
                  THEN
                     gl.in_doc3 (ref_,
                                 'OVR',
                                 6,
                                 ref_,
                                 SYSDATE,
                                 gl.bdate,
                                 1,
                                 k.kv,
                                 ts_,
                                 k.kv,
                                 ts_,
                                 NULL,
                                 gl.bdate,
                                 gl.bdate,
                                 k.nms,
                                 k.nls,
                                 mfo5_,
                                 k.nmsp,
                                 k.nlsp,
                                 mfo5_,
                                 naz_ || dtxt_,
                                 NULL,
                                 k.okpo,
                                 k.okpo,
                                 NULL,
                                 NULL,
                                 NULL,
                                 NULL,
                                 NULL
                                );
                     paytt (ovr.getpo ('OVR'),
                            ref_,
                            gl.bdate,
                            'OVR',
                            1,
                            k.kv,
                            k.nls,
                            ts_,
                            k.kv,
                            k.nlsp,
                            ts_
                           );

                     --if nvl(ts2_,0) <> 0 then
                     --  GL.PAYV(1, REF_, GL.BDATE, 'OVR', 1, K.KV, K.NLS8000, ts2_, K.KV, K.NLS8000, ts2_ );
                     --end if;

                     --- обнулить лимит овердрафта
                     IF flagrlim_ = 0
                     THEN
                        UPDATE accounts
                           SET lim = 0
                         WHERE acc = k.acc;
                     END IF;
                  END IF;
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     ROLLBACK TO do_provodki_1;

                     BEGIN
                        INSERT INTO tmp_ovr
                                    (dat, ID, dk, nlsa, nlsb, s,
                                     txt
                                    )
                             VALUES (gl.bdate, 1, 1, k.nls, k.nlsp, k.s,
                                     'Стягнення % в останнiй день'
                                    );

                        GOTO kin_1;
                     END;
               END;

               <<kin_1>>
               NULL;
            END LOOP;

            RETURN;
------------------------------------------------------------------------------

--- 91.        Невикористаний овердрафт (9129-9900) 
---         +  Запись в ND_ACC 

         ELSIF nmode_ = 91  THEN



            FOR k IN (SELECT acc, acc_2067, acc_9129, acc_8000,
                             acc_3600, ND
                        FROM acc_over 
                       WHERE 
                             nvl(sos,0) <> 1
                         AND acc = acco
                         AND tipo <> 200
                     )
            LOOP

               
               Begin                                    

                  INSERT into ND_ACC (ACC,   ND  )      --- 1). 2600
                      values         (k.acc, k.ND); 

               Exception when OTHERS then
                  null;
               End;


               Begin                                    

                  SELECT ACRA                           --- 2). 2607
                  INTO   acc_2607_
                  FROM   Int_Accn
                  WHERE  ACC = k.acc   
                     and ID  = 0 ;
               
                  INSERT into ND_ACC (ACC,      ND  ) 
                        values       (acc_2607_,k.ND); 
               
               Exception when OTHERS then
                  null;
               End;
               
               
               If nvl(k.acc_2067,0) > 0 then            --- 3). 2067
               
                  Begin                                 --- 4). 2069
 
                     INSERT into ND_ACC (ACC,       ND  )   
                        values          (k.acc_2067,k.ND); 

                  Exception when OTHERS then
                     null;
                  End;

                  Begin

                     SELECT ACRA              
                     INTO   acc_2069_
                     FROM   Int_Accn
                     WHERE  ACC = k.acc_2067   
                        and ID  = 0 ;
                  
                     INSERT into ND_ACC (ACC,      ND  ) 
                           values       (acc_2069_,k.ND); 
                  
                  Exception when OTHERS then
                     null;
                  End;
               

                  Begin                                 --- 5). 8008

                     SELECT ACRA              
                     INTO   acc_8008_
                     FROM   Int_Accn
                     WHERE  ACC = k.acc_2067   
                        and ID  = 2 ;
                  
                     INSERT into ND_ACC (ACC,      ND  ) 
                           values       (acc_8008_,k.ND); 
                  
                  Exception when OTHERS then
                     null;
                  End;
               
               End if;
               
               
               if nvl(k.acc_9129,0) > 0 then              --- 6). 9129
                  Begin
                      INSERT into ND_ACC (ACC,       ND  )   
                            values       (k.acc_9129,k.ND); 
                  Exception when OTHERS then
                     null;
                  End;
               end if;
               
               
               if nvl(k.acc_3600,0)>0 then                --- 7). 3600
                  Begin
                      INSERT into ND_ACC (ACC,       ND  )   
                            values       (k.acc_3600,k.ND); 
                  Exception when OTHERS then
                     null;
                  End;
               end if;


               If nvl(k.acc_8000,0) > 0 then              
               
                  Begin                                 ---  8). 3578
           
                     SELECT ACRA              
                     INTO   acc_3578_
                     FROM   Int_Accn
                     WHERE  ACC = k.acc_8000   
                        and ID  = 0 ;
                  
                     INSERT into ND_ACC (ACC,      ND  ) 
                           values       (acc_3578_,k.ND); 
                  
                  Exception when OTHERS then
                     null;
                  End;
               
               End if;

               Begin                                    --- 9). 3579
                  Select ACC into acc_3579_   From   Accounts           Where  NBS = SB_3579.R020  and NMS like 'Просроч%комiс%за%овердрафт%' and RNK in (Select RNK from Accounts where ACC=k.acc); 
                  INSERT into ND_ACC (ACC,      ND  )   values       (acc_3579_,k.ND); 
               Exception when OTHERS then     null;
               End;

            END LOOP;

----------------------------------------------------

            -- 91.OVR-F5: Невикористаний овердрафт    (DK-9129)

            FOR k IN (SELECT cu.rnk, a.isp, a.grp, a.sec,
                             SUBSTR (a.nms, 1, 38) nms, a.nls, a.tobo,
                             LEAST (- (  LEAST (fost (a.acc, gl.bdate), 0)
                                       + a.lim
                                      ),
                                    0
                                   ) s,
                             a.kv, a.acc, o.acc_9129, o.ndoc, o.datd
                        FROM accounts a, cust_acc cu, acc_over o
                       WHERE a.acc = cu.acc
                         AND o.flag IN (0, 1, 4, 5)
                         AND a.acc = o.acc
                         AND NVL (o.sos, 0) <> 1
                         AND o.acc = o.acco
                         AND a.nbs = ovr.f_nbs (o.acc, 2600)
                         AND o.tipo <> 200
                         AND o.datd <= gl.bdate)
            LOOP
               SAVEPOINT do_provodki_91;

----111-------------------------------------------------

       --   Kонтрсчет 9900 (nls9_)для проводки берем из карточки опер. OV-
       --
       --      BEGIN
       --         SELECT NLSK, NAME  INTO nls9_, naz_
       --         FROM tts
       --         WHERE tt=tt9_;
       --      EXCEPTION
       --         WHEN NO_DATA_FOUND THEN
       --         nls9_:='9900000000';
       --      END;
       --      nls9_:=TRIM(nls9_);   --- 9900 "общевойсковой" из оп."OV-"


       --   Ищем 9900:  - как параметр TAG='OVR_9900'
       --               - как параметр TAG='NLS_9900'
       --               - счет 9900/00 на BRANCH-е

               Begin  Select VAL  into  nls9_    From   BRANCH_PARAMETERS     where  TAG='OVR_9900' and BRANCH=k.tobo;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  Begin  Select VAL  into  nls9_  From   BRANCH_PARAMETERS      where  TAG='NLS_9900' and BRANCH=k.tobo;
                  EXCEPTION WHEN NO_DATA_FOUND THEN     nls9_:=NBS_OB22_NULL('9900','00', k.tobo);
                  END;
               END;


               BEGIN  SELECT ovr.f_nbs (k.acc, 9129), acc,  SUBSTR (nms, 1, 38)   INTO b9129_, acc9_, nms9_      FROM Accounts       WHERE NLS=nls9_  and  KV=k.kv;
               EXCEPTION   WHEN NO_DATA_FOUND             THEN      erm := '8012 - No defined # ' || nls9_;            RAISE err;
               END;
----------------------

               BEGIN
                  -- k.S = должно быть
                  -- S_  = есть по факту
                  BEGIN
                     SELECT acc, nls, SUBSTR (nms, 1, 38),
                            fost (acc, gl.bdate)
                       INTO acc_, nls_, nms_,
                            s_
                       FROM accounts
                      WHERE nbs = b9129_ AND kv = k.kv AND acc = k.acc_9129;
                  EXCEPTION    WHEN NO_DATA_FOUND        THEN
                      nls_ := f_newnls (k.nls, 'OV9', '');
                      nls_ := vkrzn (SUBSTR (gl.amfo, 1, 5),  b9129_ || '0' || SUBSTR (NVL (nls_, k.nls), 6, 9)    );
                      txt_ := 'Открытие ' || nls_;
                      op_reg_ex (99, 0, 0, k.grp, ret1_, k.rnk, nls_, k.kv, k.nms, 'ODB', k.isp, acc_, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, k.tobo, NULL);
                      UPDATE accounts  SET sec = k.sec      WHERE acc = acc_ ;
                      if a_grp_ > 0 then   SEC.addAgrp(acc_, a_grp_); end if ;
                      s_ := 0;
                  END;

                  txt_ := '9129-Наследование обеспечения';
                  INSERT INTO cc_accp (accs,acc,nd)  SELECT acc_, c.acc, c.nd  FROM cc_accp c, pawn_acc p  WHERE accs = k.acc  AND c.acc = p.acc AND (acc_, c.acc) NOT IN (SELECT accs, acc FROM cc_accp);

                  naz_ :=
                        'Врегулювання невикористаного овердрафту по рах. '||k.NLS||' '||k.NMS;
                --        naz_
                --     || 'дог.ов.№'
                --     || RTRIM (k.ndoc)
                --     || ' вiд '
                --     || TO_CHAR (k.datd, 'dd.mm.yyyy');
                --  DBMS_OUTPUT.put_line (   'KS='
                --                        || TO_CHAR (k.s)
                --                        || 'S='
                --                        || TO_CHAR (s_)
                --                        || ',nls='
                --                        || nls_
                --                       );
                  s_ := k.s - s_;

                  IF s_ <> 0      THEN           txt_ := 'Урегулирование 9129';
                     IF s_ < 0    THEN           dk_ := 0;        s_ := 0 - s_;
                     ELSE                        dk_ := 1;
                     END IF;

                     BEGIN     SELECT vob    INTO       vob_     FROM tts_vob       WHERE tt = tt9_ AND ROWNUM = 1;
                     EXCEPTION WHEN NO_DATA_FOUND  THEN vob_ := 89;
                     END;

                     gl.REF (ref_);
                     gl.in_doc3 (ref_,
                                 tt9_,
                                 vob_,
                                 ref_,
                                 SYSDATE,
                                 gl.bdate,
                                 1 - dk_,
                                 k.kv,
                                 s_,
                                 k.kv,
                                 s_,
                                 NULL,
                                 gl.bdate,
                                 gl.bdate,
                                 nms_,
                                 nls_,
                                 gl.amfo,
                                 nms9_,
                                 nls9_,
                                 gl.amfo,
                                 naz_,
                                 NULL,
                                 okpo_,
                                 okpo_,
                                 NULL,
                                 NULL,
                                 NULL,
                                 NULL,
                                 NULL
                                );
                     gl.payv (ovr.getpo (tt9_),
                              ref_,
                              gl.bdate,
                              tt9_,
                              1 - dk_,
                              k.kv,
                              nls_,
                              s_,
                              k.kv,
                              nls9_,
                              s_
                             );
                  END IF;
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     ROLLBACK TO do_provodki_91;

                     BEGIN
                        INSERT INTO tmp_ovr
                                    (dat, ID, dk, nlsa, nlsb, s, txt
                                    )
                             VALUES (gl.bdate, 91, dk_, nls_, nls9_, s_, txt_
                                    );

                        GOTO kin_91;
                     END;
               END;

               <<kin_91>>
               NULL;
            END LOOP;

            RETURN;

---------------------------------------------------------------------------

         ELSIF nmode_ = 72 
         THEN

            FOR k IN (SELECT a.acc, o.PR_9129, o.PR_2069 
                        FROM Accounts a, Acc_Over o
                       WHERE o.ACC = a.ACC
                         and a.OSTC < 0
                         and o.PR_9129 > 20110000
                         and nvl(o.SOS,0) = 0
                         and nvl(o.KRL,0) = 1
                     )
            LOOP

               If to_date(to_char(k.PR_9129),'yyyymmdd') < gl.bdate and  
                  k.PR_2069=1  then
                  -----------

                  -- Превышена дата PR_9129:  Блокируем лимит ов-та 
                  -- (TIP='BLD' ) и сбрасываем флаг  PR_2069 в 0.
                  --
                  -- Если лимит разблокируют (уберут птичку: BLD->ODB),
                  -- то при отработке этой программы при следующем 
                  -- Открытии Дня, она блокировать лимит уже НЕ будет !  
                  -- Т.е. nmode_ = 72 блокирует лимит по одной дате  
                  -- только 1 раз !
            

                  Update ACCOUNTS set TIP='BLD' where ACC=k.ACC;

                  Update ACC_OVER set PR_2069=0 where ACC=k.ACC;

               End If;


            END LOOP;

            RETURN;

--------------------------------------------------------------------------------

         ELSIF nmode_ = 2 OR nmode_ = 22
         THEN
            --2.OVR-S3: Перенос на просрочку        (D-2067,K-2600,D-2069,K2607)

            -- перенос на просрочку задолженности по овердрафту
            nbs3_ := SB_3579.R020 ;         -- для комиссии за однодневный овердрафт
            naz_ := 'Перенесення заборгованностi овердрафта на просрочену';

            FOR k IN (SELECT a.nls, a.kv, SUBSTR (a.nms, 1, 38) nms, a.acc,
                             -a.ostc ost, a.grp, a.sec, a.seco, a.seci,
                             a.isp, a.mdate, NVL (a.lim, 0) lim, a.tobo,
                             c.okpo, c.rnk, o.ndoc, o.datd, c.nmk,
                             o.acc_9129, o.acc_2067, o.acc_8000, o.nd
                        FROM accounts a, acc_over o, cust_acc u, customer c
                       WHERE o.acc = a.acc
                         AND u.acc = a.acc
                         AND c.rnk = u.rnk
                         AND a.ostc < 0
                         AND gl.bdate >= pay_date(a.mdate)
                         AND NVL (o.sos, 0) <> 1
                         AND a.nbs = ovr.f_nbs (o.acc, 2600)
                         AND (acc_2000 = 0 OR acc_2000 = o.acc)
                         AND o.tipo <> 200)
            LOOP
               SAVEPOINT do_provodki_2;
               nbs_  := ovr.f_nbs (k.acc, 2067);  -- пока неясен другой способ
               nbs9_ := ovr.f_nbs (k.acc, 2069);         -- для нач процентов
               nbs3_ := SB_3579.R020;                     -- для комиссии

               --Обнуление 9129
               BEGIN
                  BEGIN   dtxt_ :=  'Угода № '  || RTRIM (k.ndoc)  || ' вiд '  || TO_CHAR (k.datd, 'dd.mm.yyyy');

                     BEGIN SELECT DAZS , substr(NMS,1,38)    INTO dazs_, nms_2067_  FROM accounts WHERE acc = k.ACC_2067;
                           SELECT i.ACRA   , substr(a.NMS,1,38)  INTO acc_2069_, nms_2069_  FROM int_accn i, accounts a  WHERE i.acc = k.ACC_2067  and i.ID=0  and i.ACRA=a.ACC;
                     EXCEPTION WHEN NO_DATA_FOUND THEN        dazs_ := NULL;
                     END;

                     IF NVL (k.ACC_2067, 0) = 0  or  DAZS_ is not NULL then ---  Нет 2067     ---  или он Закрыт
                                               
                        SELECT s080   INTO s080_     FROM specparam    WHERE acc = k.acc;
                        -----------------------------------------------------------------
                        nls_2067_ := nbs_  || '0'  || SUBSTR (NVL (f_newnls (k.acc, 'OV2067', ''),    k.nls ),   6,   9 ) ;
                        nls_2067_ := vkrzn (SUBSTR (mfo5_, 1, 5), nls_2067_ ) ;
                        nms_2067_ := SUBSTR ('Просроч.заборг.' || k.ndoc || ' за овердp.', 1,  38 );
                        ret1_     := 0;
                        txt_      := '1.Открытие ' || nls_2067_;
                        op_reg_ex (99, 0, 0, k.grp, ret1_, k.rnk, nls_2067_, k.kv, nms_2067_, 'SP ', k.isp, acc_2067_, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, k.tobo, NULL);
                        txt_      := '2.Обновление ' || nls_2067_;
                        UPDATE accounts  SET sec = k.sec,  blkd = 0,   mdate = k.mdate,   nms = nms_2067_,      dazs = NULL WHERE acc = acc_2067_ ;
                        Accreg.setAccountSParam(acc_2067_, 'S080', s080_ ) ;
                        if a_grp_ > 0 then      SEC.addAgrp(acc_2067_, a_grp_) ;  end if;
                        -----------------------------------------------------------------
                        nls_2069_ := nbs9_ || '0' || SUBSTR (NVL (f_newnls (k.acc, 'OV2069', ''), k.nls),  6,  9  ) ;
                        nls_2069_ := vkrzn (SUBSTR (mfo5_, 1, 5), nls_2069_);
                        nms_2069_ :=  SUBSTR('Просроч. % за дог.овердpафту № ' || k.ndoc,   1 , 70 );
                        ret1_ := 0;
                        txt_      := '3.Открытие ' || nls_2069_;
                        op_reg_ex (99, 0, 0, k.grp, ret1_, k.rnk, nls_2069_, k.kv, nms_2069_, 'SPN', k.isp, acc_2069_, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, k.tobo, NULL);
                        txt_      := '4.Обновление ' || nls_2069_;
                        UPDATE accounts  SET sec = k.sec, blkd = 0, mdate = k.mdate, nms = nms_2069_, dazs = NULL WHERE acc = acc_2069_ ;
                        if a_grp_ > 0 then   SEC.addAgrp( acc_2069_, a_grp_);  end if ;
                        -----------------------------------------------------------------


                        IF ovr.ovr_par_val ('DO_3578') = 'TRUE' THEN

                           nls_3579_ := nbs3_ || '0' || SUBSTR (NVL (f_newnls (k.acc, 'OV3579', ''),  k.nls ),  6,  9 );
                           nls_3579_ := vkrzn (SUBSTR (mfo5_, 1, 5), nls_3579_);
                           nms_3579_ := SUBSTR ('Просроч.комiс.за дог.овердрафту № ' || trim(k.ndoc),1,70  );
                           ret1_ := 0;
                           txt_ := '5.Открытие ' || nls_3579_;
                           op_reg (99,0,0, k.grp, ret1_, k.rnk, nls_3579_, k.kv, nms_3579_, ( CASE WHEN newnbs.g_state = 1 then 'OFR' else 'ODB' end ), k.isp, acc_3579_ ) ;
                           txt_ := '6.Обновление ' || nls_3579_;
                           UPDATE accounts    SET sec = k.sec, blkd = 0, mdate = k.mdate, nms = nms_3579_, dazs = NULL,TOBO=k.tobo  WHERE acc = acc_3579_;
                           if a_grp_ > 0 then    SEC.addAgrp(acc_3579_, a_grp_);          end if;
                           BEGIN  INSERT INTO nd_acc  (nd, acc   )  VALUES (k.nd, acc_3579_        );
                           EXCEPTION WHEN OTHERS THEN     NULL;
                           END;
                           Accreg.setAccountSParam(acc_3579_, 'OB22', SB_3579.ob22 ) ;
                        END IF;


                        IF ovr.ovr_par_val ('DO_PEN') = 'TRUE'  THEN

                           nls_8008_ :=
                                 '80080'
                              || SUBSTR (NVL (f_newnls (k.acc, 'SN8', ''),
                                              k.nls
                                             ),
                                         6,
                                         9
                                        );
                           nls_8008_ :=
                                       vkrzn (SUBSTR (mfo5_, 1, 5), nls_8008_);
                           nms_8008_ :=
                              SUBSTR ('Пеня за просрочку овердрафта '
                                      || k.ndoc,
                                      1,
                                      38
                                     );
                           ret1_ := 0;
                           txt_ := '7.Открытие ' || nls_8008_;
                           op_reg (99,
                                   0,
                                   0,
                                   k.grp,
                                   ret1_,
                                   k.rnk,
                                   nls_8008_,
                                   k.kv,
                                   nms_8008_,
                                   'ODB',
                                   k.isp,
                                   acc_8008_
                                  );
                           txt_ := '8.Обновление ' || nls_8008_;

                           UPDATE accounts
                              SET sec = k.sec,
                                  blkd = 0,
                                  mdate = k.mdate,
                                  nms = nms_8008_,
                                  dazs = NULL,
                                  TOBO=k.tobo
                            WHERE acc = acc_8008_;

                           if a_grp_ > 0 then
                              SEC.addAgrp(acc_8008_, a_grp_);
                           end if;


                           BEGIN
                              INSERT INTO nd_acc
                                          (nd, acc
                                          )
                                   VALUES (k.nd, acc_8008_
                                          );
                           EXCEPTION  WHEN OTHERS  THEN
                                NULL;
                           END;

                           BEGIN
                              INSERT INTO int_accn
                                          (acc, ID, metr, basem, basey,
                                           freq, acra,
                                           acrb,
                                           tt
                                          )
                                   VALUES (acc_2067_, 2, 0, 0, 0,
                                           1, acc_8008_,
                                           TO_NUMBER
                                                   (ovr.ovr_par_val ('PEN_ACC')
                                                   ),
                                           '%%1'
                                          );
                           EXCEPTION  WHEN OTHERS  THEN
                                 UPDATE int_accn
                                    SET metr = 0,
                                        basem = 0,
                                        basey = 0,
                                        freq = 1,
                                        acra = acc_8008_,
                                        acrb =
                                           TO_NUMBER
                                                   (ovr.ovr_par_val ('PEN_ACC')
                                                   ),
                                        tt = '%%1'
                                  WHERE acc = acc_2067_ AND ID = 2;
                           END;

                           BEGIN
                              INSERT INTO int_ratn
                                          (acc, ID, bdat,
                                           ir
                                          )
                                   VALUES (acc_2067_, 2, gl.bdate,
                                           TO_NUMBER
                                                    (ovr.ovr_par_val ('PEN_PR')
                                                    )
                                          );
                           EXCEPTION  WHEN OTHERS THEN
                                 UPDATE int_ratn
                                    SET ir =
                                           TO_NUMBER
                                                    (ovr.ovr_par_val ('PEN_PR')
                                                    )
                                  WHERE acc = acc_2067_
                                    AND ID = 2
                                    AND bdat = gl.bdate;
                           END;
                        END IF;

                                                 
                        BEGIN              
                           SELECT acc      --  Есть ли ПК 2067/ID=0 ?
                             INTO ret1_
                             FROM int_accn
                            WHERE acc = acc_2067_ AND ID = 0;

                           UPDATE int_accn
                              SET acra = acc_2069_
                            WHERE acc = acc_2067_ AND ID = 0;
                        EXCEPTION  WHEN NO_DATA_FOUND  THEN
                              BEGIN
                                 ---- Находим счет доходов для нового БС NBS_
                                 SELECT a.acc
                                   INTO acc67_
                                   FROM accounts a, proc_dr p
                                  WHERE a.kv = k.kv
                                    AND p.nbs = nbs_
                                    AND p.sour = 4
                                    AND p.rezid = 0
                                    AND p.g67 = a.nls;
                              EXCEPTION  WHEN NO_DATA_FOUND  THEN
                                 acc67_ := NULL;
                              END;

                              txt_ := '9.Создание % карты ' || nls_2067_;

                              INSERT INTO int_accn
                                          (acc, ID,    METR, basem, basey, freq,
                                           tt, acra, acrb)
                                 SELECT acc_2067_, 0,  0,    basem, basey,
                                        freq, tt, acc_2069_,
                                        NVL (acc67_, acrb)
                                   FROM int_accn
                                  WHERE acc = k.acc AND ID = 0;
                        END;

                     ELSE        ---  Счет 2067 уже есть:

                        SELECT nls, acc
                          INTO nls_2067_, acc_2067_
                          FROM accounts
                         WHERE acc = k.acc_2067;

                        SELECT a.nls, a.acc         -- Определяем 2069
                          INTO nls_2069_, acc_2069_
                          FROM accounts a, int_accn i
                         WHERE i.acc = k.acc_2067
                           AND i.acra = a.acc
                           AND i.ID = 0;

                     END IF;

                     ------проставить/добавить историю % ставки
                     txt_ := '10.Внесение % ставки ' || nls_2067_;

                     BEGIN
                        SELECT acc
                          INTO acc_2067_
                          FROM int_ratn
                         WHERE acc = acc_2067_
                           AND ID = 0
                           AND bdat = gl.bdate;
                     EXCEPTION WHEN NO_DATA_FOUND THEN

                           INSERT INTO int_ratn
                                       (acc, ID, bdat, ir, br, op)
                              SELECT acc_2067_, 0, gl.bdate, ir, br,
                                     op
                                FROM int_ratn n
                               WHERE n.acc = k.acc
                                 AND n.ID = 0
                                 AND n.bdat =
                                        (SELECT MAX (bdat)
                                           FROM int_ratn
                                          WHERE bdat <= gl.bdate
                                            AND acc = k.acc
                                            AND ID = 0);
                     END;

                     BEGIN
                        SELECT acc     ---  Строка по просрочки ЕСТЬ!
                          INTO s_
                          FROM acc_over
                         WHERE ACC = k.acc AND ACCO = acc_2067_
                               AND tipo <> 200;

                     EXCEPTION WHEN NO_DATA_FOUND THEN -- Строки по проср.НЕТ!
                        
                           ---поместить в портфель овердрафта
                           txt_ := '11.Помещение в овр' || nls_2067_;

                           INSERT INTO acc_over
                                       (acc, acco, tipo, flag, nd, DAY, sos,
                                        sd, ndoc)
                              SELECT ao.acc, acc_2067_, ao.tipo, ao.flag,
                                     ao.nd, ao.DAY, 1, ao.sd, ao.ndoc
                                FROM acc_over ao
                               WHERE acco = k.acc
                                 AND NVL (ao.sos, 0) = 0
                                 AND ao.tipo <> 200
                                 AND ao.acc NOT IN (
                                        SELECT ao2.acc
                                          FROM acc_over ao2
                                         WHERE ao2.acc = k.acc
                                           AND NVL (ao2.sos, 0) = 1);

                           UPDATE acc_over
                              SET acc_2067 = acc_2067_
                            WHERE acc = k.acc;

                           UPDATE acc_over
                              SET acco = acc_2067_
                            WHERE acc = k.acc AND sos = 1;
                     END;

                     dtxt_ :=
                           'Угода '
                        || RTRIM (k.ndoc)
                        || ' вiд '
                        || TO_CHAR (k.datd, 'dd.mm.yyyy');
                     naz_ :=
                        SUBSTR (   'Перенес.нарах. %% за овердрафт на просроч. '
                                || dtxt_
                                || ' '
                                || k.nmk,
                                1,
                                160
                               );

                     --- Размазывание обеспечения
                     begin 
                       INSERT INTO cc_accp
                                 (acc, accs)
                        (SELECT acc, acc_2067_
                           FROM cc_accp
                          WHERE accs = k.acc
                            AND acc NOT IN (SELECT acc
                                             FROM cc_accp
                                             WHERE accs = acc_2067_));
                     EXCEPTION WHEN others THEN
                        null;
                     end;


                     ---  Перенос %%-ов   2607 -> 2069

                     BEGIN       
                            --  Находим остаток на 2607:
                        SELECT a.acc, a.nls, SUBSTR (a.nms, 1, 38), -a.ostc
                          INTO acc_2008_, nls_2008_, nms_2008_, ost_2008_
                          FROM accounts a, int_accn i
                         WHERE i.acra = a.acc
                           AND i.acc = k.acc
                           AND a.ostc < 0     
                       ---    AND MOD(i.ID, 2) = 0;
                           AND i.ID = 0;

                            -- Нашли акт. остаток на 2607:

                        IF NVL(sum_pr_, 0) <> 0  OR  NVL(sum_, 0) <> 0
                        THEN
                           ost_2008_ := ABS(sum_pr_);  -- перенос част.сумм
                        END IF;

                        gl.REF (ref_);
                    
                        gl.in_doc3 (ref_,
                                    'OVR',
                                    6,
                                    ref_,
                                    SYSDATE,
                                    gl.bdate,
                                    1,
                                    k.kv,
                                    ost_2008_,
                                    k.kv,
                                    ost_2008_,
                                    NULL,
                                    gl.bdate,
                                    gl.bdate,
                                    nms_2069_,
                                    nls_2069_,
                                    mfo5_,
                                    nms_2008_,
                                    nls_2008_,
                                    mfo5_,
                                    naz_,
                                    NULL,
                                    k.okpo,
                                    k.okpo,
                                    NULL,
                                    NULL,
                                    NULL,
                                    NULL,
                                    NULL
                                   );
                        gl.payv (ovr.getpo ('OVR'),
                                 ref_,
                                 gl.bdate,
                                 'OVR',
                                 1,
                                 k.kv,
                                 nls_2069_,
                                 ost_2008_,
                                 k.kv,
                                 nls_2008_,
                                 ost_2008_
                                );

                        UPDATE opldok
                           SET txt = SUBSTR (naz_, 1, 70)
                         WHERE REF = ref_ AND stmt = gl.astmt;
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           ost_2008_ := 0;
                     END;


                     --- Перенос  3578 -> 3579                          

                     IF ovr.ovr_par_val ('DO_3578') = 'TRUE'  THEN

                        dtxt_ :=
                              'Угода '
                           || RTRIM (k.ndoc)
                           || ' вiд '
                           || TO_CHAR (k.datd, 'dd.mm.yyyy');

                        naz_ :=
                           SUBSTR
                              (   'Перенес. ком. за овердр. на просроч. '
                               || dtxt_
                               || ' '
                               || k.nmk,
                               1,
                               160
                              );

                     -- Размазывание обеспечения
                        Begin
                          INSERT INTO cc_accp
                                    (acc, accs)
                           (SELECT acc, acc_3579_
                              FROM cc_accp
                             WHERE accs = k.acc
                               AND acc NOT IN (SELECT acc
                                                 FROM cc_accp
                                                WHERE accs = acc_3579_));
                        EXCEPTION WHEN others THEN
                           null;
                        end;


                        BEGIN

                           SELECT a.acc, a.nls, SUBSTR (a.nms, 1, 38),
                                  -a.ostc
                             INTO acc_3578_, nls_3578_, nms_3578_,
                                  ost_3578_
                             FROM accounts a, int_accn i
                            WHERE i.acra = a.acc
                              AND i.acc = k.acc_8000
                              AND a.ostc < 0
                              AND i.ID = 0;

                           gl.REF (ref_);
                  
                           gl.in_doc3 (ref_,
                                       'OVR',
                                       6,
                                       ref_,
                                       SYSDATE,
                                       gl.bdate,
                                       1,
                                       k.kv,
                                       ost_3578_,
                                       k.kv,
                                       ost_3578_,
                                       NULL,
                                       gl.bdate,
                                       gl.bdate,
                                       nms_3579_,
                                       nls_3579_,
                                       mfo5_,
                                       nms_3578_,
                                       nls_3578_,
                                       mfo5_,
                                       naz_,
                                       NULL,
                                       k.okpo,
                                       k.okpo,
                                       NULL,
                                       NULL,
                                       NULL,
                                       NULL,
                                       NULL
                                      );
                           gl.payv (ovr.getpo ('OVR'),
                                    ref_,
                                    gl.bdate,
                                    'OVR',
                                    1,
                                    k.kv,
                                    nls_3579_,
                                    ost_3578_,
                                    k.kv,
                                    nls_3578_,
                                    ost_3578_
                                   );

                           UPDATE opldok
                              SET txt = SUBSTR (naz_, 1, 70)
                            WHERE REF = ref_ AND stmt = gl.astmt;

                        EXCEPTION WHEN others  THEN
                              ost_3578_ := 0;
                        END;

                     END IF;  


                     --- Перенос тела  2600 -> 2067:

                     naz_ :=
                        SUBSTR (   'Перенес. заборг. овердр. на просроч. '
                                || dtxt_
                                || ' '
                                || k.nmk,
                                1,
                                160
                               );
                     gl.REF (ref_);

                     IF NVL (sum_pr_, 0) <> 0 OR NVL (sum_, 0) <> 0
                     THEN
                        k.ost := ABS (sum_);
                     END IF;

                 
                     gl.in_doc3 (ref_,
                                 'OVR',
                                 6,
                                 ref_,
                                 SYSDATE,
                                 gl.bdate,
                                 1,
                                 k.kv,
                                 k.ost,
                                 k.kv,
                                 k.ost,
                                 NULL,
                                 gl.bdate,
                                 gl.bdate,
                                 nms_2067_,
                                 nls_2067_,
                                 mfo5_,
                                 k.nms,
                                 k.nls,
                                 mfo5_,
                                 naz_,
                                 NULL,
                                 k.okpo,
                                 k.okpo,
                                 NULL,
                                 NULL,
                                 NULL,
                                 NULL,
                                 NULL
                                );
                     gl.payv (ovr.getpo ('OVR'),
                              ref_,
                              gl.bdate,
                              'OVR',
                              1,
                              k.kv,
                              nls_2067_,
                              k.ost,
                              k.kv,
                              k.nls,
                              k.ost
                             );

                     UPDATE opldok
                        SET txt = SUBSTR (naz_, 1, 70)
                      WHERE REF = ref_ AND stmt = gl.astmt;

                     
                     IF flagrlim_ = 0 THEN  --- Убираем лимит (LIM=0)
                        UPDATE accounts
                           SET lim = 0
                         WHERE acc = k.acc;
                     ELSE
                        --- Уменьшаем лимит на просроченую сумму (Петрокоммерц)
                        IF k.lim > k.ost
                        THEN
                           UPDATE accounts
                              SET lim = k.lim - ABS (k.ost)
                            WHERE acc = k.acc;
                        ELSE
                           UPDATE accounts
                              SET lim = 0
                            WHERE acc = k.acc;
                        END IF;
                     END IF;

                  --   Блокируем на Дебет счет 2067
                  --   UPDATE accounts
                  --      SET blkd = 1
                  --    WHERE acc = acc_2067_;

                     SELECT acc, nls, SUBSTR (nms, 1, 38),
                            LEAST (- (LEAST (fost (acc, gl.bdate), 0) + lim),
                                   0),
                            kv
                     INTO acc_, nls_, nms_,
                            s_,
                            kv_
                     FROM accounts
                     WHERE acc = k.acc_9129;

----222---
               -- Kонтрсчет 9900 для проводки берем из карточки операции  OV-
               --        BEGIN
               --            SELECT NLSK, NAME
               --            INTO   nls9_, naz_
               --            FROM   tts
               --            WHERE  tt=tt9_;
               --        EXCEPTION
               --            WHEN NO_DATA_FOUND
               --            THEN
               --               erm := '8012 - No defined # ' || tt9_;
               --               RAISE err;
               --        END;
               --        nls9_:=TRIM(nls9_);




       --   Ищем 9900:  - как параметр TAG='OVR_9900'
       --               - как параметр TAG='NLS_9900'
       --               - счет 9900/00 на 

                     Begin  Select VAL  into  nls9_   From   BRANCH_PARAMETERS       where  TAG='OVR_9900' and BRANCH=k.tobo;
                     EXCEPTION WHEN NO_DATA_FOUND THEN
                        Begin Select VAL  into  nls9_ From   BRANCH_PARAMETERS        where  TAG='NLS_9900' and BRANCH=k.tobo;
                        EXCEPTION WHEN NO_DATA_FOUND THEN         nls9_:=NBS_OB22_NULL('9900','00', k.tobo);
                        END;
                     END;


                     BEGIN   SELECT acc,  SUBSTR(nms,1,38)     INTO acc9_, nms9_     FROM Accounts     WHERE NLS=nls9_  and  KV=kv_;
                     EXCEPTION    WHEN NO_DATA_FOUND    THEN  erm := '8012 - No defined # ' || nls9_;     RAISE err;
                     END;

                  EXCEPTION WHEN NO_DATA_FOUND THEN    erm := '8012 - No defined # ' || tt9_;             RAISE err;
                  END;

                  naz_ :=
                        'Зменшення лiмiта по дог.оведр. №'
                     || k.ndoc
                     || ' вiд '
                     || TO_CHAR (k.datd, 'dd.mm.yyyy')
                     || ' у звязку iз прострочкою';

                  SELECT ostc
                    INTO s2_
                    FROM accounts
                   WHERE acc = k.acc ;   ------  !!! было   acc_200 = acc

                  s_ := s2_ - s_;

                  IF s_ <> 0  THEN

                     txt_ := 'Урегулирование 9129';

                     IF s_ < 0  THEN
                        dk_ := 1;
                        s_  := 0 - s_;
                     ELSE
                        dk_ := 0;
                     END IF;

                     gl.REF (ref_);

                     gl.in_doc3 (ref_,
                                 tt9_,
                                 6,
                                 ref_,
                                 SYSDATE,
                                 gl.bdate,
                                 dk_,
                                 kv_,
                                 s_,
                                 kv_,
                                 s_,
                                 NULL,
                                 gl.bdate,
                                 gl.bdate,
                                 nms_,
                                 nls_,
                                 gl.amfo,
                                 nms9_,
                                 nls9_,
                                 gl.amfo,
                                 naz_,
                                 NULL,
                                 okpo_,
                                 okpo_,
                                 NULL,
                                 NULL,
                                 NULL,
                                 NULL,
                                 NULL
                                );
                     gl.payv (ovr.getpo (tt9_),
                              ref_,
                              gl.bdate,
                              tt9_,
                              dk_,
                              kv_,
                              nls_,
                              s_,
                              kv_,
                              nls9_,
                              s_
                             );
                  END IF;

                EXCEPTION  WHEN OTHERS  THEN

                     ROLLBACK TO do_provodki_2;

                     BEGIN
                        INSERT INTO tmp_ovr
                                    (dat, ID, dk, nlsa, nlsb,
                                     s, txt
                                    )
                             VALUES (gl.bdate, 2, 1, nls_2067_, k.nls,
                                     k.ost, txt_
                                    );

                      --  GOTO kin_2;
                     END;
               END;

               <<kin_2>>
               NULL;
            END LOOP;

            RETURN;

--------------------------------------------------------------------------------

                               ----------------------------------------
         ELSIF nmode_ = 12     ---  Перенос только %% на просрочку  ---
         THEN                  ----------------------------------------

            nbs3_ := '3579';         -- для комиссии за однодневный овердрафт
            naz_ := 'Перенесення только %  на просрочену';


       --   Ниже закомментарено
       --      --- AND nvl(o.PR_2600A,0) > 0   --  число месяца 
       --      --- AND gl.bdate > pay_date(gl.bdate, o.PR_2600A)
       --   для того, что бы автооткрытие 2067,2069 происходило и 
       --   в том случае, когда "День погашення %%" не проставлен !!!


            FOR k IN (SELECT a.nls, a.kv, SUBSTR (a.nms, 1, 38) nms, a.acc,
                             -a.ostc ost, a.grp, a.sec, a.seco, a.seci,
                             a.isp, a.mdate, NVL (a.lim, 0) lim, a.tobo,
                             c.okpo, c.rnk, o.ndoc, o.datd, c.nmk,
                             o.acc_9129, o.acc_2067, o.acc_8000, o.nd,
                             o.PR_2600A 
                        FROM accounts a, acc_over o, cust_acc u, customer c
                       WHERE o.acc = a.acc
                         AND u.acc = a.acc
                         AND c.rnk = u.rnk
                      --- AND o.PR_2600A <> 0        -- число месяца --
                      --- AND gl.bdate > pay_date(gl.bdate, o.PR_2600A)
                         AND NVL (o.sos, 0) <> 1
                         AND a.nbs = ovr.f_nbs (o.acc, 2600)
                         AND (acc_2000 = 0 OR acc_2000 = o.acc)
                         AND o.tipo <> 200
                      )
            LOOP

               SAVEPOINT do_provodki_12;
               nbs_  := ovr.f_nbs (k.acc, 2067);  -- пока неясен другой способ
               nbs9_ := ovr.f_nbs (k.acc, 2069);         -- для нач процентов
               nbs3_ := '3579';                               -- для комиссии


               Begin --- Проставляем OB22 уже открытым 2607,9129:

                  SELECT a.acc     INTO   acc_2008_    FROM   accounts a, int_accn i    WHERE  i.acc = k.acc     AND i.ID = 0    AND i.acra = a.acc ;
                  Accreg.setAccountSParam(acc_2008_ , 'OB22', '01') ;

                  ---  В зависмости от наличия застави 95* проставляем ОВ22 счету 9129:
                  Select count(*) into kol_9500  from CC_ACCP c, ACCOUNTS a  where c.ACC=a.ACC and c.ACCS=k.ACC and a.NBS like '95%'; 

                  if kol_9500 > 0 then   Accreg.setAccountSParam(k.acc_9129 , 'OB22', '04') ;
                  else                   Accreg.setAccountSParam(k.acc_9129 , 'OB22', '37') ;
                  end if;

               EXCEPTION  WHEN NO_DATA_FOUND  THEN       NULL;
               END;
     

               If nvl(k.acc_8000,0) > 0 then              
                  Begin SELECT ACRA  INTO   acc_3578_  FROM   Int_Accn   WHERE  ACC = k.acc_8000         and ID  = 0 ;   ---             ---  3578/36
                        Accreg.setAccountSParam(acc_3578_ , 'OB22', '36') ;
                        Begin Select ACC into acc_3579_  From   Accounts       Where  NBS='3579'and NMS like 'Просроч%комiс%за%овердрафт%' and RNK in (Select RNK from Accounts where ACC=k.acc);    ---  3579/91
                              Accreg.setAccountSParam(acc_3579_ , 'OB22', SB_3579.ob22) ;
                        Exception when OTHERS then   null;
                        End;
                  Exception when OTHERS then      null;
                  End;
               End if;



               BEGIN

                  BEGIN
                     dtxt_ :=
                           'Угода № '
                        || RTRIM (k.ndoc)
                        || ' вiд '
                        || TO_CHAR (k.datd, 'dd.mm.yyyy');

                     BEGIN SELECT DAZS , substr(NMS,1,38)   INTO dazs_, nms_2067_       FROM accounts    WHERE acc = k.ACC_2067;
                           Accreg.setAccountSParam( k.ACC_2067, 'OB22', SB_2067.ob22 ) ;
                           SELECT i.ACRA   , substr(a.NMS,1,38)  INTO acc_2069_, nms_2069_    FROM int_accn i, accounts a   WHERE i.acc = k.ACC_2067   and i.ID=0    and i.ACRA=a.ACC;
                           Accreg.setAccountSParam( acc_2069_, 'OB22', SB_2069.ob22 ) ;
                     EXCEPTION  WHEN NO_DATA_FOUND  THEN     dazs_ := NULL;
                     END;


                     IF NVL(k.acc_2067,0) = 0 OR dazs_ IS NOT NULL  THEN
                     
                        SELECT s080            --  2067 нет  
                          INTO s080_
                          FROM specparam
                         WHERE acc = k.acc;

                        nls_2067_ :=
                              nbs_
                           || '0'
                           || SUBSTR (NVL (f_newnls (k.acc, 'OV2067', ''),
                                           k.nls
                                          ),
                                      6,
                                      9
                                     );
                        nls_2067_ := vkrzn (SUBSTR (mfo5_, 1, 5), nls_2067_);
                        nms_2067_ :=
                           SUBSTR ('Просрочена заборг. за дог.овердpафту № '||k.ndoc,
                                   1,
                                   70
                                  );
                        ret1_ := 0;
                        txt_ := '1.Открытие ' || nls_2067_;
                        op_reg_ex (99,
                                   0,
                                   0,
                                   k.grp,
                                   ret1_,
                                   k.rnk,
                                   nls_2067_,
                                   k.kv,
                                   nms_2067_,
                                   'ODB',
                                   k.isp,
                                   acc_2067_,
                                   '1',
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   k.tobo,
                                   NULL
                                  );
                        txt_ := '2.Обновление ' || nls_2067_;

                        UPDATE accounts
                           SET sec = k.sec,
                               blkd = 0,
                               mdate = k.mdate,
                               nms = nms_2067_,
                               dazs = NULL
                         WHERE acc = acc_2067_;


                        if a_grp_ > 0 then          SEC.addAgrp(acc_2067_, a_grp_);             end if;

                        Accreg.setAccountSParam( acc_2067_, 'OB22', SB_2067.ob22 ) ;
                        Accreg.setAccountSParam( acc_2067_, 'S080', s080_ ) ;

                        nls_2069_ := nbs9_     || '0'  || SUBSTR (NVL (f_newnls (k.acc, 'OV2069', ''),  k.nls    ),   6, 9  );
                        nls_2069_ := vkrzn (SUBSTR (mfo5_, 1, 5), nls_2069_);
                        nms_2069_ := SUBSTR('Просроч. % за дог.овердpафту № '    || k.ndoc,   1,70   );

                        ret1_ := 0;
                        txt_ := '3.Открытие ' || nls_2069_;
                        op_reg_ex (99,
                                   0,
                                   0,
                                   k.grp,
                                   ret1_,
                                   k.rnk,
                                   nls_2069_,
                                   k.kv,
                                   nms_2069_,
                                   'ODB',
                                   k.isp,
                                   acc_2069_,
                                   '1',
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   k.tobo,
                                   NULL
                                  );
                        txt_ := '4.Обновление ' || nls_2069_;

                        UPDATE accounts       SET sec = k.sec,        blkd = 0,    mdate = k.mdate,      nms = nms_2069_,      dazs = NULL    WHERE acc = acc_2069_;
                        Accreg.setAccountSParam(acc_2069_, 'OB22', sb_2069.ob22 ) ;
                        if a_grp_ > 0 then       SEC.addAgrp(acc_2069_, a_grp_);    end if;
-----------------------------------------
                        IF ovr.ovr_par_val ('DO_3578') = 'TRUE'           THEN
                           nls_3579_ :=  nbs3_ || '0' || SUBSTR (NVL (f_newnls (k.acc, 'OV3579', ''),   k.nls   ),  6,  9      );
                           nls_3579_ :=  vkrzn (SUBSTR (mfo5_, 1, 5), nls_3579_);
                           nms_3579_ :=  SUBSTR  ('Просроч.комiс.за дог.овердрафту № ' ||trim(k.ndoc),    1,38    );
                           ret1_ := 0;
                           txt_ := '5.Открытие ' || nls_3579_;
                           op_reg (99,
                                   0,
                                   0,
                                   k.grp,
                                   ret1_,
                                   k.rnk,
                                   nls_3579_,
                                   k.kv,
                                   nms_3579_,
                                   'ODB',
                                   k.isp,
                                   acc_3579_
                                  );
                           txt_ := '6.Обновление ' || nls_3579_;

                           UPDATE accounts
                              SET sec = k.sec,
                                  blkd = 0,
                                  mdate = k.mdate,
                                  nms = nms_3579_,
                                  dazs = NULL,
                                  TOBO=k.tobo
                           WHERE acc = acc_3579_;

                           if a_grp_ > 0 then
                              SEC.addAgrp(acc_3579_, a_grp_);
                           end if;


                           BEGIN
                              INSERT INTO nd_acc
                                          (nd, acc
                                          )
                                   VALUES (k.nd, acc_3579_
                                          );
                           EXCEPTION WHEN OTHERS THEN
                                NULL;
                           END;
                        END IF;
-----------------------------------------

                        IF ovr.ovr_par_val ('DO_PEN') = 'TRUE'   THEN

                           nls_8008_ :=
                                 '80080'
                              || SUBSTR (NVL (f_newnls (k.acc, 'SN8', ''),
                                              k.nls
                                             ),
                                         6,
                                         9
                                        );
                           nls_8008_ :=
                                       vkrzn (SUBSTR (mfo5_, 1, 5), nls_8008_);
                           nms_8008_ :=
                              SUBSTR ('Пеня за просрочку по дог.овердрафту № '
                                      || k.ndoc,
                                      1,
                                      70
                                     );
                           ret1_ := 0;
                           txt_ := '7.Открытие ' || nls_8008_;
                           op_reg (99,
                                   0,
                                   0,
                                   k.grp,
                                   ret1_,
                                   k.rnk,
                                   nls_8008_,
                                   k.kv,
                                   nms_8008_,
                                   'ODB',
                                   k.isp,
                                   acc_8008_
                                  );
                           txt_ := '8.Обновление ' || nls_8008_;

                           UPDATE accounts
                              SET sec = k.sec,
                                  blkd = 0,
                                  mdate = k.mdate,
                                  nms = nms_8008_,
                                  dazs = NULL,
                                  TOBO=k.tobo
                            WHERE acc = acc_8008_;

                           if a_grp_ > 0 then
                              SEC.addAgrp(acc_8008_, a_grp_);
                           end if;


                           BEGIN
                              INSERT INTO nd_acc
                                          (nd, acc
                                          )
                                   VALUES (k.nd, acc_8008_
                                          );
                           EXCEPTION WHEN OTHERS THEN
                                NULL;
                           END;


                           BEGIN
                              INSERT INTO int_accn
                                          (acc, ID, metr, basem, basey,
                                           freq, acra,
                                           acrb,
                                           tt
                                          )
                                   VALUES (acc_2067_, 2, 0, 0, 0,
                                           1, acc_8008_,
                                           TO_NUMBER
                                                   (ovr.ovr_par_val ('PEN_ACC')
                                                   ),
                                           '%%1'
                                          );
                           EXCEPTION  WHEN OTHERS  THEN

                                 UPDATE int_accn
                                    SET metr = 0,
                                        basem = 0,
                                        basey = 0,
                                        freq = 1,
                                        acra = acc_8008_,
                                        acrb =
                                           TO_NUMBER
                                                   (ovr.ovr_par_val ('PEN_ACC')
                                                   ),
                                        tt = '%%1'
                                  WHERE acc = acc_2067_ AND ID = 2;
                           END;

                           BEGIN
                              INSERT INTO int_ratn
                                          (acc, ID, bdat,
                                           ir
                                          )
                                   VALUES (acc_2067_, 2, gl.bdate,
                                           TO_NUMBER
                                                    (ovr.ovr_par_val ('PEN_PR')
                                                    )
                                          );
                           EXCEPTION WHEN OTHERS THEN
                                 UPDATE int_ratn
                                    SET ir =
                                           TO_NUMBER
                                                    (ovr.ovr_par_val ('PEN_PR')
                                                    )
                                  WHERE acc = acc_2067_
                                    AND ID = 2
                                    AND bdat = gl.bdate;
                           END;
                        END IF;


                        BEGIN
                           SELECT acc
                             INTO ret1_
                             FROM int_accn
                            WHERE acc = acc_2067_ AND ID = 0;

                           UPDATE int_accn
                              SET acra = acc_2069_
                            WHERE acc = acc_2067_ AND ID = 0;
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                              BEGIN
                                 ---- счет доходов для нового БС NBS_
                                 SELECT a.acc
                                   INTO acc67_
                                   FROM accounts a, proc_dr p
                                  WHERE a.kv = k.kv
                                    AND p.nbs = nbs_
                                    AND p.sour = 4
                                    AND p.rezid = 0
                                    AND p.g67 = a.nls;
                              EXCEPTION WHEN NO_DATA_FOUND THEN
                                    acc67_ := NULL;
                              END;

                              txt_ := '9.Создание % карты ' || nls_2067_;

                              ---- Создаем % карточку на 2067:
                              INSERT INTO int_accn
                                          (acc, ID,    METR, basem, basey, freq,
                                           tt, acra, acrb)
                                 SELECT acc_2067_, 0,  0,    basem, basey,
                                        freq, tt, acc_2069_,
                                        NVL (acc67_, acrb)
                                   FROM int_accn
                                  WHERE acc = k.acc AND ID = 0;
                        END;

                     ELSE
                                              --- 2067 есть 
                        SELECT nls, acc
                          INTO nls_2067_, acc_2067_
                          FROM accounts
                         WHERE acc = k.acc_2067;

                        SELECT a.nls, a.acc
                          INTO nls_2069_, acc_2069_
                          FROM accounts a, int_accn i
                         WHERE i.acc  = k.acc_2067
                           AND i.acra = a.acc
                           AND i.ID   = 0;

                     END IF;


                     txt_ := '10.Внесение % ставки ' || nls_2067_;

                     BEGIN

                        SELECT acc             
                          INTO acc_2067_
                          FROM int_ratn
                         WHERE acc = acc_2067_
                           AND ID = 0
                           AND rownum = 1 ;   ----  bdat = gl.bdate;

                     EXCEPTION WHEN NO_DATA_FOUND THEN

                        Begin 
                                 -- Это 2600 с "плавающей" ставкой.

                          Select nvl(IDR,0) into idr_   --  № шкалы на 2600
                          From   INT_ACCN
                          Where  ACC=k.ACC and ID=0 and METR=7;

                          
                          If idr_>0 then  --- Ставим макс. СТАВКУ по этой ШКАЛЕ
                             Begin 
                               select max(IR) into ir_max 
                               from   INT_OVR
                               where  ID=idr_;

                               INSERT INTO int_ratn
                                      (acc,      ID, bdat,     ir    , br  )
                               values (acc_2067_, 0, gl.bdate, ir_max, null);
                             EXCEPTION WHEN OTHERS THEN
                               null;
                             End;
                          End if;

                        EXCEPTION WHEN NO_DATA_FOUND THEN
                               -- Это 2600 с обычной постоянной ставкой.
                           INSERT INTO int_ratn
                                     (acc, ID, bdat, ir, br, op)
                            SELECT acc_2067_, 0, gl.bdate, ir, br, op
                              FROM int_ratn n
                             WHERE n.acc = k.acc
                               AND n.ID = 0
                               AND n.bdat =
                                      (SELECT MAX (bdat)
                                         FROM int_ratn
                                        WHERE bdat <= gl.bdate
                                          AND acc = k.acc
                                          AND ID = 0);
                        END;

                     END;
                     

                     BEGIN 
                           ---  Строка просрочки ЕСТЬ
                        SELECT acc     
                          INTO s_
                          FROM acc_over
                         WHERE acc = k.acc AND acco = acc_2067_
                               AND tipo <> 200;

                     EXCEPTION  WHEN NO_DATA_FOUND THEN

                           --- Добавляем строку просрочки в AСC_OVER:

                           txt_ := '11.Помещение в овр' || nls_2067_;

                           INSERT INTO acc_over
                                       (acc, acco, tipo, flag, nd, DAY, sos,
                                        sd, ndoc)
                              SELECT ao.acc, acc_2067_, ao.tipo, ao.flag,
                                     ao.nd, ao.DAY, 1, ao.sd, ao.ndoc
                                FROM acc_over ao
                               WHERE acco = k.acc
                                 AND NVL (ao.sos, 0) = 0
                                 AND ao.tipo <> 200
                                 AND ao.acc NOT IN (
                                        SELECT ao2.acc
                                          FROM acc_over ao2
                                         WHERE ao2.acc = k.acc
                                           AND NVL (ao2.sos, 0) = 1);

                           UPDATE acc_over
                              SET acc_2067 = acc_2067_
                            WHERE acc = k.acc;

                           UPDATE acc_over
                              SET acco = acc_2067_
                            WHERE acc = k.acc AND sos = 1;
                     END;

                     dtxt_ :=
                           'Угода '
                        || RTRIM (k.ndoc)
                        || ' вiд '
                        || TO_CHAR (k.datd, 'dd.mm.yyyy');
                     naz_ :=
                        SUBSTR (   'Перенес.нарах. %% за овердрафт на просроч. '
                                || dtxt_
                                || ' '
                                || k.nmk,
                                1,
                                160
                               );


           --------------------------------------------------------------

           IF  nvl(k.PR_2600A,0) > 0    and
               gl.bdate > pay_date(gl.bdate, k.PR_2600A)   then
                     
                     ---   Перенос %%:  2607 -> 2069   ---

                     BEGIN    

           ---  Находим ACC и текущий ост. счета 2607 :
                        -- Текущий ост.2607 должен     
                        -- быть строго < 0, иначе выход

                        SELECT a.acc, a.nls, SUBSTR (a.nms, 1, 38), a.ostc
                          INTO acc_2008_, nls_2008_, nms_2008_, ost_2008_
                          FROM accounts a, int_accn i
                         WHERE i.acra = a.acc      
                           AND i.acc = k.acc   
                           AND a.ostc < 0  
                           AND i.ID = 0;   

           ---  Находим сумму KOS по 2607 с начала месяца по тек.момент:
                        Select nvl(sum(KOS),0)
                        Into   kos_2008_
                        From   SaldoA 
                        Where  ACC=acc_2008_ 
                          and  FDAT>=ADD_MONTHS(TRUNC(gl.bdate,'MM'),0)  and
                               FDAT<=gl.bdate ;


           ---  Находим ost_2008_1  - входящий АКТ.остаток 2607 на 01 число:
                     -- Входящий ост.2607 на 01 должен быть строго < 0, 
                     -- иначе выход
 
                        Select nvl(ostf-dos+kos,0)
                        Into   ost_2008_1 
                        From   SaldoA 
                        Where  ACC=acc_2008_ 
                          and  (ACC,FDAT)=
                                   (Select ACC, max(FDAT) from Saldoa 
                                    where ACC=acc_2008_ and 
                                      FDAT < ADD_MONTHS(TRUNC(gl.bdate,'MM'),0 )
                                    group by ACC)
                          and nvl(ostf-dos+kos,0)<0;

                        --  ost_2008_  и  ost_2008_1  оба строго <  0 

                        --  Переносимая сумма %%:
                        s_per2008_:= ABS(least(0, ost_2008_1+kos_2008_));


                        If s_per2008_ > 0  and  s_per2008_ <= -ost_2008_ then

                          gl.REF (ref_);
                          
                          gl.in_doc3 (ref_,
                                      'OVR',
                                      6,
                                      ref_,
                                      SYSDATE,
                                      gl.bdate,
                                      1,
                                      k.kv,
                                      s_per2008_,
                                      k.kv,
                                      s_per2008_,
                                      NULL,
                                      gl.bdate,
                                      gl.bdate,
                                      nms_2069_,
                                      nls_2069_,
                                      mfo5_,
                                      nms_2008_,
                                      nls_2008_,
                                      mfo5_,
                                      naz_,
                                      NULL,
                                      k.okpo,
                                      k.okpo,
                                      NULL,
                                      NULL,
                                      NULL,
                                      NULL,
                                      NULL
                                     );
                          gl.payv (ovr.getpo ('OVR'),
                                   ref_,
                                   gl.bdate,
                                   'OVR',
                                   1,
                                   k.kv,
                                   nls_2069_,
                                   s_per2008_,
                                   k.kv,
                                   nls_2008_,
                                   s_per2008_
                                  );
                          
                          UPDATE opldok
                             SET txt = SUBSTR (naz_, 1, 70)
                           WHERE REF = ref_ AND stmt = gl.astmt;
                        else
                           ost_2008_ := 0;
                        end if;

                     EXCEPTION  WHEN NO_DATA_FOUND  THEN
                        ost_2008_ := 0;
                     END;

           END IF;
           ------------------------------------------------


                  EXCEPTION WHEN OTHERS THEN
                     erm := '8012 - No defined # ' ;
                     RAISE err;
                  END;


                EXCEPTION WHEN OTHERS THEN

                  ROLLBACK TO do_provodki_12;

                  BEGIN
                     INSERT INTO tmp_ovr
                                 (dat, ID, dk, nlsa, nlsb,
                                  s, txt
                                 )
                          VALUES (gl.bdate, 2, 1, nls_2067_, k.nls,
                                  k.ost, txt_
                                 );

                   --  GOTO kin_2;
                  END;
               END;

               <<kin_12>>
               NULL;
            END LOOP;

            RETURN;

----=======================  Для "НАДР":  ======================================

         ELSIF nmode_ = 14
         THEN
   ---- Блокировка пользования овердрафтом при превышении MDATE
   ----                   gl.BDATE > MDATE 

            FOR k IN (SELECT a.nls, a.kv, SUBSTR (a.nms, 1, 38) nms, a.acc,
                             -a.ostc ost, a.grp, a.sec, a.seco, a.seci,
                             a.isp, a.mdate, NVL (a.lim, 0) lim, a.tobo,
                             o.ndoc, o.datd, 
                             o.acc_9129, o.acc_2067, o.acc_8000, o.nd
                        FROM accounts a, acc_over o
                       WHERE o.acc = a.acc
                         AND NVL (o.sos, 0) <> 1                
                         AND a.nbs = ovr.f_nbs (o.acc, 2600)    
                         AND (acc_2000 = 0 OR acc_2000 = o.acc) 
                         AND o.tipo <> 200                      
                         AND a.OSTC < 0 
                         AND gl.BDATE>a.MDATE  
                     )
            LOOP

               SAVEPOINT do_provodki_14;

               BEGIN

                  update ACCOUNTS set TIP='BLD' where ACC=k.ACC;

               EXCEPTION WHEN OTHERS THEN
                  ROLLBACK TO do_provodki_14;
                  NULL;
               END;

            END LOOP;

            RETURN;

----==================================================================
         --- Погашение %% 2607 по овердрафту

         ELSIF nmode_ = 3  THEN

for k in (select o.ndoc, o.datd, o.nd, o.uselim, i.ACRA,
                 o.acc_3739, o.ACC, a0.nls 
          from   acc_over o, int_accn i, accounts a0
          where o.tipo <> 200
            AND (acc_2000 = 0 OR acc_2000 = i.acc)
            AND o.ACCO = i.acc                       ---- 2600          
            AND MOD(i.ID,2) = 0
            and i.acra is not null 
            and a0.acc = o.acc_8000
            and o.SOS is NULL           --- это осн. запись 
         )
loop

   SAVEPOINT do_provodki_3;

   declare
      l_acc  accounts.acc%type  ;
      l_ost8 accounts.ostc%type ;
      l_ost6 accounts.ostc%type ;
      l_lim  accounts.lim%type  ;
      l_s    oper.s%type        ;
      l_s3   oper.s%type        ;
      l_kv   accounts.kv%type   ;
      l_nls6 accounts.nls%type  ;
      l_nms6 accounts.nms%type  ;
      l_nls8 accounts.nls%type  ;
      l_nms8 accounts.nms%type  ; 
      l_okpo customer.okpo%type ;

   begin
      l_acc  := nvl(k.acc_3739, k.acc); -- счет, с которого будем списывать
      l_ost8 := fost(k.acra, gl.bdate); -- остаток на 2607
      l_ost6 := fost(l_acc , gl.bdate); -- остаток на 2600(3739)

      If l_ost8 >= 0 then GOTO kin_3  ; end if;
      --------------------------------------
      l_s  := LEAST (l_ost6, -l_ost8 ) ;
      l_s3 := l_ost6 ;

      --- использовать лимит
      IF k.uselim = 1  and  k.acc_3739 is null THEN    
         select lim into l_lim from accounts where acc =k.ACC;
         l_s := LEAST (l_ost6 + l_lim, -l_ost8 ) ;

         -- опр необх оборот по 8000 на сумму исп лимита
         IF l_s3 < l_s   THEN  ts2_ := l_s;
            IF l_s3 > 0  THEN  ts2_ := ts2_ - l_s3;
            END IF;
         END IF;
      END IF;

      If  l_s <= 0   then GOTO kin_3  ; end if;
      -----------------------------------------

      select a.kv, a.nls, substr(a.nms,1,38), s.okpo
      into l_kv, l_nls6, l_nms6, l_okpo
      from accounts a, customer s
      where a.acc= l_acc and a.rnk =s.rnk;

      select nls, substr(nms,1,38) into l_nls8, l_nms8
      from accounts  where acc= k.acra;

      gl.REF (ref_);
      naz_ := 'Погашення %% за користування овердрафтом. Угода № '
              || RTRIM (k.ndoc)|| ' вiд '  || TO_CHAR (k.datd, 'dd.mm.yyyy');

      gl.in_doc3 (ref_, 'OVR', 6, ref_ , SYSDATE,   gl.bdate, 1,
                  l_kv,  l_s, l_kv, l_s,    NULL,   gl.bdate, gl.bdate,
                  l_nms6, l_nls6, mfo5_, l_nms8 , l_nls8,  mfo5_, naz_,
                   NULL, l_okpo,  l_okpo,   NULL,   NULL,  NULL,  NULL, null );
 
      paytt (ovr.getpo ('OVR'),
             ref_, 
             gl.bdate, 
             'OVR', 
             1,
             l_kv, 
             l_nls6,
             l_s,
             l_kv, 
             l_nls8,
             l_s
            );

   EXCEPTION  WHEN OTHERS  THEN  
      ROLLBACK TO do_provodki_3;
      BEGIN
     --   INSERT INTO tmp_ovr (dat, ID, dk, nlsa, nlsb, s, txt )
     --          VALUES (gl.bdate, 3, 1, k.nls6, k.nls8, k.s, 'Погашення %'  );
        GOTO kin_3;
      END;
   END;
   <<kin_3>>   NULL;
END LOOP;

RETURN;
------------------------------------------------------------------------------
-------    Гашение комиссии 3578:

         ELSIF nmode_ = 31  THEN

for k in (select o.ndoc, o.datd, o.nd, o.uselim, 
                 o.ACC_3739, o.ACC, i.ACRA 
          from   acc_over o, int_accn i
          where o.tipo <> 200
            AND (acc_2000 = 0 OR acc_2000 = o.ACC)
            AND o.ACC_8000 = i.ACC                    --- 8000
            AND i.ACRA is not NULL                    --- 3578
            AND i.ID = 0
            and nvl(o.SOS,0)=0 
         )
loop

   SAVEPOINT do_provodki_31;

   declare
      l_acc  accounts.acc%type  ;
      l_ost8 accounts.ostc%type ;
      l_ost6 accounts.ostc%type ;
      l_lim  accounts.lim%type  ;
      l_s    oper.s%type        ;
      l_s3   oper.s%type        ;
      l_kv   accounts.kv%type   ;
      l_nls6 accounts.nls%type  ;
      l_nms6 accounts.nms%type  ;
      l_nls8 accounts.nls%type  ;
      l_nms8 accounts.nms%type  ; 
      l_okpo customer.okpo%type ;

   begin
      l_acc  := nvl(k.acc_3739, k.acc); -- счет гашения (2600/3739)
      l_ost8 := fost(k.ACRA, gl.bdate); -- остаток на 3578
      l_ost6 := fost(l_acc , gl.bdate); -- остаток на счете гашения (2600/3739)

      If l_ost8 >= 0 then GOTO kin_31  ; end if;
      --------------------------------------
      l_s  := LEAST (l_ost6, -l_ost8 ) ;
      l_s3 := l_ost6 ;

      --- использовать лимит
      IF k.uselim = 1  and  k.acc_3739 is null THEN    
         select lim into l_lim from accounts where acc =k.ACC;
         l_s := LEAST (l_ost6 + l_lim, -l_ost8 ) ;

         -- опр необх оборот по 8000 на сумму исп лимита
         IF l_s3 < l_s   THEN  ts2_ := l_s;
            IF l_s3 > 0  THEN  ts2_ := ts2_ - l_s3;
            END IF;
         END IF;
      END IF;

      If  l_s <= 0   then GOTO kin_31  ; end if;
      -----------------------------------------

      select a.kv, a.nls, substr(a.nms,1,38), s.okpo
      into l_kv, l_nls6, l_nms6, l_okpo
      from accounts a, customer s
      where a.acc= l_acc and a.rnk =s.rnk;

      select nls, substr(nms,1,38) into l_nls8, l_nms8
      from accounts  where acc= k.acra;

      gl.REF (ref_);
      naz_ := 'Погашення комiсiї за овердрафт. Угода № '
              || RTRIM (k.ndoc)|| ' вiд '  || TO_CHAR (k.datd, 'dd.mm.yyyy');

      gl.in_doc3 (ref_, 'OVR', 6, ref_ , SYSDATE,   gl.bdate, 1,
                  l_kv,  l_s, l_kv, l_s,    NULL,   gl.bdate, gl.bdate,
                  l_nms6, l_nls6, mfo5_, l_nms8 , l_nls8,  mfo5_, naz_,
                   NULL, l_okpo,  l_okpo,   NULL,   NULL,  NULL,  NULL, null );
 
      paytt (ovr.getpo ('OVR'),
             ref_, 
             gl.bdate, 
             'OVR', 
             1,
             l_kv, 
             l_nls6,
             l_s,
             l_kv, 
             l_nls8,
             l_s
            );

   EXCEPTION  WHEN OTHERS  THEN  
      ROLLBACK TO do_provodki_31;
      BEGIN
        GOTO kin_31;
      END;
   END;
   <<kin_31>>   NULL;
END LOOP;

RETURN;

-------------------------------------------------------------------------------

---- 33.  Погашение ВСЕХ долгов по овердрафту:

         ELSIF nmode_ = 33
         THEN

            FOR k IN (SELECT o.*, a.nls, a.rnk
                        FROM acc_over o, accounts a
                       WHERE (acc_2000 = 0 OR o.acc = acc_2000)
                         AND NVL (o.sos, 0) != 1
                         AND o.acc=a.acc
                         AND o.tipo <> 200
                     )
            LOOP

               SAVEPOINT do_provodki_33;

               BEGIN
                  IF NVL (k.acc_2067, 0) = 0
                  THEN
                     acc_2067_ := -1;
                     acc_2069_ := -1;
                     acc_3579_ := -1;
                  ELSE
                     acc_2067_ := k.acc_2067;
                  END IF;

                  IF NVL (k.acc_8000, 0) = 0
                  THEN
                     acc_8000_ := -1;
                     acc_3578_ := -1;
                  ELSE
                     acc_8000_ := k.acc_8000;
                  END IF;

                  IF NVL (k.acc_2096, 0) = 0
                  THEN
                     acc_2096_ := -1;
                     acc_2480_ := -1;
                  ELSE
                     acc_2096_ := k.acc_2096;
                  END IF;


                  BEGIN
                     SELECT NVL (ACRA, -1)
                       INTO acc_2008_         --- 2607
                       FROM int_accn
                      WHERE acc = k.acc AND ID = 0;
                  EXCEPTION WHEN NO_DATA_FOUND THEN
                     acc_2008_ := -1;
                  END;


                  IF acc_2067_ != -1 THEN
                     BEGIN
                        SELECT NVL (acra, -1)
                          INTO acc_2069_
                          FROM int_accn
                         WHERE acc = acc_2067_ AND ID = 0;
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           acc_2069_ := -1;
                     END;
                  END IF;


                  IF acc_2096_ != -1 THEN
                     BEGIN
                        SELECT NVL (acra, -1)
                          INTO acc_2480_
                          FROM int_accn
                         WHERE acc = acc_2096_ AND ID = 0;
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           acc_2480_ := -1;
                     END;
                  END IF;

                  IF acc_8000_ != -1 THEN
                     BEGIN
                        SELECT NVL (i.acra, -1)
                          INTO acc_3578_
                          FROM int_accn i
                         WHERE i.acc = acc_8000_ AND i.ID = 0;
                     EXCEPTION WHEN NO_DATA_FOUND THEN
                         acc_3578_ := -1;
                     END;
                  END IF;

                  IF acc_3578_ != -1  THEN
                     Begin
                       Select ACC into acc_3579_
                       From   Accounts 
                       Where  NBS='3579'
                          and NMS like 'Просроч%комiс%за%овердрафт%'
                          and RNK = k.rnk 
                          and rownum = 1; 
                     EXCEPTION WHEN NO_DATA_FOUND THEN
                       acc_3579_ := -1;
                     END;
                  END IF;


             --------------------  Гашение:  ------------------------


             -----  2480:
                  IF NVL (acc_2480_, -1) != -1
                  THEN
                     gash (nvl(k.acc_3739,k.acc),
                           acc_2480_,
                           k.uselim,
                              'Погашення сумнiвних %% за овердрафт. Угода № '
                           || RTRIM (k.ndoc)
                           || ' вiд '
                           || TO_CHAR (k.datd, 'dd.mm.yyyy')
                          );
                  END IF;


             -----  2096:
                  IF NVL (acc_2096_, -1) != -1
                  THEN
                     gash (nvl(k.acc_3739,k.acc),
                           acc_2096_,
                           k.uselim,
                              'Погашення сумнiвного боргу за овердр. Угода № '
                           || RTRIM (k.ndoc)
                           || ' вiд '
                           || TO_CHAR (k.datd, 'dd.mm.yyyy')
                          );
                  END IF;


             -----  3579:
                  IF NVL (acc_3579_, -1) != -1
                  THEN
                     gash (nvl(k.acc_3739,k.acc),
                           acc_3579_,
                           k.uselim,
                              'Погашення просроченої комiсiї за овердр. Угода № '
                           || RTRIM (k.ndoc)
                           || ' вiд '
                           || TO_CHAR (k.datd, 'dd.mm.yyyy')
                          );
                  END IF;


             -----  2069:
                  IF NVL (acc_2069_, -1) != -1
                  THEN
                     gash
                        (nvl(k.acc_3739,k.acc),
                         acc_2069_,
                         k.uselim,
                            'Погашення %% нарах. на просроч.овердрафт. Угода № '
                         || RTRIM (k.ndoc)
                         || ' вiд '
                         || TO_CHAR (k.datd, 'dd.mm.yyyy')
                        );
                  END IF;


             -----  2067:
                  IF NVL (acc_2067_, -1) != -1
                  THEN
                     gash (nvl(k.acc_3739,k.acc),
                           acc_2067_,
                           k.uselim,
                              'Погашення просроченого боргу за овердр. Угода № '
                           || RTRIM (k.ndoc)
                           || ' вiд '
                           || TO_CHAR (k.datd, 'dd.mm.yyyy')
                          );
                  END IF;


             -----  3578:
                  IF NVL (acc_3578_, -1) != -1
                  THEN
                     gash (nvl(k.acc_3739,k.acc),
                           acc_3578_,
                           k.uselim,
                              'Погашення комiсiї за овердр. Угода № '
                           || RTRIM (k.ndoc)
                           || ' вiд '
                           || TO_CHAR (k.datd, 'dd.mm.yyyy')
                          );
                  END IF;


             -----  2607:
                  IF NVL (acc_2008_, -1) != -1
                  THEN
                     gash (nvl(k.acc_3739,k.acc),
                           acc_2008_,
                           k.uselim,
                              'Погашення %% за овердр. Угода № '
                           || RTRIM (k.ndoc)
                           || ' вiд '
                           || TO_CHAR (k.datd, 'dd.mm.yyyy')
                          );
                  END IF;
               END;

               <<kin_33>>
               NULL;
            END LOOP;

---------------------------------------------------------------------------

---            Закрытие договора:

         ELSIF nmode_ = 8
         THEN

            --- 9129,8000,2607:
            BEGIN
               SELECT o.acc_9129, o.acc_8000, i.acra
                 INTO acc_9129_, acc_8000_, acc_2008_
                 FROM acc_over o, int_accn i
                WHERE o.acc = acc_2000
                  AND NVL (o.sos, 0) <> 1
                  AND i.acc = acc_2000
                  AND i.ID = 0
                  AND o.tipo <> 200;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  acc_9129_ := 0;
                  acc_8000_ := 0;
                  acc_2008_ := 0;
            END;

            --- 2067,2069:
            BEGIN
               SELECT o.acc_2067, i.acra
                 INTO acc_2067_, acc_2069_
                 FROM acc_over o, int_accn i
                WHERE i.acc = o.acco
                  AND i.ID = 0
                  AND o.acc = acc_2000
                  AND o.sos = 1
                  AND o.tipo <> 200;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  acc_2067_ := 0;
                  acc_2069_ := 0;
            END;

            --- 2096:
            BEGIN
               SELECT o.acc_2096
                 INTO acc_2096_
                 FROM acc_over o
                WHERE o.acc = acc_2000 AND NVL (o.sos, 0) <> 1
                      AND o.tipo <> 200;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  acc_2096_ := 0;
            END;

           ---  Проверяем на остатки: 2600,2607,2067,2069,2096

            IF    acc_2000 >0 and bars.fost (acc_2000 , gl.bdate) < 0
               OR acc_2008_>0 and bars.fost (acc_2008_, gl.bdate) <> 0
               OR acc_2067_>0 and bars.fost (acc_2067_, gl.bdate) <> 0
               OR acc_2069_>0 and bars.fost (acc_2069_, gl.bdate) <> 0
            -- OR acc_2096_>0 and bars.fost (acc_2096_, gl.bdate) <> 0
            THEN
               erm := '8999 - На счетах 2600,2607,2067,2069 есть остатки !';
               RAISE err;
            END IF;


---+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

            Begin

               Select sum(fost(ACC,gl.bdate)) into ost_9500_
               From   Accounts 
               Where  ACC in ( Select ACC 
                               From   CC_ACCP           
                               Where  ACCS=acc_2000 
                             );   
               
               If ost_9500_ <> 0 then
                  erm := '8999  К договору привязаны счета обеспечения с ненулевыми остатками !';
                  RAISE err;
               End If;

            EXCEPTION WHEN NO_DATA_FOUND THEN
               null;
            End;

---+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


            BEGIN
               SELECT i.ir
                 INTO pr_2600_
                 FROM int_ratn i, int_accn n
                WHERE i.acc = acc_2000
                  AND i.ID = 0
                  AND i.acc = n.acc
                  AND n.ID = i.ID
                  AND bdat =
                         (SELECT MAX (bdat)
                            FROM int_ratn i
                           WHERE acc = acc_2000 AND ID = 0
                                 AND bdat <= gl.bdate);
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  pr_2600_ := 0;
            END;

            BEGIN
               SELECT ir
                 INTO pr_komis_
                 FROM int_ratn i, int_accn n
                WHERE i.acc = acc_8000_
                  AND i.ID = 0
                  AND i.ID = n.ID
                  AND i.acc = n.acc
                  AND bdat =
                         (SELECT MAX (bdat)
                            FROM int_ratn
                           WHERE acc = acc_8000_ AND ID = 0
                                 AND bdat <= gl.bdate);
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  pr_komis_ := 0;
            END;

            IF pr_komis_ = 0
            THEN
               pr_komis_ := pr_2600_;
            END IF;

            pr_9129_ := acrn.fproc (acc_9129_, gl.bdate);
            pr_2069_ := acrn.fproc (acc_2069_, gl.bdate);

            UPDATE accounts
               SET tip = 'ODB'
            WHERE acc = acc_2000 AND tip = 'BLD';


            --Обнуление 9129

            SELECT acc, nls, SUBSTR (nms, 1, 38), ostc, kv
            INTO acc_, nls_, nms_, s_, kv_
            FROM accounts
            WHERE acc = acc_9129_;

----333---
        -- Kонтрсчет 9900 для проводки берем из карточки операции  OV-
        --    BEGIN
        --         SELECT NLSK, NAME
        --         INTO  nls9_,naz_
        --         FROM  tts
        --         WHERE tt=tt9_;
        --    EXCEPTION
        --         WHEN NO_DATA_FOUND
        --         THEN
        --            erm := '8012 - No defined # ' || tt9_;
        --            RAISE err;
        --    END;
        --    nls9_:=TRIM(nls9_);



            Select TOBO into tobo_a From Accounts Where ACC=acc_2000;

       --   Ищем 9900:  - как параметр TAG='OVR_9900'
       --               - как параметр TAG='NLS_9900'
       --               - счет 9900/00 на этом BRANCH-е

            Begin  Select VAL  into  nls9_   From   BRANCH_PARAMETERS  where  TAG='OVR_9900' and BRANCH=tobo_a;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               Begin Select VAL  into  nls9_   From   BRANCH_PARAMETERS   where  TAG='NLS_9900' and BRANCH=tobo_a;
               EXCEPTION WHEN NO_DATA_FOUND THEN                 nls9_:=NBS_OB22_NULL('9900','00', tobo_a);
               END;
            END;

            BEGIN SELECT acc,  SUBSTR(nms,1,38)   INTO acc9_, nms9_   FROM Accounts    WHERE NLS=nls9_  and  KV=kv_;
            EXCEPTION     WHEN NO_DATA_FOUND    THEN     erm := '8012 - No defined # ' || nls9_;   RAISE err;
            END;
       -------------------------------------

            naz_ := 'Обнулення 9129 в связку с закриттям договору овердрафту';

            IF s_ <> 0
            THEN
               txt_ := 'Урегулирование 9129';

               IF s_ < 0
               THEN
                  dk_ := 0;
                  s_ := 0 - s_;
               ELSE
                  dk_ := 1;
               END IF;

               gl.REF (ref_);
               gl.in_doc3 (ref_,
                           tt9_,
                           6,
                           ref_,
                           SYSDATE,
                           gl.bdate,
                           dk_,
                           kv_,
                           s_,
                           kv_,
                           s_,
                           NULL,
                           gl.bdate,
                           gl.bdate,
                           nms_,
                           nls_,
                           gl.amfo,
                           nms9_,
                           nls9_,
                           gl.amfo,
                           naz_,
                           NULL,
                           okpo_,
                           okpo_,
                           NULL,
                           NULL,
                           NULL,
                           NULL,
                           NULL
                          );
               gl.payv (ovr.getpo (tt9_),
                        ref_,
                        gl.bdate,
                        tt9_,
                        dk_,
                        kv_,
                        nls_,
                        s_,
                        kv_,
                        nls9_,
                        s_
                       );
            END IF;

            DELETE FROM acc_over
                  WHERE acc = acc_2000 AND sos = 1;

            UPDATE acc_over o
               SET acc_2067 = acc_2067_,
                   acc_2069 = acc_2069,
                   pr_2600a = pr_2600_,
                   pr_komis = pr_komis_,
                   pr_2069 = pr_2069_,
                   pr_9129 = pr_9129_
             WHERE acc = acc_2000;

            /*update accounts set dazs=gl.bdate
                      where acc in (acc_2008_,acc_2067_,acc_2069_,acc_2096_,acc_8000_,acc_9129_);*/

----  Закрытие 9129:  ----

            IF ovr.ovr_par_val ('DELACC') = 'TRUE'  then
               update accounts set DAZS=gl.bdate
                      where acc=acc_9129_;
            END IF;
--------------------------
            INSERT INTO acc_over_archive
                        (acc, acco, tipo, nd, DAY, flag, sos, datd, sd, ndoc,
                         vidd, datd2, krl, useostf, uselim, acc_9129,
                         acc_8000, obs, txt, userid, deleted, pr_2600a,
                         pr_komis, pr_9129, pr_2069, acc_2067, acc_2069,
                         acc_2096, deldate)
               SELECT acc, acco, tipo, nd, DAY, flag, sos, datd, sd, ndoc,
                      vidd, datd2, krl, useostf, uselim, acc_9129, acc_8000,
                      obs, txt, userid, deleted, pr_2600a, pr_komis, pr_9129,
                      pr_2069, acc_2067, acc_2069, acc_2096, SYSDATE
                 FROM acc_over
                WHERE acc = acc_2000;

            DELETE FROM acc_over
                  WHERE acc = acc_2000;


            Update ACCOUNTS set MDATE=null where ACC = acc_2000;

------------------------------------------------------------------------------
--96.OVR-S3: Перенос на сомнительную задолженость  (2096-2067, 2096-2069)

         ELSIF nmode_ = 96
         THEN
            naz_ :=
               'Перенесення просроченої заборгованностi на сумнiвну заборгованнiсть овердрафта';

            FOR k IN (SELECT a.nls, a.kv, SUBSTR (a.nms, 1, 38) nms, a.acc,
                             -a.ostc ost, a.grp, a.sec, a.seco, a.seci,
                             a.isp, a.mdate, NVL (a.lim, 0) lim, c.okpo,
                             c.rnk, o.ndoc, o.datd, c.nmk, o.acc_2096,
                             o.acc_2067, a.tobo
                        FROM accounts a, acc_over o, cust_acc u, customer c
                       WHERE o.acc = a.acc
                         AND u.acc = a.acc
                         AND c.rnk = u.rnk
                         AND a.mdate < gl.bdate
                         AND NVL (o.sos, 0) <> 1
                         AND a.nbs = ovr.f_nbs (o.acc, 2600)
                         AND (acc_2000 = 0 OR acc_2000 = o.acc)
                         AND o.tipo <> 200)
            LOOP
               SAVEPOINT do_provodki_8;
               nbs_ := ovr.f_nbs (k.acc, 2096);  -- пока неясен другой способ
               nbs9_ := ovr.f_nbs (k.acc, 2480);         -- для нач процентов

               BEGIN
                  dtxt_ :=
                        'Угода № '
                     || RTRIM (k.ndoc)
                     || ' вiд '
                     || TO_CHAR (k.datd, 'dd.mm.yyyy');

                  BEGIN
                     SELECT dazs
                       INTO dazs_
                       FROM accounts
                      WHERE acc = k.acc_2096;
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                        dazs_ := NULL;
                  END;

                  IF NVL (k.acc_2096, 0) = 0 OR dazs_ IS NOT NULL
                  THEN
                     SELECT s080
                       INTO s080_
                       FROM specparam
                      WHERE acc = k.acc;

                     nls_2096_ :=
                           nbs_
                        || '0'
                        || SUBSTR (NVL (f_newnls (k.acc, 'OV2096', ''), k.nls),
                                   6,
                                   9
                                  );
                     nls_2096_ := vkrzn (SUBSTR (mfo5_, 1, 5), nls_2096_);
                     nms_2096_ :=
                        SUBSTR ('Сумн_вна.заборг.' || k.ndoc || ' за оверд',
                                1,
                                38
                               );
                     ret1_ := 0;
                     txt_ := '1.Открытие ' || nls_2096_;
                     op_reg_ex (99,
                                0,
                                0,
                                k.grp,
                                ret1_,
                                k.rnk,
                                nls_2096_,
                                k.kv,
                                nms_2096_,
                                'ODB',
                                k.isp,
                                acc_2096_,
                                '1',
                                NULL,
                                NULL,
                                NULL,
                                NULL,
                                NULL,
                                NULL,
                                NULL,
                                NULL,
                                NULL,
                                NULL,
                                NULL,
                                k.tobo,
                                NULL
                               );
                     txt_ := '2.Обновление ' || nls_2096_;

                     UPDATE accounts
                        SET sec = k.sec,
                            blkd = 0,
                            mdate = k.mdate,
                            nms = nms_2096_,
                            dazs = NULL
                      WHERE acc = acc_2096_;


                        if a_grp_ > 0 then
                           SEC.addAgrp(acc_2096_, a_grp_);
                        end if;


                     UPDATE specparam
                        SET s080 = s080_
                      WHERE acc = acc_2096_;

                     BEGIN
                        SELECT acc
                          INTO ret1_
                          FROM specparam
                         WHERE acc = acc_2096_;
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           INSERT INTO specparam
                                       (acc, s080
                                       )
                                VALUES (acc_2096_, s080_
                                       );
                     END;

                     IF som_prc_ = 1
                     THEN
                        nls_2480_ :=
                              nbs9_
                           || '0'
                           || SUBSTR (NVL (f_newnls (k.acc, 'OV2480', ''),
                                           k.nls
                                          ),
                                      6,
                                      9
                                     );
                        nls_2480_ := vkrzn (SUBSTR (mfo5_, 1, 5), nls_2480_);
                        nms_2480_ :=
                           SUBSTR (   'Нарах % на сумн.заборг.'
                                   || k.ndoc
                                   || ' за оверд',
                                   1,
                                   38
                                  );
                        ret1_ := 0;
                        txt_ := '1.Открытие ' || nls_2480_;
                        op_reg_ex (99,
                                   0,
                                   0,
                                   k.grp,
                                   ret1_,
                                   k.rnk,
                                   nls_2480_,
                                   k.kv,
                                   nms_2480_,
                                   'ODB',
                                   k.isp,
                                   acc_2480_,
                                   '1',
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   k.tobo,
                                   NULL
                                  );
                        txt_ := '2.Обновление ' || nls_2480_;

                        UPDATE accounts
                           SET sec = k.sec,
                               blkd = 0,
                               mdate = k.mdate,
                               nms = nms_2480_,
                               dazs = NULL
                         WHERE acc = acc_2480_;

                        if a_grp_ > 0 then
                           SEC.addAgrp(acc_2480_, a_grp_);
                        end if;


                        BEGIN
                           SELECT acc
                             INTO ret1_
                             FROM int_accn
                            WHERE acc = acc_2096_ AND ID = 0;

                           --DBMS_OUTPUT.PUT_LINE(txt_);
                           UPDATE int_accn
                              SET acra = acc_2480_
                            WHERE acc = acc_2096_ AND ID = 0;
                        EXCEPTION
                           WHEN NO_DATA_FOUND
                           THEN
                              BEGIN
                                 BEGIN
                                    -----счет для нового БС NBS_
                                    SELECT a.acc
                                      INTO acc67_
                                      FROM accounts a, proc_dr p
                                     WHERE a.kv = k.kv
                                       AND p.nbs = nbs_
                                       AND p.g67 = a.nls;
                                 EXCEPTION
                                    WHEN NO_DATA_FOUND
                                    THEN
                                       acc67_ := NULL;
                                 END;

                                 txt_ := 'Создание % карты' || nls_2096_;

                                 ------ Создать проц. карточку
                                 INSERT INTO int_accn
                                             (acc, ID, metr, basem, basey,
                                              freq, tt, acra, acrb)
                                    SELECT acc_2096_, 0, metr, basem, basey,
                                           freq, tt, acc_2480_,
                                           NVL (acc67_, acrb)
                                      FROM int_accn
                                     WHERE acc = k.acc_2067 AND ID = 0;
                              END;
                        END;
                     END IF;
                  ELSE
                     SELECT acc, nls, nms
                       INTO acc_2096_, nls_2096_, nms_2096_
                       FROM accounts
                      WHERE acc = k.acc_2096;

                     IF som_prc_ = 1
                     THEN
                        BEGIN
                           SELECT a.nls, a.acc, a.nms
                             INTO nls_2480_, acc_2480_, nms_2480_
                             FROM accounts a, int_accn i
                            WHERE i.acc = k.acc_2096
                              AND i.acra = a.acc
                              AND i.ID = 0;
                        EXCEPTION
                           WHEN NO_DATA_FOUND
                           THEN
                              raise_application_error
                                   (- (20000 + ern),
                                    'Не создана процентная карта счета 2096',
                                    TRUE
                                   );
                        END;
                     END IF;
                  END IF;

                  IF som_prc_ = 1
                  THEN
                     BEGIN
                        SELECT acc
                          INTO ret1_
                          FROM int_ratn
                         WHERE acc = acc_2480_ AND bdat = gl.bdate;
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           ------проставить/добавить историю % ставки
                           txt_ := 'Внесение % став' || nls_2096_;

                           BEGIN
                              SELECT acc
                                INTO acc_2096_
                                FROM int_ratn
                               WHERE acc = acc_2096_
                                 AND ID = 0
                                 AND bdat = gl.bdate;
                           EXCEPTION
                              WHEN NO_DATA_FOUND
                              THEN
                                 INSERT INTO int_ratn
                                             (acc, ID, bdat, ir, br, op, idu)
                                    (SELECT acc_2096_, 0, gl.bdate, ir, br,
                                            op, idu
                                       FROM int_ratn
                                      WHERE acc = k.acc_2067
                                        AND ID = 0
                                        AND bdat =
                                               (SELECT MAX (bdat)
                                                  FROM int_ratn
                                                 WHERE bdat <= gl.bdate
                                                   AND acc = k.acc_2067
                                                   AND ID = 0));
                           END;
                     END;
                  ELSE
                     nls_2480_ := nls_2096_;
                     nms_2480_ := nms_2096_;
                     acc_2480_ := acc_2096_;
                  END IF;

                  UPDATE acc_over
                     SET acc_2096 = acc_2096_
                   WHERE acc = k.acc;

                  dtxt_ :=
                        'Угода '
                     || RTRIM (k.ndoc)
                     || ' вiд '
                     || TO_CHAR (k.datd, 'dd.mm.yyyy');
                  naz_ :=
                     SUBSTR
                        (   'Перенес. нар %% за просроч. на сумнiвну заборгованiсть'
                         || dtxt_
                         || ' '
                         || k.nmk,
                         1,
                         160
                        );

                  --- Размазывание обеспечения
                  Begin
                     INSERT INTO cc_accp
                              (acc, accs)
                     (SELECT acc, acc_2096_
                        FROM cc_accp
                       WHERE accs = k.acc
                         AND acc NOT IN (SELECT acc
                                           FROM cc_accp
                                          WHERE accs = acc_2096_));
                  EXCEPTION WHEN others THEN
                     null;
                  end;


                  IF som_prc_ = 1  THEN

                     Begin
                       INSERT INTO cc_accp
                                   (acc, accs)
                          (SELECT acc, acc_2480_
                             FROM cc_accp
                            WHERE accs = k.acc
                              AND acc NOT IN (SELECT acc
                                                FROM cc_accp
                                               WHERE accs = acc_2480_));
                     EXCEPTION WHEN others THEN
                         null;
                     End;

                  END IF;


                  --- 2069 -> 2480
                  BEGIN
                     SELECT a.acc, a.nls, SUBSTR (a.nms, 1, 38), a.ostc
                       INTO acc_2008_, nls_2008_, nms_2008_, ost_2008_
                       FROM accounts a, int_accn i, acc_over o
                      WHERE i.acra = a.acc
                        AND o.acc = k.acc
                        AND i.acc = o.acc_2067
                        AND NVL (o.sos, 0) <> 1
                        AND i.ID = 0
                        AND o.tipo <> 200;
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                        ost_2008_ := 0;
                  END;

                  IF ost_2008_ < 0
                  THEN
                     gl.REF (ref_);
               ----  ovr.p_oversob (k.acc, NULL, ref_, 14, ABS (ost_2008_), NULL);
                     gl.in_doc3 (ref_,
                                 'OVR',
                                 6,
                                 ref_,
                                 SYSDATE,
                                 gl.bdate,
                                 1,
                                 k.kv,
                                 ABS (ost_2008_),
                                 k.kv,
                                 ABS (ost_2008_),
                                 NULL,
                                 gl.bdate,
                                 gl.bdate,
                                 nms_2480_,
                                 nls_2480_,
                                 mfo5_,
                                 nms_2008_,
                                 nls_2008_,
                                 mfo5_,
                                 naz_,
                                 NULL,
                                 k.okpo,
                                 k.okpo,
                                 NULL,
                                 NULL,
                                 NULL,
                                 NULL,
                                 NULL
                                );
                     gl.payv (ovr.getpo ('OVR'),
                              ref_,
                              gl.bdate,
                              'OVR',
                              1,
                              k.kv,
                              nls_2480_,
                              ABS (ost_2008_),
                              k.kv,
                              nls_2008_,
                              ABS (ost_2008_)
                             );

                     UPDATE opldok
                        SET txt = SUBSTR (naz_, 1, 70)
                      WHERE REF = ref_ AND stmt = gl.astmt;
                  END IF;

                  --- 2067 -> 2096
                  naz_ :=
                     SUBSTR
                         (   'Перенес. просроч. заборг. на сумнiвну. заборг '
                          || dtxt_
                          || ' '
                          || k.nmk,
                          1,
                          160
                         );

                  SELECT a.acc, a.nls, SUBSTR (a.nms, 1, 38), a.ostc
                    INTO acc_2001_, nls_2001_, nms_2001_, ost_2001_
                    FROM accounts a, acc_over o
                   WHERE a.acc = o.acc_2067
                     AND k.acc = o.acc
                     AND NVL (o.sos, 0) <> 1;

                  IF ost_2001_ < 0
                  THEN
                     gl.REF (ref_);
                ---- ovr.p_oversob (k.acc, NULL, ref_, 15, ABS (ost_2001_), NULL);
                     gl.in_doc3 (ref_,
                                 'OVR',
                                 6,
                                 ref_,
                                 SYSDATE,
                                 gl.bdate,
                                 1,
                                 k.kv,
                                 ABS (ost_2001_),
                                 k.kv,
                                 ABS (ost_2001_),
                                 NULL,
                                 gl.bdate,
                                 gl.bdate,
                                 nms_2096_,
                                 nls_2096_,
                                 mfo5_,
                                 nms_2001_,
                                 nls_2001_,
                                 mfo5_,
                                 naz_,
                                 NULL,
                                 k.okpo,
                                 k.okpo,
                                 NULL,
                                 NULL,
                                 NULL,
                                 NULL,
                                 NULL
                                );
                     gl.payv (ovr.getpo ('OVR'),
                              ref_,
                              gl.bdate,
                              'OVR',
                              1,
                              k.kv,
                              nls_2096_,
                              ABS (ost_2001_),
                              k.kv,
                              nls_2001_,
                              ABS (ost_2001_)
                             );

                     UPDATE opldok
                        SET txt = SUBSTR (naz_, 1, 70)
                      WHERE REF = ref_ AND stmt = gl.astmt;
                  END IF;
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     ROLLBACK TO do_provodki_8;

                     BEGIN
                        INSERT INTO tmp_ovr
                                    (dat, ID, dk, nlsa, nlsb,
                                     s, txt
                                    )
                             VALUES (gl.bdate, 2, 1, nls_2096_, k.nls,
                                     k.ost, txt_
                                    );

                        GOTO kin_2;
                     END;
               END;

               <<kin_2>>
               NULL;
            END LOOP;

            RETURN;
         END IF;
      END IF;
   EXCEPTION
      WHEN err
      THEN
         raise_application_error (- (20000 + ern), '\' || erm, TRUE);
   -- WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-(20000+ern),SQLERRM,TRUE);
   END p_ovr8z;

----======================================================================
----========================   END p_ovr8z    ============================
----======================================================================


--  Вставка событий по овердрафтам в cc_sob.

   PROCEDURE p_oversob (
      acc_     NUMBER,
      nd_      NUMBER,
      ref_     NUMBER,
      sob_     NUMBER,
      s_       NUMBER,
      mdate_   DATE
   )
   IS
      nd2_      acc_over.nd%TYPE;
      ndoc_     acc_over.ndoc%TYPE;
      userid_   NUMBER;
      txt_      VARCHAR2 (4000);
      nls_      VARCHAR (15);
      kv_       NUMBER;
   BEGIN
      IF nd_ IS NULL
      THEN
         check_ovr (acc_, nd2_, ndoc_);
      ELSE
         nd2_ := nd_;
      END IF;

      BEGIN
         SELECT txt
           INTO txt_
           FROM acc_over_sobtype
          WHERE ID = sob_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            RETURN;
      END;

      IF sob_ = 1 OR sob_ = 2
      THEN
         NULL;
      ELSIF sob_ = 3
      THEN
         txt_ := txt_ || ' ' || TO_CHAR (mdate_, 'dd.mm.yyyy');
      ELSIF sob_ = 4
      THEN
         txt_ := txt_ || ' s =' || TO_CHAR (s_ / 100);
      ELSIF sob_ = 5
      THEN
         txt_ := txt_ || ' s =' || TO_CHAR (s_ / 100);
      ELSIF sob_ = 6
      THEN
         txt_ :=
             txt_ || ' ref =' || TO_CHAR (ref_) || ' s='
             || TO_CHAR (s_ / 100);
      ELSIF sob_ = 7
      THEN
         NULL;
      ELSIF sob_ = 8
      THEN
         txt_ :=
             txt_ || ' ref =' || TO_CHAR (ref_) || ' s='
             || TO_CHAR (s_ / 100);
      ELSIF sob_ = 9
      THEN
         NULL;
      ELSIF sob_ = 10
      THEN
         txt_ := txt_ || ' lim =' || TO_CHAR (s_ / 100);
      ELSIF sob_ = 11
      THEN
         check_ovr2 (acc_, nls_, kv_);
         txt_ := txt_ || ' nls =' || nls_ || ', kv=' || TO_CHAR (kv_);
      ELSIF sob_ = 12
      THEN
         check_ovr2 (acc_, nls_, kv_);
         txt_ := txt_ || ' nls =' || nls_ || ', kv=' || TO_CHAR (kv_);
      ELSIF sob_ = 14
      THEN
         txt_ :=
             txt_ || ' ref =' || TO_CHAR (ref_) || ' s='
             || TO_CHAR (s_ / 100);
      ELSIF sob_ = 15
      THEN
         txt_ :=
             txt_ || ' ref =' || TO_CHAR (ref_) || ' s='
             || TO_CHAR (s_ / 100);
      END IF;

      userid_ := user_id;

      INSERT INTO cc_sob
                  (nd, fdat, isp, txt, otm, freq, psys
                  )
           VALUES (nd2_, bankdate, userid_, txt_, NULL, NULL, NULL
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         IF nd2_ IS NOT NULL
         THEN
            INSERT INTO cc_sob
                        (nd, fdat, isp,
                         txt,
                         otm, freq, psys
                        )
                 VALUES (nd2_, bankdate, userid_,
                         'ошибка генерации события ' || TO_CHAR (sob_),
                         NULL, NULL, NULL
                        );
         END IF;
   END p_oversob;

--------------------------------------------------------------------------------

   PROCEDURE check_ovr (acc_ NUMBER, nnd_ OUT NUMBER, ndc_ OUT VARCHAR2)
   IS
      PRAGMA AUTONOMOUS_TRANSACTION;
   BEGIN
      SELECT nd, ndoc
        INTO nnd_, ndc_
        FROM acc_over
       WHERE acc = acc_ AND NVL (sos, 0) <> 1 AND tipo <> 200;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         nnd_ := 0;
   END;
--------------------------------------------------------------------------------

   PROCEDURE check_ovr2 (acc_ NUMBER, nls_ OUT VARCHAR2, kv_ OUT NUMBER)
   IS
      PRAGMA AUTONOMOUS_TRANSACTION;
   BEGIN
      SELECT nls, kv
        INTO nls_, kv_
        FROM accounts
       WHERE acc = acc_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         nls_ := NULL;
         kv_ := NULL;
   END;

--------------------------------------------------------------------------------

   PROCEDURE p_tmp_agx (dat1_ DATE, dat2_ DATE)
   IS
      vost_   NUMBER (24);
      sn_     NUMBER (24);
      su_     NUMBER (24);
      sp_     NUMBER (24);
      ost_    NUMBER (24);
   BEGIN
      DELETE FROM tmp_agx;

      FOR k IN (SELECT o.nd, o.ndoc, i.acra acc, a.isp, c.rnk, m.nmk, a.nls
                  FROM (SELECT nd, ndoc, acco
                          FROM acc_over
                         WHERE NVL (sos, 0) <> 1
                        UNION ALL
                        SELECT nd, ndoc, acco
                          FROM acc_over_archive
                         WHERE NVL (sos, 0) <> 1) o,
                       int_accn i,
                       accounts a,
                       cust_acc c,
                       customer m
                 WHERE o.acco = i.acc
                   AND i.acra = a.acc
                   AND a.acc = c.acc
                   AND m.rnk = c.rnk)
      LOOP
         SELECT NVL (SUM (DECODE (dk, 1, s, 0, -s)), 0)
           INTO vost_
           FROM opldok
          WHERE acc = k.acc AND sos = 5 AND fdat < dat1_;

         SELECT NVL (SUM (s), 0)
           INTO sn_
           FROM opldok
          WHERE acc = k.acc AND dk = 0 AND fdat >= dat1_ AND fdat <= dat2_;

         SELECT NVL (SUM (p1.s), 0)
           INTO su_
           FROM opldok p1, opldok p2, accounts a
          WHERE p1.acc = k.acc
            AND p1.dk = 1
            AND p1.REF = p2.REF
            AND p1.stmt = p2.stmt
            AND p2.dk = 0
            AND p2.acc = a.acc
            AND a.nbs <> 2069
            AND p1.sos = 5
            AND p1.fdat >= dat1_
            AND p1.fdat <= dat2_;

         SELECT NVL (SUM (p1.s), 0)
           INTO sp_
           FROM opldok p1, opldok p2, accounts a
          WHERE p1.acc = k.acc
            AND p1.dk = 1
            AND p1.REF = p2.REF
            AND p1.stmt = p2.stmt
            AND p2.dk = 0
            AND p2.acc = a.acc
            AND a.nbs = 2069
            AND p1.sos = 5
            AND p1.fdat >= dat1_
            AND p1.fdat <= dat2_;

         SELECT NVL (SUM (DECODE (dk, 1, s, 0, -s)), 0)
           INTO ost_
           FROM opldok
          WHERE acc = k.acc AND sos = 5 AND fdat < dat2_;

         IF sn_ > 0 OR su_ > 0 OR sp_ > 0
         THEN
            INSERT INTO tmp_agx
                        (nd, ndoc, nmk, isp, rnk, nls, vost,
                         sn, su, sp, ost
                        )
                 VALUES (k.nd, k.ndoc, k.nmk, k.isp, k.rnk, k.nls, vost_,
                         sn_, su_, sp_, ost_
                        );
         END IF;
      END LOOP;

      COMMIT;
   END;
--------------------------------------------------------------------------------

   FUNCTION ovr_par_val (par_ VARCHAR)
      RETURN VARCHAR2
   IS
      val_   VARCHAR2 (50);
   BEGIN
      BEGIN
         SELECT val
           INTO val_
           FROM acc_over_par
          WHERE par = par_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            val_ := NULL;
      END;

      RETURN val_;
   END;
--------------------------------------------------------------------------------

   FUNCTION int_per (dat_ DATE, acc_ INT, br_id_ INT)
      RETURN NUMBER
   IS
      num_days   NUMBER;
      rate_      NUMBER;
   BEGIN
      SELECT dat_ - MAX (fdat) + 1
        INTO num_days
        FROM saldoa
       WHERE ostf >= 0 AND acc = acc_ AND fdat <= dat_
             AND ostf - dos + kos < 0;

      BEGIN
         SELECT rate
           INTO rate_
           FROM acc_over_intper
          WHERE num_days BETWEEN lim1 AND lim2 AND br_id_ = br_id;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            rate_ := 0;
      END;

      RETURN rate_;
   END;
--------------------------------------------------------------------------------

   FUNCTION f_nbs (acc_ INT, nbs_par INT)      RETURN VARCHAR   IS
      nbs2600_   VARCHAR (4);
      nbs2000_   VARCHAR (4);
      nbs2607_   VARCHAR (4);
      nbs2067_   VARCHAR (4);
      nbs2069_   VARCHAR (4);
      nbs2096_   VARCHAR (4);
      nbs2480_   VARCHAR (4);
      nbs9129_   VARCHAR (4);
   BEGIN
      SELECT SUBSTR (nls, 1, 4)        INTO nbs2600_        FROM accounts       WHERE acc = acc_;

      BEGIN
         SELECT NVL(nbs2600,   '2600')    ,  NVL(nbs2000,  '2000'),     NVL(nbs2607,'2607'), 
                NVL(nbs2067, SB_2067.R020),  NVL(nbs2069,SB_2069.R020), NVL(nbs2096, '2096'),   NVL (nbs2480, '2480'), NVL (nbs9129, '9129')
         INTO nbs2600_, nbs2000_,  nbs2607_, nbs2067_,  nbs2069_, nbs2096_,  nbs2480_, nbs9129_
         FROM acc_over_nbs          WHERE nbs2600 = nbs2600_;
      EXCEPTION WHEN NO_DATA_FOUND THEN   nbs2000_ :=   '2000';       nbs2607_ :=   '2607';  
                                          nbs2067_ := SB_2067.R020;   nbs2069_ := SB_2069.R020; nbs2096_ := '2096'; nbs2480_ := '2480';  nbs9129_ := '9129';
      END;

      IF    nbs_par = 2600 THEN  RETURN nbs2600_;  ELSIF nbs_par = 2000  THEN  RETURN nbs2000_;  ELSIF nbs_par = 2607 THEN  RETURN nbs2607_;  ELSIF nbs_par = 2067  THEN  RETURN nbs2067_;
      ELSIF nbs_par = 2069 THEN  RETURN nbs2069_;  ELSIF nbs_par = 2096  THEN  RETURN nbs2096_;  ELSIF nbs_par = 2480 THEN  RETURN nbs2480_;  ELSIF nbs_par = 9129  THEN  RETURN nbs9129_;
      END IF;

      RETURN NULL;
   END;
--------------------------------------------------------------------------------

   FUNCTION getpo (tt_ VARCHAR2)      RETURN NUMBER   IS      po   NUMBER;
   BEGIN    BEGIN         SELECT TO_NUMBER (SUBSTR (flags, 38, 1))           INTO po           FROM tts          WHERE tt = tt_;      
            EXCEPTION         WHEN NO_DATA_FOUND         THEN            po := 1;
            END;
     RETURN po;
   END;

-------------------------------------------------------------------
   PROCEDURE int_ovrp (
      nacc_          INT,                                    -- для передачи в
      nid            INT,  -- acrn.p_int(nAcc,nId,dDat1,dDat2,nInt,nOst,nMode)
      ddat1          DATE,                                                   --
      ddat2_         DATE,                                                   --
      nint     OUT   NUMBER,                               -- Interest accrued
      nost           NUMBER,
      nmode          INT
   )
   IS
-- 03.01.2006 Если был только вход и больше нет движ
-- Сухова  03.10.2005. STA исправлено для включения в пакедж
-- заказанов ПЕТРОКОМЕРЦ см пачч patcD42.ovr

      ntmp_          INT;
      dat1_          DATE;                                 --дата входa в овр
      dat11_         DATE;                                 --дата входa в овр
      dat2_          DATE;                               --дата выхода из овр
      kol_           INT;      --количество дней беспрерывного пользования Ов
      ir_            NUMBER;                                       --% ставка
      kol1_          INT; --кол дней беспрерывного пользования в пред периоде
      ir1_           NUMBER;                              --% ст пред периода
      kol2_          INT;      --количество дней беспрерывного пользования Ов
      ir2_           NUMBER;                               --% ст тек периода
      ir22_          NUMBER;                               --% ст тек периода
      s_             NUMBER;                               --сумма к проводке
      nazn_          VARCHAR2 (160) := '';
      ern   CONSTANT POSITIVE       := 203;
      erm            VARCHAR2 (80);
      err            EXCEPTION;
   BEGIN
-- Анализируем те счета, которые имеют признак начисления по-новому (?)

If Nvl(GetGlobalOption('OB22'),'0') <> '1' then goto NO_OB; end if;
--------------------------------------------------------------------
--15/06/2009 Sta  Плавающая ставка в РУ ОБ



--                 Переход на новую ШКАЛУ №2
--                 =========================
--
--      Меняем в двух местах:           NVL(i.IDR,1)  -->  NVL(i.IDR,2)

FOR k IN (SELECT NVL(i.acr_dat, a.daos - 1) acr_dat, a.kv, NVL(i.IDR,2) idr
          FROM int_accn i, accounts a
          WHERE i.acc = a.acc   AND i.ID = 0  AND i.metr = 7
            AND i.acc = nacc_   AND NVL (i.acr_dat, a.daos - 1) < ddat2_
         )
LOOP
 --очистим ставки для периода начисления
 DELETE FROM int_ratn WHERE acc = nacc_ AND ID = 0 AND bdat > k.acr_dat;
 IR1_ := -1;

 -- сканируем все дни от пред до тек начисления
 for f in (select FDAT
           from ( select (k.acr_dat+c.num) FDAT from conductor c
                  where  (k.acr_dat+c.num) <=ddat2_ )
           where fost(nacc_, FDAT ) < 0   order by FDAT
          )
 LOOP

   -- последняя дата входа в овр
   select max(fdat) into dat1_ from saldoa
   where fdat<=f.FDAT and acc=nacc_ and  ostf>=0 ;

   kol_:= f.FDAT - dat1_ +1;

   begin
     -- ставка нового дня
     SELECT NVL(ir,IR1_) INTO IR2_
     FROM (SELECT ir,dni FROM int_ovr WHERE kv=k.kv AND ID=k.idr ORDER BY dni)
     WHERE ROWNUM = 1 AND dni >= KOL_ ;

     -- если поменялась, то запомнить
     If IR1_ <> IR2_ then
        INSERT INTO int_ratn (acc,ID,bdat,ir) VALUES (nacc_,0,f.FDAT,IR2_);
        IR1_:= IR2_;
     end if;
   EXCEPTION  WHEN NO_DATA_FOUND THEN null;
   end;

 end loop;

end loop;

--начис %
  UPDATE int_accn  SET metr = 0  WHERE acc = nacc_ AND ID = 0;
  acrn.p_int (nacc_, nid, ddat1, ddat2_, nint, TO_NUMBER (NULL), nmode);
  UPDATE int_accn  SET metr = 7  WHERE acc = nacc_ AND ID = 0;

RETURN;
-----------------------------------
<<NO_OB>> null;
      FOR k IN (SELECT NVL (i.acr_dat, a.daos - 1) acr_dat, i.acc, a.kv,
                       a.daos, NVL(i.IDR,2) idr
                  FROM int_accn i, accounts a
                 WHERE i.acc = a.acc
                   AND i.ID = 0
                   AND i.metr = 7
                   AND i.acc = nacc_
                   AND NVL (i.acr_dat, a.daos - 1) < ddat2_)
      LOOP

-- Часть 1. Доначисление % и изменение % ставки задним числом если
--          период беспрерывного пользования (DAT1_...ACR_DAT...DAT2)
-- надо ли делать по этому счету ДОначисление %
         BEGIN
            logger.info (   'INT_OVRP-1. Acc='
                         || k.acc
                         || ', Дата пред.нач ACR_DAT='
                         || k.acr_dat
                         || ', код шкалы IDR='
                         || k.idr
                        );
            s_ := 0;

            UPDATE int_accn
               SET metr = 0
             WHERE acc = nacc_ AND ID = 0;

            SELECT 1
              INTO kol_
              FROM saldoa s
             WHERE s.acc = k.acc
               AND (s.acc, s.fdat) =
                                    (SELECT   acc, MAX (fdat)
                                         FROM saldoa
                                        WHERE acc = s.acc
                                              AND fdat <= k.acr_dat
                                     GROUP BY acc)
               AND (s.ostf - s.dos + s.kos) < 0;

            ------------ ДА !
            BEGIN
               SELECT NVL (MAX (fdat), k.daos)
                 INTO dat1_
                 FROM saldoa
                WHERE acc = k.acc
                  AND ostf - dos + kos < 0
                  AND ostf >= 0
                  AND fdat <= k.acr_dat;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  dat1_ := k.daos;
            END;

            logger.info ('INT_OVRP-2. Дата послед.входа в ОВР DAT1_=' || dat1_);
            kol1_ := k.acr_dat - dat1_ + 1;
            logger.info
                    (   'INT_OVRP-3. Кол дней овр в пред.периоде нач % KOL1_='
                     || kol1_
                    );

            BEGIN
               SELECT NVL (MIN (fdat) - 1, ddat2_)
                 INTO dat2_
                 FROM saldoa
                WHERE acc = k.acc
                  AND ostf - dos + kos >= 0
                  AND ostf < 0
                  AND fdat > k.acr_dat
                  AND fdat <= ddat2_;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  dat2_ := ddat2_;
            END;

            logger.info
                    (   'INT_OVRP-4. Дата выхода из овд или дата нач % DAT2_='
                     || dat2_
                    );
            kol2_ := dat2_ - dat1_ + 1;
            logger.info (   'INT_OVRP-5. Кол-во известных дней овр KOL2_= '
                         || kol2_
                        );

            -- % ст пред периода
            SELECT ir
              INTO ir1_
              FROM (SELECT   ir, dni
                        FROM int_ovr
                       WHERE kv = k.kv AND ID = k.idr
                    ORDER BY dni)
             WHERE ROWNUM = 1 AND dni >= kol1_;

            logger.info ('INT_OVRP-6. % ст пред периода IR1_= ' || ir1_);

            -- % ст тек периода
            SELECT ir
              INTO ir2_
              FROM (SELECT   ir, dni
                        FROM int_ovr
                       WHERE kv = k.kv AND ID = k.idr
                    ORDER BY dni)
             WHERE ROWNUM = 1 AND dni >= kol2_;

            logger.info ('INT_OVRP-7. % ст тек периода IR2_= ' || ir2_);

            IF kol1_ > 0 AND kol2_ > kol1_
            THEN
               --разница
               ir_ := ir2_ - ir1_;

               IF ir_ > 0
               THEN
                  --расчитать % за период с DAT1_ по k.ACR_DAT вкл по ставке IR_,
                  --временно модифицировав % ствку
                  UPDATE int_ratn
                     SET ir = ir_
                   WHERE acc = k.acc AND ID = 0 AND bdat = dat1_;

                  IF SQL%ROWCOUNT = 0
                  THEN
                     INSERT INTO int_ratn
                                 (acc, ID, bdat, ir
                                 )
                          VALUES (k.acc, 0, dat1_, ir_
                                 );
                  END IF;

                  logger.info ('INT_OVRP-8. Доначислить по ставке IR_= '
                               || ir_
                              );
                  acrn.p_int (k.acc,
                              0,
                              dat1_,
                              k.acr_dat,
                              s_,
                              TO_NUMBER (NULL),
                              0
                             );
                  ir22_ := ir_;
                  dat11_ := dat1_;
               END IF;
            END IF;

            UPDATE int_ratn
               SET ir = ir2_
             WHERE acc = k.acc AND ID = 0 AND bdat = dat1_;

            IF SQL%ROWCOUNT = 0
            THEN
               INSERT INTO int_ratn
                           (acc, ID, bdat, ir
                           )
                    VALUES (k.acc, 0, dat1_, ir2_
                           );
            END IF;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               NULL;
         END;

         -- Часть 2. Формирование графика % ставки для последующего использования
         --          в обычном начислении процентов
         --          для переменных периодов беспрерывного пользования (DAT1_...DAT2_),
         --          где DAT1_ > ACR_DAT
         dat1_ := NULL;

         DELETE FROM int_ratn
               WHERE acc = k.acc AND ID = 0 AND bdat > k.acr_dat;

-- 03.01.2006  Последняя дата теперь есть всегда в курсоре
         FOR k1 IN (SELECT   fdat, pdat, ostf vst, ostf - dos + kos ost
                        FROM saldoa
                       WHERE acc = k.acc AND fdat > k.acr_dat
                             AND fdat < ddat2_
                    UNION ALL
                    SELECT   fdat, dapp, ost - kos + dos vst, ost
                        FROM sal
                       WHERE acc = k.acc AND fdat > k.acr_dat
                             AND fdat = ddat2_
                    ORDER BY 1)
         LOOP
            IF k1.vst >= 0 AND k1.ost < 0  THEN
               --начало периода, запомнить дату начала
               kol_ := 1;
               dat1_ := k1.fdat;
            ELSIF k1.vst < 0 AND k1.ost >= 0
                  OR k1.fdat = ddat2_ AND k1.ost < 0 THEN
               --завершение периода ИЛИ последний незавершенный период
               kol_ := kol_ + (k1.fdat - k1.pdat);

               IF k1.ost >= 0   THEN
                  dat2_ := k1.fdat - 1;
                  kol_ := kol_ - 1;
               END IF;
            ELSIF k1.vst < 0 AND k1.ost < 0      THEN
               -- продолжение периода
               kol_ := kol_ + (k1.fdat - k1.pdat);
            END IF;

            IF    k1.vst < 0 AND k1.ost >= 0 AND dat1_ > k.acr_dat
               OR k1.fdat = ddat2_ AND k1.ost < 0 AND dat1_ IS NOT NULL  THEN
               BEGIN
                  -- % ст периода
                  SELECT ir
                    INTO ir_
                    FROM (SELECT   ir, dni
                              FROM int_ovr
                             WHERE kv = k.kv AND ID = k.idr
                          ORDER BY dni)
                   WHERE ROWNUM = 1 AND dni >= kol_;

                  logger.info (   'INT_OVRP-9. Новая ставка с DAT1_='
                               || dat1_
                               || ' IR_ ='
                               || ir_
                              );

                  INSERT INTO int_ratn
                              (acc, ID, bdat, ir
                              )
                       VALUES (k.acc, 0, dat1_, ir_
                              );
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     NULL;
               END;
            END IF;
         END LOOP;

         --начис %
         acrn.p_int (nacc_, nid, ddat1, ddat2_, nint, TO_NUMBER (NULL), nmode);

         UPDATE int_accn
            SET metr = 7
          WHERE acc = k.acc AND ID = 0;

         IF s_ < 0 AND nmode = 1
         THEN
            --донач %
            INSERT INTO acr_intn
                        (acc, ID, fdat, tdat, ir, br, acrd
                        )
                 VALUES (k.acc, 0, dat11_, k.acr_dat, ir22_, 0, s_
                        );
         END IF;
      END LOOP;

   END int_ovrp;

----------------------------------------------------------------------------

   PROCEDURE mdate_9129 (aa_ NUMBER)
   IS
   BEGIN
      FOR k IN (SELECT a.mdate, o.acc_9129
                  FROM acc_over o, accounts a
                 WHERE NVL (o.sos, 0) != 1 AND o.acc = a.acc)
      LOOP
         UPDATE accounts
            SET mdate = k.mdate
          WHERE k.acc_9129 = acc;
      END LOOP;
   END;
  
---------------------------------------------------------------

  Function pay_date  ( p_date  in  fdat.fdat%type,    p_pday  in  acc_over.pr_2600a%type  default NULL  ) return date  is    l_paydat  fdat.fdat%type;
  Begin
    If (p_pday > 0) then   Select  min(FDAT)  Into  l_paydat  From  FDAT  Where FDAT >= (trunc(p_date,'MM') + p_pday - 1 );
    Else                   Select  min(FDAT)  into  l_paydat  from  FDAT  where FDAT > (Select min(FDAT) from FDAT where FDAT >= p_date);
    End If;
    Return l_paydat;
  End pay_date;
---------------------------------------------------------------
  FUNCTION header_version    RETURN VARCHAR2  IS  BEGIN    RETURN 'Package header CCK ' || g_header_version;   END header_version;
  FUNCTION body_version    RETURN VARCHAR2  IS  BEGIN    RETURN 'Package body CCK ' || g_body_version;  END body_version;

---Аномимный блок --------------
begin

 begin select 0 into OVR.G_2017 from SB_OB22  where         r020  = '2067'      and ob22  = '01'   and d_close is null ;
       SB_2067.R020 := '2067';   SB_2067.OB22 := '01' ; -- короткостроковў кредити в поточну дўяльнўсть
       SB_2069.R020 := '2069';   SB_2069.OB22 := '04' ; -- простроченў нарахованў доходи за короткостроковими кредитами в поточну дўяльнўсть
       SB_6020.R020 := '6020';   SB_6020.ob22 := '06' ; -- за рахунками клўїнтўв банку за овердрафтом в нацўональнўй валютў (рахунок 2600)
       SB_6111.R020 := '6111';   SB_6111.ob22 := '05' ; -- за супроводження кредитів, наданих юридичним особам та іншим суб`єктам підприємницької діяльності
       SB_3579.R020 := '3579';   SB_3579.ob22 := '91' ; -- за нарахованими доходами за кредитами овердрафт, що неотримані від суб"єктів господарювання
 EXCEPTION WHEN NO_DATA_FOUND THEN OVR.G_2017 := 1;  
       SB_2067.R020 := '2063';   SB_2067.OB22 := '33' ; -- короткостроковў кредити в поточну дўяльнўсть                                     
       SB_2069.R020 := '2068';   SB_2069.OB22 := '46' ; -- простроченў нарахованў доходи за короткостроковими кредитами в поточну дўяльнўсть
       SB_6020.R020 := '6020';   SB_6020.ob22 := '06' ; -- за рахунками клўїнтўв банку за овердрафтом в нацўональнўй валютў (рахунок 2600)
       SB_6111.R020 := '6511';   SB_6111.ob22 := '05' ; -- за супроводження кредитів, наданих юридичним особам та іншим суб`єктам підприємницької діяльності
       SB_3579.R020 := '3578';   SB_3579.ob22 := '55' ; --прострочені нараховані доходи за кредитами овердрафт, що неотримані від суб"єктів господарювання	
 end ;




END ovr;
/

show err