

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CP_HIERARCHY_REPORT.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CP_HIERARCHY_REPORT ***

  CREATE OR REPLACE PROCEDURE BARS.P_CP_HIERARCHY_REPORT (
   p_ID       IN INT,                              -- какую ЦБ   ( или все =0)
   p_dat1     IN DATE,                                                    -- з
   p_dat2     IN DATE,                                             -- дата  по
   p_reg      IN INT DEFAULT 0,
   p_period   IN VARCHAR2 DEFAULT NULL)
IS
   title            VARCHAR2(23)      := 'p_cp_hierarchy_report: ';
   l_errmsg         VARCHAR2(500);
   l_errcode        NUMBER;

   l_mdl            VARCHAR2(20)      := 'CPN';
   l_trace          VARCHAR2(1000)    := '';
   l_userid         INT               := user_id;
   n1               INT               := 0;       -- количество вставленных записей в tmp_cp_work для логирования

   tr               CP_HIERARCHY_REPORT%ROWTYPE;-- коллекция для записи в итоговую таблицу
   cpdeal_main_row  cp_deal%ROWTYPE;            -- обрабатываемый пакет
   cpdeal_saled_row cp_deal%ROWTYPE;            -- это строка при продаже пакета
   cpdeal_moved_row cp_deal%ROWTYPE;            -- это строка при перемещении пакета

   l_per            VARCHAR2 (3);               -- период построения отчета
   l_ref_main       oper.REF%TYPE     := null;  -- референс самого родительского пакета, но он нигде не вычитывается

    TYPE t_transaccounts IS record              -- настройки и реквизиты транзитных счетов
      (nls_3739       accounts.nls%type,
       acc_3739       accounts.acc%type,
       nls_3739_980   accounts.nls%type,
       acc_3739_980   accounts.acc%type,
       nls_3739_840   accounts.nls%type,
       acc_3739_840   accounts.acc%type,
       nls_3739_978   accounts.nls%type,
       acc_3739_978   accounts.acc%type,
       nls_3739_826   accounts.nls%type,
       acc_3739_826   accounts.acc%type);
   l_transaccount t_transaccounts;

   /*суммы составляющих при покупке*/
   N_buy          NUMBER    := 0;
   D_buy          NUMBER    := 0;
   P_buy          NUMBER    := 0;
   R_buy          NUMBER    := 0;                 -- tr.r0
   S_buy          NUMBER    := 0;

   nm_pr                    VARCHAR2 (30);        -- наименование контрагента tr.g015
   l_ref_pr                 oper.REF%TYPE;        -- референс продажи пакета
   l_ref_pr_9               oper.REF%TYPE;        -- референс продажи пакета спомогательный  ХЗ нафига
   l_ref_sale_repay         oper.REF%TYPE;        -- референс продажи/погашения
   l_ref2                   oper.REF%TYPE;        -- вспомогательный референс продажи - через циклы и года
   l_ref_pr_7               oper.REF%TYPE;        -- вспомогательный и ОН НИЧЕГО НЕ ПРИНИМАЕТ ВСЕГДА ПУСТО!!!!!!
   l_ref_g                  oper.REF%TYPE;        -- вспомогательный референс для записи в лог и только

   s_pr_op                  opldok.s%TYPE;        -- сума угоди продажу всього пакета
   s_63                     opldok.s%TYPE;        -- сумма покупки
   s_kupl_op                opldok.s%TYPE;

   l_kv                     accounts.kv%TYPE;
   l_kv_filtr               accounts.kv%TYPE;

   -- остатки
   SN_            NUMBER    := 0;
   SD_            NUMBER    := 0;
   SP_            NUMBER    := 0;
   SS_            NUMBER    := 0;
   SR_            NUMBER    := 0;
   SR2_           NUMBER    := 0;
   -- эквиваленты остатков
   SN_Q           NUMBER    := 0;
   SD_Q           NUMBER    := 0;
   SP_Q           NUMBER    := 0;
   SS_Q           NUMBER    := 0;
   SR_Q           NUMBER    := 0;
   SR2_Q          NUMBER    := 0;

   SN_31          NUMBER;
   SD_31          NUMBER;
   SP_31          NUMBER;
   SS_31          NUMBER;
   SR_31          NUMBER;
   SR2_31         NUMBER;
   SDV_31         NUMBER;
   SPV_31         NUMBER;
   SZ_31          NUMBER;

   SN_31Q         NUMBER;
   SD_31Q         NUMBER;
   SP_31Q         NUMBER;
   SS_31Q         NUMBER;
   SR_31Q         NUMBER;
   SR2_31Q        NUMBER;
   SDV_31Q        NUMBER;
   SPV_31Q        NUMBER;

   sumb_pr        NUMBER;
   sumb_pr_7      NUMBER;

   -- обороти
   OKN_K          NUMBER;
   --------------------
   t_date_report          DATE  := bankdate;                -- дата формирования
   l_date_start           DATE  := NVL(p_dat1, bankdate);   -- начало периода формирования отчета
   l_day_befor_start      DATE  := l_date_start - 1;
   l_date_finish          DATE  := NVL(p_dat2, bankdate);   -- конец периода формирования отчета
   l_dat_pr               DATE;                             -- дата продажи/перемещения? пакета
   l_dat_mv               DATE;                             -- вспомогательная дата как индикатор операции по перемещению

   l_dat_k        DATE;
   l_dat_k2       DATE;

   l_dat31        DATE;


   l_dat_opl      DATE;

   l_dat_opl_ar   DATE;
   l_dat_ug_ar    DATE;

   t_ost_n        NUMBER;
   t_ost_d        NUMBER;
   t_ost_p        NUMBER;
   t_ost_r        NUMBER;
   t_ost_r2       NUMBER;
   t_ost_s        NUMBER;
   t_ost_z        NUMBER;

   BV_1           NUMBER    := 0; -- балансовая стоимость на начало периода
   BV_31          NUMBER    := 0; -- балансовая стоимость на конец периода

   t_bv           NUMBER;
   kol_n          INT;
   kol_t          INT;

   sn_pr          NUMBER;
   sn_prq         NUMBER;
   op_pr          NUMBER;
   sn_pr_7        NUMBER;
   op_pr_7        NUMBER;

   cena0          NUMBER;
   cena1          NUMBER;
   cena2          NUMBER;
   cena4          NUMBER;
   cena7          NUMBER;
   cena31         NUMBER;

   cena_k2        NUMBER;
   cena_p2        NUMBER;
   cena_p2q       NUMBER;
   cena_buy       NUMBER;
   cena_pr        NUMBER;
   cena_prq       NUMBER;
   cena_buy_n     NUMBER;
   kl1            NUMBER;
   kl_k           NUMBER;
   kl_k2          NUMBER;
   kl_p2          NUMBER;
   kl31           NUMBER;
   kl4            NUMBER;
   kl_7           NUMBER;
   kl_p_7         NUMBER;
   cena_pr_7      NUMBER;


   l_fl_cpdat_exists      INT;      -- существует ли проспект эмиссии для кода бумаги
   l_fl_sale_exists       INT;      -- факт продажу в зв-му періоді

   vob2           INT;
   r_buy1         NUMBER;
   l_fl_p_7       INT;
   vob7           INT;
   R_sale         NUMBER;
   r_saleq        NUMBER;
   r_int          NUMBER;
   r_intq         NUMBER;
   r_otr          NUMBER;
   r_otrq         NUMBER;
   r_amd          NUMBER;
   r_amp          NUMBER;
   r_amdq         NUMBER;
   r_ampq         NUMBER;
   DF_            NUMBER;
   tr_31          NUMBER;
   n2_k           NUMBER;
   n2_p           NUMBER;
   n3_p           NUMBER;
   nm_kup         VARCHAR2 (30);
   nm_kup4        VARCHAR2 (30);
   n2_p_7         NUMBER;
   n7_p           NUMBER;

   nm_pr2         VARCHAR2 (30);
   n2_p_ar        NUMBER;
   l_tiket        VARCHAR2 (20000);
   l_tiket_7      VARCHAR2 (20000);
   l_dnk          DATE;

   l_rnk          INT;
   l_dreyt        VARCHAR2 (20);
   l_greyt        VARCHAR2 (20);
   l_nagen        VARCHAR2 (50);
   l_reyt         VARCHAR2 (20);
   l_vreyt        VARCHAR2 (20);
   l_emi01        VARCHAR2 (20);
   l_emi02        VARCHAR2 (20);
   l_docin        VARCHAR2 (20);
   l_pstor        VARCHAR2 (3);

   l_os_um        VARCHAR2 (20);
   l_p_kup        VARCHAR2 (20);
   l_riven        VARCHAR2 (20);
   l_rive2        VARCHAR2 (20);
   l_zrivn        VARCHAR2 (20);
   l_zpryc        VARCHAR2 (20);
   l_kderg        VARCHAR2 (20);
   l_bkot         VARCHAR2 (12);
   l_dkot         VARCHAR2 (20);
   l_typcp        VARCHAR2 (20);
   l_kod01        VARCHAR2 (20);
   l_kod02        VARCHAR2 (20);

   l_aukc         VARCHAR2 (20);
   l_brdog        VARCHAR2 (20);
   l_vdogo        VARCHAR2 (20);
   l_frozr        VARCHAR2 (20);
   l_froz2        VARCHAR2 (20);
   l_nmplo        VARCHAR2 (20);
   l_bv_1         VARCHAR2 (20);
   l_voper        VARCHAR2 (20);
   l_zncin        VARCHAR2 (20);
   l_znci2        VARCHAR2 (20);
   l_dofer        DATE;
   l_indox        VARCHAR2 (20);

   l_repo         VARCHAR2 (20);

   l_frm          VARCHAR2 (3) := '800';
   l_frm2         VARCHAR2 (3);

   l_t            cp_arch.t%TYPE;
   i9             INT := 0;
   l_op_ar        INT;
   l_n_ar         NUMBER;
   l_nom_ar       NUMBER;
   l_id           INT;
   l_kf_pr        NUMBER := 1;
   l_dok5         DATE;
   l_dnk5         DATE;

   l_init_ref     INT;
   l_dat_buy      DATE;
   l_koeff        NUMBER;
   l_nom          cp_dat.nom%TYPE;
   S_INIT         NUMBER;
   SN_INIT        NUMBER;
   kol_init       NUMBER;
   cena_init      NUMBER;

   FUNCTION get_kontragent (
      P_ref    INT,
      P_ISK    VARCHAR2 DEFAULT 'Контрагенту',
      p_vx     INT DEFAULT 1)
      RETURN VARCHAR
   IS
      l_ref    INT;
      ttt1     VARCHAR2 (4000);
      pos      INT;                        --  Контрагенту  :АБ "ПОЛТАВА-Банк"
      l_isk    VARCHAR2 (15);                             --  Вiд контрагенту:
      l_MFO    VARCHAR2 (12);
      l_name   VARCHAR2 (30);
   BEGIN
      l_ref := P_ref;
      l_isk := P_isk;

      SELECT get_stiket (l_ref) INTO ttt1 FROM DUAL;

      IF ttt1 IS NULL
      THEN RETURN '***?';
      END IF;

      SELECT INSTR (ttt1,l_isk,1,p_vx)
        INTO pos
        FROM DUAL;

      IF pos != 0
      THEN l_name := SUBSTR (ttt1, pos + 14, 30);
      ELSE l_name := '??';
      END IF;

      RETURN l_name;
   END;

   PROCEDURE LOG (p_info    CHAR,
                  p_lev     CHAR DEFAULT 'TRACE',
                  p_reg     INT DEFAULT 0)
   IS
   BEGIN
      MON_U.to_log (p_reg, p_lev, l_mdl, l_trace || p_info);
   END;

   function init_transaccounts return t_transaccounts
   is
    l_transaccount t_transaccounts;
   begin
      select sum(nls_3739),
       max(acc_3739),
       max(nls_3739_980),
       max(acc_3739_980),
       max(nls_3739_840),
       max(acc_3739_840),
       max(nls_3739_978),
       max(acc_3739_978),
       max(nls_3739_826),
       max(acc_3739_826)
       into l_transaccount
       from (
       select null nls_3739,
              null acc_3739,
              decode(kv, 980, nvl(nls, '37392555'), null)  nls_3739_980,
              decode(kv, 980, nvl(acc, 137465), null)      acc_3739_980,
              decode(kv, 840, nvl(nls, '37392555'), null)  nls_3739_840,
              decode(kv, 840, nvl(acc, 280591), null)      acc_3739_840,
              decode(kv, 978, nvl(nls, '37392555'), null)  nls_3739_978,
              decode(kv, 978, nvl(acc, -100), null)        acc_3739_978,
              decode(kv, 826, nvl(nls, '37392555'), null)  nls_3739_826,
              decode(kv, 826, nvl(acc, -100), null)        acc_3739_826
       from (   with kv_set as (select 980 kv from dual union
                      select 840 kv from dual union
                      select 978 kv from dual union
                      select 826 kv from dual )
       select kv_set.kv, nvl(a.acc,-100) acc, nvl(a.nls, '37392555') nls
         from kv_set
         left join accounts a on a.kv = kv_set.kv
        and (a.nls = '37392555' and a.kv != 826
            or a.nls ='46214492701' AND a.kv = 826)));
    return l_transaccount;
   end;

BEGIN
 bars_audit.info(title||' starts');
   IF p_reg = 0
   THEN  RETURN;
   END IF;                                                   -- без формування

   l_per        := TRIM (p_period);
   l_frm2       := NVL (l_per, 'D');                           -- дов?льний д?апазон

   l_day_befor_start        := l_date_start - 1;
   IF l_frm2 = 'Y'
   THEN                            --- !  уточнити період дат для повного року
      l_date_start     := TRUNC (l_date_start, 'Y');
      l_dat31          := ADD_MONTHS (l_date_start, +12) - 1;
      l_date_finish    := ADD_MONTHS (l_date_start, +12) - 1;
   ELSIF l_frm2 = 'Q'
   THEN                                --- !  уточнити період дат для кварталу
      l_date_start := TRUNC (l_date_start, 'Q');
      l_dat31 := ADD_MONTHS (l_date_start, +3) - 1;
      l_date_finish := ADD_MONTHS (l_date_start, +3) - 1;
   ELSIF l_frm2 = 'H'
   THEN                               --- !  уточнити період дат для пів-річчя
      IF l_date_finish >= ADD_MONTHS (l_date_start, +6)
      THEN l_date_start := ADD_MONTHS (l_date_start, +6);
      ELSE l_date_start := TRUNC (l_date_start, 'Y');
      END IF;
      l_dat31 := ADD_MONTHS (l_date_start, +6) - 1;
      l_date_finish := ADD_MONTHS (l_date_start, +6) - 1;
   ELSIF l_frm2 = 'D'
   THEN                                             --- !  уточнити пер_од дат
      l_dat31 := l_date_finish + 1;
   ELSE
      logger.info (title || '! НЕ вірні пар-ри: дати ' || l_date_start || ' ' || l_date_finish|| ' p_id=' || p_id || ' frm=' || l_frm || ' l_per=' || l_per);
      RETURN;
   END IF;

   l_userid := user_id;
   logger.info (title|| ' start: дати '|| l_date_start|| ' '|| l_date_finish|| ' p_id='|| p_id|| ' l_per='|| l_per);
   bars_audit.info(title|| ' start: дати '|| l_date_start|| ' '|| l_date_finish|| ' p_id='|| p_id|| ' l_per='|| l_per);

   l_transaccount := init_transaccounts;

   IF        p_id IN (036,826,840,978,980)
   THEN      l_id := 0;      l_kv_filtr := p_id;
   ELSIF     p_id = -980
   THEN      l_id := 0;      l_kv_filtr := -980;
   ELSIF     p_id = 0
   THEN      l_id := 0;      l_kv_filtr := 0;
   ELSE      l_id := p_id;   l_kv_filtr := 0;
   END IF;

   BEGIN
      EXECUTE IMMEDIATE 'truncate table tmp_cp_work';
   EXCEPTION
      WHEN OTHERS
      THEN NULL;
   END;
   bars_audit.info(title||' truncate table tmp_cp_work - OK');
   BEGIN
      FOR x IN (  SELECT REF,
                         str_ref,
                         dat_ug,
                         id
                    FROM cp_arch
                   WHERE op = 4 AND dat_ug >= l_date_start AND dat_ug <= l_date_finish
                ORDER BY REF)
      LOOP
         FOR x1
            IN (SELECT COLUMN_VALUE AS ref_h
                  FROM TABLE (getTokens (x.str_ref)))
         LOOP
            INSERT INTO tmp_cp_work (acc, REF, fdat)
                 VALUES (x.REF, x1.ref_h, TRUNC (SYSDATE));
         END LOOP;
      END LOOP;
   END;

   SELECT COUNT (*) INTO n1 FROM tmp_cp_work;
   logger.info ('CP_ZV зап.=' || n1);

   FOR k
      IN (  SELECT e.ID,
                   e.RYN,
                   e.ACC,
                   e.REF,
                   -a.ostc / 100                SA,
                   o.nd,
                   o.vdat                       dat_k,
                   ar.sumb / 100                SUMB,
                   ar.ref_repo,
                   ar.n / 100                   SUMN,
                   ar.stiket,
                   ar.op,
                   ar.ref_main,                                        -- rnbu
                   SUBSTR (a.nls, 1, 4)         nbs1,
                   o.s / 100                    s_kupl,
                   a.kv,
                   a.pap,
                   a.rnk,
                   k.rnk                        rnk_e,
                   a.grp,
                   a.isp,
                   a.mdate,
                   a.nls,
                   SUBSTR (a.nms, 1, 38)        nms,
                   g.nls                        NLSG,
                   e.accD,
                   e.accP,
                   e.accR,
                   e.accR2,
                   e.AccS,
                   SUBSTR (d.nms, 1, 38)        nms_d,
                   SUBSTR (p.nms, 1, 38)        nms_p,
                   SUBSTR (r.nms, 1, 38)        nms_r,
                   SUBSTR (r2.nms, 1, 38)       nms_r2,
                   SUBSTR (s.nms, 1, 38)        nms_s,
                   a.pap                        pap_n,
                   d.pap                        pap_d,
                   p.pap                        pap_p,
                   s.pap                        pap_s,
                   r.pap                        pap_r,
                   r2.pap                       pap_r2,
                   k.cp_id,
                   k.emi,
                   k.DATP                       DAT_PG,
                   k.dat_em,
                   k.ir,
                   k.cena,
                   NVL (k.cena_start, k.cena)   cena_start,
                   -d.ostc / 100                SD,
                   d.nls                        NLSD,
                   -p.ostc / 100                SP,
                   p.nls                        NLSP,
                   -NVL (r.ostc, 0) / 100       SR,
                   r.nls                        NLSR,
                   -NVL (r2.ostc, 0) / 100      SR2,
                   r2.nls                       NLSR2,
                   -s.ostc / 100                SS,
                   s.nls                        NLSS,
                   k.ky,
                   k.name,
                   c.okpo,
                   c.nmkk                       NMK,
                   k.dox,
                   e.initial_ref,
                   e.dat_bay,
                   e.op                         E_OP,
                   e.ref_new,
                   NVL((select SUBSTR (e.name, 1, 50)
                          from ved e
                         where e.ved = c.ved),'??') cf008_066,
                   NVL((select pf from cp_v where ref = e.ref),99) pf
              FROM cp_deal e,
                   cp_kod k,
                   accounts g,
                   oper o,
                   cp_arch ar,
                   accounts a,
                   accounts d,
                   accounts p,
                   accounts r,
                   accounts r2,
                   accounts s,
                   customer c
             WHERE     (       e.acc = a.acc
                           AND SUBSTR (A.nls, 1, 1) != '8'
                           AND k.dox > 1
                        OR NVL (e.accd, e.accp) = a.acc AND k.dox = 1)
                   AND (    a.dapp  > l_day_befor_start - 3
                        OR  a.ostc != 0
                        OR  a.ostb != 0)
                   AND o.vdat   <= l_date_finish
                   AND a.accc   = g.acc
                   AND e.id     = k.id
                   AND k.rnk    = c.rnk(+)
                   AND o.REF    = e.REF
                   AND e.REF    = ar.REF
                   AND e.accd   = d.acc(+)
                   AND e.accp   = p.acc(+)
                   AND e.accr   = r.acc(+)
                   AND e.accr2  = r2.acc(+)
                   AND e.accs   = s.acc(+)
                   AND e.id     = DECODE (NVL (l_id, 0), 0, e.id, l_id)
                   AND k.tip    = 1
                   AND NVL (k.datp, TO_DATE ('01/01/2050', 'dd/mm/yyyy')) > l_date_start
                   AND k.kv     = DECODE (NVL (l_kv_filtr, 0), 0, k.kv, -980, k.kv, l_kv_filtr)
                   AND k.kv     != DECODE (NVL (l_kv_filtr, 0),  -980, 980,  980, 0,  0)
                   AND o.sos    = 5
                   --  and k.dox > 1        -- 1 - акції 2 - БЦП
          ORDER BY 4
                    )
   LOOP
     bars_audit.info(title||' starts loop... id = '||to_char(k.id)||', ref = '||to_char(k.ref));

     SELECT *
       INTO cpdeal_main_row
       FROM cp_deal
      WHERE REF = k.REF;

      -- ініціалізація початкових значень
      IF    k.kv = 980 THEN l_transaccount.acc_3739 := l_transaccount.acc_3739_980;
      ELSIF k.kv = 840 THEN l_transaccount.acc_3739 := l_transaccount.acc_3739_840;
      ELSIF k.kv = 978 THEN l_transaccount.acc_3739 := l_transaccount.acc_3739_978;
      ELSIF k.kv = 826 THEN l_transaccount.acc_3739 := l_transaccount.acc_3739_826;
                       ELSE l_transaccount.acc_3739 := l_transaccount.acc_3739_980;
      END IF;
      bars_audit.info(title||' l_transaccount.acc_3739 = '||to_char(l_transaccount.acc_3739));
      tr        := NULL;

      l_init_ref:= k.initial_ref;
      l_dat_buy := k.dat_bay;
      tr.userid := l_userid;
      tr.period := l_per;
      tr.g006   := 'інші';
      tr.g007   := NVL (k.nmk, '***');
      tr.g008   := 'OKPO';
      tr.g010   := '';
      tr.g011   := k.nd;
      tr.g012   := k.cp_id;
      tr.g013   := k.ky;
      tr.g014   := k.dat_k;
      tr.g016   := k.ir;
      tr.g049   := k.dat_pg;
      tr.g050   := k.dat_pg;
      tr.g066   := 1;
      tr.frm    := '00';
      tr.g009   := 'Ні';
      tr.dat_r  := t_date_report;        -- дата формирования
      tr.cf008_066 := k.cf008_066;
      tr.nls    := k.nls;
      tr.nms    := k.nms;

      i9        := 0;
      cena1         := k.cena_start;
      cena31        := k.cena_start;
      cena4         := k.cena_start;
      cena7         := k.cena_start;
      cena_buy_n    := k.cena_start;
      cena_p2       := NULL;
      cena_p2q      := NULL;
      vob2          := NULL;
      cena_k2       := NULL;
      kl1           := NULL;
      sumb_pr       := 0;
      s_pr_op       := 0;
      s_kupl_op     := 0;
      s_63          := 0;
      tr_31         := 0;

      r_sale        := NULL;
      r_saleq       := NULL;
      r_int         := NULL;
      r_amd         := NULL;
      r_amp         := NULL;
      r_intq        := NULL;
      r_amdq        := NULL;
      r_ampq        := NULL;
      r_otr         := NULL;
      r_otrq        := NULL;

      sumb_pr_7     := NULL;
      n2_k          := 0;
      n2_p          := 0;
      n3_p          := NULL;
      n2_p_7        := NULL;
      n2_p_ar       := 0;
      nm_kup        := NULL;
      nm_pr         := NULL;
      nm_kup4       := NULL;
      nm_pr2        := NULL;
      l_tiket       := k.stiket;
      l_t           := NULL;

      BEGIN
         l_fl_cpdat_exists := 0;

         SELECT 1
           INTO l_fl_cpdat_exists
           FROM DUAL
          WHERE EXISTS
                   (SELECT 1
                      FROM cp_dat
                     WHERE id = k.ID);

         IF k.cena != k.cena_start
         THEN
            SELECT k.cena_start - SUM (NVL (a.nom, 0))
              INTO cena1
              FROM cp_dat a
             WHERE a.id = k.ID AND a.DOK <= l_date_start;

            SELECT k.cena_start - SUM (NVL (a.nom, 0))
              INTO cena_buy_n
              FROM cp_dat a
             WHERE a.id = k.ID AND a.DOK <= k.dat_k;

            SELECT k.cena_start - SUM (NVL (a.nom, 0))
              INTO cena31
              FROM cp_dat a
             WHERE a.id = k.ID AND a.DOK <= l_dat31;

            SELECT k.cena_start - SUM (NVL (a.nom, 0))
              INTO cena4
              FROM cp_dat a
             WHERE a.id = k.ID AND a.DOK <= bankdate;

            cena7 := cena4;
         END IF;
        bars_audit.info(title||'k.cena = '||to_char(k.cena)||', k.cena_start='|| to_char(k.cena_start));
        bars_audit.info(title||'cena1 = '||to_char(cena1)||', cena_buy_n = '||to_char(cena_buy_n)||', cena31 = '||to_char(cena31)||', cena4 = '||to_char(cena4));
         SELECT NVL (a.dok, k.dat_pg)
           INTO l_dnk
           FROM cp_dat a
          WHERE     a.id = k.ID
                AND a.DOK = (SELECT MIN (dok)
                               FROM cp_dat
                              WHERE id = k.id AND dok > l_date_finish);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            l_fl_cpdat_exists        := 0;                                                 --null;
            cena1       := k.cena_start;
            cena31      := k.cena_start;
            cena4       := k.cena_start;
            cena_buy_n  := k.cena_start;
            l_dnk       := NULL;
      END;
       bars_audit.info(title||'2.k.cena = '||to_char(k.cena)||', k.cena_start='|| to_char(k.cena_start));
       bars_audit.info(title||'2.cena1 = '||to_char(cena1)||', cena_buy_n = '||to_char(cena_buy_n)||', cena31 = '||to_char(cena31)||', cena4 = '||to_char(cena4));

      IF l_fl_cpdat_exists = 1 -- если проспект эмиссии в наличии
      THEN
         BEGIN
            SELECT NVL (a.dok, k.dat_pg)
              INTO l_dnk5
              FROM cp_dat a
             WHERE     a.id = k.ID
                   AND a.DOK = (SELECT MIN (dok)
                                  FROM cp_dat
                                 WHERE id = k.id AND dok > k.dat_k);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN l_dnk5 := k.dat_pg;
         END;

         BEGIN
            SELECT NVL (a.dok, k.dat_em)
              INTO l_dok5
              FROM cp_dat a
             WHERE     a.id = k.ID
                   AND a.DOK = (SELECT MAX (dok)
                                  FROM cp_dat
                                 WHERE id = k.id AND dok < k.dat_k);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN l_dok5 := k.dat_em;
         END;

         tr.kl0 :=NVL (l_dnk5, k.dat_pg) - NVL (l_dok5, k.dat_em);
      END IF;

      IF NVL (cena1, 0) = 0
      THEN
         cena1 := k.cena_start;
      END IF;                                                            --- ?

      l_dat_k  := NULL;
      l_dat_k2 := NULL;

      IF k.dat_k >= l_date_start AND k.dat_k <= l_date_finish
      THEN                                                    -- !? аналіз 096
         l_dat_k2 := k.dat_k;
      END IF;

      IF k.dat_k < l_date_start
      THEN
         l_dat_k := k.dat_k;
      END IF;                                                 -- !? аналіз 096

      tr.dat_k  := l_dat_k;
      tr.dat_k2 := l_dat_k2;

      N_buy := 0;
      D_buy := 0;
      P_buy := 0;
      R_buy := 0;
      S_buy := 0;

      r_buy1    := NULL;
      cena0     := k.cena_start;
      cena_buy  := k.cena_start;

      cena_pr   := NULL;
      cena_prq  := NULL;
      n2_p      := NULL;
      n2_p_ar   := NULL;
      kl_p2     := NULL;

      t_ost_n   := k.SA;
      t_ost_d   := k.SD;
      t_ost_p   := k.SP;
      t_ost_r   := k.SR;
      t_ost_r2  := k.SR2;
      t_ost_s   := k.SS;
      t_ost_z   := 0;

      SN_31     := 0;
      SN_31Q    := 0;
      SD_31     := 0;
      SD_31Q    := 0;
      BV_1      := 0;
      BV_31     := 0;

      t_bv      := t_ost_n + t_ost_d + t_ost_p + t_ost_r + t_ost_r2 + t_ost_s + t_ost_z;

      l_kv      := k.kv;
      s_pr_op   := 0;

      SD_       := 0;
      SP_       := 0;
      SS_       := 0;
      SR_       := 0;
      SR2_      := 0;

      SN_Q      := 0;
      SD_Q      := 0;
      SP_Q      := 0;
      SS_Q      := 0;
      SR_Q      := 0;
      SR2_Q     := 0;

      kol_n         := 0;
      kol_t         := 0;
      l_dat_pr      := NULL;


      SELECT s / 100
        INTO s_kupl_op
        FROM oper
       WHERE REF = k.REF;

      SELECT NVL (SUM (DECODE (o.dk, 0, 1, 0) * o.s), 0) / 100
        INTO N_buy
        FROM opldok o
       WHERE o.REF = k.REF AND acc = k.acc;

      SELECT NVL (SUM (DECODE (o.dk, 0, 1, 0) * o.s), 0) / 100
        INTO D_buy
        FROM opldok o
       WHERE o.REF = k.REF AND acc = k.accd;

      SELECT NVL (SUM (DECODE (o.dk, 0, 1, 0) * o.s), 0) / 100
        INTO P_buy
        FROM opldok o
       WHERE o.REF = k.REF AND acc = k.accp;

      SELECT NVL (SUM (DECODE (o.dk, 0, 1, 0) * o.s), 0) / 100
        INTO R_buy
        FROM opldok o
       WHERE o.REF = k.REF AND acc = NVL (k.accr2, k.accr);                 --

     bars_audit.info(title||' s_kupl_op = '||s_kupl_op||', N_buy = '|| N_buy ||', D_buy = '||D_buy||', P_buy = '||P_buy||', R_buy = '||R_buy);
     bars_audit.info(title||' l_dat_k2 = '||l_dat_k2);
      IF l_dat_k2 IS NOT NULL
      THEN
      bars_audit.info(title||' l_dat_k2 IS NOT NULL ');
         kl_k2      := ROUND (n_buy / cena_buy_n, 0);
         n2_k       := n_buy;
         cena_buy   := ROUND (NVL (k.sumb, s_kupl_op) / kl_k2, 2);
         kl_k       := NULL;
         tr.cena_k2 := cena_buy;                                        -- nom
         cena_k2    := cena_buy;
         nm_pr      := NULL;
         cena_buy   := gl.p_icurval (l_kv, cena_buy * 100, l_dat_k2) / 100;
         cena0      := NULL;
         tr.n2      := n_buy;
         tr.g031    := gl.p_icurval (l_kv, n_buy * 100, l_dat_k2) / 100;
         tr.g032    := kl_k2;
         tr.g033    := cena_buy;
         tr.kl_k2   := kl_k2;
         tr.g019    := NULL;
         tr.g020    := NULL;
         tr.g021    := NULL;
         tr.g022    := NULL;
         r_buy1     := ROUND (r_buy / kl_k2, 2);
         tr.g034    := r_buy1;
         tr.r0      := r_buy;

         IF l_tiket IS NOT NULL
         THEN
            nm_pr2 := TRIM (get_kontragent (k.REF));
         END IF;
      ELSIF l_dat_k IS NOT NULL
      THEN
      bars_audit.info(title||' l_dat_k IS NOT NULL ');
         kl_k       := case when ROUND(n_buy/cena_buy_n, 0) = 0 then 1 else  ROUND(n_buy/cena_buy_n, 0) end;
         cena_buy   := ROUND (NVL (k.sumb, s_kupl_op) / kl_k, 2);
         cena0      := cena_buy;
         cena_buy   := gl.p_icurval (l_kv, cena_buy * 100, l_dat_k) / 100;
         kl_k2      := NULL;
         cena_k2    := NULL;
         nm_pr2     := NULL;
         tr.G017    := cena_buy;                 --tr.g018:=kl_k;   tr.kl1:=kl_k;

         IF l_tiket IS NOT NULL
         THEN
            nm_pr := TRIM (get_kontragent (k.REF));
         END IF;
      ELSE
         kl_k   := NULL;
         kl_k2  := NULL;
         cena_k2:= 7;
         cena0  := 7;
      END IF;

      tr.g015   := nm_pr;
      tr.cena0  := cena0;
      tr.g036   := l_dat_k2;
      tr.g037   := nm_pr2;

      tr.g049   := k.dat_pg;
      tr.g051   := l_dnk;
      tr.g052   := k.ir;
      tr.g068   := NULL;

      S_INIT    := s_kupl_op;
      SN_INIT   := N_buy;

      IF k.e_op = 3
      THEN
         BEGIN
            SELECT s, vdat
              INTO S_INIT, l_dat_buy
              FROM oper
             WHERE REF = l_init_ref;

            SELECT SUM (s)
              INTO SN_INIT
              FROM opldok
             WHERE REF = l_init_ref AND acc = cpdeal_main_row.acc;

            kol_init := ROUND (SN_INIT / f_cena_cp (k.id, l_dat_buy), 1);

            IF NVL (kol_init, 0) != 0
            THEN cena_init := ROUND (S_INIT / kol_init, 2);
            ELSE cena_init := 0;
            END IF;

            IF TRUNC (kol_init) != kol_init
            THEN
               LOG (title|| ' ID='|| k.id|| ' ref='|| k.REF|| ' kol_init='|| kol_init,'INFO',5);
            END IF;

            tr.cena0 := cena_init;
         END;
      END IF;
      bars_audit.info(title|| '1: ID='|| k.id|| ' '|| k.cp_id|| ' '|| l_kv|| ' buy date '|| k.dat_k|| ' ref='|| k.REF|| ' Sn_buy='|| n_buy);
      LOG (title|| '1: ID='|| k.id|| ' '|| k.cp_id|| ' '|| l_kv|| ' buy date '|| k.dat_k|| ' ref='|| k.REF|| ' Sn_buy='|| n_buy,'INFO',5);

      tr.pf_old     := k.pf;

      IF    k.pf = 1
       THEN tr.g005 := 2;
      ELSIF k.pf = 4
       THEN tr.g005 := 1;
      ELSIF k.pf = 3
       THEN tr.g005 := 3;
       ELSE tr.g005 := NULL;
      END IF;

      l_ref_pr_9    := NVL (k.ref_new, l_ref_main);                  -- sale/move

      IF l_ref_pr_9 IS NOT NULL
      THEN
         BEGIN
            SELECT vdat
              INTO l_dat_mv                                           --l_vdat
              FROM oper
             WHERE REF = l_ref_pr_9 AND sos = 5;                   -- RNBU/OBU
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN l_dat_mv   :=  null;
                 l_ref_pr   :=  null;
         END;
      ELSE
         l_dat_mv   :=  null;
         l_ref_pr   :=  null;
         l_dat_pr   :=  null;
      END IF;
      ---------
      SN_Q      := 0;
      SN_31     := 0;
      SN_31Q    := 0;
      kl31      := 0;

      IF cpdeal_main_row.acc IS NOT NULL
      THEN
         SN_    :=  -rez.ostc96 (cpdeal_main_row.acc, l_day_befor_start) / 100;
         SN_Q   :=  gl.p_icurval (k.kv, SN_ * 100, l_day_befor_start) / 100;

         IF SN_ != 0
         THEN
            kl1         := ROUND (SN_ / cena1, 0);
            tr.g018     := kl1;
            tr.kl1      := kl1;

            IF l_kv != 980
            THEN tr.g019:= SN_Q;
            ELSE tr.g019:= SN_;
            END IF;

            tr.n1       := SN_;
         END IF;

         -- кінець зв. періоду
         SN_31  := -rez.ostc96 (cpdeal_main_row.acc, l_dat31) / 100;
         SN_31Q := gl.p_icurval (k.kv, SN_31 * 100, l_dat31) / 100;
         kl31   := ROUND (SN_31 / cena31, 0);
      END IF;                                                         -- cpdeal_main_row

      IF l_kv != 980
       THEN tr.g054 := SN_31Q;
       else tr.g054 := SN_31;
      END IF;

      tr.g053   := kl31;
      tr.kl31   := kl31;
      tr.n31    := SN_31;
      ---------
      BEGIN
         -- факт продажу в зв-му періоді
         l_fl_sale_exists := 0;

        select 1
          into l_fl_sale_exists
          from dual
          where exists (select 1
                          from opldok
                         where acc = cpdeal_main_row.acc
                           and dk = 1
                           and sos = 5
                           and fdat >= l_date_start
                           and fdat <= l_dat31);                --  !!!!??? OTL
      --  ! уточнити на vob=096
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN l_fl_sale_exists := 0;
      END;

      OKN_K := 0;
      BEGIN
         SELECT SUM (o.s) / 100   -- всі кредити по номіналу з поч-ку зв. п-ду
           INTO OKN_K
           FROM opldok o, OPER P
          WHERE     o.acc = cpdeal_main_row.acc
                AND o.dk = 1
                AND o.REF = p.REF
                AND o.sos = 5
                AND o.tt LIKE 'FX%'
                AND fdat >= l_date_start
                AND p.vdat > l_date_start
                AND (p.vdat <= l_dat31 OR vob = 096 AND p.vdat > l_dat31 + 20);
      END;

      DF_ := 555;                                               --N2_P:=OKN_K;

      -- DF_ розходження по сумі кредиту
      IF OKN_K != SN_31 - SN_
      THEN
         DF_        := OKN_K - (SN_31 - SN_);
         tr.nls_p1  := '>1 sale';
      END IF;

      --  можлива різна через коригуючі

      -- всі реф-си угод продажу
      -- .... and ref in
      --     (select ref from cp_arch
      --      where ref_main=k.ref and ref!=ref_main and op in (2,20)  --22

      SN_PR     := 0;
      sn_prq    := 0;
      kl_p2     := 0;
      s_pr_op   := 0;
      n3_p      := 88;
      n2_p      := 88;

      BEGIN
         IF l_fl_sale_exists = 1 -- был факт продажи пакета в периоде
         THEN
            SELECT *
              INTO cpdeal_saled_row
              FROM cp_deal
             WHERE REF = l_ref_pr;
         ELSE
            cpdeal_saled_row := NULL;
         END IF;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN cpdeal_saled_row := NULL;
      END;

      SN_PR_7 := 0;
      kl_p_7 := 0;

      l_ref_pr_7 := NULL;

      IF l_fl_cpdat_exists = 1 AND l_dat_pr IS NOT NULL AND k.cena != k.cena_start
      THEN
         -- уточнення номінальної ціни 1 шт
         BEGIN
            SELECT k.cena_start - SUM (NVL (a.nom, 0))
              INTO cena_p2
              FROM cp_dat a
             WHERE a.id = k.ID AND a.DOK <= l_dat_pr;
         END;
      ELSE
         cena_p2 := k.cena;
      END IF;

      cena_p2   := NVL (cena_p2, 1);
      n2_p_7    := NULL;
      sumb_pr_7 := 0;
      op_pr_7   := NULL;
      l_tiket_7 := NULL;

      IF l_ref_pr_7 IS NOT NULL
      THEN                                                         -- after 31
         BEGIN
            SELECT sumb / 100,
                   op,
                   n / 100,
                   stiket,
                   t
              INTO sumb_pr_7,
                   op_pr_7,
                   n2_p_7,
                   l_tiket_7,
                   l_t
              FROM cp_arch
             WHERE REF = l_ref_pr_7;

            IF l_tiket_7 IS NOT NULL
            THEN
               nm_kup4 := TRIM (get_kontragent (l_ref_pr_7, 'контрагенту'));
               tr.g084 := nm_kup4;
            END IF;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN n2_p_7 := NULL;                                       ---sn_pr;
                 sumb_pr_7 := NULL;
                 op_pr_7 := NULL;
                 n2_p_7 := NULL;
         END;
      END IF;

      cena_pr_7 := NULL;
      kl_p_7 := NULL;

      IF sn_pr_7 IS NOT NULL AND sn_pr_7 != 0
      THEN
         kl_p_7     := ROUND (sn_PR_7 / NVL (cena7, 1), 0);                 -- ?
         cena_pr_7  := ROUND (NVL (sumb_pr_7, 0) / NVL (kl_p_7, 1), 2);     -- op_pr   2 - sale  3 - move
         tr.g083    := cena_pr_7;
         tr.g085    := kl_p_7;
         tr.g086    := sn_pr_7;
      END IF;

      cpdeal_moved_row := NULL;

      BEGIN
         IF l_ref2 IS NOT NULL AND op_pr = 3
         THEN                                                          -- move
            SELECT *
              INTO cpdeal_moved_row
              FROM cp_deal
             WHERE REF = l_ref2;
         ELSE
            cpdeal_moved_row := NULL;
         END IF;
      END;

      --LOG(title||'dl2='||r_dl2.acc||' '||r_dl2.accd||' '||r_dl2.accr,'INFO',0);

      IF cpdeal_main_row.acc IS NOT NULL OR cpdeal_moved_row.acc IS NOT NULL
      THEN
         -- вих. залишки та обороти по  складових рах-х
         -- для old за l_date_start по l_date_finish           (звітний період)
         -- для new за l_date_finish по l_date_finish+1       (...)

         kol_n := ROUND (SN_ / k.cena_start, 0);
         kol_t := ROUND (SN_ / cena4, 0);

         IF SN_ != 0
         THEN
                kl1 := ROUND (SN_ / cena1, 0);
         END IF;

         if cena_p2 != 0
         then kl_p2      := ROUND (SN_PR / cena_p2, 0);
         else kl_p2      := SN_PR;
         end if;

         --- 31/12
         SN_31      := -rez.ostc96 (cpdeal_main_row.acc, l_dat31) / 100;
         SN_31Q     := gl.p_icurval (k.kv, SN_31 * 100, l_dat31) / 100;
         kl31       := ROUND (SN_31 / cena31, 0);

         -- LOG(title||'N: ISIN='||k.cp_id||' ref='||k.ref,'ERROR',0);
         IF l_kv != 980
         THEN tr.g054 := SN_31Q;
         else tr.g054 := SN_31;
         END IF;

         tr.g053 := kl31;
      END IF;                                                         -- N end

      -- D
      SD_ := 0;
      SD_Q := 0;
      SD_31 := 0;
      SD_31Q := 0;

      IF cpdeal_main_row.accd IS NOT NULL OR cpdeal_moved_row.accd IS NOT NULL
      THEN
         IF cpdeal_main_row.accd IS NOT NULL
         THEN
            SD_     := -rez.ostc96 (cpdeal_main_row.accd, l_day_befor_start) / 100;
            SD_Q    := gl.p_icurval (k.kv, SD_ * 100, l_day_befor_start) / 100;
            --  потрібно по OPLDOK з аналізом TT
            SD_31   := -rez.ostc96 (cpdeal_main_row.accd, l_dat31) / 100;
            SD_31Q  := gl.p_icurval (k.kv, SD_31 * 100, l_dat31) / 100;
         END IF;

         IF SD_ != 0
         THEN
            IF l_kv != 980
            THEN tr.g020 := SD_Q;
            ELSE tr.g020 := SD_;
            END IF;
         END IF;

         IF l_kv != 980
         THEN tr.g055 := SD_31Q;
         ELSE tr.g055 := SD_31;
         END IF;

         tr.d1  := SD_;
         tr.d31 := SD_31;

         --LOG(title||'error D: ISIN='||k.cp_id||' ref='||k.ref,'ERROR',0);
         BEGIN
            SELECT NVL(SUM(o.s), 0) / 100,
                   NVL(SUM(o.sq), 0) / 100 -- по D при амортизації на 6
              INTO r_amd,
                   r_amdq
              FROM opldok o
             WHERE o.acc IN (cpdeal_main_row.accd)
               AND o.dk = 0
               AND o.sos = 5
               AND o.fdat >= l_date_start
               AND o.fdat <= l_date_finish
               AND o.tt = 'FXM';
         EXCEPTION WHEN NO_DATA_FOUND
                   THEN r_amd  := 0;
                        r_amdq := 0;
         END;
         tr.s_dp := r_amdq;
         tr.s_dk := r_amd;
      END IF;                                                        -- D  end

      -- P
      SP_       := 0;
      SP_Q      := 0;
      SP_31     := 0;
      SP_31Q    := 0;

      IF cpdeal_main_row.accp IS NOT NULL OR cpdeal_moved_row.accp IS NOT NULL
      THEN
         IF cpdeal_main_row.accp IS NOT NULL
         THEN
            SP_     := -rez.ostc96 (cpdeal_main_row.accp, l_day_befor_start) / 100;
            SP_Q    := gl.p_icurval (k.kv, SP_ * 100, l_day_befor_start) / 100;
            SP_31   := -rez.ostc96 (cpdeal_main_row.accp, l_dat31) / 100;
            SP_31Q  := gl.p_icurval (k.kv, SP_31 * 100, l_dat31) / 100;
         ELSE
            SP_     := 0;
            SP_Q    := 0;
            SP_31   := 0;
            SP_31Q  := 0;
         END IF;

         --LOG(title||'P: ISIN='||k.cp_id||' ref='||k.ref,'ERROR',0);

         IF SP_ != 0
         THEN
            IF l_kv != 980
            THEN tr.g020 := SD_Q + SP_Q;
            ELSE tr.g020 := SD_ + SP_;
            END IF;
         END IF;

         IF l_kv != 980
         THEN tr.g055 := SD_31Q + SP_31Q;
         ELSE tr.g055 := SD_31 + SP_31;
         END IF;

         tr.p1  := SP_;
         tr.p31 := SP_31;

         BEGIN
            SELECT NVL (SUM (o.s), 0) / 100, NVL (SUM (o.sq), 0) / 100 -- по P при амортизації на 6
              INTO r_amp, r_ampq
              FROM opldok o
             WHERE     o.acc IN (cpdeal_main_row.accp)
                   AND o.dk = 1
                   AND o.sos = 5
                   AND o.fdat >= l_date_start
                   AND o.fdat <= l_date_finish
                   AND o.tt = 'FXM';
         EXCEPTION WHEN NO_DATA_FOUND
                   THEN r_amp  := 0;
                        r_ampq := 0;
         END;

         tr.s_cp := r_ampq;
         tr.s_ck := r_amp;
      END IF;                                                        -- P  end

      --- ================       R
      SR_ := 0;
      SR_Q := 0;
      SR_31 := 0;
      SR_31Q := 0;
      -- R
      IF cpdeal_main_row.accr IS NOT NULL OR cpdeal_moved_row.accr IS NOT NULL
      THEN
         IF cpdeal_main_row.accr IS NOT NULL
         THEN
            SR_     := -rez.ostc96 (cpdeal_main_row.accr, l_day_befor_start) / 100;
            SR_Q    := gl.p_icurval (k.kv, SR_ * 100, l_day_befor_start) / 100;
            --  потрібно по OPLDOK з аналізом TT
            SR_31   := -rez.ostc96 (cpdeal_main_row.accr, l_dat31) / 100;
            SR_31Q  := gl.p_icurval (k.kv, SR_31 * 100, l_dat31) / 100;
         ELSE
            SR_     := 0;
            SR_Q    := 0;
            SR_31   := 0;
            SR_31Q  := 0;
         END IF;

         --LOG(title||'R: ISIN='||k.cp_id||' ref='||k.ref,'ERROR',0);

         IF SR_ != 0
         THEN
            IF l_kv != 980
            THEN tr.g021 := SR_Q;
            ELSE tr.g021 := SR_;
            END IF;
         END IF;

         IF l_kv != 980
         THEN tr.g056 := SR_31Q;
         ELSE tr.g056 := SR_31;
         END IF;

         tr.r1      := SR_;
         tr.r31     := SR_31;

         BEGIN
            SELECT NVL (SUM (o.s), 0) / 100, NVL (SUM (o.sq), 0) / 100 -- по R при нарахуванні на 605
              INTO r_int, r_intq
              FROM opldok o                                         --, OPER P
             WHERE     o.acc IN (k.accr)
                   AND o.dk = 0                              --and o.ref=p.ref
                   AND o.sos = 5
                   AND o.fdat >= l_date_start
                   AND o.fdat <= l_date_finish             --and o.tt in ('FXU','FXU'
                   AND o.tt = 'FX%';
         EXCEPTION WHEN NO_DATA_FOUND
                   THEN r_int  := 0;
                        r_intq := 0;
         END;
         tr.g069    := r_intq;                                 -- tr. ...:=r_int;
      END IF;                                                        -- R  end

      -- R2
      SR2_31        := 0;
      SR2_31Q       := 0;
      SR2_          := 0;
      SR2_Q         := 0;

      IF cpdeal_main_row.accr2 IS NOT NULL
      THEN
         SR2_    :=  -rez.ostc96 (cpdeal_main_row.accr2, l_day_befor_start) / 100;
         SR2_Q   := gl.p_icurval (k.kv, SR2_ * 100, l_day_befor_start) / 100;

         --  потрібно по OPLDOK з аналізом TT
         SR2_31  := -rez.ostc96 (cpdeal_main_row.accr2, l_dat31) / 100;
         SR2_31Q := gl.p_icurval (k.kv, SR2_31 * 100, l_dat31) / 100;

         IF SR2_ != 0
         THEN
            IF l_kv != 980
            THEN tr.g022 := SR2_Q;
            ELSE tr.g022 := SR2_;
            END IF;

            tr.g021 := tr.g021 + tr.g022;
         END IF;

         IF l_kv != 980
         THEN tr.g057 := SR2_31Q;
         ELSE tr.g057 := SR2_31;
         END IF;

         tr.g056 := tr.g056 + tr.g057;
      END IF;                                                       -- R2  end

      r_otr     := 0;
      r_otrq    := 0;

      BEGIN
         SELECT NVL (SUM (o.s), 0) / 100,
                NVL (SUM (o.sq), 0) / 100,
                MAX (r.acc)
           INTO r_otr, r_otrq, l_ref_g
           FROM opldok o, saldoa s, tmp_cp_work r
          WHERE     o.acc IN (k.accr, k.accr2)
                AND o.dk = 1
                AND o.sos = 5
                AND s.fdat >= l_date_start
                AND s.fdat <= l_date_finish
                AND o.acc = s.acc
                AND o.fdat = s.fdat
                AND o.REF = r.REF
                AND o.tt IN ('FX7', 'FX8');

         IF r_otr != 0
         THEN
            logger.info (title|| 'погаш. '|| k.cp_id|| ' '|| '/'|| k.REF|| ' ref пог. '|| l_ref_g|| ' купон='|| r_otr);
         END IF;
      END;

      tr.cf008_057  := r_otr;
      tr.cf008_058  := r_otrq;
      tr.r4         := r_otrq;

      -- S
      SS_31         := 0;
      ss_31q        := 0;
      SS_           := 0;
      SS_q          := 0;

      IF cpdeal_main_row.accs IS NOT NULL OR cpdeal_moved_row.accs IS NOT NULL
      THEN
         IF cpdeal_main_row.accs IS NOT NULL
         THEN
            SS_     := -rez.ostc96 (cpdeal_main_row.accs, l_day_befor_start) / 100;
            SS_Q    := gl.p_icurval (k.kv, SS_ * 100, l_day_befor_start) / 100;
            SS_31   := -rez.ostc96 (cpdeal_main_row.accs, l_dat31) / 100;
            SS_31Q  := gl.p_icurval (k.kv, SS_31 * 100, l_dat31) / 100;
         ELSE
            SS_ := 0;
            SS_q := 0;
            SS_31 := 0;
            SS_31Q := 0;
         END IF;

         --LOG(title||'ss: ISIN='||k.cp_id||' ref='||k.ref,'ERROR',0);

         IF SS_ != 0
         THEN
            IF l_kv != 980
            THEN tr.g025 := SS_Q;
            ELSE tr.g025 := SS_;
            END IF;
            tr.s1 := SS_;
         END IF;

         IF l_kv != 980
         THEN tr.g060 := SS_31Q;
         ELSE tr.g060 := SS_31;
         END IF;
         tr.S31 := SS_31;
     END IF;                                                         -- S end

      IF k.dox = 1
      THEN
        BV_1    := 0 + SD_ + SP_ + SR_ + SR2_ + SS_;                      -- SZ_
        tr.g020 := NULL;
      ELSE
        IF l_kv != 980
        THEN BV_1 := SN_Q + SD_Q + SP_Q + SR_Q + SR2_Q + SS_Q;
        ELSE BV_1 := SN_ + SD_ + SP_ + SR_ + SR2_ + SS_;                    -- SZ_
        END IF;
      END IF;

      cena1 := ROUND (BV_1 / NVL (kl1, 1), 0);

      IF NVL (kl1, 0) = 0
      THEN
         kl1 := NULL;
      END IF;

      IF BV_1 = 0
      THEN
         cena1 := NULL;
      END IF;

      IF k.dox = 1
      THEN
        BV_31 := 0 + SD_31 + SP_31 + SR_31 + SR2_31 + SS_31;         -- SZ_31
        tr.g055 := NULL;
      ELSE
        IF l_kv != 980
        THEN BV_31 := SN_31Q + SD_31Q + SP_31Q + SR_31Q + SR2_31Q + SS_31Q;
        ELSE BV_31 := SN_31 + SD_31 + SP_31 + SR_31 + SR2_31 + SS_31;     -- SZ_31
        END IF;
      END IF;

      cena_p2       := cena_pr;
      tr.g001       := k.nbs1;
      tr.g002       := 'НІ';
      tr.g003       := '3';
      tr.g006       := '6*';
      tr.g004       := l_kv;
      tr.g007       := NVL (k.nmk, '***');       -- seria
      tr.g014       := l_dat_k;
      tr.g015       := nm_pr;
      tr.dat_k      := l_dat_k;
      tr.g026       := NULL;
      tr.bv1        := BV_1;

      IF BV_1 != 0
      THEN
         tr.g027 := BV_1;
      END IF;

      tr.g062       := BV_31;
      tr.g063       := NULL;
      tr.bv31       := bv_31;
      tr.id         := k.id;
      tr.isin       := k.cp_id;
      tr.REF        := k.REF;
      tr.vid_r      := 'N';
      tr.kv         := k.kv;
      tr.ir         := k.ir;
      tr.cena_start := k.cena_start;

      --- !!! Розробити алгоритм
      tr.g003       := NULL;
      tr.g006       := NULL;
      tr.g008       := NULL;

      tr.g028       := NULL;
      tr.g065       := NULL;
      tr.okpo       := NULL;
      tr.g029       := NULL;
      tr.g070       := NULL;
      tr.g072       := NULL;
      tr.g074       := NULL;
      tr.g075       := NULL;
      tr.g076       := NULL;
      tr.g077       := NULL;
      tr.g078       := NULL;
      tr.g079       := NULL;
      tr.g080       := NULL;
      tr.ost_v      := l_init_ref;
      tr.dat_4      := l_dat_buy;

      DF_ := 555;                                               --N2_P:=OKN_K;

      -- DF_ розходження по сумі кредиту
      IF OKN_K != SN_31 - SN_
      THEN
         DF_ := OKN_K - (SN_31 - SN_);
         tr.nls_p1 := '>1 sale';
      END IF;

      --  можлива різна через коригуючі
      --- розкладка одного пакета на часткові продажі в зв-му періоді
      i9            := 0;
      l_dat_opl     := NULL;
      l_dat_opl_ar  := NULL;
      l_kf_pr       := 1;

      FOR i5
         IN (  SELECT o.REF,
                      NULL,
                      p.nd,
                      o.s / 100 S,
                      o.stmt,
                      o.tt,
                      DECODE (vob, 096, p.vdat, o.fdat) dat_opl,
                      p.datp dat_ug
                 FROM opldok o, oper p
                WHERE     o.acc = cpdeal_main_row.acc
                      AND o.dk = 1
                      AND o.REF = p.REF
                      AND o.fdat BETWEEN l_date_start AND l_date_finish
                      AND o.sos = 5
             ORDER BY 1)
      LOOP
         -- всі реф-си угод продажу
         l_ref_pr   := i5.REF;

         SN_PR      := 0;
         kl_p2      := 0;
         s_pr_op    := 0;
         n3_p       := 88;
         n2_p       := 88;

         -- i5-й продаж
         BEGIN
            SELECT TO_NUMBER (txt)
              INTO l_koeff
              FROM cp_forw
             WHERE REF = i5.REF AND acc = cpdeal_main_row.acc AND TO_NUMBER (txt) < 1;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN l_koeff := 1;

         END;

         l_koeff := 1; -- !! визначення через CP_FORW  - для op=20  задовільняє
                   -- !! визначення через CP_FORW  - для op=2   НЕ задовільняє

         BEGIN
            SELECT o.REF,
                   DECODE (vob, 096, p.vdat, o.fdat),
                   ar.op,
                   NVL (ar.n, o.s) / 100,
                   NVL (ar.nom, k.cena),
                   ROUND (o.s / NVL (ar.n, o.s), 2),
                   ar.dat_opl,
                   ar.dat_ug,
                   o.s / 100,
                   p.s / 100
              INTO l_ref_pr,
                   l_dat_pr,
                   l_op_ar,
                   l_n_ar,
                   l_nom_ar,
                   l_kf_pr,
                   l_dat_opl_ar,
                   l_dat_ug_ar,
                   sn_pr,
                   s_pr_op                 -- сума угоди продажу всього пакета
              FROM opldok o, oper p, cp_arch ar
             WHERE     o.acc = cpdeal_main_row.acc
                   AND o.dk = 1
                   AND o.REF = p.REF
                   AND o.REF = ar.REF(+)
                   -- and rownum=1
                   AND o.sos = 5
                   AND o.REF = I5.REF;

            N2_P    := SN_PR;
            sn_prq  := gl.p_icurval (l_kv, SN_pr * 100, l_dat_pr) / 100;
            l_ref2  := i5.REF;                          -- l_dat_pr:=i5.dat_ug;
            i9      := i9 + 1;
            tr.nls  := i9;

                    LOG (title|| 'ISIN=' || k.cp_id|| ' '|| k.dat_k|| '/'|| k.REF|| ' SN='|| SN_|| ' sale '|| l_dat_pr|| '/'|| l_ref2|| ' SN_pr='|| sn_pr|| ' i9='|| i9,'INFO');
            logger.info (title|| 'прод. '|| k.cp_id|| ' '|| k.dat_k|| '/'|| k.REF|| ' SN='|| SN_|| ' sale '|| l_dat_pr|| '/'|| l_ref2|| ' SN_pr='|| sn_pr|| ' i9='|| i9);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN   l_dat_pr := NULL;
                   l_ref_pr := NULL;
                   N2_p := NULL;
                   sn_pr := NULL;
                   sn_prq := NULL;
                   s_pr_op := 0;
                   l_ref2 := NULL;
         END;

         IF l_ref_pr IS NOT NULL
         THEN
            r_sale := NULL;
            r_saleq := NULL;

            BEGIN
               SELECT SUM (o.s) / 100, SUM (o.sq) / 100 -- кредит по R/R2 при продажу
                 INTO r_sale, r_saleq
                 FROM opldok o                                      --, OPER P
                WHERE     o.acc IN (cpdeal_main_row.accr, cpdeal_main_row.accr2)
                      AND o.dk = 1                           --and o.ref=p.ref
                      AND o.sos = 5                             -- !? OBU/BARS
                      AND o.REF = l_ref_pr;
            END;
         END IF;

         IF l_kv != 980
         THEN tr.g041 := r_saleq;
         ELSE tr.g041 := r_sale;
         END IF;

         --LOG(title||'a ref='||k.ref||'/'||l_ref2||' i9='||i9,'INFO',0);

         IF l_fl_cpdat_exists = 1 AND l_dat_pr IS NOT NULL AND k.cena != k.cena_start
         THEN
            -- уточнення номінальної ціни 1 шт
            BEGIN
               SELECT   k.cena_start
                      - SUM (NVL (a.nom, 0))
                      + SUM (DECODE (a.dok, k.dat_pg, NVL (a.nom, 0), 0))
                 INTO cena_p2                                      --  6/04-15
                 FROM cp_dat a
                WHERE a.id = k.ID AND a.DOK <= l_dat_pr;
            END;
         ELSE
            cena_p2 := k.cena;                                   -- номінальна
         END IF;

         cena_p2    := NVL (cena_p2, 1);

         IF l_op_ar = 22
         THEN
            BEGIN
               SELECT NVL (nom, 0)
                 INTO l_nom
                 FROM cp_dat a
                WHERE     a.id = k.ID
                      AND a.DOK = (SELECT MAX (dok)
                                     FROM cp_dat
                                    WHERE id = k.id AND dok < l_dat_pr);
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN l_nom := 0;
            END;
         END IF;

         IF     l_ref_pr IS NOT NULL
            AND l_dat_pr IS NOT NULL
            AND l_dat_pr <= l_dat31
         THEN                                                            -- 31
            BEGIN
               SELECT NVL (sumb, 0) / 100,
                      op,
                      NVL (n, 0) / 100,
                      NVL (t, 0)
                 INTO sumb_pr,
                      op_pr,
                      n2_p_ar,
                      l_t
                 FROM cp_arch
                WHERE REF = NVL (l_ref_pr, 0);

               l_tiket := NULL;

               IF k.id NOT IN (280, 296) OR NVL (l_op_ar, 2) NOT IN (20, 22)
               THEN
                  SELECT stiket
                    INTO l_tiket
                    FROM cp_arch
                   WHERE REF = NVL (l_ref_pr, 0);
               END IF;

               IF l_tiket IS NOT NULL
               THEN
                  nm_kup := TRIM ( get_kontragent (l_ref_pr, 'д контрагенту'));
                  tr.g045 := nm_kup;
               END IF;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  n2_p := sn_pr;
                  l_t := NULL;
                  n2_p_ar := sn_pr;
                  sumb_pr := 0;
                  op_pr := NULL;
                  nm_kup := NULL;
            END;
         ELSE
            n2_p        := sn_pr;
            sumb_pr     := 0;
            op_pr       := NULL;
            kl_p2       := NULL;
            cena_p2     := NULL;                                     --n2_p:=null;
            n3_p        := NULL;
            cena_p2q    := NULL;
         END IF;                                                         -- 31

         IF sn_pr IS NOT NULL AND op_pr IN (2, 3)
         THEN                                            -- 2 - sale  3 - move
            kl_p2   := ROUND (SN_PR / NVL (cena_p2, k.cena), 0);
            l_koeff := ROUND (sn_pr / n2_p_ar, 5);

            IF NVL (kl_p2, 0) != 0
            THEN cena_pr := ROUND (NVL (sumb_pr, s_pr_op) * l_koeff / NVL (kl_p2, 1), 2);
            ELSE cena_pr := 0;
            END IF;

            tr.cena_p2  := cena_pr;
            tr.nls_p1   := 'sale';

            IF l_kv != 980
            THEN cena_prq := gl.p_icurval (l_kv, cena_pr * 100, l_dat_pr) / 100;
            ELSE cena_prq := cena_pr;
            END IF;
         END IF;

         IF sn_pr IS NOT NULL AND op_pr = 20
         THEN
            l_koeff     := 1;
            if NVL (cena_p2, k.cena) != 0
            then kl_p2       := ROUND (SN_PR / NVL (cena_p2, k.cena), 0);
            else kl_p2       := SN_PR;
            end if;
            cena_pr     := f_cena_cp (k.id, l_dat_pr);
            tr.cena_p2  := cena_pr;
            tr.nls_p1   := 'op=20';

            IF l_kv != 980
            THEN cena_prq := gl.p_icurval (l_kv, cena_pr * 100, l_dat_pr) / 100;
            ELSE cena_prq := cena_pr;
            END IF;
         END IF;

         IF sn_pr IS NOT NULL AND op_pr = 22
         THEN
            cena_pr     := l_nom;
            tr.cena_p2  := l_nom;
            tr.nls_p1   := 'op=22';

            IF l_kv != 980
            THEN cena_prq := gl.p_icurval (l_kv, cena_pr * 100, l_dat_pr) / 100;
            ELSE cena_prq := cena_pr;
            END IF;
         END IF;

         tr.g038    := sn_prq;
         tr.g039    := kl_p2;
         tr.g040    := cena_prq;
         tr.g043    := l_dat_pr;
         cena_p2q   := tr.g040;

         tr.kl2_p   := kl_p2;
         tr.dat_p2  := l_dat_pr;                                             --
         tr.n2_p    := sn_pr;

         tr.g046    := '';
         tr.g047    := '';
         tr.ref2    := l_ref_pr;

         IF l_ref2 IS NOT NULL AND op_pr IN (2, 20)
         THEN                                                     -- sale/gash
            l_ref_sale_repay := l_ref2;
            ---  torg. rez-t   *****+++++++++
            IF k.kv = 980
            THEN                             -- для kv!=980 через VP  доробити
               BEGIN
                  SELECT DECODE (o.dk,  0, 1,  1, -1) * o.s / 100
                    INTO s_63
                    FROM opldok o, opldok k, accounts ak
                   WHERE     o.acc = l_transaccount.acc_3739
                         AND o.dk = 1 - k.dk
                         AND o.stmt = k.stmt
                         AND o.tt = 'FXT'
                         AND k.tt = 'FXT'
                         AND o.REF = k.REF
                         AND o.REF = l_ref_sale_repay
                         AND ak.acc = k.acc
                         AND (--ak.nls like '6%' --or ak.nls like '8000%'    -- NBU
                              ak.nls LIKE '6393%' OR ak.nls LIKE '3800%') -- OBU
                         AND o.sos = 5
                         AND ROWNUM = 1;

                  --logger.info(title||k.ref||' sale '||l_ref_pr||' TR '||s_63);
                  LOG (title|| k.cp_id|| '  '|| k.REF|| ' sale '|| l_ref_pr|| ' TR '|| s_63,'INFO');
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN s_63 := 0;
               END;

               tr_31 := tr_31 + s_63;                                     -- ?
            ELSIF k.kv != 980
            THEN
               BEGIN
                  SELECT DECODE (o.dk,  0, 1,  1, -1) * k.s / 100    --o.s/100
                    INTO s_63
                    FROM opldok o, opldok k, accounts ak
                   WHERE o.acc = l_transaccount.acc_3739
                     AND o.dk = 1 - k.dk
                     --  and o.stmt=k.stmt     -- вал. номіналу
                     AND o.tt = 'FXT'
                     AND k.tt = 'FXT'
                     AND o.REF = k.REF
                     AND o.REF = l_ref_sale_repay
                     AND ak.acc = k.acc
                     AND (--ak.nls like '6%' or ak.nls like '8000%'
                          ak.nls LIKE '6393%' OR ak.nls LIKE '3800999%')
                     AND o.sos = 5
                     AND ROWNUM = 1;

                  LOG (title|| '* '|| k.cp_id|| ' '|| k.REF|| ' sale '|| l_ref_pr|| ' TR '|| s_63|| ' '|| ROUND (s_63 * l_kf_pr, 2)|| ' kf_pr='|| l_kf_pr,'INFO');
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN s_63 := 0;
               END;

               tr_31 := tr_31 + s_63;             -- перевірити ном-л чи екв-т
            ELSE
               s_63 := 0;
               tr_31 := 0;
            END IF;
         ELSE
            l_ref_sale_repay := NULL;
            s_63   := 0;
            tr_31  := 0;
         END IF;

         --tr.G068:=tr_31;  tr.tr1_31:=tr_31;
         tr.tr1_31  := s_63;
         tr.G068    := ROUND (s_63 * l_kf_pr, 2);

         -- в подальшому ТР вичитувати з CP_ARCH.t  і порівнювати
         --  ******   -- OBU/NBU
         --- Блок Вичитки дод-х реквізитів угоди, ЦП, емітента

         BEGIN
            l_pstor := 'Ні';
              SELECT                                                    --rnk,
                    MAX (DECODE (tag, 'DREYT', VALUE, NULL)) DREYT,
                     MAX (DECODE (tag, 'GREYT', VALUE, NULL)) GREYT,
                     MIN (DECODE (tag, 'NAGEN', VALUE, NULL)) NAGEN,
                     MIN (DECODE (tag, 'REYT', VALUE, NULL)) REYT,
                     MIN (DECODE (tag, 'VREYT', VALUE, NULL)) VREYT,
                     MIN (DECODE (tag, 'DOCIN', VALUE, NULL)) DOCIN,
                     MIN (DECODE (tag, 'EMI01', VALUE, NULL)) EMI01,
                     MIN (DECODE (tag, 'EMI02', VALUE, NULL)) EMI02,
                     --       min( decode(tag,'EMI03', value, null)) EMI03, min( decode(tag,'EMI04', value, null)) EMI04,
                     MIN (DECODE (tag, 'PSTOR', VALUE, NULL)) PSTOR
                INTO                                                  --l_rnk,
                    l_dreyt,
                     l_greyt,
                     l_nagen,
                     l_reyt,
                     l_vreyt,
                     l_docin,
                     l_emi01,
                     l_emi02,
                     l_pstor
                FROM cp_emiw
               WHERE rnk = NVL (k.rnk_e, -5)
            GROUP BY rnk;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN LOG (title|| '10: ISIN='|| k.cp_id|| ' ref='|| k.REF|| ' rnk='|| k.rnk_e,'INFO',0);
            WHEN OTHERS
            THEN LOG (title|| '11: ISIN='|| k.cp_id|| ' ref='|| k.REF|| ' rnk='|| k.rnk_e,'ERROR',0);
         END;

         IF l_pstor IS NOT NULL
         THEN
            tr.g009 := SUBSTR (l_pstor, 1, 3); -- пов'язана сторона з Customer_...
         END IF;

         l_p_kup := NULL;

         BEGIN
              SELECT MIN (DECODE (tag, 'OS_UM', VALUE, NULL)) OS_UM,
                     MIN (DECODE (tag, 'P_KUP', VALUE, NULL)) P_KUP,
                     MIN (DECODE (tag, 'RIVEN', VALUE, NULL)) RIVEN,
                     MIN (DECODE (tag, 'RIVE2', VALUE, NULL)) RIVE2,
                     MIN (DECODE (tag, 'ZRIVN', VALUE, NULL)) ZRIVN,
                     MIN (DECODE (tag, 'BKOT', VALUE, NULL)) BKOT,
                     MIN (DECODE (tag, 'DKOT', VALUE, NULL)) DKOT,
                     MIN (DECODE (tag, 'ZPRYC', VALUE, NULL)) ZPRYC,
                     MIN (DECODE (tag, 'KDERG', VALUE, NULL)) KDERG,
                     MIN (DECODE (tag, 'TYPCP', VALUE, NULL)) TYPCP,
                     MIN (DECODE (tag, 'KOD01', VALUE, NULL)) KOD01,
                     MIN (DECODE (tag, 'KOD02', VALUE, NULL)) KOD02        --,
                --    min( decode(tag,'KOD03', value, null)) KOD03, min( decode(tag,'KOD04', value, null)) KOD04,
                --    min( decode(tag,'KOD05', value, null)) KOD05, min( decode(tag,'KOD06', value, null)) KOD06,
                INTO l_os_um,
                     l_p_kup,
                     l_riven,
                     l_rive2,
                     l_zrivn,
                     l_bkot,
                     l_dkot,
                     l_zpryc,
                     l_kderg,
                     l_typcp,
                     l_kod01,
                     l_kod02
                FROM cp_kodw
               WHERE id = k.id
            GROUP BY id;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN LOG (title || '12: ISIN=' || k.cp_id || ' ref=' || k.REF, 'INFO',0);
            WHEN OTHERS
            THEN LOG (title || '14: ISIN=' || k.cp_id || ' ref=' || k.REF, 'ERROR',0);
         END;
         --   ********   ---  OBU/NBU
         tr.g013 := NULL;

         IF k.ky = 1
          THEN tr.g013 := 'щорічно';
         ELSIF k.ky = 2
          THEN tr.g013 := 'раз на півроку';
         ELSIF k.ky = 4
          THEN tr.g013 := 'щоквартально';
          ELSE tr.g013 := k.ky;
         END IF;

         tr.g003 := SUBSTR (l_typcp, 1, 1);
         tr.g006 := l_os_um;
         tr.g008 := k.okpo;
         tr.okpo := k.rnk_e;

         BEGIN
            tr.g030 := TO_NUMBER (SUBSTR (l_riven, 1, 1));
            tr.g067 := TO_NUMBER (SUBSTR (l_rive2, 1, 1));
         EXCEPTION
            WHEN OTHERS
            THEN tr.g030 := 9;
                 tr.g067 := 9;
         END;

         BEGIN
            tr.g071 := TO_NUMBER (l_bkot);
         EXCEPTION
            WHEN OTHERS
            THEN tr.g071 := 9;
         END;

         BEGIN
            tr.g073 := TO_DATE (l_DKOT, 'dd/mm/yyyy');
         EXCEPTION
            WHEN OTHERS
            THEN tr.g073 := TO_DATE ('01/01/2001', 'dd/mm/yyyy');
         END;

         tr.g075 := l_zpryc;                               -- tr.g074 := ....;
         tr.g076 := l_reyt;
         tr.g077 := l_nagen;
         tr.g079 := l_dreyt;
         tr.g080 := l_vreyt;
         tr.g081 := l_greyt;

         BEGIN
            tr.g078 := TO_DATE (l_DOCIN, 'dd/mm/yyyy');
         EXCEPTION
            WHEN OTHERS
            THEN tr.g078 := TO_DATE ('01/01/2000', 'dd/mm/yyyy');
         END;

         l_aukc := NULL;
         l_brdog := NULL;
         l_vdogo := NULL;
         l_bkot := NULL;
         l_frozr := NULL;
         l_froz2 := NULL;
         l_nmplo := NULL;
         l_bv_1 := NULL;
         l_kod01 := NULL;
         l_kod02 := NULL;

         --      ****   -- OBU/NBU
         BEGIN
            l_aukc  := NULL;
            l_brdog := NULL;
            l_vdogo := NULL;
            l_frozr := NULL;
            l_froz2 := NULL;
            l_nmplo := NULL;
            l_bv_1  := NULL;

            l_voper := NULL;
            l_repo  := NULL;
            l_dofer := NULL;
            l_zncin := NULL;
            l_znci2 := NULL;

              SELECT MIN (DECODE (tag, 'AUKC', VALUE, NULL)) AUKC,
                     MIN (DECODE (tag, 'BRDOG', VALUE, NULL)) BRDOG,
                     MIN (DECODE (tag, 'VDOGO', VALUE, NULL)) VDOGO,
                     MIN (DECODE (tag, 'FROZR', VALUE, NULL)) FROZR,
                     MIN (DECODE (tag, 'FROZ2', VALUE, NULL)) FROZ2,
                     MIN (DECODE (tag, 'NMPLO', VALUE, NULL)) NMPLO,
                     MIN (DECODE (tag, 'BV_1', VALUE, NULL)) BV_1,
                     MIN (DECODE (tag, 'VOPER', VALUE, NULL)) VOPER,
                     MIN (DECODE (tag, 'REPO', VALUE, NULL)) REPO,
                     MIN (DECODE (tag, 'DOFER', VALUE, NULL)),
                     MIN (DECODE (tag, 'ZNCIN', VALUE, NULL)),
                     MIN (DECODE (tag, 'ZNCI2', VALUE, NULL))
                INTO l_aukc,
                     l_brdog,
                     l_vdogo,
                     l_frozr,
                     l_froz2,
                     l_nmplo,
                     l_bv_1,
                     l_voper,
                     l_repo,
                     l_dofer,
                     l_zncin,
                     l_znci2
                FROM cp_refw
               WHERE REF = k.REF
            GROUP BY REF;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN LOG (title || '15: ISIN=' || k.cp_id || ' ref=' || k.REF, 'INFO', 0);
            WHEN OTHERS
            THEN LOG (title || '16: ISIN=' || k.cp_id || ' ref=' || k.REF, 'ERROR', 0);
         END;

         tr.g002 := NVL(SUBSTR (l_repo, 1, 3),'Ні');

         IF l_aukc IS NOT NULL
         THEN tr.g011 := l_aukc;
         END IF;

         IF tr.g036 IS NOT NULL
         THEN tr.g035 := '1';
         END IF;

         IF l_frozr IS NOT NULL
         THEN tr.g035 := SUBSTR (l_frozr, 1, 1);
         END IF;

         IF tr.g043 IS NOT NULL
         THEN tr.g042 := '1';
         END IF;

         IF l_froz2 IS NOT NULL
         THEN tr.g042 := SUBSTR (l_froz2, 1, 1);
         END IF;

         tr.g044 := NVL (l_brdog, i5.nd);

         IF tr.g043 IS NOT NULL
         THEN tr.g048 := '01';
         END IF;

         IF l_voper IS NOT NULL
         THEN tr.g048 := SUBSTR (l_voper, 1, 2);
         END IF;

         IF l_vdogo IS NOT NULL
         THEN tr.g047 := l_vdogo;
         END IF;

         BEGIN
            IF l_dofer IS NOT NULL
            THEN tr.g050 := TO_DATE (l_dofer, 'dd/mm/yyyy');
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN tr.g050 := TO_DATE ('01/01/2050', 'dd/mm/yyyy');
         END;

         tr.g029 := 1;

         IF l_zncin IS NOT NULL
         THEN
            BEGIN
               tr.g029 := TO_NUMBER (SUBSTR (l_zncin, 1, 1));
            EXCEPTION
               WHEN OTHERS
               THEN tr.g029 := 9;
            END;
         END IF;

         tr.g066 := 1;

         IF l_znci2 IS NOT NULL
         THEN
            BEGIN
               tr.g066 := TO_NUMBER (SUBSTR (l_znci2, 1, 1));
            EXCEPTION
               WHEN OTHERS
               THEN tr.g066 := 9;
            END;
         END IF;

         cena_p2 := cena_pr;
         -- check hierarchy_level
         begin
          select distinct first_value (hierarchy_id) over (ORDER BY cp_id ASC)||'>>'||last_value (hierarchy_id) over (ORDER BY cp_id ASC)
            into tr.HIERARCHY_LEVEL
            from
            (SELECT cp_id,
                   fdat date_from,
                   nvl(lead (fdat) over (partition by cp_id order by fdat),bankdate) date_to,
                   hierarchy_id
              FROM cp_hierarchy_hist
             WHERE cp_id = k.id AND fdat BETWEEN l_date_start AND l_date_finish);
         exception when no_data_found
                   then select to_char(hierarchy_id)
                          into tr.HIERARCHY_LEVEL
                          from cp_kod
                         where id = k.id ;
         end;

         BEGIN
            IF i9 > 0
            THEN
               -- clear same fields
               IF i9 > 1
               THEN
                  tr.g018       := NULL;
                  tr.g019       := NULL;
                  tr.g020       := NULL;
                  tr.g021       := NULL;
                  tr.g022       := NULL;
                  tr.g023       := NULL;
                  tr.g025       := NULL;
                  tr.g027       := NULL;
                  tr.g031       := NULL;
                  tr.g032       := NULL;
                  tr.g033       := NULL;
                  tr.g034       := NULL;
                  tr.g035       := NULL;
                  tr.g036       := NULL;
                  tr.g038       := sn_prq;
                  tr.g039       := kl_p2;
                  tr.g040       := cena_prq;
                  tr.g043       := l_dat_pr;
                  tr.g046       := '';
                  tr.g047       := '';
                  tr.g053       := NULL;
                  tr.g054       := NULL;
                  tr.g055       := NULL;
                  tr.g056       := NULL;
                  tr.g057       := NULL;
                  tr.g060       := NULL;
                  tr.g062       := NULL;
                  tr.g069       := NULL;
                  tr.kl2_p      := kl_p2;
                  tr.cena_p2    := cena_pr;
                  tr.dat_p2     := l_dat_pr;
                  tr.n2_p       := sn_pr;

                  tr.s_dp       := NULL;
                  tr.s_dk       := NULL;
                  tr.s_cp       := NULL;
                  tr.s_ck       := NULL;

                  tr.cf008_057  := NULL;
                  tr.cf008_058  := NULL;
                  tr.r4         := NULL;
               END IF;

               BEGIN
                  --tr.nls_p1:='sale';
                   bars_audit.info(title||'insert i9 > 1');
                  tr.nls := i9;
                  INSERT INTO CP_HIERARCHY_REPORT
                       VALUES tr;
               EXCEPTION
                  WHEN OTHERS
                  THEN LOG (title|| 'error* sale N ID='|| k.cp_id|| ' ref='|| k.REF|| ' i9='|| i9,'ERROR',0);
               END;
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN LOG (title || '20 error ID=' || k.cp_id || ' ref=' || k.REF, 'ERROR', 0);
         END;
      ----end if;    -- 44
      END LOOP;
     bars_audit.info(title||'i9 = '||to_char(i9));
      IF i9 < 1
      THEN                                                         -- NO saled
         BEGIN
          bars_audit.info(title||'insert i9 < 1');
            tr.nls_p1 := 'buy';
            INSERT INTO CP_HIERARCHY_REPORT
                 VALUES tr;
         EXCEPTION
            WHEN OTHERS
            THEN LOG (title|| 'error9 N ISIN='|| k.cp_id|| ' '|| k.dat_k|| ' ref='|| k.REF,'ERROR',0);
         END;
      END IF;
   END LOOP;

   LOG (title || 'finished ', 'INFO', 0);
   logger.info (title || 'finished ');
END;
/
show err;

PROMPT *** Create  grants  P_CP_HIERARCHY_REPORT ***
grant DEBUG,EXECUTE                                                          on P_CP_HIERARCHY_REPORT to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CP_HIERARCHY_REPORT.sql ========
PROMPT ===================================================================================== 
