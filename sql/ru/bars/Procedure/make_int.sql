

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/MAKE_INT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure MAKE_INT ***

  CREATE OR REPLACE PROCEDURE BARS.MAKE_INT (
   p_dat2        IN     DATE,           -- граничная дата начисления процентов
   p_runmode     IN     NUMBER DEFAULT 0, -- режим запуска (0 - начисление,1 - оплата)
   p_runid       IN     NUMBER DEFAULT 0,                         -- № запуска
   p_intamount      OUT NUMBER, -- сумма начисленных процентов (для 1-го счета)
   p_errflg         OUT BOOLEAN) -- флаг ошибки                 (для 1-го счета)
   PARALLEL_ENABLE
IS
   -- ====================================================================================
   -- Процедура начисления процентов (прогноз +/- оплата) VERSION 1.8.6 01.12.2015
   -- DPTWEB - расширенный функционал депозитной системы
   -- ACR_DAT - с возможностью сторно процентов
   -- SBER - специфика Сбербанка
   -- TAX - оподаткування процентних доходів ФО
   -- ====================================================================================
   --
   -- константы
   --
   modcode          CONSTANT CHAR (3)    NOT NULL := 'INT';
   title            CONSTANT CHAR (4)    NOT NULL := 'INT:';
   errmsgdim        CONSTANT NUMBER (38) NOT NULL := 3000;
   rowslimit        CONSTANT NUMBER (38) NOT NULL := 1000;
   autocommit       CONSTANT NUMBER (38) NOT NULL := 1000;

   --
   -- налогообложения депозитных счетов
   --
   tax_tt           CONSTANT VARCHAR2 (3) := '%15';
   tax_mil_tt       CONSTANT VARCHAR2 (3) := 'MIL';
   l_tax_method              INT := F_GET_PARAMS ('TAX_METHOD', 2); -- 2 - сплата податку та запис в проток / 3 - лише запис в протокол
   l_tax_required            INT := 0; -- переменная для определения необходимости снятия налога по ряду критериев
   l_tax_socfactor           INT := 1; -- переменная для определения необходимости снятия налога с учетом разделяемого остатка
   l_tax_s                   NUMBER := 0; -- временная переменная для суммирования налога по периодам в цикле
   l_tax_sq                  NUMBER := 0; -- временная переменная для суммирования налога по периодам в цикле (в эквиваленте)
   l_tax_mil_s               NUMBER := 0; -- временная переменная для суммирования налога по периодам в цикле
   l_tax_mil_sq              NUMBER := 0; -- временная переменная для суммирования налога по периодам в цикле (в эквиваленте)
   l_taxrow_tax_base_s       NUMBER := 0; -- база налогообложения для ПДФО
   l_taxrow_mil_tax_base_s   NUMBER := 0; -- база налогообложения для Военного сбора

   l_tax_base_soc            NUMBER := 0; -- сумма начисленных %% за период "социального остатка"
   l_tax_base_soc_sq         NUMBER := 0; -- сумма начисленных (экв) %% за период "социального остатка"

   l_tmp_s_soc               NUMBER := 0;
   l_tmp_sq_soc              NUMBER := 0;
   l_tmp_mil_s_soc           NUMBER := 0;
   l_tmp_mil_sq_soc          NUMBER := 0;

   l_tax_s_soc               NUMBER := 0;
   l_tax_sq_soc              NUMBER := 0;
   l_tax_mil_s_soc           NUMBER := 0;
   l_tax_mil_sq_soc          NUMBER := 0;

   TYPE t_tax_settings IS RECORD
   (
      tax_type         NUMBER,
      tax_int          NUMBER,    -- % налога;
      tax_date_begin   DATE,      -- начало действия периода налогообложения;
      tax_date_end     DATE       -- конец  действия периода налогообложения пост 4110; если дата конца действия постановы не установлена, то принимаем, +1 месяц от сегодня
   );

   TYPE t_taxdata IS TABLE OF t_tax_settings;

   TYPE t_soc_turns_rec IS RECORD
   (
      accd         NUMBER,
      soc_factor   NUMBER,    -- коэффициент социальной составляющей остатка;
      date_begin   DATE,      -- начало действия периода разделяемого остатка;
      date_end     DATE       -- конец  действия периода разделяемого остатка;
   );

   TYPE t_soc_turns_data IS TABLE OF t_soc_turns_rec;

   l_taxrow                  DPT_15LOG%ROWTYPE;
   l_taxrow_mil              DPT_15LOG%ROWTYPE;

   TYPE t_taxnls IS TABLE OF accounts.nls%TYPE INDEX BY accounts.branch%TYPE;

   G_TAXNLS_LIST             t_taxnls;
   G_TAXNLS_LIST_MILITARY    t_taxnls;

   --
   -- типы
   --
   TYPE t_rwdata IS TABLE OF ROWID;

   TYPE t_intrec IS RECORD
   (
      kf            VARCHAR2 (12),
      branch        VARCHAR2 (30),
      deal_id       NUMBER (38),
      deal_num      VARCHAR2 (35),
      deal_dat      DATE,
      cust_id       NUMBER (38),
      int_id        NUMBER (1),
      acc_id        NUMBER (38),
      acc_num       VARCHAR2 (15),
      acc_cur       NUMBER (3),
      acc_nbs       CHAR (4),
      acc_name      VARCHAR2 (38),
      acc_iso       CHAR (3),
      acc_open      DATE,
      acc_amount    NUMBER (38),
      int_details   VARCHAR2 (160),
      int_tt        CHAR (3),
      mod_code      CHAR (3),
      rw            ROWID
   );

   TYPE t_intdata IS TABLE OF t_intrec;

   --
   -- исключение
   --
   expt_int                  EXCEPTION;

   --
   -- переменные
   --
   l_bdate                   DATE := gl.bdate;
   l_userid                  staff.id%TYPE := gl.auid;
   l_basecur                 tabval.kv%TYPE := gl.baseval;
   l_rwlist                  t_rwdata := t_rwdata ();
   l_intlist                 t_intdata;
   l_taxlist                 t_taxdata;
   l_soc_turns_data          t_soc_turns_data;
   l_taxlist_mil             t_taxdata;                     -- Військовий збір
   l_docrec                  oper%ROWTYPE;
   l_cardrow                 int_accn%ROWTYPE;
   l_cleared                 BOOLEAN;
   l_errmsg                  VARCHAR2 (3000);
   l_acrdat                  DATE;
   l_stpdat                  DATE;
   l_cnt                     NUMBER (38) := 0;
   l_is8                     NUMBER := 0;

   --
   -- инициализация записи "заготовка платежа"
   --

   PROCEDURE init_docrec (p_docrec IN OUT oper%ROWTYPE)
   IS
   BEGIN
      p_docrec.REF := NULL;
      p_docrec.dk := NULL;
      p_docrec.vob := NULL;
      p_docrec.tt := NULL;
      p_docrec.nazn := NULL;
      p_docrec.userid := NULL;
      p_docrec.vdat := NULL;
      p_docrec.s := NULL;
      p_docrec.s2 := NULL;
      p_docrec.kv := NULL;
      p_docrec.kv2 := NULL;
      p_docrec.nlsa := NULL;
      p_docrec.nlsb := NULL;
      p_docrec.mfoa := NULL;
      p_docrec.mfob := NULL;
      p_docrec.nam_a := NULL;
      p_docrec.nam_b := NULL;
      p_docrec.id_a := NULL;
      p_docrec.id_b := NULL;
      p_docrec.tobo := NULL;
   END init_docrec;

   --
   -- расчет периода начисления
   --
   PROCEDURE get_dates (p_acrdat    IN OUT int_accn.acr_dat%TYPE,
                        p_stpdat    IN OUT int_accn.stp_dat%TYPE,
                        p_dat2      IN     DATE,
                        p_opendat   IN     accounts.daos%TYPE,
                        p_intid     IN     int_accn.id%TYPE,
                        p_amount    IN     NUMBER)
   IS
   BEGIN
      bars_audit.trace (
         '%s get_dates: запуск, (acr,stp,bd,open)=(%s,%s,%s,%s),id=%s, amount=%s',
         title,
         TO_CHAR (p_acrdat, 'dd/mm/yy'),
         TO_CHAR (p_stpdat, 'dd/mm/yy'),
         TO_CHAR (p_dat2, 'dd/mm/yy'),
         TO_CHAR (p_opendat, 'dd/mm/yy'),
         TO_CHAR (p_intid),
         TO_CHAR (p_amount));

      IF (p_acrdat IS NULL)
         OR (p_acrdat IS NOT NULL AND p_acrdat < p_dat2 AND p_stpdat IS NULL)
         OR (    p_acrdat IS NOT NULL
             AND p_acrdat < p_dat2
             AND p_acrdat < p_stpdat)
      THEN
         -- стартовая дата начисления (дата "с")
         p_acrdat :=
            CASE
               WHEN (p_acrdat IS NOT NULL) THEN p_acrdat + 1
               WHEN (p_intid IN (0, 2)) THEN p_opendat
               WHEN (p_amount IS NULL) THEN p_opendat
               ELSE p_opendat + 1
            END;
         -- конечная дата начисления (дата "по")
         p_stpdat :=
            CASE
               WHEN (p_stpdat IS NULL) THEN p_dat2
               WHEN (p_dat2 < p_stpdat) THEN p_dat2
               ELSE p_stpdat
            END;
      ELSE
         p_acrdat := NULL;
         p_stpdat := NULL;
      END IF;

      bars_audit.trace (
         '%s get_dates: период начисления %s-%s',
         title,
         TO_CHAR (p_acrdat, 'dd/mm/yy'),
         TO_CHAR (p_stpdat, 'dd/mm/yy'));
   END get_dates;

  --
  -- определение счетов для формирования платежа (наполнение "заготовки платежа")
  --
  procedure get_docaccs
  ( p_acra   in     int_accn.acra%type,
    p_acrb   in     int_accn.acrb%type,
    p_docrec in out oper%rowtype
  ) is
  begin

    bars_audit.trace( '%s get_docaccs: запуск, {acra, acrb} = {%s, %s}', title, to_char(p_acra), to_char(p_acrb) );

    -- процентный счет и контрсчет доходов/расходов
    select case   -- для траншів деп. ліні
             when ap.NBS = '8618' then ap.NLSALT
             else ap.NLS
           end,    ap.KV, substr(ap.NMS, 1, 38), cp.OKPO,
           ae.NLS, ae.KV, substr(ae.NMS, 1, 38), ce.OKPO
      into p_docrec.nlsa, p_docrec.kv,  p_docrec.nam_a, p_docrec.id_a,
           p_docrec.nlsb, p_docrec.kv2, p_docrec.nam_b, p_docrec.id_b
      from BARS.ACCOUNTS ap, BARS.CUSTOMER cp,
           BARS.ACCOUNTS ae, BARS.CUSTOMER ce
     where ap.ACC = p_acra
       and ae.ACC = p_acrb
       and ap.RNK = cp.RNK
       and ae.RNK = ce.RNK;

    bars_audit.trace( '%s get_docaccs: счета = {%s, %s}', title, p_docrec.nlsa, p_docrec.nlsb );

  exception
     when no_data_found then
       bars_audit.trace( '%s get_docaccs: счета не найдены', title );
  end get_docaccs;

  --
  -- определение реквизитов платежа (наполнение "заготовки платежа")
  --
  PROCEDURE get_docparams
  ( p_intrec   IN     t_intrec,
    p_fdat     IN     DATE,
    p_tdat     IN     DATE,
    p_tt       IN     oper.tt%TYPE,
    p_metr     IN     int_accn.metr%TYPE,
    p_docrec   IN OUT oper%ROWTYPE
  ) IS
   -- l_ratO  number;
   -- l_ratB  number;
   -- l_ratS  number;
   BEGIN
      bars_audit.trace (
         '%s get_docparams: запуск, с %s по %s, операция %s, метод %s, сумма %s, вал-А %s, вал-Б %s',
         title,
         TO_CHAR (p_fdat, 'dd.mm.yy'),
         TO_CHAR (p_tdat, 'dd.mm.yy'),
         p_tt,
         TO_CHAR (p_metr),
         TO_CHAR (p_docrec.s),
         TO_CHAR (p_docrec.kv),
         TO_CHAR (p_docrec.kv2));

      p_docrec.dk := CASE WHEN p_docrec.s > 0 THEN 0 ELSE 1 END;

      IF p_metr IN (3, 4, 5)
      THEN
         p_docrec.dk := 1 - p_docrec.dk;
      END IF;

      p_docrec.vob := CASE WHEN p_docrec.kv = p_docrec.kv2 THEN 6 ELSE 16 END;

      p_docrec.s := ABS (p_docrec.s);

      IF (p_docrec.kv = p_docrec.kv2)
      THEN
         p_docrec.s2 := p_docrec.s;
      ELSE
         -- gl.x_rat(l_ratO, l_ratB, l_ratS, p_docrec.kv, p_docrec.kv2, p_docrec.vdat);
         -- p_docrec.s2 := round(p_docrec.s * l_ratO);
         p_docrec.s2 := gl.p_icurval (p_docrec.kv, p_docrec.s, p_docrec.vdat);
      END IF;

      p_docrec.s2 := ABS (p_docrec.s2);

      p_docrec.tt := NVL (p_intrec.int_tt, p_tt);

      IF p_intrec.int_details IS NOT NULL
      THEN
         p_docrec.nazn := SUBSTR (p_intrec.int_details, 1, 160);
      ELSE
         IF p_intrec.mod_code IN ('DPT', 'SOC')
         THEN                                                   -- депозити ФО
            p_docrec.nazn := SUBSTR ( bars_msg.get_msg (modcode, 'INT_DETAILS_TITLE_DPT1') || ' '
                                      || p_intrec.deal_num || ' '|| bars_msg.get_msg (modcode, 'INT_DETAILS_TITLE_DPT2') || ' '
                                      || TO_CHAR (p_intrec.deal_dat, 'dd/mm/yyyy'),1,160);
         ELSE                                                      -- усі інші
            p_docrec.nazn := SUBSTR (bars_msg.get_msg (modcode, 'INT_DETAILS_TITLE') || ' ' || p_intrec.acc_num || '/' || p_intrec.acc_iso, 1,160);
         END IF;
      END IF;

      p_docrec.nazn :=
         SUBSTR (p_docrec.nazn || ' ' || bars_msg.get_msg (modcode, 'INT_DETAILS_FROM') || ' ' || TO_CHAR (p_fdat, 'dd.mm.yy') || ' '
            || bars_msg.get_msg (modcode, 'INT_DETAILS_TILL') || ' ' || TO_CHAR (p_tdat, 'dd.mm.yy') || ' '|| bars_msg.get_msg (modcode, 'INT_DETAILS_INCLUDE'),1,160);

      bars_audit.trace ('%s get_docparams: (ДК,вид,опер,ном,экв,назн) = {%s,%s,%s,%s,%s,%s}',
                        title,TO_CHAR (p_docrec.dk),TO_CHAR (p_docrec.vob),p_docrec.tt,TO_CHAR (p_docrec.s),TO_CHAR (p_docrec.s2),p_docrec.nazn);
   END get_docparams;

   --
   -- оплата документа
   --
   FUNCTION make_doc (p_docrec IN oper%ROWTYPE)
      RETURN oper.REF%TYPE
   IS
      l_ref   oper.REF%TYPE := NULL;
   BEGIN
      bars_audit.trace ('%s make_doc: запуск, %s -> %s, %s %s %s', title, p_docrec.nlsa
         || ' ('         || TO_CHAR (p_docrec.s)
         || '/'          || TO_CHAR (p_docrec.kv)
         || ')', p_docrec.nlsb
         || ' ('         || TO_CHAR (p_docrec.s2)
         || '/'          || TO_CHAR (p_docrec.kv2)
         || ')',         p_docrec.tt, TO_CHAR (p_docrec.vdat, 'dd.mm.yy'), p_docrec.nazn);


      --IF (p_docrec.branch <> SYS_CONTEXT ('bars_context', 'user_branch'))
      --THEN                                    -- змінюємо код бранча документа
               -- для правильного підбору рахунку по формулі з катрки операції
      --   bars_context.subst_branch (p_docrec.branch);
      --END IF;

      gl.REF (l_ref);

      gl.in_doc3 (ref_     => l_ref,
                  tt_      => p_docrec.tt,
                  vob_     => p_docrec.vob,
                  nd_      => SUBSTR (TO_CHAR (l_ref), 1, 10),
                  pdat_    => SYSDATE,
                  vdat_    => p_docrec.vdat,
                  dk_      => p_docrec.dk,
                  kv_      => p_docrec.kv,
                  s_       => p_docrec.s,
                  kv2_     => p_docrec.kv2,
                  s2_      => p_docrec.s2,
                  sk_      => NULL,
                  data_    => p_docrec.vdat,
                  datp_    => p_docrec.vdat,
                  nam_a_   => p_docrec.nam_a,
                  nlsa_    => p_docrec.nlsa,
                  mfoa_    => p_docrec.mfoa,
                  nam_b_   => p_docrec.nam_b,
                  nlsb_    => p_docrec.nlsb,
                  mfob_    => p_docrec.mfob,
                  nazn_    => p_docrec.nazn,
                  d_rec_   => NULL,
                  id_a_    => p_docrec.id_a,
                  id_b_    => p_docrec.id_b,
                  id_o_    => NULL,
                  sign_    => NULL,
                  sos_     => 0,
                  prty_    => NULL,
                  uid_     => p_docrec.userid);

      paytt (NULL,
             l_ref,
             p_docrec.vdat,
             p_docrec.tt,
             p_docrec.dk,
             p_docrec.kv,
             p_docrec.nlsa,
             p_docrec.s,
             p_docrec.kv2,
             p_docrec.nlsb,
             p_docrec.s2);

      bars_audit.trace ('%s make_doc: ref = %s', title, TO_CHAR (l_ref));
      -- bars_audit.financial(title||' '||bars_msg.get_msg(modcode, 'INTDOC_CREATED', to_char(l_ref)));

      RETURN l_ref;
   END make_doc;

   --
   -- формирование протокола автомат.операций
   --
   PROCEDURE fill_log (p_intrec   IN t_intrec,
                       p_runid    IN dpt_jobs_log.run_id%TYPE,
                       p_ref      IN dpt_jobs_log.REF%TYPE,
                       p_amount   IN dpt_jobs_log.int_sum%TYPE,
                       p_errmsg   IN dpt_jobs_log.errmsg%TYPE)
   IS
      l_dptid   dpt_jobs_log.dpt_id%TYPE;
      l_socid   dpt_jobs_log.contract_id%TYPE;
   BEGIN
      bars_audit.trace (
         '%s fill_log: запуск, %s, deal = %s, run = %s, ref = %s, sum = %s, %s',
         title,
         p_intrec.mod_code,
         TO_CHAR (p_intrec.deal_id),
         TO_CHAR (p_runid),
         TO_CHAR (p_ref),
         TO_CHAR (p_amount),
         p_errmsg);

      IF (p_intrec.mod_code = 'DPT' OR p_intrec.mod_code = 'DPU')
      THEN
         l_dptid := p_intrec.deal_id;
      END IF;

      IF p_intrec.mod_code = 'SOC'
      THEN
         l_socid := p_intrec.deal_id;
      END IF;

      dpt_jobs_audit.p_save2log (
         p_intrec.mod_code,
         p_runid,
         l_dptid,
         p_intrec.deal_num,
         p_intrec.branch,
         p_ref,
         p_intrec.cust_id,
         p_intrec.acc_num,
         p_intrec.acc_cur,
         NULL,
         p_amount,
         (CASE WHEN p_errmsg IS NULL THEN 1 ELSE -1 END),
         p_errmsg,
         l_socid);

      bars_audit.trace ('%s fill_log: выполнено', title);
   END fill_log;

   --
   -- Пошук рахунків для сплати податку
   --
   PROCEDURE INIT_TAXNLS_LIST
   IS
   BEGIN
      bars_audit.info (title || 'INIT_TAXNLS_LIST: entry.');

      for k in (select distinct branch, nls
     	from ( with tab as ( select NLS, BRANCH
                               from BARS.ACCOUNTS
            	              where nbs  = '3622'
                                and kv   = 980
                                and ob22 = '37'
                                and dazs is null )
             select branch, nls
               from tab
             union all
             select branch, case when LENGTH (branch) = 15
                                 then nbs_ob22_null ('3622', '37',branch || '06' || SUBSTR (branch, -5))
                                 else nbs_ob22_null ('3622', '37',branch)
                            end
              from branch)
            where LENGTH (branch) >= 15)
      LOOP
         G_TAXNLS_LIST (k.branch) := k.nls;
      -- bars_audit.trace( '%s INIT_TAXNLS_LIST (branch = %s, nls = %s).', title, k.branch, k.nls );

      END LOOP;

      bars_audit.trace ('%s INIT_TAXNLS_LIST: exit with %s accounts.',
                        title,
                        TO_CHAR (G_TAXNLS_LIST.COUNT));

    for n in ( select distinct branch, nls
        from ( with tab as ( select NLS, BRANCH
                               from BARS.ACCOUNTS
                              where nbs  = '3622'
                                and kv   = 980
                                and ob22 = '36'
                                and dazs is null )
             select branch, nls
               from tab
             union all
             select branch, case when LENGTH (branch) = 15
                                 then nbs_ob22_null ('3622', '36',branch || '06' || SUBSTR (branch, -5))
                                 else nbs_ob22_null ('3622', '36',branch)
                            end
              from branch)
            where LENGTH (branch) >= 15 )
      LOOP
         G_TAXNLS_LIST_MILITARY (n.branch) := n.nls;
      END LOOP;

      bars_audit.trace (
         '%s INIT_TAXNLS_LIST(MILITARY): exit with %s accounts.',
         title,
         TO_CHAR (G_TAXNLS_LIST_MILITARY.COUNT));
   END INIT_TAXNLS_LIST;
--
--
-- ====================================================================================
BEGIN
   bars_audit.trace (
      '%s старт, начисление по %s, режим %s, запуск № %s',
      title,
      TO_CHAR (p_dat2, 'dd.mm.yy'),
      TO_CHAR (p_runmode),
      TO_CHAR (p_runid));

   IF ( (p_runmode = 1) AND (l_tax_method = 2 OR l_tax_method = 3))
   THEN
      -- ініціалізація списку рахунків для сплати податку
      INIT_TAXNLS_LIST;
   END IF;

   LOOP
        SELECT kf,
               branch,
               deal_id,
               deal_num,
               deal_dat,
               cust_id,
               int_id,
               acc_id,
               acc_num,
               acc_cur,
               acc_nbs,
               acc_name,
               acc_iso,
               acc_open,
               acc_amount,
               int_details,
               int_tt,
               mod_code,
               ROWID rw
          BULK COLLECT INTO l_intlist
          FROM int_queue
         WHERE ROWNUM <= rowslimit
      ORDER BY branch;

      EXIT WHEN l_intlist.COUNT = 0;

      l_rwlist.EXTEND (l_intlist.COUNT);

      FOR i IN 1 .. l_intlist.COUNT
      LOOP
         BEGIN
            l_taxrow.tax_s := 0;
            l_taxrow.tax_sq := 0;
            l_tax_s := 0;
            l_tax_sq := 0;
            l_taxrow_mil.tax_s := 0;
            l_taxrow_mil.tax_sq := 0;
            l_tax_mil_s := 0;
            l_tax_mil_sq := 0;
            SAVEPOINT sp_beforeIntDoc;

            -- наполнение коллекции
            l_rwlist (i) := l_intlist (i).rw;

            p_intamount := NULL;
            p_errflg := FALSE;
            l_cleared := FALSE; -- флаг очистки ведомости начисленных процентов
            l_errmsg := NULL;                           -- сообщение об ошибке

            bars_audit.trace ('%s счет %s/%s', title, l_intlist (i).acc_num, l_intlist (i).acc_iso);

            -- чтение и блокировка процентной карточки
            BEGIN
                   SELECT *
                     INTO l_cardrow
                     FROM int_accn
                    WHERE acc = l_intlist (i).acc_id
                          AND id = l_intlist (i).int_id
               FOR UPDATE NOWAIT;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  -- не найдена проц.карточка № %s по счету %s/%s
                  l_errmsg :=
                     SUBSTR (bars_msg.get_msg (
                                modcode,
                                'INTCARD_NOT_FOUND',
                                TO_CHAR (l_intlist (i).int_id),
                                l_intlist (i).acc_num,
                                l_intlist (i).acc_iso),
                             1,
                             errmsgdim);
                  RAISE expt_int;
               WHEN OTHERS
               THEN
                  -- ошибка чтения и блокировки проц.карточки № %s по счету %s/%s : %s
                  l_errmsg :=
                     SUBSTR (bars_msg.get_msg (
                                modcode,
                                'INTCARD_READ_FAILED',
                                TO_CHAR (l_intlist (i).int_id),
                                l_intlist (i).acc_num,
                                l_intlist (i).acc_iso,
                                SQLERRM),
                             1,
                             errmsgdim);
                  RAISE expt_int;
            END;

            bars_audit.trace ('%s (acra, acrb, acrdat, stpdat) = (%s, %s, %s, %s)', title,
               TO_CHAR (l_cardrow.acra),
               TO_CHAR (l_cardrow.acrb),
               TO_CHAR (l_cardrow.acr_dat, 'dd.mm.yy'),
               TO_CHAR (l_cardrow.stp_dat, 'dd.mm.yy'));

            -- проверка метода начисления
            IF l_cardrow.metr NOT IN (0, 1, 2, 4, 5)
            THEN
               -- метод начисления № %s по счету %s/%s не поддерживается процедурой
               l_errmsg :=
                  SUBSTR (bars_msg.get_msg (modcode,
                                            'INTMETHOD_INVALID',
                                            TO_CHAR (l_cardrow.metr),
                                            l_intlist (i).acc_num,
                                            l_intlist (i).acc_iso),
                          1,
                          errmsgdim);
               RAISE expt_int;
            END IF;

            -- расчет периода начисления
            l_acrdat := l_cardrow.acr_dat;
            l_stpdat := l_cardrow.stp_dat;

            get_dates (p_acrdat    => l_acrdat,
                       p_stpdat    => l_stpdat,
                       p_dat2      => p_dat2,
                       p_opendat   => l_intlist (i).acc_open,
                       p_intid     => l_intlist (i).int_id,
                       p_amount    => l_intlist (i).acc_amount);

            IF (l_acrdat IS NULL OR l_stpdat IS NULL)
            THEN
               -- Период %s - %s закрыт для счета %s/%s
               bars_audit.trace ('%s указанный период закрыт для начисления для %s/%s',title, l_intlist (i).acc_num, l_intlist (i).acc_iso);
               l_errmsg := NULL;
               RAISE expt_int;
            END IF;

            -- расчет суммы начисленных процентов

            --delete from tmp_intn;
            --delete from tmp_intcn;

            DELETE FROM acr_intn;

            IF (    l_intlist (i).mod_code = 'DPT'
                AND l_intlist (i).int_id = 3
                AND l_cardrow.stp_dat <= l_stpdat)
            THEN   -- окончательная амортизация процентов по авансовому вкладу
               bars_audit.trace ('%s окончат.амортизация по аванс.вкладу...',title);

               BEGIN
                  SELECT ostb
                    INTO p_intamount
                    FROM accounts
                   WHERE pap = 1 AND acc = l_cardrow.acra;

                  bars_audit.trace ('%s остаток на счете амортизации - %s',title,TO_CHAR (p_intamount));
                  IF (p_intamount != 0)
                  THEN
                     INSERT INTO acr_intn (acc,
                                           id,
                                           fdat,
                                           tdat,
                                           ir,
                                           br,
                                           osts,
                                           acrd,
                                           remi)
                          VALUES (
                                    l_intlist (i).acc_id,
                                    l_intlist (i).int_id,
                                    l_acrdat,
                                    l_stpdat,
                                    acrn.fproc (l_intlist (i).acc_id,
                                                l_stpdat),
                                    0,
                                    fost (l_intlist (i).acc_id, l_stpdat),
                                    ABS (p_intamount),
                                    0);
                  END IF;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     -- ошибка формирования ведомости начисленных процентов по счету %s/%s: %s
                     l_errmsg :=
                        SUBSTR (bars_msg.get_msg (
                                   modcode,
                                   'INTCALC_FAILED',
                                   l_intlist (i).acc_num,
                                   l_intlist (i).acc_iso,
                                   'no active saldo for amortization found'),
                                1,
                                errmsgdim);
                     RAISE expt_int;
               END;
            ELSE            -- классический расчет суммы начисленных процентов
               BEGIN
                  acrn.p_int (l_intlist (i).acc_id,         -- внутр.номер основного счета
                              l_intlist (i).int_id,         -- код процентной карточки
                              l_acrdat,                     -- начальная дата начисления
                              l_stpdat,                     -- конечная дата начисления
                              p_intamount,                  -- сумма начисленных процентов OUT
                              l_intlist (i).acc_amount,     -- сумма начисления
                              1);                           -- режим выполнения
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     -- ошибка формирования ведомости начисленных процентов по счету %s/%s: %s
                     l_errmsg :=
                        SUBSTR (bars_msg.get_msg (modcode,
                                                  'INTCALC_FAILED',
                                                  l_intlist (i).acc_num,
                                                  l_intlist (i).acc_iso,
                                                  SQLERRM),
                                1,
                                errmsgdim);
                     RAISE expt_int;
               END;

               bars_audit.trace ('%s сумма начисленных процентов - %s',title,TO_CHAR (p_intamount));

               -- сжатие ведомости начисленных процентов
               BEGIN
                  acrn.p_cnds;
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     -- ошибка сжатия ведомости начисленных процентов по счету %s/%s: %s
                     l_errmsg :=
                        SUBSTR (bars_msg.get_msg (modcode,
                                                  'INTCNDSC_FAILED',
                                                  l_intlist (i).acc_num,
                                                  l_intlist (i).acc_iso,
                                                  SQLERRM),
                                1,
                                errmsgdim);
                     RAISE expt_int;
               END;
            END IF;

            p_intamount := ROUND (p_intamount);

            -- прогнозный расчет суммы начисленных процентов выполнен.
            -- начинается формирование документов по начислению процентов
            IF (p_runmode = 1)
            THEN
               -- чтение ведомости начисленных процентов по счету
               FOR acr_list
                  IN (  SELECT acc,
                               id,
                               fdat,
                               tdat,
                               ir,
                               br,
                               acrd,
                               remi,
                               osts
                          FROM acr_intn
                         WHERE acc = l_intlist (i).acc_id
                               AND id = l_intlist (i).int_id
                      ORDER BY fdat)
               LOOP
                  bars_audit.trace (
                     '%s период %s-%s по ставке %s/%s => %s',
                     title,
                     TO_CHAR (acr_list.fdat, 'dd.mm.yy'),
                     TO_CHAR (acr_list.tdat, 'dd.mm.yy'),
                     TO_CHAR (acr_list.ir),
                     TO_CHAR (acr_list.br),
                     TO_CHAR (acr_list.acrd));

                  -- фиксация даты последнего начисления
                  BEGIN
                     UPDATE int_accn
                        SET acr_dat = acr_list.tdat, s = acr_list.remi
                      WHERE acc = acr_list.acc AND id = acr_list.id;
                  EXCEPTION
                     WHEN OTHERS
                     THEN
                        -- ошибка записи даты последнего начисления по счету %s/%s: %s
                        l_errmsg :=
                           SUBSTR (bars_msg.get_msg (modcode,
                                                     'INTDAT_FIX_FAILED',
                                                     l_intlist (i).acc_num,
                                                     l_intlist (i).acc_iso,
                                                     SQLERRM),
                                   1,
                                   errmsgdim);
                        RAISE expt_int;
                  END;

                  -- очистка ведомости начисленных процентов от предыдущих попыток
                  IF (NOT l_cleared)
                  THEN
                     DELETE FROM tmp_intarc
                           WHERE     acc = acr_list.acc
                                 AND id = acr_list.id
                                 AND fdat >= acr_list.fdat;

                     l_cleared := TRUE;
                  END IF;

                  -- заполнение ведомости начисленных процентов
                  BEGIN
                     INSERT INTO tmp_intarc (id,
                                             acc,
                                             fdat,
                                             tdat,
                                             ir,
                                             br,
                                             osts,
                                             acrd,
                                             nls,
                                             nbs,
                                             kv,
                                             lcv,
                                             nms,
                                             userid,
                                             bdat)
                          VALUES (acr_list.id,
                                  acr_list.acc,
                                  acr_list.fdat,
                                  acr_list.tdat,
                                  acr_list.ir,
                                  acr_list.br,
                                  acr_list.osts,
                                  acr_list.acrd,
                                  l_intlist (i).acc_num,
                                  l_intlist (i).acc_nbs,
                                  l_intlist (i).acc_cur,
                                  l_intlist (i).acc_iso,
                                  l_intlist (i).acc_name,
                                  l_userid,
                                  l_bdate);
                  EXCEPTION
                     WHEN OTHERS
                     THEN
                        -- ошибка сохранения ведомости начисленных процентов по счету %s/%s: %s
                        l_errmsg :=
                           SUBSTR (bars_msg.get_msg (modcode,
                                                     'INTLIST_FIX_FAILED',
                                                     l_intlist (i).acc_num,
                                                     l_intlist (i).acc_iso,
                                                     SQLERRM),
                                   1,
                                   errmsgdim);
                        RAISE expt_int;
                  END;

                  -- оплата
                  IF (acr_list.acrd != 0)
                  THEN
                     bars_audit.trace ('%s сума платежу = %s',title,TO_CHAR (acr_list.acrd));

                     -- инициализация переменных
                     init_docrec (l_docrec);

                     -- определение реквизитов документа
                     l_docrec.s := acr_list.acrd;
                     l_docrec.vdat := l_bdate;
                     l_docrec.mfoa := l_intlist (i).kf;
                     l_docrec.mfob := l_intlist (i).kf;
                     l_docrec.tobo := l_intlist (i).branch;
                     l_docrec.branch := l_intlist (i).branch;

                     -- пошук рахунків (А = рах. відсотків, Б = рах. видатків)
                     get_docaccs (l_cardrow.acra, l_cardrow.acrb, l_docrec);

                     IF (l_docrec.nlsa IS NULL)
                     THEN -- не найден процентный и (или) контр.счет по счету %s/%s
                        l_errmsg :=
                           SUBSTR (bars_msg.get_msg (modcode,
                                                     'INTPAYACC_NOT_FOUND',
                                                     l_intlist (i).acc_num,
                                                     l_intlist (i).acc_iso),
                                   1,
                                   errmsgdim);
                        RAISE expt_int;
                     END IF;

                     -- Розрахунок та утримання податку з нарахованих відсотків
                     IF (l_tax_method = 2 OR l_tax_method = 3)
                     THEN
                       BEGIN
                         SELECT 1,
                                CASE
                                  WHEN a.nbs = '2620' AND a.ob22 IN ('20', '21')
                                  THEN 1
                                  ELSE 0
                                END
                           INTO l_tax_required, l_tax_socfactor
                           FROM BARS.ACCOUNTS a
                           JOIN BARS.CUSTOMER c
                             ON ( c.RNK = a.RNK )
                          WHERE a.acc = l_intlist (i).acc_id
                            AND ( ( a.NBS in ('2630','2635') ) OR
                                  ( a.NBS  =  '2620' AND a.ob22 Not in ('14', '17', '20', '21') ) -- ФО (Ощадбанк)
                             OR ( a.NBS in ('2600', '2610', '2615', '8610', '8615' ) AND          -- ФОП
                                  c.SED  =  '91' AND
                                  c.ISE IN ('14200', '14201', '14100', '14101') ) );
                       EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                           l_tax_required := 0;
                           l_tax_socfactor := 0;
                       END;

                        bars_audit.trace ('%s l_tax_required='|| TO_CHAR (l_tax_required) || ', l_intlist(i).acc_id=' || TO_CHAR (l_intlist (i).acc_id) || ', l_tax_socfactor=' || TO_CHAR (l_tax_socfactor),title);

                        IF (l_tax_required = 1)
                        THEN -- Расчет суммы для налогообложения по ДФЛ (налогом облагаются начисленные проценты позднее 01/08/2014)
                           l_taxrow.tax_s               := 0;
                           l_taxrow.tax_sq              := 0;
                           l_tax_s                      := 0;
                           l_tax_sq                     := 0;
                           l_taxrow_mil.tax_s           := 0;
                           l_taxrow_mil.tax_sq          := 0;
                           l_tax_mil_s                  := 0;
                           l_tax_mil_sq                 := 0;
                           l_taxrow.tax_type            := 1;

                           l_taxrow.dpt_id              := NVL (l_intlist (i).deal_id, 0);
                           l_taxrow.acra                := l_cardrow.acra;
                           l_taxrow.kv                  := l_intlist (i).acc_cur;
                           l_taxrow.int_date_begin      := acr_list.fdat;
                           l_taxrow.int_date_end        := acr_list.tdat;
                           l_taxrow.int_s               := acr_list.acrd;
                           l_taxrow.int_sq              := gl.p_icurval (l_taxrow.kv,acr_list.acrd,l_bdate);
                           l_taxrow.tax_nls             := G_TAXNLS_LIST (l_intlist (i).branch);
                           l_taxrow.tax_date_begin      := acr_list.fdat;
                           l_taxrow.tax_date_end        := acr_list.tdat;
                           l_taxrow.userid              := user_id;
                           l_taxrow.dwhen               := SYSTIMESTAMP;
                           l_taxrow.bdate               := l_bdate;

                           l_taxrow_mil.dpt_id          := NVL (l_intlist (i).deal_id, 0);
                           l_taxrow_mil.acra            := l_cardrow.acra;
                           l_taxrow_mil.kv              := l_intlist (i).acc_cur;
                           l_taxrow_mil.int_date_begin  := acr_list.fdat;
                           l_taxrow_mil.int_date_end    := acr_list.tdat;
                           l_taxrow_mil.int_s           := acr_list.acrd;
                           l_taxrow_mil.int_sq          := gl.p_icurval (l_taxrow_mil.kv, acr_list.acrd,l_bdate);
                           l_taxrow_mil.tax_nls         := G_TAXNLS_LIST_MILITARY (l_intlist (i).branch);

                           l_taxrow_mil.tax_date_begin  := acr_list.fdat;
                           l_taxrow_mil.tax_date_end    := acr_list.tdat;
                           l_taxrow_mil.userid          := user_id;
                           l_taxrow_mil.dwhen           := SYSTIMESTAMP;
                           l_taxrow_mil.bdate           := l_bdate;
                           l_taxrow_mil.tax_type        := 2;

                           SELECT tax_type,
                                  tax_int,
                                  dat_begin,
                                  dat_end
                             BULK COLLECT INTO l_taxlist
                             FROM TAX_SETTINGS
                            WHERE tax_type = l_taxrow.tax_type -- 1 Налог на пассивные доходы ФЛ
                                  AND (dat_end >= l_acrdat OR dat_end IS NULL);

                           SELECT tax_type,
                                  tax_int,
                                  dat_begin,
                                  dat_end
                             BULK COLLECT INTO l_taxlist_mil
                             FROM TAX_SETTINGS
                            WHERE tax_type = l_taxrow_mil.tax_type -- 2 Військовий збір
                                  AND (dat_end >= l_acrdat OR dat_end IS NULL);

                           BARS_AUDIT.trace ('%s Количество периодов налогообложения = '|| TO_CHAR (l_taxlist.COUNT),title);

                           FOR j IN 1 .. l_taxlist.COUNT
                           LOOP
                              bars_audit.trace ('%s Считаем налог за период с '|| TO_CHAR (GREATEST (l_acrdat,l_taxlist (j).tax_date_begin),'dd/mm/yyyy')|| ' по '|| TO_CHAR(NVL (l_taxlist (j).tax_date_end,l_stpdat),'dd/mm/yyyy'),title);

                              BEGIN
                                 acrn.p_int (
                                    l_intlist (i).acc_id,                       -- внутр.номер основного счета
                                    l_intlist (i).int_id,                       -- код процентной карточки
                                    GREATEST (acr_list.fdat,
                                              l_taxlist (j).tax_date_begin),    -- начальная дата начисления, для периода налогообложения из l_taxlist (TAX_SETTINGS)
                                    NVL (l_taxlist (j).tax_date_end,
                                         acr_list.tdat),                        -- конечная дата начисления, для периода налогообложения из l_taxlist (TAX_SETTINGS)
                                    l_taxrow.tax_base_s,                        -- сумма начисленных процентов OUT для периода налогообложения из l_taxlist (TAX_SETTINGS)
                                    l_intlist (i).acc_amount,                   -- сумма начисления
                                    0);                                         -- режим выполнения - Только узнать сумму процентов, для периода налогообложения из l_taxlist (TAX_SETTINGS)
                              EXCEPTION
                                 WHEN OTHERS
                                 THEN
                                    -- ошибка формирования ведомости начисленных процентов по счету %s/%s: %s
                                    l_errmsg :=
                                       SUBSTR (bars_msg.get_msg (
                                                  modcode,
                                                  'INTCALC_TAX_FAILED',
                                                  l_intlist (i).acc_num,
                                                  l_intlist (i).acc_iso,
                                                  SQLERRM),
                                               1,
                                               errmsgdim);
                                    RAISE expt_int;
                              END;

                              l_taxrow.tax_base_s  := ROUND (l_taxrow.tax_base_s, 0); -- так как в проводку реально вставляется округленное, остаток ->> acr_docs.int_rest
                              l_taxrow.tax_base_sq := gl.p_icurval (l_taxrow.kv,l_taxrow.tax_base_s,l_taxrow.bdate);
                              l_taxrow.tax_s       := ROUND (l_taxrow.tax_base_s* l_taxlist (j).tax_int,0);
                              l_taxrow.tax_sq      := gl.p_icurval (l_taxrow.kv,l_taxrow.tax_s,l_taxrow.bdate);
                              l_taxrow.round_err   := l_taxrow.tax_base_s * l_taxlist (j).tax_int - l_taxrow.tax_s;

                              bars_audit.trace ('%s сумма начисленных c '|| TO_CHAR (GREATEST (acr_list.fdat,l_taxlist (j).tax_date_begin),'dd/mm/yyyy')
                                                                         || ' по '|| TO_CHAR (NVL (l_taxlist (j).tax_date_end,acr_list.tdat),'dd/mm/yyyy')
                                                                         || ' (база для налогообложения = '|| TO_CHAR (l_taxrow.tax_base_s)|| ') ('|| TO_CHAR (l_taxlist (j).tax_int * 100)
                                                                         || '%) процентов = %s',title,'>>' || TO_CHAR (l_taxrow.tax_s));

                              l_tax_s   := NVL (l_tax_s, 0)  + NVL (l_taxrow.tax_s,  0);
                              l_tax_sq  := NVL (l_tax_sq, 0) + NVL (l_taxrow.tax_sq, 0);
                              l_taxrow_tax_base_s := NVL (l_taxrow_tax_base_s, 0) + NVL (l_taxrow.tax_base_s, 0);

                              IF l_tax_socfactor = 1
                              THEN
                                 BEGIN
                                    SELECT acc,
                                           case when (nvl(ost_real,0) + nvl(kos_real,0) - nvl(dos_real,0)) = 0
                                                then 0
                                                else nvl(ost_for_tax,0)/(nvl(ost_real,0) + nvl(kos_real,0) - nvl(dos_real,0))
                                           end,
                                           greatest(date1, l_acrdat),
                                           nvl(date2 - 1, NVL (l_taxlist (j).tax_date_end,l_stpdat))
                                      BULK COLLECT INTO l_soc_turns_data
                                      FROM dpt_soc_turns
                                     WHERE acc = l_intlist (i).acc_id
                                           AND (date1 BETWEEN l_acrdat AND acr_list.tdat
                                            OR (nvl(date2 - 1, NVL (l_taxlist (j).tax_date_end,l_stpdat)) BETWEEN l_acrdat AND acr_list.tdat));
                                 EXCEPTION
                                    WHEN OTHERS
                                    THEN
                                       bars_audit.trace ('%s_SOC' || SQLCODE || ' +За указанный период нет данных об оборотах в dpt_soc_turns по счету асс = '|| TO_CHAR (l_intlist (i).acc_id), title);
                                 END;

                                 BARS_AUDIT.trace ('%s_SOC Количество периодов оборотов (для расчета социального остатка)= '|| TO_CHAR (l_soc_turns_data.COUNT),title);

                                  l_tax_s_soc       := 0;
                                  l_tax_sq_soc      := 0;
                                  l_tax_base_soc    := 0;
                                  l_tax_base_soc_sq := 0;
                                  l_tmp_s_soc       := 0;
                                  l_tmp_sq_soc      := 0;

                                 FOR si IN 1 .. l_soc_turns_data.COUNT
                                 LOOP

                                    BARS_AUDIT.trace ('INT:_SOC' || ' soc_date_begin = '|| TO_CHAR (l_soc_turns_data (si).date_begin,'dd/mm/yyyy')||' , soc_date_end = '
                                       || TO_CHAR (l_soc_turns_data (si).date_end,'dd/mm/yyyy')|| ' , soc_factor = '|| TO_CHAR (l_soc_turns_data (si).soc_factor));

                                    BEGIN
                                       acrn.p_int (
                                          l_intlist (i).acc_id,                 -- внутр.номер основного счета
                                          l_intlist (i).int_id,                 -- код процентной карточки
                                          GREATEST (
                                             l_soc_turns_data (si).date_begin,
                                             l_taxlist (j).tax_date_begin),     -- начальная дата начисления, для периода налогообложения из l_taxlist (TAX_SETTINGS)
                                          NVL (
                                             l_taxlist (j).tax_date_end,
                                             l_soc_turns_data (si).date_end),   -- конечная дата начисления, для периода налогообложения из l_taxlist (TAX_SETTINGS)
                                          l_tax_base_soc,                       -- сумма начисленных процентов OUT для периода налогообложения из l_taxlist (TAX_SETTINGS)
                                          l_intlist (i).acc_amount,             -- сумма начисления
                                          0);                                   -- режим выполнения - Только узнать сумму процентов, для периода налогообложения из l_taxlist (TAX_SETTINGS)
                                    EXCEPTION
                                       WHEN OTHERS
                                       THEN
                                          -- ошибка формирования ведомости начисленных процентов по счету %s/%s: %s
                                          l_errmsg :=
                                             SUBSTR (bars_msg.get_msg (
                                                        modcode,
                                                        'INTCALC_TAX_FAILED',
                                                        l_intlist (i).acc_num,
                                                        l_intlist (i).acc_iso,
                                                        SQLERRM),
                                                     1,
                                                     errmsgdim);
                                          RAISE expt_int;
                                    END;

                                    l_tax_base_soc      :=  ROUND (l_tax_base_soc, 0); -- так как в проводку реально вставляется округленное, остаток ->> acr_docs.int_rest
                                    l_tax_base_soc_sq   :=  gl.p_icurval (l_taxrow.kv,l_tax_base_soc,l_taxrow.bdate);

                                    --считаю разницу (налог с соцфактором)- (налог без соцфактора) чтобы потом ПРИБАВИТЬ к сумме налога за весь период
                                    if l_soc_turns_data (si).soc_factor < 1
                                        then l_tmp_s_soc         :=  ROUND((l_tax_base_soc * l_taxlist (j).tax_int * l_soc_turns_data (si).soc_factor) - (l_tax_base_soc * l_taxlist (j).tax_int),0);
                                        else l_tmp_s_soc         :=  0;
                                    end if;

                                    l_tax_s_soc     :=  NVL (l_tax_s_soc, 0) + NVL (l_tmp_s_soc, 0);
                                    l_tax_sq_soc    :=  NVL (l_tax_sq_soc, 0) + gl.p_icurval (l_taxrow.kv,l_tmp_s_soc,l_taxrow.bdate);

                                    bars_audit.trace('l_tax_base_soc = '||to_char(l_tax_base_soc)||' for --->' ||
                                                    to_char(GREATEST (l_soc_turns_data (si).date_begin,l_taxlist (j).tax_date_begin),'dd/mm/yyyy')||
                                                    ' - '|| to_char(NVL (l_taxlist (j).tax_date_end,l_soc_turns_data (si).date_end),'dd/mm/yyyy'));
                                    bars_audit.trace('l_tmp_s_soc = '||to_char(l_tmp_s_soc)||'l_tax_s_soc = '||to_char(l_tax_s_soc)||', l_tax_sq_soc = '|| to_char(l_tax_sq_soc));

                                    l_taxrow.tax_socinfo :=substr(NVL (l_taxrow.tax_socinfo, '')|| TO_CHAR (l_soc_turns_data (si).soc_factor)
                                                           || ' ('|| TO_CHAR (l_soc_turns_data (si).date_begin,'dd/mm/yyyy')|| '-'
                                                           || TO_CHAR (l_soc_turns_data (si).date_end,'dd/mm/yyyy')|| ') base ='|| TO_CHAR (l_tax_base_soc)|| ', l_tmp_s_soc='|| TO_CHAR (l_tmp_s_soc)|| ';',2000);
                                 END LOOP;
                              END IF;
                           END LOOP;
                           FOR z IN 1 .. l_taxlist_mil.COUNT
                           LOOP
                              bars_audit.trace ('%s Считаем Военный сбор за период с '|| TO_CHAR (GREATEST (l_acrdat,l_taxlist_mil (z).tax_date_begin),'dd/mm/yyyy')
                                                || ' по '|| TO_CHAR (NVL (l_taxlist_mil (z).tax_date_end,l_stpdat),'dd/mm/yyyy'),title);

                              BEGIN
                                 acrn.p_int (
                                    l_intlist (i).acc_id,                       -- внутр.номер основного счета
                                    l_intlist (i).int_id,                       -- код процентной карточки
                                    GREATEST (
                                       acr_list.fdat,
                                       l_taxlist_mil (z).tax_date_begin),       -- начальная дата начисления, для периода налогообложения из l_taxlist (TAX_SETTINGS)
                                    NVL (l_taxlist_mil (z).tax_date_end,
                                         acr_list.tdat),                        -- конечная дата начисления, для периода налогообложения из l_taxlist (TAX_SETTINGS)
                                    l_taxrow_mil.tax_base_s,                    -- сумма начисленных процентов OUT для периода налогообложения из l_taxlist (TAX_SETTINGS)
                                    l_intlist (i).acc_amount,                   -- сумма начисления
                                    0);                                         -- режим выполнения - Только узнать сумму процентов, для периода налогообложения из l_taxlist (TAX_SETTINGS)
                              EXCEPTION
                                 WHEN OTHERS
                                 THEN
                                    -- ошибка формирования ведомости начисленных процентов по счету %s/%s: %s
                                    l_errmsg :=
                                       SUBSTR (bars_msg.get_msg (
                                                  modcode,
                                                  'INTCALC_TAX_FAILED',
                                                  l_intlist (i).acc_num,
                                                  l_intlist (i).acc_iso,
                                                  SQLERRM),
                                               1,
                                               errmsgdim);
                                    RAISE expt_int;
                              END;

                              l_taxrow_mil.tax_base_s   := ROUND (l_taxrow_mil.tax_base_s, 0); -- так как в проводку реально вставляется округленное, остаток ->> acr_docs.int_rest
                              l_taxrow_mil.tax_base_sq  := gl.p_icurval (l_taxrow_mil.kv,l_taxrow_mil.tax_base_s,l_taxrow_mil.bdate);
                              l_taxrow_mil.tax_s        := ROUND (l_taxrow_mil.tax_base_s* l_taxlist_mil (z).tax_int,0);
                              l_taxrow_mil.tax_sq       := gl.p_icurval (l_taxrow_mil.kv,l_taxrow_mil.tax_s,l_taxrow_mil.bdate);
                              l_taxrow_mil.round_err    := l_taxrow_mil.tax_base_s * l_taxlist_mil (z).tax_int - l_taxrow_mil.tax_s;

                              bars_audit.trace ('%s сумма начисленных c '|| TO_CHAR (GREATEST (acr_list.fdat,l_taxlist_mil (z).tax_date_begin),'dd/mm/yyyy')
                                                || ' по '|| TO_CHAR (NVL (l_taxlist_mil (z).tax_date_end,acr_list.tdat),'dd/mm/yyyy')
                                                || ' (база для налогообложения = '|| TO_CHAR (l_taxrow_mil.tax_base_s)|| ') ('|| TO_CHAR (l_taxlist_mil (z).tax_int * 100)
                                                || '%) процентов = %s',title, '>>' || TO_CHAR (l_taxrow_mil.tax_s));

                              l_tax_mil_s               := NVL (l_tax_mil_s, 0)  + NVL (l_taxrow_mil.tax_s, 0);
                              l_tax_mil_sq              := NVL (l_tax_mil_sq, 0) + NVL (l_taxrow_mil.tax_sq, 0);
                              l_taxrow_mil_tax_base_s   := NVL (l_taxrow_mil_tax_base_s, 0) + NVL (l_taxrow_mil.tax_base_s, 0);

                              IF l_tax_socfactor = 1
                              THEN
                                 BEGIN
                                    SELECT acc,
                                           case when (nvl(ost_real,0) + nvl(kos_real,0) - nvl(dos_real,0)) = 0
                                                then 0
                                                else nvl(ost_for_tax,0)/(nvl(ost_real,0) + nvl(kos_real,0) - nvl(dos_real,0))
                                           end,
                                           greatest(date1, l_acrdat),
                                           nvl(date2 - 1,  NVL (l_taxlist_mil (z).tax_date_end,l_stpdat))
                                      BULK COLLECT INTO l_soc_turns_data
                                      FROM dpt_soc_turns
                                     WHERE acc = l_intlist (i).acc_id
                                           AND (date1 BETWEEN l_acrdat AND acr_list.tdat
                                            OR (nvl(date2 - 1,  NVL (l_taxlist_mil (z).tax_date_end,l_stpdat)) BETWEEN l_acrdat AND acr_list.tdat));
                                 EXCEPTION
                                    WHEN OTHERS
                                    THEN
                                       bars_audit.trace ('%s_SOC' || SQLCODE|| ' +За указанный период нет данных об оборотах в dpt_soc_turns по счету асс = '|| TO_CHAR (l_intlist (i).acc_id),title);
                                 END;

                                 BARS_AUDIT.trace ('%s_SOC Количество периодов оборотов (для расчета социального остатка)= '|| TO_CHAR (l_soc_turns_data.COUNT),title);
                                 l_tax_mil_s_soc   := 0;
                                 l_tax_mil_sq_soc  := 0;
                                 l_tmp_mil_s_soc   := 0;
                                 l_tmp_mil_s_soc   := 0;

                                 FOR si IN 1 .. l_soc_turns_data.COUNT
                                 LOOP
                                    BARS_AUDIT.trace ('INT:_SOC'
                                                      || ' soc_date_begin = '|| TO_CHAR (l_soc_turns_data (si).date_begin,'dd/mm/yyyy')
                                                      || ' , soc_date_end = '|| TO_CHAR (l_soc_turns_data (si).date_end,'dd/mm/yyyy')
                                                      || ' , soc_factor = '  || TO_CHAR (l_soc_turns_data (si).soc_factor));

                                    BEGIN
                                       acrn.p_int (
                                          l_intlist (i).acc_id,                 -- внутр.номер основного счета
                                          l_intlist (i).int_id,                 -- код процентной карточки
                                          GREATEST (
                                             l_soc_turns_data (si).date_begin,
                                             l_taxlist_mil (z).tax_date_begin), -- начальная дата начисления, для периода налогообложения из l_taxlist (TAX_SETTINGS)
                                          NVL (
                                             l_taxlist_mil (z).tax_date_end,
                                             l_soc_turns_data (si).date_end),   -- конечная дата начисления, для периода налогообложения из l_taxlist (TAX_SETTINGS)
                                          l_tax_base_soc,                       -- сумма начисленных процентов OUT для периода налогообложения из l_taxlist (TAX_SETTINGS)
                                          l_intlist (i).acc_amount,             -- сумма начисления
                                          0);                                   -- режим выполнения - Только узнать сумму процентов, для периода налогообложения из l_taxlist (TAX_SETTINGS)
                                    EXCEPTION
                                       WHEN OTHERS
                                       THEN
                                          -- ошибка формирования ведомости начисленных процентов по счету %s/%s: %s
                                          l_errmsg :=
                                             SUBSTR (bars_msg.get_msg (
                                                        modcode,
                                                        'INTCALC_TAX_FAILED',
                                                        l_intlist (i).acc_num,
                                                        l_intlist (i).acc_iso,
                                                        SQLERRM),
                                                     1,
                                                     errmsgdim);
                                          RAISE expt_int;
                                    END;

                                    l_tax_base_soc      := ROUND (l_tax_base_soc, 0); -- так как в проводку реально вставляется округленное, остаток ->> acr_docs.int_rest
                                    l_tax_base_soc_sq   := nvl(l_tax_base_soc_sq,0) + gl.p_icurval (l_taxrow_mil.kv,l_tax_base_soc,l_taxrow_mil.bdate);

                                    --считаю разницу (налог с соцфактором)- (налог без соцфактора) чтобы потом ПРИБАВИТЬ к сумме налога за весь период
                                    if l_soc_turns_data (si).soc_factor < 1
                                        then l_tmp_mil_s_soc         :=  ROUND ((l_tax_base_soc* l_taxlist_mil (z).tax_int * l_soc_turns_data (si).soc_factor) - (l_tax_base_soc * l_taxlist_mil (z).tax_int),0);
                                        else l_tmp_mil_s_soc         :=  0;
                                    end if;

                                    l_tax_mil_s_soc     :=  NVL (l_tax_mil_s_soc, 0) + NVL (l_tmp_mil_s_soc, 0);
                                    l_tax_mil_sq_soc    :=  NVL (l_tax_mil_sq_soc, 0)+ gl.p_icurval (l_taxrow_mil.kv,l_tmp_mil_s_soc,l_taxrow_mil.bdate);

                                    bars_audit.trace('l_tax_base_soc = '||to_char(l_tax_base_soc)||' for --->' ||
                                                    to_char(GREATEST (l_soc_turns_data (si).date_begin,l_taxlist (z).tax_date_begin),'dd/mm/yyyy')||
                                                    ' - '|| to_char(NVL (l_taxlist (z).tax_date_end,l_soc_turns_data (si).date_end),'dd/mm/yyyy') );
                                    bars_audit.trace('l_tmp_mil_s_soc = '||to_char(l_tmp_mil_s_soc)||'l_tax_mil_s_soc = '||to_char(l_tax_mil_s_soc)||', l_tax_mil_sq_soc = '|| to_char(l_tax_mil_sq_soc));

                                    l_taxrow_mil.tax_socinfo := substr(NVL (l_taxrow.tax_socinfo, '') || TO_CHAR (l_soc_turns_data (si).soc_factor) || ' ('|| TO_CHAR (l_soc_turns_data (si).date_begin,'dd/mm/yyyy')
                                       || '-'|| TO_CHAR (l_soc_turns_data (si).date_end,'dd/mm/yyyy') || ') base =' || TO_CHAR (l_tax_base_soc) || ', l_tmp_mil_s_soc='|| TO_CHAR (l_tmp_mil_s_soc)|| ';',2000);
                                 END LOOP;
                              ELSE
                               l_tax_s_soc      := 0;
                               l_tax_sq_soc     := 0;
                               l_tax_mil_s_soc  := 0;
                               l_tax_mil_sq_soc := 0;
                              END IF;
                           END LOOP;

                           l_taxrow.tax_s       := CASE WHEN (l_tax_s + l_tax_s_soc) >=0            THEN l_tax_s + l_tax_s_soc              ELSE 0 END;
                           l_taxrow.tax_sq      := CASE WHEN (l_tax_sq + l_tax_sq_soc) >=0          THEN l_tax_sq + l_tax_sq_soc            ELSE 0 END;
                           l_taxrow_mil.tax_s   := CASE WHEN (l_tax_mil_s  + l_tax_mil_s_soc) >=0   THEN l_tax_mil_s + l_tax_mil_s_soc      ELSE 0 END;
                           l_taxrow_mil.tax_sq  := CASE WHEN (l_tax_mil_sq + l_tax_mil_sq_soc) >=0  THEN l_tax_mil_sq + l_tax_mil_sq_soc    ELSE 0 END;

                           bars_audit.trace('%s l_taxrow.tax_sq = %s',      title, to_char(l_taxrow.tax_sq));
                           bars_audit.trace('%s l_taxrow_mil.tax_sq = %s',  title, to_char(l_taxrow_mil.tax_sq));

                            -- убираю ошибки округления
                           if l_tax_base_soc_sq = l_taxrow.tax_base_s       and (l_taxrow.tax_s = 1     or l_taxrow.tax_sq = 1)
                           then     l_taxrow.tax_s      := 0;
                                    l_taxrow.tax_sq     := 0;
                           end if;
                           if l_tax_base_soc_sq = l_taxrow_mil.tax_base_s   and (l_taxrow_mil.tax_s = 1 or l_taxrow_mil.tax_sq = 1)
                           then
                                    l_taxrow_mil.tax_s  := 0;
                                    l_taxrow_mil.tax_sq := 0;
                           end if;

                           l_taxrow.TAX_SOCINFO     := substr(l_taxrow.TAX_SOCINFO,     1,1500);
                           l_taxrow_mil.TAX_SOCINFO := substr(l_taxrow_mil.TAX_SOCINFO, 1,1500);

                           INSERT INTO BARS.DPT_15LOG
                                VALUES l_taxrow;

                           INSERT INTO BARS.DPT_15LOG
                                VALUES l_taxrow_mil;

                           BARS_AUDIT.trace ('%s TAX ПДФО (l_taxrow.tax_s) = %s, (l_taxrow.tax_sq)= %s',title, TO_CHAR (l_taxrow.tax_s),TO_CHAR(l_taxrow.tax_sq));
                           BARS_AUDIT.trace ('%s TAX Военный сбор (l_taxrow_mil.tax_s) = %s,(l_taxrow_mil.tax_sq) = %s',title, TO_CHAR (l_taxrow_mil.tax_s),TO_CHAR (l_taxrow_mil.tax_sq));
                        END IF;


                        -- оплата
                        BEGIN
                          IF (l_intlist (i).mod_code = 'DPU')
                          THEN
                            l_docrec.nazn := SUBSTR ( DPU.get_intdetails (l_intlist (i).acc_num,l_intlist (i).acc_cur)
                                                      ||' '|| bars_msg.get_msg (modcode,'INT_DETAILS_FROM')
                                                      ||' '|| TO_CHAR (acr_list.fdat, 'dd.mm.yy')
                                                      ||' '|| bars_msg.get_msg (modcode,'INT_DETAILS_TILL')
                                                      ||' '|| TO_CHAR (acr_list.tdat, 'dd.mm.yy')
                                                      ||' '|| bars_msg.get_msg (modcode,'INT_DETAILS_INCLUDE'),1,160);

                            -- процедура оплати ВНУТРІШНІХ операцій депозитного модуля ЮО
                            dpu.pay_doc_int
                            ( p_dpuid => l_intlist (i).deal_id,
                              p_tt    => NVL (l_intlist (i).int_tt,l_cardrow.tt),
                              p_dk    => 0,
                              p_bdat  => l_bdate,
                              p_acc_A => l_cardrow.acra,
                              p_acc_B => l_cardrow.acrb,
                              p_sum_A => l_docrec.s,
                              p_nazn  => l_docrec.nazn,
                              p_ref   => l_docrec.REF,
                              p_tax   => (nvl(l_taxrow.tax_s,0) + nvl(l_taxrow_mil.tax_s,0))
                            );

                          ELSE                            -- інші, в т.ч. DPT
                             -- определение реквизитов документа
                             get_docparams (l_intlist (i),
                                            acr_list.fdat,
                                            acr_list.tdat,
                                            l_cardrow.tt,
                                            l_cardrow.metr,
                                            l_docrec);

                             l_docrec.REF := make_doc (l_docrec);

                             IF (l_intlist (i).deal_id IS NOT NULL AND l_intlist (i).mod_code = 'DPT')
                             THEN -- наполнение хранилища документов по депозитам ФО
                                dpt_web.fill_dpt_payments (l_intlist (i).deal_id, l_docrec.REF);
                             END IF;

                          END IF;

                          IF (l_tax_method = 2) AND (l_tax_required = 1)
                          THEN -- сплата податку

                            l_taxrow.REF := l_docrec.REF;

                            IF (NVL(l_taxrow.tax_sq, 0) > 0)
                            THEN

                              paytt( NULL,
                                     l_taxrow.REF,
                                     l_docrec.vdat,
                                     tax_tt, 1,
                                     l_docrec.kv, l_docrec.nlsa,    l_taxrow.TAX_S,
                                     l_basecur,   l_taxrow.TAX_NLS, l_taxrow.TAX_SQ );

                              bars_audit.trace ( title|| ' за період з %s по %s сума відсотків = %s сума податку = %s.',
                                                 to_char(l_taxrow.tax_date_begin,'dd/mm/yyyy'),
                                                 to_char(l_taxrow.tax_date_end,'dd/mm/yyyy'),
                                                 to_char(l_taxrow_tax_base_s),
                                                 to_char(l_taxrow.tax_s));
                            END IF;

                            IF (NVL (l_taxrow_mil.tax_sq, 0) > 0)
                            THEN

                              paytt( NULL,
                                     l_taxrow.REF,
                                     l_docrec.vdat,
                                     tax_mil_tt, 1,
                                     l_docrec.kv, l_docrec.nlsa,        l_taxrow_mil.TAX_S,
                                     l_basecur,   l_taxrow_mil.TAX_NLS, l_taxrow_mil.TAX_SQ );

                              bars_audit.trace( title || ' за період з %s по %s сума відсотків = %s сума податку (Військовий збір) = %s.',
                                                TO_CHAR (l_taxrow_mil.tax_date_begin,'dd/mm/yyyy'),
                                                TO_CHAR (l_taxrow_mil.tax_date_end,'dd/mm/yyyy'),
                                                TO_CHAR (l_taxrow_mil_tax_base_s),
                                                TO_CHAR (l_taxrow_mil.tax_s));
                            END IF;

                          ELSE
                             l_taxrow.REF := 0;
                          END IF;

                          -- наполнение acr_docs - хранилища документов по начислению процентов
                          acrn.acr_dati( l_intlist (i).acc_id,         -- внутр.номер основного счета
                                         l_intlist (i).int_id,         -- код процентной карточки
                                         l_docrec.REF,                 -- референс документа
                                         (acr_list.fdat - 1),          -- дата пред.начисления
                                         l_cardrow.s);                 -- хвост округления
                        EXCEPTION
                           WHEN OTHERS
                           THEN
                             -- ошибка оплаты документа по счету %s/%s : %s
                             l_errmsg := SUBSTR( bars_msg.get_msg( modcode, 'INTPAY_FAILED', l_intlist (i).acc_num, l_intlist (i).acc_iso, SQLERRM), 1, errmsgdim );
                             RAISE expt_int;
                        END;

                    END IF;

                  END IF; -- (l_docrec.s != 0)


                  -- протоколирование автоматических операций
                  IF (    p_runid > 0
                      AND l_intlist (i).deal_id > 0
                      AND l_intlist (i).mod_code IN ('DPT', 'DPU'))
                  THEN
                     fill_log (p_intrec   => l_intlist (i),
                               p_runid    => p_runid,
                               p_ref      => l_docrec.REF,
                               p_amount   => l_docrec.s,
                               p_errmsg   => NULL);
                  END IF;

               END LOOP;                                           -- acr_list

               -- фиксация даты посл.начисления для счетов, не попавших в acr_list

               UPDATE int_accn
                  SET acr_dat = l_stpdat
                WHERE acc = l_intlist (i).acc_id
                      AND id = l_intlist (i).int_id;

               -- промежуточная фиксация
               l_cnt := l_cnt + 1;

               IF l_cnt >= autocommit
               THEN
                  COMMIT;
                  l_cnt := 0;
               END IF;
            END IF;
         -- завершено формирование документов по начислению процентов

         EXCEPTION
            WHEN expt_int
            THEN
               IF l_errmsg IS NOT NULL
               THEN
                  p_errflg := TRUE;
                  bars_audit.ERROR ( SUBSTR (title || ' ' || l_errmsg, 1, errmsgdim));
               END IF;

               ROLLBACK TO sp_beforeIntDoc;


               -- протоколирование автоматических операций
               IF (    p_runmode = 1
                   AND p_runid > 0
                   AND l_intlist (i).deal_id > 0
                   AND l_intlist (i).mod_code IN ('DPT', 'DPU')
                   AND l_errmsg IS NOT NULL)
               THEN
                  fill_log (p_intrec   => l_intlist (i),
                            p_runid    => p_runid,
                            p_ref      => NULL,
                            p_amount   => NULL,
                            p_errmsg   => l_errmsg);
               END IF;
         END;
      END LOOP;

      FORALL i IN 1 .. l_intlist.COUNT
         DELETE FROM int_queue
               WHERE ROWID = l_rwlist (i);

      l_rwlist.delete;
   END LOOP;

   bars_audit.TRACE ('%s финиш, начисление по %s, режим %s, запуск № %s',title,
                      TO_CHAR (p_dat2, 'dd.mm.yy'),
                      TO_CHAR (p_runmode),
                      TO_CHAR (p_runid));
END make_int;
/
show err;

PROMPT *** Create  grants  MAKE_INT ***
grant EXECUTE                                                                on MAKE_INT        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on MAKE_INT        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/MAKE_INT.sql =========*** End *** 
PROMPT ===================================================================================== 
