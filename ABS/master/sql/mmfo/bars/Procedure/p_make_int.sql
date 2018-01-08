CREATE OR REPLACE PROCEDURE BARS.P_MAKE_INT
( acc_cur SYS_REFCURSOR,            -- подмножество счетов
  p_dat2  IN  DATE,                 -- дата, по которую начисляются %%
  p_mod   IN  NUMBER  DEFAULT 0,    -- 0 - прогноз, 1 - начисление+проводки
  p_runid IN  NUMBER  DEFAULT 0,    -- № запуска
  p_int   OUT NUMBER,               -- сумма нач.%% (для 1-го счета)
  p_err   OUT BOOLEAN               -- флаг ошибки  (для 1-го счета)
) IS
  -- Процедура начисления процентов (прогноз  +/- оплата)
  --               БАНК "ПРАВЕКС"
  --      мульти-МФО схема с иерархическими отделениями
  --      С возможностью сторно процентов
  -- VERSION 1.8 17.07.15
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   23.07.08 Инна  ACR_DAT: уточнена дата пред.начисления для acrn.acr_dati.
   14.07.08 Инна  ACR_DAT: в acrn.acr_dati передается нач.дата начисления в текущ.периоде.
   03.06.08 Инна  PRAVEX: для группового начисления - фиксация каждые 100 строк.
   13.03.08 Инна  В dpt_jobs_audit.p_save2log передается № договора.
   11.07.07 Инна  PRAVEX: после начисления %% по вкладам и
                  формирования платежа вызывается dpt_web.fill_dpt_payments.
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
  -- ------------------------------------------------------------------
  -- фиксация типа данных и маск.размерности для текстов сообщений
  g_errmsg        varchar2(3000);
  g_errmsg_dim    constant number(38) not null := 3000;
  errmsgdim       constant number(38) not null := 3000;
  autocommit      constant number(38) not null := 100;
  modcode         constant char(5)    not null := 'P_INT';
  title           constant char(6)    not null := 'P_INT:';
  -- ------------------------------------------------------------------
  -- с p_mod = 0 передавать курсор только с одним счетом, иначе бред!!!
  -- наследство из курсора
  l_bdate    DATE;                  -- банк.дата подразделения
  l_mfo      VARCHAR2(12);          -- МФО подразделения
  l_pens     social_contracts.contract_id%type;
  l_branch   accounts.branch%type;  -- код подразделения
  l_acc      int_accn.acc%type;     -- внутр.номер основного счета
  l_id       int_accn.id%type;      -- код %-ной карточки
  l_nls      accounts.nls%type;
  l_kv       accounts.kv%type;
  l_nbs      accounts.nbs%type;
  l_nms      accounts.nms%type;
  l_lcv      tabval.lcv%type;
  l_daos     accounts.daos%type;
  l_nazn     VARCHAR2(122); -- начало назначения платежа (для хвоста резервирую 38 символов!!!)
  l_ost      NUMBER;        -- остаток, на который начисляются %% (как правило NULL)
  -----------------------------
  l_userid   NUMBER;
  l_tt       int_accn.tt%type;
  l_acra     int_accn.acra%type;
  l_acrb     int_accn.acrb%type;
  l_acrdat   int_accn.acr_dat%type;
  l_stpdat   int_accn.stp_dat%type;
  l_metr     int_accn.metr%type;
  l_int      NUMBER;
  l_dpt      dpt_deposit.deposit_id%type;
  l_nd       dpt_deposit.nd%type;
  l_rnk      dpt_deposit.rnk%type;
  l_deleted  BOOLEAN := FALSE;
  l_kva      NUMBER; l_nlsa VARCHAR2(15); l_nama VARCHAR2(38); l_ida VARCHAR2(14);
  l_kvb      NUMBER; l_nlsb VARCHAR2(15); l_namb VARCHAR2(38); l_idb VARCHAR2(14);
  l_dk       INT;
  l_vob      NUMBER;
  l_ratO     NUMBER;
  l_ratB     NUMBER;
  l_ratS     NUMBER;
  l_acrdQ    NUMBER;
  l_ref      NUMBER;
  l_fullnazn VARCHAR2(160);
  l_errmsg   g_errmsg%type;
  l_remi     int_accn.s%type;
  l_cnt      number(38);
  expt_int   exception;

  -- дата начала налогообложения депозитных счетов 18/07/2014 Pavlenko
  tax_tt        constant    varchar2(3) := '%15';
  tax_mil_tt    constant    varchar2(3) := 'MIL';
  l_tax_method              int         := nvl(to_number(GetGlobalOption('TAX_METHOD')), 2);
  l_tax_required            int         := 0; -- переменная для определения необходимости снятия налога по ряду критериев
  l_tax_socfactor           int         := 1; -- переменная для определения необходимости снятия налога с учетом разделяемого остатка
  l_tax_s                   number      := 0; -- временная переменная для суммирования налога по периодам в цикле
  l_tax_sq                  number      := 0; -- временная переменная для суммирования налога по периодам в цикле (в эквиваленте)
  l_tax_mil_s               number      := 0; -- временная переменная для суммирования налога по периодам в цикле
  l_tax_mil_sq              number      := 0;  -- временная переменная для суммирования налога по периодам в цикле (в эквиваленте)
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

  type t_tax_settings  is record (tax_type        number,
                                  tax_int         number,     -- % налога;
                                  tax_date_begin  date,       -- начало действия периода налогообложения;
                                  tax_date_end    date        -- конец  действия периода налогообложения пост 4110; если дата конца действия постановы не установлена, то принимаем, +1 месяц от сегодня
                                 );
  type t_taxdata is table of t_tax_settings;

  TYPE t_soc_turns_rec IS RECORD
  ( accd         NUMBER,
    soc_factor   NUMBER,    -- коэффициент социальной составляющей остатка;
    date_begin   DATE,      -- начало действия периода разделяемого остатка;
    date_end     DATE       -- конец  действия периода разделяемого остатка;
  );

  TYPE t_soc_turns_data IS TABLE OF t_soc_turns_rec;
  l_soc_turns_data            t_soc_turns_data; -- учет социального остатка

  l_taxrow           DPT_15LOG%rowtype;
  l_taxrow_mil       DPT_15LOG%rowtype;
  type t_taxnls      is table of accounts.nls%type index by accounts.branch%type;
  G_TAXNLS_LIST               t_taxnls;
  G_TAXNLS_LIST_MILITARY      t_taxnls;

  l_taxlist     t_taxdata;
  l_taxlist_mil t_taxdata; -- Військовий збір
  l_tax_branch  varchar2(50);

  --
  -- Пошук рахунків для сплати податку
  --
  procedure INIT_TAXNLS_LIST
  is
  begin

    bars_audit.info( title || 'INIT_TAXNLS_LIST: entry.');

    for k in ( with tab as ( select NLS, BRANCH
                               from ACCOUNTS
                              where nbs  = '3622'
                                and kv   = 980
                                and ob22 = '37'
                                and dazs is null )
             select branch, nls
               from tab
              union
             select SubStr(branch, 1,15), nls
               from tab
              where branch like '/______/______/06____/' )
    loop

      G_TAXNLS_LIST(k.branch) := k.nls;

      -- bars_audit.trace( '%s INIT_TAXNLS_LIST (branch = %s, nls = %s).', title, k.branch, k.nls );

    end loop;

    bars_audit.trace( '%s INIT_TAXNLS_LIST: exit with %s accounts.', title, to_char(G_TAXNLS_LIST.COUNT) );

    for n in ( with tab as ( select NLS, BRANCH
                               from ACCOUNTS
                              where NBS  = '3622'
                                and KV   = 980
                                and OB22 = '36'
                                and DAZS is null )
             select branch, nls
               from tab
              union
             select SubStr(branch, 1,15), nls
               from tab
              where branch like '/______/______/06____/' )
    loop

      G_TAXNLS_LIST_MILITARY(n.branch) := n.nls;

    end loop;

    bars_audit.trace( '%s INIT_TAXNLS_LIST(MILITARY): exit with %s accounts.', title, to_char(G_TAXNLS_LIST_MILITARY.COUNT) );

  end INIT_TAXNLS_LIST;

BEGIN
  INIT_TAXNLS_LIST;
  p_err    := FALSE;

  -- курсор д.б.открыть к моменту вызова процедуры
  IF NOT acc_cur%ISOPEN THEN
     bars_audit.error('INT: закрыт курсор');
     p_err := TRUE;
     RETURN;
  END IF;

  -- p_runid м.б. пустой, потому что вызывается из разных кусков кода
  bars_audit.trace('INT: № запуска: '||to_char(p_runid));

  LOOP
  <<nextrec>> -- переход на другую строку курсора
  FETCH acc_cur INTO
    l_bdate, l_mfo, l_branch, l_acc,  l_id,   l_nls, l_kv,
    l_nbs,   l_nms, l_lcv,    l_daos, l_nazn, l_ost;
  EXIT
    WHEN acc_cur%NOTFOUND;

  bars_audit.trace('INT: основной счет %s/%s (#%s)',
               l_nls, to_char(l_kv), to_char(l_acc));

  -- код текущего пользователя
  l_userid := gl.aUID;
  l_int    := null;

  -- а вдруг это вклад
  BEGIN
    SELECT deposit_id, nd, rnk
      INTO l_dpt, l_nd, l_rnk
      FROM dpt_deposit
     WHERE acc = l_acc;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- а вдруг это пенсионнный договор
      BEGIN
        SELECT contract_id, contract_num, rnk
          INTO l_pens, l_nd, l_rnk
          FROM social_contracts
         WHERE acc = l_acc;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          l_dpt := NULL; l_pens := NULL; l_nd := '_';
      END;
  END;

        --     begin
        --        select  1
        --        into    l_tax_required
        --        from    accounts a, customer c
        --        where   a.acc = l_acc
        --        and     a.rnk = c.rnk
        --        and     (a.nbs in ('2630','2635') or a.nbs = '2620' and a.ob22 not in ('14', '17', '20', '21')
        --        or      a.nbs in ('2600','2610') and c.sed in ('91') and c.ise in ('14200','14201', '14100', '14101'));
        --     exception when no_data_found then l_tax_required := 0;
        --     end;
        --
      BEGIN
           SELECT 1
                , CASE
                  WHEN a.nbs = '2620' AND a.ob22 IN ('20','21')
                  THEN 1
                  ELSE 0
                  END
             INTO l_tax_required, l_tax_socfactor
             FROM accounts a
             join customer c
               on ( c.rnk = a.rnk )
            WHERE a.acc = l_acc
              AND ( a.nbs = '2630'
                    or
                    a.nbs = '2620' AND a.ob22 NOT IN ('14', '17') --, '20', '21')
                    or
                    a.nbs IN ('2600','2610') AND c.sed IN ('91') AND c.ise IN ('14100','14101','14200','14201')
                  );
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            l_tax_required := 0;
            l_tax_socfactor := 0;
      END;

    bars_audit.trace( '%s ( l_tax_required=%s, l_intlist(i).acc_id=%s, l_tax_socfactor=%s ).'
                    , title, to_char(l_tax_required), to_char(l_acc), to_char(l_tax_socfactor) );


    bars_audit.info('l_tax_required='||to_char(l_tax_required)||'l_acc='||to_char(l_acc));
    bars_audit.trace('%s счет %s/%s', title, l_nls, l_lcv);
  -- параметры %-ной карточки
  BEGIN
    SELECT NVL(tt, '%%1'), acra, acrb, acr_dat, stp_dat, metr, s
      INTO l_tt, l_acra, l_acrb, l_acrdat, l_stpdat, l_metr, l_remi
      FROM int_accn
     WHERE acc = l_acc
       AND id = l_id
    FOR UPDATE NOWAIT;
  bars_audit.trace('INT: асra = %s, acrb = %s ',to_char(l_acra), to_char(l_acrb));
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      bars_audit.trace('INT: отсутствует %-ная карточка с кодом '||to_char(l_id)
                 ||' по счету #'||to_char(l_acc));
      p_err := TRUE;
      GOTO nextrec;
    WHEN OTHERS THEN
      l_errmsg := SUBSTR('INT: ошибка начисления процентов '
                       ||'по счету #'||to_char(l_acc)||': '||SQLERRM, 1, g_errmsg_dim);
      bars_audit.error(l_errmsg);
      IF p_runid * (NVL(l_dpt, 0) + NVL(l_pens,0)) > 0 THEN
        dpt_jobs_audit.p_save2log
         (p_runid, l_dpt, l_nd, l_branch, null,
          l_rnk, null, l_kv, null, null,
          -1, l_errmsg, l_pens);
      END IF;
      p_err := TRUE;
      GOTO nextrec;
  END;

  -- проверки

  IF l_metr NOT IN (0, 1, 2, 4, 5)  THEN
     bars_audit.error('INT: метод начисления с кодом '||to_char(l_metr)
                ||' не поддерживается процедурой p-make_int');
     p_err := TRUE;
     GOTO nextrec;
  END IF;

  -- попали ли мы в период начисления?   (сравнение с NULL - всегда FALSE!!!)
  IF (l_acrdat IS NULL)                          OR
     (l_acrdat < p_dat2 AND l_stpdat IS NULL)    OR
     (l_acrdat < p_dat2 AND l_acrdat < l_stpdat)    THEN

      -- стартовая дата начисления
      IF l_acrdat IS NOT NULL THEN
         l_acrdat := l_acrdat + 1;
      ELSE
         IF l_id IN (0, 2) THEN
            l_acrdat := l_daos;
         ELSE
            IF l_ost IS NULL THEN
               l_acrdat := l_daos;
            ELSE
               l_acrdat := l_daos + 1;
            END IF;
         END IF;
      END IF;

      -- граничная дата начисления
     IF p_dat2 < l_stpdat OR l_stpdat IS NULL THEN
        l_stpdat := p_dat2;
     END IF;

    bars_audit.trace('INT: период начисления: '||to_char(l_acrdat,'DD/MM/YYYY')
                                        ||' - '||to_char(l_stpdat,'DD/MM/YYYY'));

  ELSE

      bars_audit.trace('INT: указанный период ЗАКРЫТ для начисления процентов');
      p_err := FALSE;
      p_int := 0;
      GOTO nextrec;

  END IF;

  -- расчет суммы начисленных %%
  BEGIN

    acrn.p_int (l_acc, l_id, l_acrdat, l_stpdat, l_int, l_ost, 1);

    if l_tax_method in (2,3) and l_tax_required = 1
    then -- Pavlenko tax

      -- Расчет суммы для налогообложения по ДФЛ (налогом облагаются начисленные проценты позднее 01/08/2014)
      begin
        select dptid
        into l_taxrow.dpt_id
        from dpt_accounts
        where accid = l_acc;
        exception when no_data_found then l_taxrow.dpt_id := nvl(l_acc,0);
      end;

      bars_audit.trace('l_cardrow.acra = '||to_char(l_acra));

            select tax_type, tax_int, dat_begin, dat_end
            bulk collect
            into l_taxlist
            from TAX_SETTINGS
            where tax_type = 1-- 1 Налог на пассивные доходы ФЛ
            and (dat_end >= l_acrdat or dat_end is null);

            select tax_type, tax_int, dat_begin, dat_end
            bulk collect
            into l_taxlist_mil
            from TAX_SETTINGS
            where tax_type = 2-- 2 Військовий збір
            and (dat_end >= l_acrdat or dat_end is null);

            l_taxrow.acra := l_acra;
            l_taxrow.kv   := l_kv;
            l_taxrow.int_date_begin := l_acrdat;
            l_taxrow.int_date_end   := l_stpdat;
            l_taxrow.int_s  := 0;
            l_taxrow.int_sq := 0;

            if length(l_branch)=15
            then l_tax_branch := l_branch||'06'||substr(l_branch,-5);
            else l_tax_branch := l_branch;
            end if;

            bars_audit.trace('TAX l_branch = '||to_char(l_branch));

            l_taxrow.tax_nls := G_TAXNLS_LIST(l_branch);

            bars_audit.trace('TAX l_taxrow.tax_nls = '||to_char(l_taxrow.tax_nls));

            l_taxrow.tax_date_begin:=l_acrdat;
            l_taxrow.tax_date_end :=l_stpdat;
            l_taxrow.tax_base_s := 0;
            l_taxrow.tax_base_sq := 0;
            l_taxrow.tax_s := 0;
            l_taxrow.tax_sq := 0;
            l_taxrow.ref := 0;
            l_taxrow.userid := user_id;
            l_taxrow.dwhen := sysdate;
            l_taxrow.bdate := l_bdate;
            l_taxrow.round_err := 0;

            l_taxrow_mil.dpt_id         := nvl(0,0);
            l_taxrow_mil.acra           := l_acra;
            l_taxrow_mil.kv             := l_kv;
            l_taxrow_mil.int_date_begin := l_acrdat;
            l_taxrow_mil.int_date_end   := l_stpdat;
            l_taxrow_mil.int_s          := 0;
            l_taxrow_mil.int_sq         := 0;
            l_taxrow_mil.tax_nls        := G_TAXNLS_LIST_MILITARY(l_branch);

            bars_audit.trace('TAX l_taxrow_mil.tax_nls = '||to_char(l_taxrow_mil.tax_nls));

            l_taxrow_mil.tax_date_begin := l_acrdat;
            l_taxrow_mil.tax_date_end   := l_stpdat;
            l_taxrow_mil.userid         := user_id;
            l_taxrow_mil.dwhen          := systimestamp;
            l_taxrow_mil.bdate          := l_bdate;
            l_taxrow_mil.tax_s := 0;
            l_taxrow_mil.tax_sq := 0;
            
            l_tax_s := 0;
            l_tax_sq := 0;
            l_tax_mil_s := 0;
            l_tax_mil_sq := 0;

            l_tax_base_soc := 0; 
            l_tax_base_soc_sq := 0;
            
            l_tmp_s_soc := 0;
            l_tmp_sq_soc := 0;
            l_tmp_mil_s_soc := 0;
            l_tmp_mil_sq_soc := 0;
            
            l_tax_s_soc := 0;
            l_tax_sq_soc := 0;
            l_tax_mil_s_soc := 0;
            l_tax_mil_sq_soc := 0;


            bars_audit.trace('Количество периодов налогообложения = '|| to_char(l_taxlist.count));

                     for j in 1..l_taxlist.count
                     loop
                      bars_audit.trace('%s Считаем налог за период с '
                                      || to_char(greatest(l_acrdat,l_taxlist(j).tax_date_begin),'dd/mm/yyyy')
                                      || ' по '
                                      || to_char(nvl(l_taxlist(j).tax_date_end,l_stpdat),'dd/mm/yyyy'));
                               begin
                                   acrn.p_int (l_acc,      -- внутр.номер основного счета
                                            l_id,         -- код процентной карточки
                                            greatest(l_acrdat,l_taxlist(j).tax_date_begin), -- начальная дата начисления, для периода налогообложения из l_taxlist (TAX_SETTINGS)
                                            nvl(l_taxlist(j).tax_date_end,l_stpdat),   -- конечная дата начисления, для периода налогообложения из l_taxlist (TAX_SETTINGS)
                                            l_taxrow.tax_base_s,         -- сумма начисленных процентов OUT для периода налогообложения из l_taxlist (TAX_SETTINGS)
                                            l_ost,     -- сумма начисления
                                            0);                          -- режим выполнения - Только узнать сумму процентов, для периода налогообложения из l_taxlist (TAX_SETTINGS)
                               exception
                                when others then
                                  -- ошибка формирования ведомости начисленных процентов по счету %s/%s: %s
                                  l_errmsg := substr(bars_msg.get_msg(modcode,
                                                                     'INTCALC_TAX_FAILED',
                                                                     l_acc,
                                                                     l_kv,
                                                                     sqlerrm), 1, errmsgdim);
                                  raise expt_int;
                              end;
                              l_taxrow.tax_base_s := round(l_taxrow.tax_base_s,0); -- так как в проводку реально вставляется округленное, остаток ->> acr_docs.int_rest
                              l_taxrow.tax_base_sq :=  gl.p_icurval(l_taxrow.kv, l_taxrow.tax_base_s, l_taxrow.bdate);
                              l_taxrow.tax_s := round(l_taxrow.tax_base_s*l_taxlist(j).tax_int,0);
                              l_taxrow.tax_sq := gl.p_icurval(l_taxrow.kv, l_taxrow.tax_s, l_taxrow.bdate);
                              l_taxrow.round_err := l_taxrow.tax_base_s*l_taxlist(j).tax_int - l_taxrow.tax_s;
                              bars_audit.trace('%s сумма начисленных c '|| to_char(greatest(l_acrdat,l_taxlist(j).tax_date_begin),'dd/mm/yyyy')
                                  || ' по '|| to_char(nvl(l_taxlist(j).tax_date_end,l_stpdat),'dd/mm/yyyy')
                                  ||' (база для налогообложения = '||to_char(l_taxrow.tax_base_s)|| ') ('
                                  || to_char (l_taxlist(j).tax_int*100) ||'%) процентов = %s', title, '>>'
                                  ||to_char(l_taxrow.tax_s));

                              l_tax_s   :=  nvl(l_tax_s,0)  + nvl(l_taxrow.tax_s,0);
                              l_tax_sq  :=  nvl(l_tax_sq,0) + nvl(l_taxrow.tax_sq,0);
                              bars_audit.trace('%s l_tax_s = %s', title, to_char(l_tax_s));
                          IF l_tax_socfactor = 1
                              THEN
                                 BEGIN
                                    SELECT acc,
                                           case when (nvl(ost_real,0) + nvl(kos_real,0) - nvl(dos_real,0)) = 0
                                                then 0
                                                else nvl(ost_for_tax,0)/(nvl(ost_real,0) + nvl(kos_real,0) - nvl(dos_real,0))
                                           end,
                                           date1,
                                           nvl(date2 - 1, l_stpdat)
                                      BULK COLLECT INTO l_soc_turns_data
                                      FROM dpt_soc_turns
                                     WHERE acc = l_acc;
--                                           AND date1 BETWEEN l_acrdat
--                                                         AND l_stpdat;
                                 EXCEPTION
                                    WHEN OTHERS
                                    THEN bars_audit.trace ('%s_SOC' || SQLCODE|| ' +За указанный период нет данных об оборотах в dpt_soc_turns по счету асс = '|| TO_CHAR (l_acc),title);
                                 END;

                                 BARS_AUDIT.trace ('%s_SOC Количество периодов оборотов (для расчета социального остатка)= '|| TO_CHAR (l_soc_turns_data.COUNT),title);
                                 FOR si IN 1 .. l_soc_turns_data.COUNT
                                 LOOP
                                    BARS_AUDIT.trace ('INT:_SOC' || ' soc_date_begin = '|| TO_CHAR (l_soc_turns_data (si).date_begin,'dd/mm/yyyy')|| ' , soc_date_end = '|| TO_CHAR (l_soc_turns_data (si).date_end,'dd/mm/yyyy')|| ' , soc_factor = '|| TO_CHAR (l_soc_turns_data (si).soc_factor));

                                    BEGIN
                                       acrn.p_int (
                                          l_acc,                                            -- внутр.номер основного счета
                                          l_id,                                             -- код процентной карточки
                                          GREATEST (    l_soc_turns_data (si).date_begin,
                                                        l_acrdat,
                                                        l_taxlist (j).tax_date_begin),          -- начальная дата начисления, для периода налогообложения из l_taxlist (TAX_SETTINGS)
                                          NVL (         l_soc_turns_data (si).date_end,
                                                        l_taxlist (j).tax_date_end),    -- конечная дата начисления, для периода налогообложения из l_taxlist (TAX_SETTINGS)
                                          l_tax_base_soc,                                   -- сумма начисленных процентов OUT для периода налогообложения из l_taxlist (TAX_SETTINGS)
                                          l_ost,                                            -- сумма начисления
                                          0);                                               -- режим выполнения - Только узнать сумму процентов, для периода налогообложения из l_taxlist (TAX_SETTINGS)
                                    EXCEPTION
                                       WHEN OTHERS
                                       THEN
                                          -- ошибка формирования ведомости начисленных процентов по счету %s/%s: %s
                                          l_errmsg :=
                                             SUBSTR (bars_msg.get_msg (
                                                        modcode,
                                                        'INTCALC_TAX_FAILED',
                                                        l_acc,
                                                        l_kv,
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
                                    l_tax_s_soc         :=  NVL(l_tax_s_soc, 0) + NVL (l_tmp_s_soc, 0);
                                    l_tax_sq_soc        :=  NVL (l_tax_sq_soc, 0) + gl.p_icurval (l_taxrow.kv,l_tmp_s_soc,l_taxrow.bdate);

                                    bars_audit.trace('l_tax_base_soc = '||to_char(l_tax_base_soc)||' for --->' ||
                                    to_char(GREATEST (l_soc_turns_data (si).date_begin,l_acrdat),'dd/mm/yyyy')||
                                    ' - '|| to_char(NVL (l_soc_turns_data (si).date_end,l_taxlist (j).tax_date_end),'dd/mm/yyyy'));
                                    bars_audit.trace('l_tmp_s_soc = '||to_char(l_tmp_s_soc)||'l_tax_s_soc = '||to_char(l_tax_s_soc)||', l_tax_sq_soc = '|| to_char(l_tax_sq_soc));

                                    l_taxrow.tax_socinfo := NVL (l_taxrow.tax_socinfo, '') || TO_CHAR (l_soc_turns_data (si).soc_factor)
                                                            || ' ('|| TO_CHAR (l_soc_turns_data (si).date_begin,'dd/mm/yyyy')|| '-'
                                                            || TO_CHAR (l_soc_turns_data (si).date_end,'dd/mm/yyyy')|| ') base ='|| TO_CHAR (l_tax_base_soc)|| ', l_tmp_s_soc='|| TO_CHAR (l_tmp_s_soc)|| ';';
                                 END LOOP;
                                 bars_audit.trace('%s l_tax_s_soc = %s', title, to_char(l_tax_s_soc));
                              END IF;
                     end loop;
                  l_taxrow.tax_s := l_tax_s;
                  l_taxrow.tax_sq := l_tax_sq;

                  insert into DPT_15LOG
                  values l_taxrow;

                  for z in 1..l_taxlist_mil.count
                      loop
                      bars_audit.trace('%s Считаем Военный сбор за период с '
                                      || to_char(greatest(l_acrdat,l_taxlist_mil(z).tax_date_begin),'dd/mm/yyyy')
                                      || ' по '
                                      || to_char(nvl(l_taxlist_mil(z).tax_date_end,l_stpdat),'dd/mm/yyyy'));
                               begin
                                   acrn.p_int (L_acc,                                           -- внутр.номер основного счета
                                            l_id,                                               -- код процентной карточки
                                            greatest(l_acrdat,l_taxlist_mil(z).tax_date_begin), -- начальная дата начисления, для периода налогообложения из l_taxlist (TAX_SETTINGS)
                                            nvl(l_taxlist_mil(z).tax_date_end,l_stpdat),        -- конечная дата начисления, для периода налогообложения из l_taxlist (TAX_SETTINGS)
                                            l_taxrow_mil.tax_base_s,                            -- сумма начисленных процентов OUT для периода налогообложения из l_taxlist (TAX_SETTINGS)
                                            l_ost,                                              -- сумма начисления
                                            0);                                                 -- режим выполнения - Только узнать сумму процентов, для периода налогообложения из l_taxlist (TAX_SETTINGS)
                               exception
                                when others then
                                  -- ошибка формирования ведомости начисленных процентов по счету %s/%s: %s
                                  l_errmsg := substr(bars_msg.get_msg(modcode,
                                                                     'INTCALC_TAX_FAILED',
                                                                     l_acc,
                                                                     l_kv,
                                                                     sqlerrm), 1, errmsgdim);
                                  raise expt_int;
                              end;
                              l_taxrow_mil.tax_base_s   := round(l_taxrow_mil.tax_base_s,0); -- так как в проводку реально вставляется округленное, остаток ->> acr_docs.int_rest
                              l_taxrow_mil.tax_base_sq  :=  gl.p_icurval(l_taxrow_mil.kv, l_taxrow_mil.tax_base_s, l_taxrow_mil.bdate);
                              l_taxrow_mil.tax_s        := round(l_taxrow_mil.tax_base_s*l_taxlist_mil(z).tax_int,0);
                              l_taxrow_mil.tax_sq       := gl.p_icurval(l_taxrow_mil.kv, l_taxrow_mil.tax_s, l_taxrow_mil.bdate);
                              l_taxrow_mil.round_err    := l_taxrow_mil.tax_base_s*l_taxlist_mil(z).tax_int - l_taxrow_mil.tax_s;

                              bars_audit.trace('%s сумма начисленных c '|| to_char(greatest(l_acrdat,l_taxlist_mil(z).tax_date_begin),'dd/mm/yyyy')
                                  || ' по '|| to_char(nvl(l_taxlist_mil(z).tax_date_end,l_stpdat),'dd/mm/yyyy')
                                  ||' (база для налогообложения = '||to_char(l_taxrow_mil.tax_base_s)|| ') ('
                                  || to_char (l_taxlist_mil(z).tax_int*100) ||'%) процентов = %s', title, '>>'
                                  ||to_char(l_taxrow_mil.tax_s));

                              l_tax_mil_s     :=  nvl(l_tax_mil_s,0)  + nvl(l_taxrow_mil.tax_s,0);
                              l_tax_mil_sq    :=  nvl(l_tax_mil_sq,0) + nvl(l_taxrow_mil.tax_sq,0);

                            IF l_tax_socfactor = 1
                              THEN
                                 BEGIN
                                    SELECT acc,
                                           case when (nvl(ost_real,0) + nvl(kos_real,0) - nvl(dos_real,0)) = 0
                                                then 0
                                                else nvl(ost_for_tax,0)/(nvl(ost_real,0) + nvl(kos_real,0) - nvl(dos_real,0))
                                           end,
                                           date1,
                                           nvl(date2 - 1, l_stpdat)
                                      BULK COLLECT INTO l_soc_turns_data
                                      FROM dpt_soc_turns
                                     WHERE acc = l_acc;
--                                           AND date1 BETWEEN l_acrdat
--                                                         AND l_stpdat;
                                 EXCEPTION
                                    WHEN OTHERS
                                    THEN bars_audit.trace ('%s_SOC' || SQLCODE|| ' +За указанный период нет данных об оборотах в dpt_soc_turns по счету асс = '|| TO_CHAR (l_acc),title);
                                 END;

                                 BARS_AUDIT.trace ('%s_SOC Количество периодов оборотов (для расчета социального остатка)= '|| TO_CHAR (l_soc_turns_data.COUNT),title);
                                 FOR si IN 1 .. l_soc_turns_data.COUNT
                                 LOOP
                                    BARS_AUDIT.trace ('INT:_SOC' || ' soc_date_begin = '|| TO_CHAR (l_soc_turns_data (si).date_begin,'dd/mm/yyyy')|| ' , soc_date_end = '|| TO_CHAR (l_soc_turns_data (si).date_end,'dd/mm/yyyy')|| ' , soc_factor = '|| TO_CHAR (l_soc_turns_data (si).soc_factor));

                                    BEGIN
                                       acrn.p_int (
                                          l_acc,                                            -- внутр.номер основного счета
                                          l_id,                                             -- код процентной карточки
                                          GREATEST (    l_soc_turns_data (si).date_begin,
                                                        l_acrdat),                          -- начальная дата начисления, для периода налогообложения из l_taxlist (TAX_SETTINGS)
                                          NVL (         l_soc_turns_data (si).date_end,
                                                        l_taxlist_mil (z).tax_date_end),    -- конечная дата начисления, для периода налогообложения из l_taxlist (TAX_SETTINGS)
                                          l_tax_base_soc,                                   -- сумма начисленных процентов OUT для периода налогообложения из l_taxlist (TAX_SETTINGS)
                                          l_ost,                                            -- сумма начисления
                                          0);                                               -- режим выполнения - Только узнать сумму процентов, для периода налогообложения из l_taxlist (TAX_SETTINGS)
                                    EXCEPTION
                                       WHEN OTHERS
                                       THEN
                                          -- ошибка формирования ведомости начисленных процентов по счету %s/%s: %s
                                          l_errmsg :=
                                             SUBSTR (bars_msg.get_msg (
                                                        modcode,
                                                        'INTCALC_TAX_FAILED',
                                                        l_acc,
                                                        l_kv,
                                                        SQLERRM),
                                                     1,
                                                     errmsgdim);
                                          RAISE expt_int;
                                    END;

                                    l_tax_base_soc      :=  ROUND (l_tax_base_soc, 0); -- так как в проводку реально вставляется округленное, остаток ->> acr_docs.int_rest
                                    l_tax_base_soc_sq   :=  nvl(l_tax_base_soc_sq,0) + gl.p_icurval (l_taxrow.kv,l_tax_base_soc,l_taxrow.bdate);

                                    --считаю разницу (налог с соцфактором)- (налог без соцфактора) чтобы потом ПРИБАВИТЬ к сумме налога за весь период
                                    if l_soc_turns_data (si).soc_factor < 1
                                        then l_tmp_mil_s_soc         :=  ROUND ((l_tax_base_soc* l_taxlist_mil (z).tax_int * l_soc_turns_data (si).soc_factor) - (l_tax_base_soc * l_taxlist_mil (z).tax_int),0);
                                        else l_tmp_mil_s_soc         :=  0;
                                    end if;
                                    l_tax_mil_s_soc     := NVL (l_tax_mil_s_soc, 0) + NVL (l_tmp_mil_s_soc, 0);
                                    l_tax_mil_sq_soc    := NVL (l_tax_mil_sq_soc, 0) + gl.p_icurval (l_taxrow_mil.kv,l_tmp_mil_s_soc,l_taxrow_mil.bdate);

                                    bars_audit.trace('l_tax_base_soc = '||to_char(l_tax_base_soc)||' for --->' ||
                                    to_char(GREATEST (l_soc_turns_data (si).date_begin,l_taxlist_mil (z).tax_date_begin),'dd/mm/yyyy')||
                                    ' - '|| to_char(NVL (l_soc_turns_data (si).date_end,
                                                        l_taxlist_mil (z).tax_date_end),'dd/mm/yyyy'));
                                    bars_audit.trace('l_tmp_mil_s_soc = '||to_char(l_tmp_mil_s_soc)||'l_tax_mil_s_soc = '||to_char(l_tax_mil_s_soc)||', l_tax_mil_sq_soc = '|| to_char(l_tax_mil_sq_soc));

                                    l_taxrow_mil.tax_socinfo := NVL (l_taxrow.tax_socinfo, '')|| TO_CHAR (l_soc_turns_data (si).soc_factor)|| ' ('
                                       || TO_CHAR (l_soc_turns_data (si).date_begin,'dd/mm/yyyy')|| '-'
                                       || TO_CHAR (l_soc_turns_data (si).date_end,'dd/mm/yyyy')|| ') base ='
                                       || TO_CHAR (l_tax_base_soc)|| ', l_tmp_mil_s_soc='|| TO_CHAR (l_tmp_mil_s_soc)|| ';';
                                 END LOOP;
                              END IF;

                     end loop;
                  l_taxrow_mil.tax_s  := l_tax_mil_s;
                  l_taxrow_mil.tax_sq := l_tax_mil_sq;
        end if;

        l_taxrow.tax_s       := CASE WHEN (l_tax_s + l_tax_s_soc) >=0 THEN l_tax_s + l_tax_s_soc ELSE 0 END;
        l_taxrow.tax_sq      := CASE WHEN (l_tax_sq + l_tax_sq_soc) >=0 THEN l_tax_sq + l_tax_sq_soc ELSE 0 END;
        l_taxrow_mil.tax_s   := CASE WHEN (l_tax_mil_s  + l_tax_mil_s_soc) >=0 THEN l_tax_mil_s + l_tax_mil_s_soc ELSE 0 END;
        l_taxrow_mil.tax_sq  := CASE WHEN (l_tax_mil_sq + l_tax_mil_sq_soc) >=0 THEN l_tax_mil_sq + l_tax_mil_sq_soc ELSE 0 END;

        -- убираю ошибки округления
        if l_tax_base_soc_sq = p_int and (l_taxrow.tax_s = 1 or l_taxrow.tax_sq = 1) then l_taxrow.tax_s := 0;l_taxrow.tax_sq := 0; end if;
  EXCEPTION
    WHEN OTHERS THEN
      l_errmsg := SUBSTR('INT: ошибка выполнения процедуры acrn.p_int '
                       ||'для счета #'||to_char(l_acc)||': '||SQLERRM, 1, g_errmsg_dim);
      bars_audit.error(l_errmsg);
      IF p_runid * (NVL(l_dpt, 0) + NVL(l_pens,0)) > 0 THEN
        dpt_jobs_audit.p_save2log
         (p_runid, l_dpt, l_nd, l_branch, null,
          l_rnk, null, l_kv, null, null,
          -1, l_errmsg, l_pens);
      END IF;
      p_err := TRUE;
      GOTO nextrec;
  END;

  BEGIN
    acrn.p_cnds;
  EXCEPTION
    WHEN OTHERS THEN
      l_errmsg := SUBSTR('INT: ошибка выполнения процедуры acrn.p_cnds: '
                        ||SQLERRM, 1, g_errmsg_dim);
      bars_audit.error(l_errmsg);
      IF p_runid * (NVL(l_dpt, 0) + NVL(l_pens,0)) > 0 THEN
        dpt_jobs_audit.p_save2log
         (p_runid, l_dpt, l_nd, l_branch, null,
          l_rnk, null, l_kv, null, null,
          -1, l_errmsg, l_pens);
      END IF;
      p_err := TRUE;
      GOTO nextrec;
  END;

  p_int := round(l_int);
  bars_audit.trace('INT: сумма нач.%% = '||to_char(p_int));

  IF p_mod = 0 THEN
     -- прогнозное начисление (только расчет суммы нач.%%)
     -- используется только для ОДНОГО счета => ща выйдем
     p_err := FALSE;
     GOTO nextrec;
  ELSE
     -- порождаем документ
     l_deleted := FALSE;

     SAVEPOINT sp_beforeIntDoc;

     -- ШАГ №1: выбираем все, что было начислено по данному счету
     FOR int IN
        (SELECT fdat, tdat, ir, br, acrd, remi, osts
           FROM acr_intn
          WHERE acc = l_acc AND id = l_id
          ORDER BY fdat)
     LOOP
       bars_audit.trace('INT: данные во врем.таблице: '
                  ||to_char(int.fdat,'DD/MM/YYYY')
                  ||' - '
                  ||to_char(int.tdat,'DD/MM/YYYY')
                  ||' ir = '||to_char(int.ir)
                  ||' br = '||to_char(int.br)
                  ||' acrd = '||to_char(int.acrd)
                  ||' remi = '||to_char(int.remi));

       -- ШАГ №2: фиксируем результат начисления
       BEGIN
         UPDATE int_accn
            SET acr_dat = int.tdat,
                   s = int.remi
           WHERE acc = l_acc AND id = l_id;
       EXCEPTION
         WHEN OTHERS THEN
           l_errmsg := SUBSTR('INT: ошибка фиксации даты посл.начисления, '
                            ||'счет #'||to_char(l_acc)||': '||SQLERRM, 1, g_errmsg_dim);
           bars_audit.error(l_errmsg);
           IF p_runid * (NVL(l_dpt, 0) + NVL(l_pens,0)) > 0 THEN
              dpt_jobs_audit.p_save2log
               (p_runid, l_dpt, l_nd, l_branch, null,
                l_rnk, null, l_kv, null, null,
                -1, l_errmsg, l_pens);
           END IF;
           p_err := TRUE;
	   ROLLBACK TO sp_beforeIntDoc;
           GOTO nextrec;
       END;

       -- ШАГ №3: чистим врем.таблицу-ведомость от предыдущих попыток
       IF NOT l_deleted THEN
          DELETE FROM tmp_intarc
           WHERE acc = l_acc AND id = l_id AND fdat >= int.fdat;
          l_deleted := TRUE;
       END IF;

       -- ШАГ №4: заполняем ведомость начисленных %%
       BEGIN
         INSERT INTO tmp_intarc
          (id, acc, nls, kv, lcv, nbs, nms,
           fdat, tdat, ir, br, osts, acrd, userid, bdat)
         VALUES
          (l_id, l_acc, l_nls, l_kv, l_lcv, l_nbs, l_nms,
           int.fdat, int.tdat, int.ir, int.br, int.osts, int.acrd,
           l_userid, l_bdate);
       EXCEPTION
         WHEN OTHERS THEN
           l_errmsg := SUBSTR('INT: ошибка записи в ведомость, '
                            ||'счет #'||to_char(l_acc)||': '||SQLERRM, 1, g_errmsg_dim);
           bars_audit.error(l_errmsg);
           IF p_runid * (NVL(l_dpt, 0) + NVL(l_pens,0)) > 0 THEN
              dpt_jobs_audit.p_save2log
               (p_runid, l_dpt, l_nd, l_branch, null,
                l_rnk, null, l_kv, null, null,
                -1, l_errmsg, l_pens);
           END IF;
           p_err := TRUE;
	   ROLLBACK TO sp_beforeIntDoc;
           GOTO nextrec;
       END;

       -- ШАГ №5: поиск реквизитов документа, если есть что платить
       IF int.acrd <> 0 THEN
          -- сторона А для начисления % (счет начисленных %%)
          BEGIN
            SELECT a.nls, a.kv, SUBSTR(a.nms,1,38), c.okpo
              INTO l_nlsa, l_kva, l_nama, l_ida
              FROM accounts a, customer c
             WHERE a.acc = l_acra AND a.rnk = c.rnk;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              l_errmsg := SUBSTR('INT: не найден счет начисленных процентов '
                               ||'для счета #'||to_char(l_acc)||': '||SQLERRM, 1, g_errmsg_dim);
              bars_audit.error(l_errmsg);
              IF p_runid * (NVL(l_dpt, 0) + NVL(l_pens,0)) > 0 THEN
                 dpt_jobs_audit.p_save2log
                  (p_runid, l_dpt, l_nd, l_branch, null,
                   l_rnk, null, l_kv, null, null,
                   -1, l_errmsg, l_pens);
              END IF;
              p_err := TRUE;
              ROLLBACK TO sp_beforeIntDoc;
              GOTO nextrec;
          END;
          -- сторона Б для начисления % (счет доходов-расходов)
          BEGIN
            SELECT a.nls, a.kv, SUBSTR(a.nms, 1, 38), c.okpo
              INTO l_nlsb, l_kvb, l_namb, l_idb
              FROM accounts a, customer c
             WHERE a.acc = l_acrb AND a.rnk = c.rnk;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              l_errmsg := SUBSTR('INT: не найден счет расходов '
                               ||'для счета #'||to_char(l_acc)||': '||SQLERRM, 1, g_errmsg_dim);
              bars_audit.error(l_errmsg);
              IF p_runid * (NVL(l_dpt, 0) + NVL(l_pens,0)) > 0 THEN
                 dpt_jobs_audit.p_save2log
                  (p_runid, l_dpt, l_nd, l_branch, null,
                   l_rnk, null, l_kv, null, null,
                   -1, l_errmsg, l_pens);
              END IF;
              p_err := TRUE;
              ROLLBACK TO sp_beforeIntDoc;
              GOTO nextrec;
          END;
          bars_audit.trace('INT: счета: '||l_nlsa||' <-> '||l_nlsb);

          -- Дебет/Кредит
          IF int.acrd > 0 THEN
             l_dk := 0;
          ELSE
             l_dk := 1;
          END IF;

          -- Гривневый эквивалент
          IF l_kva = l_kvb THEN
             l_vob := 6;
             l_acrdQ := int.acrd;
          ELSE
             l_vob := 16;
             gl.x_rat(l_ratO, l_ratB, l_ratS, l_kva, l_kvb, gl.bdate);
             l_acrdQ := int.acrd * l_ratO;
          END IF;
          bars_audit.trace('INT: грн.экв = '||to_char(l_acrdQ));

          -- назначение платежа
	  IF l_nazn IS NULL THEN
	     l_nazn := SUBSTR('Начисление процентов по счету '
                              ||l_nls||'/'||l_lcv, 1, 122);
          END IF;
          l_fullnazn := substr(l_nazn
                               ||' за период с '||to_char(int.fdat,'DD.MM.YY')
			       ||' по '         ||to_char(int.tdat,'DD.MM.YY')
			       ||' вкл.', 1, 160);
          bars_audit.trace('INT: назначение: '||l_fullnazn);

          -- ШАГ №6: оплата
          BEGIN
            gl.ref (l_ref);

            INSERT INTO oper
             (ref, tt, vob, nd, dk, pdat, vdat, datd,
              id_a, nam_a, mfoa, nlsa, kv,  s,
              id_b, nam_b, mfob, nlsb, kv2, s2,
              branch, tobo,
              userid, nazn)
            VALUES
             (l_ref, l_tt, l_vob, substr(l_ref,1,10), l_dk, sysdate, l_bdate, l_bdate,
              l_ida, l_nama, l_mfo, l_nlsa, l_kva, ABS(int.acrd),
              l_idb, l_namb, l_mfo, l_nlsb, l_kvb, ABS(l_acrdQ),
              l_branch, l_branch,
              l_userid, l_fullnazn);

            paytt (NULL, l_ref, l_bdate, l_tt, l_dk,
                  l_kva, l_nlsa, ABS(int.acrd),
                  l_kvb, l_nlsb, ABS(l_acrdQ));

            bars_audit.financial('INT-TAX: налогообложение (РЕФ) = '||to_char(l_ref));

               if l_tax_method = 2 and l_tax_required = 1
                then
                  paytt (null, l_ref, l_bdate, tax_tt, 1,
                             l_kva,   l_nlsa,  l_taxrow.TAX_S,
                             l_kvb,   l_taxrow.TAX_NLS, l_taxrow.TAX_SQ);

                  paytt (null,
                           l_ref,
                           l_bdate,
                           tax_mil_tt, 1,
                           l_kva,  l_nlsa, l_taxrow_mil.TAX_S,
                           l_kvb, l_taxrow_mil.TAX_NLS, l_taxrow_mil.TAX_SQ );

                end if;

                if l_tax_method in (2,3) and l_tax_required = 1
                then
                INSERT INTO dpt_15log (DPT_ID,
                                           ACRA,
                                           KV,
                                           INT_DATE_BEGIN,
                                           INT_DATE_END,
                                           INT_S,
                                           INT_SQ,
                                           TAX_NLS,
                                           TAX_DATE_BEGIN,
                                           TAX_DATE_END,
                                           TAX_BASE_S,
                                           TAX_BASE_SQ,
                                           TAX_S,
                                           TAX_SQ,
                                           REF,
                                           userid,
                                           dwhen,
                                           bdate,
                                           round_err)
                            SELECT nvl(l_taxrow.DPT_ID,'2620'),
                                   l_taxrow.ACRA,
                                   l_taxrow.KV,
                                   l_taxrow.INT_DATE_BEGIN,
                                   l_taxrow.INT_DATE_END,
                                   l_taxrow.INT_S,
                                   l_taxrow.INT_SQ,
                                   l_taxrow.TAX_NLS,
                                   l_taxrow.TAX_DATE_BEGIN,
                                   l_taxrow.TAX_DATE_END,
                                   l_taxrow.TAX_BASE_S,
                                   l_taxrow.TAX_BASE_SQ,
                                   l_taxrow.TAX_S,
                                   l_taxrow.TAX_SQ,
                                   l_ref,
                                   l_taxrow.userid,
                                   l_taxrow.dwhen,
                                   l_taxrow.bdate,
                                   l_taxrow.round_err
                              FROM DUAL;

                end if;
            bars_audit.financial('INT: сформирован документ (РЕФ) = '||to_char(l_ref));

            acrn.acr_dati(l_acc, l_id, l_ref, (int.fdat - 1), l_remi);

            -- запись документа в хранилище док-тов по депозитному договору
            IF l_dpt IS NOT NULL THEN
               dpt_web.fill_dpt_payments (l_dpt, l_ref) ;
            END IF;

          EXCEPTION
            WHEN OTHERS THEN
              l_errmsg := SUBSTR('INT: ошибка оплаты документа '
                               ||'по счету #'||to_char(l_acc)||': '||SQLERRM, 1, g_errmsg_dim);
              bars_audit.error(l_errmsg);
              IF p_runid * (NVL(l_dpt, 0) + NVL(l_pens,0)) > 0 THEN
                 dpt_jobs_audit.p_save2log
                  (p_runid, l_dpt, l_nd, l_branch,
                   null, l_rnk, l_nlsa, l_kv, null, null,
                   -1, l_errmsg, l_pens);
              END IF;
              p_err := TRUE;
              ROLLBACK TO sp_beforeIntDoc;
              GOTO nextrec;
          END; --блок оплаты

       END IF;  -- (int_acrd <> 0)

       IF p_runid * (NVL(l_dpt, 0) + NVL(l_pens,0)) > 0 THEN
          dpt_jobs_audit.p_save2log
           (p_runid, l_dpt, l_nd, l_branch,
            l_ref, l_rnk, l_nlsa, l_kv, null, int.acrd,
            1, null, l_pens);
       END IF;
     END LOOP;  -- int

     -- если по счету было начислено 0, то фиксируем дату посл.начисления
     UPDATE int_accn SET acr_dat = l_stpdat WHERE acc = l_acc AND id = l_id;

     l_cnt := l_cnt + 1;
     if (p_runid > 0 and l_cnt >= autocommit) then
         commit;
         l_cnt := 0;
     end if;

  END IF; -- p_mod = 0

  END LOOP;

  -- во внешнем блоке не забыть закрыть курсор!!!

END P_MAKE_INT;
/

show err;

grant EXECUTE on P_MAKE_INT to BARS_ACCESS_DEFROLE;
grant EXECUTE on P_MAKE_INT to DPT_ROLE;
grant EXECUTE on P_MAKE_INT to WR_ALL_RIGHTS;
