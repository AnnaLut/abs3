CREATE OR REPLACE PACKAGE BARS.BARS_SNAPSHOT
is
  --
  -- constants
  --
  g_header_version        constant varchar2(64) := 'version 1.2 06.02.2017';

  --
  -- HEADER_VERSION
  --
  function header_version return varchar2;

  --
  -- BODY_VERSION
  --
  function body_version return varchar2;

  --
  -- CURRENCY_REVALUATION
  --
  --  Переоцінка вал. позицій коригуючими проводками (аналог проц. PVP_R96)
  --
  procedure CURRENCY_REVALUATION;

  --
  -- CREATE_DAILY_SNAPSHOT
  --
  --   Створення денних знімків балансу.
  --
  PROCEDURE CREATE_DAILY_SNAPSHOT
  ( p_snapshot_dt  in     date );

  --
  -- CREATE_MONTHLY_BALANCE_SNAPSHOT
  --
  --   Створення місячних знімків балансу.
  --
  PROCEDURE CREATE_MONTHLY_SNAPSHOT
  ( p_snapshot_dt  in     date
  , p_auto_daily   in     boolean  default false );

  --
  -- CREATE_ANNUAL_BALANCE_SNAPSHOT
  --
  --   Створення річних знімків балансу.
  --
  procedure CREATE_ANNUAL_SNAPSHOT
  ( p_snapshot_dt  in     date );

  --
  -- REMOVING_OBSOLETE_SNAPSHOTS
  --
  --   Видалення застарілих знімків балансу
  --
  procedure REMOVING_OBSOLETE_SNAPSHOTS;


end BARS_SNAPSHOT;
/
show errors;

CREATE OR REPLACE PACKAGE BODY BARS.BARS_SNAPSHOT
IS
   --
   -- constants
   --
   g_body_version   CONSTANT VARCHAR2 (64) := 'version 2.2  08.02.2019';

   --
   -- types
   --

   --
   -- variables
   --
   l_mfo                     VARCHAR2 (6);
   l_baseval                 NUMBER (3);                -- tabval$global%type;
   l_userid                  NUMBER (38);                 -- oper.userid%type;
   l_okpo                    oper.id_a%TYPE;
   l_condition               VARCHAR2 (300);
   l_first_day               DATE;
   l_bank_dt                 DATE;
   l_vdat                    oper.vdat%TYPE;

   --
   -- повертає версію заголовка пакета
   --
   FUNCTION header_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN 'Package ' || $$PLSQL_UNIT || ' header ' || g_header_version;
   END header_version;

   --
   -- повертає версію тіла пакета
   --
   FUNCTION body_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN 'Package ' || $$PLSQL_UNIT || ' body ' || g_body_version;
   END body_version;

   --
   -- DAILY_CURRENCY_REVALUATION
   -- for DAILY SNAPSHOT
   --
   PROCEDURE DAILY_CURRENCY_REVALUATION
   IS
      /**
      <b>DAILY_CURRENCY_REVALUATION</b> - процедура переоцінки валютних позицій
      %param

      %version 1.0
      %usage   переоцінка валютних позицій коригуючими проводками.
      */
      title   CONSTANT VARCHAR2 (64)
                          := $$PLSQL_UNIT || '.DAILY_CURRENCY_REVALUATION' ;
      l_ref            oper.REF%TYPE;
      l_dk             oper.dk%TYPE;
      l_nd             oper.nd%TYPE;
      l_amnt           oper.s%TYPE;
      l_tt             oper.tt%TYPE := 'PVP';
      l_vob            oper.vob%TYPE := 6;
   BEGIN
      bars_audit.trace ('%s: Start running.', title);

      bars_audit.trace ('%s: Exit.', title);
   END DAILY_CURRENCY_REVALUATION;

   --
   -- переоцінка вал. позицій коригуючими проводками (аналог проц. PVP_R96)
   -- для місячних знімків балансу ( для одного МФО )
   --
   PROCEDURE CURRENCY_REVALUATION (p_kf IN agg_monbals.kf%TYPE)
   IS
      /**
      <b>CURRENCY_REVALUATION</b> - процедура переоцінки валютних позицій
      %param

      %version 1.2
      %usage   переоцінка валютних позицій коригуючими проводками.
      */
      title   CONSTANT VARCHAR2 (64)
                          := $$PLSQL_UNIT || '.CURRENCY_REVALUATION' ;
      l_ref            oper.REF%TYPE;
      l_dk             oper.dk%TYPE;
      l_nd             oper.nd%TYPE;
      l_amnt           oper.s%TYPE;
      l_tt             oper.tt%TYPE := 'PVP';
      l_vob            oper.vob%TYPE := 96;
   BEGIN
      bars_audit.trace ('%s: Entry with ( kf=%s ).', title, p_kf);

      l_bank_dt := GL.GBD ();
      l_vdat := DAT_NEXT_U (TRUNC (l_bank_dt, 'MM'), -1);
      l_first_day := TRUNC (l_vdat, 'MM');

      gl.fSOS0 := 1;

      FOR cur
         IN (SELECT /*+ NO_PARALLEL */
                   t.BRANCH,
                       'Finis/Реал.Курс.Рiзниця для рах.'
                    || t.NLS
                    || '/'
                    || t.KV
                       AS PAYMENT_DESC,
                    t.ACC3801,
                    a3.NLS AS NLS_A,
                    a3.KV AS KV_A,
                    SUBSTR (a3.NMS, 1, 38) AS NAME_A,
                    t.ACC6204,
                    a6.NLS AS NLS_B,
                    a6.KV AS KV_B,
                    SUBSTR (a6.NMS, 1, 38) AS NAME_B,
                    (ADJ_AMNT_3800_UAH - ADJ_AMNT_3801) AS DIFF_AMNT
               FROM (SELECT /*+ ORDERED FULL(v) FULL(b0) FULL(b1) USE_HASH( b0 ) USE_HASH( b1 )*/
                           v.KF,
                            v.ACC3801,
                            v.ACC6204,
                            a.NLS,
                            a.KV,
                            a.BRANCH,
                            b0.OSTQ - b0.CRDOSQ + b0.CRKOSQ
                               AS ADJ_AMNT_3800_UAH,
                            b1.OST - b1.CRDOS + b1.CRKOS AS ADJ_AMNT_3801
                       FROM VP_LIST v
                            JOIN AGG_MONBALS_INTR_TBL b0
                               ON (    b0.FDAT = l_first_day
                                   AND b0.KF = v.KF
                                   AND b0.ACC = v.ACC3800)
                            JOIN AGG_MONBALS_INTR_TBL b1
                               ON (    b1.FDAT = l_first_day
                                   AND b1.KF = v.KF
                                   AND b1.ACC = v.ACC3801)
                            JOIN ACCOUNTS a ON (a.acc = v.ACC3800)
                      WHERE     v.KF = p_kf
                            AND v.ACC6204 IS NOT NULL
                            AND a.DAZS IS NULL
                            AND (  (b0.OSTQ - b0.CRDOSQ + b0.CRKOSQ)
                                 + (b1.OST - b1.CRDOS + b1.CRKOS)) <> 0) t
                    JOIN ACCOUNTS a3 ON (a3.KF = t.KF AND a3.ACC = t.ACC3801)
                    JOIN ACCOUNTS a6 ON (a6.KF = t.KF AND a6.ACC = t.ACC6204))
      LOOP
         GL.REF (l_ref);

         DBMS_APPLICATION_INFO.set_client_info (
               'Переоцінка валютних позицій міс. знімку балансу ref #'
            || TO_CHAR (l_ref));

         l_dk := CASE WHEN cur.DIFF_AMNT > 0 THEN 0 ELSE 1 END;
         l_amnt := ABS (cur.DIFF_AMNT);
         l_nd := SUBSTR (TO_CHAR (l_ref), 1, 10);

         INSERT INTO OPER (REF,
                           TT,
                           VOB,
                           ND,
                           DK,
                           PDAT,
                           VDAT,
                           DATD,
                           USERID,
                           MFOA,
                           NLSA,
                           NAM_A,
                           KV,
                           S,
                           ID_A,
                           MFOB,
                           NLSB,
                           NAM_B,
                           KV2,
                           S2,
                           ID_B,
                           NAZN,
                           BRANCH,
                           TOBO)
              VALUES (l_ref,
                      l_tt,
                      l_vob,
                      l_nd,
                      l_dk,
                      SYSDATE,
                      l_vdat,
                      l_bank_dt,
                      l_userid,
                      l_mfo,
                      cur.NLS_A,
                      cur.NAME_A,
                      cur.KV_A,
                      l_amnt,
                      l_okpo,
                      l_mfo,
                      cur.NLS_B,
                      cur.NAME_B,
                      cur.KV_B,
                      l_amnt,
                      l_okpo,
                      cur.PAYMENT_DESC,
                      cur.BRANCH,
                      cur.BRANCH);

         -- gl.payS = gl.payV
         gl.payS (1,
                  l_ref,
                  l_bank_dt,
                  l_tt,
                  l_dk,
                  cur.KV_A,
                  cur.NLS_A,
                  l_amnt,
                  cur.KV_B,
                  cur.NLS_B,
                  l_amnt);

         -- 3801
         UPDATE AGG_MONBALS_INTR_TBL
            SET CRDOS = CRDOS + CASE WHEN l_dk = 0 THEN l_amnt ELSE 0 END,
                CRDOSQ = CRDOSQ + CASE WHEN l_dk = 0 THEN l_amnt ELSE 0 END,
                CRKOS = CRKOS + CASE WHEN l_dk = 1 THEN l_amnt ELSE 0 END,
                CRKOSQ = CRKOSQ + CASE WHEN l_dk = 1 THEN l_amnt ELSE 0 END
          WHERE FDAT = l_first_day AND KF = p_kf AND ACC = cur.ACC3801;

         -- 6204
         UPDATE AGG_MONBALS_INTR_TBL
            SET CRDOS = CRDOS + CASE WHEN l_dk = 0 THEN 0 ELSE l_amnt END,
                CRDOSQ = CRDOSQ + CASE WHEN l_dk = 0 THEN 0 ELSE l_amnt END,
                CRKOS = CRKOS + CASE WHEN l_dk = 1 THEN 0 ELSE l_amnt END,
                CRKOSQ = CRKOSQ + CASE WHEN l_dk = 1 THEN 0 ELSE l_amnt END
          WHERE FDAT = l_first_day AND KF = p_kf AND ACC = cur.ACC6204;

         bars_audit.trace ('%s: ACC_3801=%s, ACC6204=%s, AMNT=%s.',
                           title,
                           TO_CHAR (cur.ACC3801),
                           TO_CHAR (cur.ACC6204),
                           TO_CHAR (l_amnt));
      END LOOP;

      gl.fSOS0 := 0;

      bars_audit.trace ('%s: Exit.', title);
   END CURRENCY_REVALUATION;

   --
   -- переоцінка вал. позицій коригуючими проводками (аналог проц. PVP_R96)
   -- для місячних знімків балансу ( по всіх МФО )
   --
   PROCEDURE CURRENCY_REVALUATION
   IS
      /**
      <b>CURRENCY_REVALUATION</b> - процедура переоцінки валютних позицій по усіх KF
      %param

      %version 1.0
      %usage   переоцінка валютних позицій коригуючими проводками.
      */
      title   CONSTANT VARCHAR2 (64)
                          := $$PLSQL_UNIT || '.CURRENCY_REVALUATION' ;
      l_kf             agg_monbals.kf%TYPE;
   BEGIN
      bars_audit.trace ('%s: Start running.', title);

      l_kf := SYS_CONTEXT ('bars_context', 'user_mfo');

      IF (l_kf IS NULL)
      THEN                                                       -- for all KF
         NULL;
      ELSE                                                       -- for one KF
         CURRENCY_REVALUATION (l_kf);
      END IF;

      bars_audit.trace ('%s: Exit.', title);
   END CURRENCY_REVALUATION;

   --
   --
   --
   PROCEDURE ANNUAL_CURRENCY_REVALUATION
   IS
      /**
      <b>ANNUAL_CURRENCY_REVALUATION</b> - процедура переоцінки валютних позицій
      %param

      %version 1.0
      %usage   переоцінка валютних позицій коригуючими проводками.
      */
      title   CONSTANT VARCHAR2 (60)
                          := $$PLSQL_UNIT || '.annual_currency_revaluation' ;
   BEGIN
      bars_audit.trace ('%s: Start running.', title);

      bars_audit.trace ('%s: Exit.', title);
   END ANNUAL_CURRENCY_REVALUATION;

   --
   -- CREATE_DAILY_SNAPSHOT
   --
   PROCEDURE CREATE_DAILY_SNAPSHOT (p_snapshot_dt IN DATE)
   IS
      /**
      <b>CREATE_DAILY_SNAPSHOT</b> - процедура створення денних знімків балансу
      %param

      %version 1.0
      %usage   Створення денних знімків балансу.
      */
      title   CONSTANT VARCHAR2 (64)
                          := $$PLSQL_UNIT || '.create_daily_snapshot' ;
      l_errmsg         VARCHAR2 (500);
   BEGIN
      bars_audit.trace ('%s: Start running with p_snapshot_dt=%s.',
                        title,
                        TO_CHAR (p_snapshot_dt, 'dd.mm.yyyy'));

      IF (p_snapshot_dt IS NULL)
      THEN
         raise_application_error (
            -20666,
            'Не вказано дату для формування знімку!');
      -- ELSE
      --   dat1_ := trunc(p_date,'MM');
      --   dat2_ := last_day(dat1_);
      --   dat3_ := trunc(dat1_-1,'MM');
      END IF;

      -- Перевірка наявності активного процесу формування знімку
      l_errmsg := BARS_UTL_SNAPSHOT.CHECK_SNP_RUNNING ('DAYBALS');

      IF (l_errmsg IS NOT NULL)
      THEN
         raise_application_error (
            -20666,
               'формування денного знімку балансу вже запущено користувачем '
            || l_errmsg);
      ELSE                                -- Блокування від декількох запусків
         BARS_UTL_SNAPSHOT.SET_RUNNING_FLAG ('DAYBALS');
      END IF;

      DBMS_APPLICATION_INFO.set_client_info (
            'Формування денного знімку балансу за '
         || F_MONTH_LIT (p_snapshot_dt, 0, 0));

      -- execute immediate 'TRUNCATE TABLE AGG_MONBALS_EXCHANGE';



      BARS_UTL_SNAPSHOT.PURGE_RUNNING_FLAG ();

      bars_audit.trace ('%s: Exit.', title);
   EXCEPTION
      WHEN OTHERS
      THEN
         -- gl.setp('MONBAL','',NULL); -- deprecated (for compatibility)
         BARS_UTL_SNAPSHOT.PURGE_RUNNING_FLAG ();
         bars_audit.error (
               title
            || ': '
            || DBMS_UTILITY.format_error_stack ()
            || CHR (10)
            || DBMS_UTILITY.format_error_backtrace ());
         RAISE;
   END CREATE_DAILY_SNAPSHOT;

   --
   -- CREATE_MONTHLY_BALANCE_SNAPSHOT
   --
   PROCEDURE CREATE_MONTHLY_SNAPSHOT (
      p_snapshot_dt   IN DATE,
      p_auto_daily    IN BOOLEAN DEFAULT FALSE)
   IS
      /**
      <b>CREATE_MONTHLY_SNAPSHOT</b> - процедура створення місячних знімків балансу
      %param p_snapshot_dt -
      %param p_auto_daily  -

      %version 1.3   08/02/2019
      %usage   створення місячних знімків балансу.
      */
      title      CONSTANT VARCHAR2 (64)
                             := $$PLSQL_UNIT || '.CREATE_MONTHLY_SNAPSHOT' ;
      dat0_               DATE;   -- останній банківський день звітного місяця
      dat1_               DATE;   -- перший   календарний день звітного місяця
      dat2_               DATE;   -- останній календарний день звітного місяця
      dat3_               DATE; -- перший   календарний день попереднього місяця
      dat11_              DATE;   -- перший   календарний день звітного місяця
      l_errmsg            VARCHAR2 (500);
      l_kf                agg_monbals.kf%TYPE;
      e_result_too_long   EXCEPTION;
      PRAGMA EXCEPTION_INIT (e_result_too_long, -01489);
   BEGIN
      bars_audit.trace (
         '%s: Start running with ( p_snapshot_dt=%s, p_auto_daily=%s ).',
         title,
         TO_CHAR (p_snapshot_dt, 'dd.mm.yyyy'),
         CASE WHEN p_auto_daily THEN 'true' ELSE 'false' END);

      IF (p_snapshot_dt IS NULL)
      THEN
         raise_application_error (
            -20666,
            'Не вказано дату для формування знімку!');
      ELSE
         dat1_ := TRUNC (p_snapshot_dt, 'MM');
         dat2_ := LAST_DAY (dat1_);
         dat3_ := TRUNC (dat1_ - 1, 'MM');
         
         if to_char(dat1_, 'ddmm') = '0101' then
         -- не включаємо перший день, щоб не включились обороти по згортанню
            dat11_ := dat1_ + 1; 
         else
            dat11_ := dat1_;
         end if;
      END IF;

      l_kf := SYS_CONTEXT ('bars_context', 'user_mfo');

      IF (l_kf IS NULL)
      THEN                                                       -- for all KF
         -- temporarry
         raise_application_error (
            -20666,
            'Не задано код філіалу (МФО) для формування знімку!');
      ELSE                                                       -- for one KF
         /* FDAT, SNAP_BALANCES, SALDOZ
         */

         -- Перевірка на наявність усіх денних знімків місяця
         IF (p_auto_daily)
         THEN               -- автоматичне доформування денних знімків балансу
            FOR f IN (  SELECT k.FDAT
                          FROM FDAT k
                         WHERE     k.FDAT BETWEEN dat11_ AND dat2_
                               AND NOT EXISTS
                                      (SELECT 1
                                         FROM SNAP_BALANCES
                                        WHERE FDAT = k.FDAT)
                      ORDER BY k.FDAT)
            LOOP
               -- CREATE_DAILY_SNAPSHOT( f.FDAT, l_kf );
               DDRAPS (f.FDAT);

               COMMIT;
            END LOOP;
         ELSE
            SELECT LISTAGG (TO_CHAR (k.FDAT, 'dd-mm-yyyy'), ', ')
                      WITHIN GROUP (ORDER BY k.FDAT)
              INTO l_errmsg
              FROM FDAT k
             WHERE     k.FDAT BETWEEN dat11_ AND dat2_
                   AND NOT EXISTS
                          (SELECT 1
                             FROM SNAP_BALANCES
                            WHERE FDAT = k.FDAT);

            IF (l_errmsg IS NOT NULL)
            THEN
               raise_application_error (
                  -20666,
                     'Відсутній щоденний знімок балансу за: '
                  || l_errmsg);
            END IF;
         END IF;

         SELECT MAX (FDAT)
           INTO dat0_
           FROM SNAP_BALANCES
          WHERE FDAT BETWEEN dat11_ AND dat2_ AND KF = l_kf;

         IF (dat0_ IS NULL)
         THEN
            raise_application_error (
               -20666,
                  'Відсутні щоденні знімки балансу за '
               || F_MONTH_LIT (dat1_, 1, 4));
         END IF;

         -- Перевірка наявності активного процесу формування знімку
         l_errmsg := BARS_UTL_SNAPSHOT.CHECK_SNP_RUNNING ('MONBALS', l_kf);

         IF (l_errmsg IS NOT NULL)
         THEN
            RAISE_APPLICATION_ERROR (
               -20666,
                  'формування місячного знімку балансу вже запущено користувачем '
               || l_errmsg);
         ELSE                             -- Блокування від декількох запусків
            BARS_UTL_SNAPSHOT.SET_RUNNING_FLAG ('MONBALS');
         END IF;

         DBMS_APPLICATION_INFO.set_client_info (
               'Формування місячного знімку балансу для '
            || l_kf
            || ' за '
            || F_MONTH_LIT (dat1_, 1, 2)
            || 'міс.');

         --    execute immediate 'alter table AGG_MONBALS_INTR_TBL truncate partition for ( '''||l_kf||''' )';
         EXECUTE IMMEDIATE
            'alter table AGG_MONBALS_INTR_TBL truncate partition P_' || l_kf;

         l_condition := TO_CHAR (dat1_, 'ddmmyyyy');
         l_condition :=
            REPLACE (q'[ (to_date('%dt','ddmmyyyy'),'%kf') ]',
                     '%dt',
                     l_condition);
         l_condition := REPLACE (l_condition, '%kf', l_kf);

         --    execute immediate 'lock table SALDOZ subpartition for '||l_condition||' IN EXCLUSIVE MODE';
         EXECUTE IMMEDIATE
               'lock table SALDOZ partition ( P_'
            || l_kf
            || ' ) IN EXCLUSIVE MODE';

         bars_audit.info ($$PLSQL_UNIT || ': SALDOZ subpartition locked.');

         INSERT INTO AGG_MONBALS_INTR_TBL (FDAT,
                                           KF,
                                           ACC,
                                           RNK,
                                           OST,
                                           OSTQ,
                                           DOS,
                                           DOSQ,
                                           KOS,
                                           KOSQ,
                                           CRDOS,
                                           CRDOSQ,
                                           CRKOS,
                                           CRKOSQ,
                                           CUDOS,
                                           CUDOSQ,
                                           CUKOS,
                                           CUKOSQ,
                                           YR_DOS,
                                           YR_DOS_UAH,
                                           YR_KOS,
                                           YR_KOS_UAH)
            SELECT dat1_,
                   NVL (b.KF, z.KF) AS KF,
                   NVL (b.ACC, z.ACC) ACC,
                   NVL (b.RNK, 1) AS RNK,
                   NVL (b.OST, 0) AS OST,
                   NVL (b.OSTQ, 0) AS OSTQ,
                   NVL (b.DOS, 0) AS DOS,
                   NVL (b.DOSQ, 0) AS DOSQ,
                   NVL (b.KOS, 0) AS KOS,
                   NVL (b.KOSQ, 0) AS KOSQ,
                   NVL (z.RDOS, 0) AS CRDOS,
                   NVL (z.RDOSQ, 0) AS CRDOSQ,
                   NVL (z.RKOS, 0) AS CRKOS,
                   NVL (z.RKOSQ, 0) AS CRKOSQ,
                   NVL (z.UDOS, 0) AS CUDOS,
                   NVL (z.UDOSQ, 0) AS CUDOSQ,
                   NVL (z.UKOS, 0) AS CUKOS,
                   NVL (z.UKOSQ, 0) AS CUKOSQ,
                   NVL (z.YDOS, 0) AS YR_DOS,
                   NVL (z.YDOSQ, 0) AS YR_DOS_UAH,
                   NVL (z.YKOS, 0) AS YR_KOS,
                   NVL (z.YKOSQ, 0) AS YR_KOS_UAH
              FROM (  SELECT KF,
                             ACC,
                             SUM (DECODE (fdat, dat0_, ost, 0)) ost,
                             SUM (DECODE (fdat, dat0_, ostq, 0)) ostq,
                             SUM (dos) dos,
                             SUM (dosq) dosq,
                             SUM (kos) kos,
                             SUM (kosq) kosq,
                             ABS (MAX (DECODE (fdat, dat0_, rnk, -rnk))) rnk
                        FROM SNAP_BALANCES
                       WHERE FDAT BETWEEN dat11_ AND dat2_ AND KF = l_kf
                    GROUP BY KF, ACC) b
                   FULL JOIN (SELECT NVL (r.KF, u.KF) AS KF,
                                     NVL (r.acc, u.acc) AS ACC,
                                     r.dos AS RDOS,
                                     r.dosq AS RDOSQ,
                                     r.kos AS RKOS,
                                     r.kosq AS RKOSQ,
                                     u.dos AS UDOS,
                                     u.dosq AS UDOSQ,
                                     u.kos AS UKOS,
                                     u.kosq AS UKOSQ,
                                     u.DOS_YR AS YDOS,
                                     u.DOSQ_YR AS YDOSQ,
                                     u.KOS_YR AS YKOS,
                                     u.KOSQ_YR AS YKOSQ
                                FROM (SELECT KF,
                                             ACC,
                                             DOS,
                                             DOSQ,
                                             KOS,
                                             KOSQ
                                        FROM SALDOZ
                                       WHERE FDAT = dat1_ -- перший календарний день звітного місяця
                                                         AND KF = l_kf) r
                                     FULL JOIN
                                     (SELECT KF,
                                             ACC,
                                             DOS,
                                             DOSQ,
                                             KOS,
                                             KOSQ,
                                             DOS_YR,
                                             DOSQ_YR,
                                             KOS_YR,
                                             KOSQ_YR
                                        FROM SALDOZ
                                       WHERE FDAT = dat3_ -- перший календарний день попереднього місяця
                                                         AND KF = l_kf) u
                                        ON (u.KF = r.KF AND u.ACC = r.ACC)) z
                      ON (z.KF = b.KF AND z.ACC = b.ACC);

         bars_audit.trace ('%s: %s row created.',
                           title,
                           TO_CHAR (SQL%ROWCOUNT));

         DBMS_APPLICATION_INFO.set_client_info (
               'Переоцінка валютних позицій місячного знімку балансу для '
            || l_kf
            || ' за '
            || F_MONTH_LIT (dat1_, 1, 2));

         -- переоцінка валютних позицій (коригуючі проводки + корекція даних в AGG_MONBALS_INTR_TBL)
         --BARS_SNAPSHOT.CURRENCY_REVALUATION( l_kf );

         COMMIT;

         -- Фіксуємо SCN на якому формуємо знімок балансу по табл. SALDOZ
         BARS_UTL_SNAPSHOT.SET_TABLE_SCN (p_table   => 'SALDOZ',
                                          p_date    => dat1_,
                                          p_kf      => l_kf,
                                          p_scn     => DM_UTL.GET_LAST_SCN (
                                                         'AGG_MONBALS_INTR_TBL',
                                                         'BARS',
                                                         NULL,
                                                         l_kf));

         BARS_AUDIT.INFO ($$PLSQL_UNIT || ': lock requested.');

         IF (DBMS_LOCK.REQUEST (TO_NUMBER (l_kf),
                                DBMS_LOCK.x_mode,
                                600,
                                FALSE) = 0)
         THEN
            BARS_AUDIT.INFO ($$PLSQL_UNIT || ': lock acquired.');

            EXECUTE IMMEDIATE 'truncate table AGG_MONBALS_EXCHANGE';

            -- bypass the RLS policies
            DM_UTL.EXCHANGE_PARTITION (
               p_source_table_nm   => 'AGG_MONBALS_EXCHANGE',
               p_target_table_nm   => 'AGG_MONBALS_INTR_TBL',
               p_partition_nm      => 'P_' || l_kf,
               p_novalidate        => TRUE);

            -- bypass the RLS policies
            DM_UTL.EXCHANGE_SUBPARTITION_FOR (
               p_source_table_nm   => 'AGG_MONBALS_EXCHANGE',
               p_target_table_nm   => 'AGG_MONBALS',
               p_condition         => l_condition);

            IF (DBMS_LOCK.RELEASE (TO_NUMBER (l_kf)) = 0)
            THEN
               BARS_AUDIT.INFO ($$PLSQL_UNIT || ': lock released.');
            END IF;
         ELSE
            BARS_AUDIT.INFO ($$PLSQL_UNIT || ': lock was not acquired.');
         END IF;
      END IF;

      BARS_UTL_SNAPSHOT.PURGE_RUNNING_FLAG ();

      bars_audit.trace ('%s: Exit.', title);
   EXCEPTION
      WHEN OTHERS
      THEN
         gl.fSOS0 := 0;
         BARS_UTL_SNAPSHOT.PURGE_RUNNING_FLAG ();
         bars_audit.error (
               title
            || ': '
            || DBMS_UTILITY.format_error_stack ()
            || CHR (10)
            || DBMS_UTILITY.format_error_backtrace ());
         RAISE;
   END CREATE_MONTHLY_SNAPSHOT;

   --
   -- CREATE_ANNUAL_BALANCE_SNAPSHOT
   --
   PROCEDURE CREATE_ANNUAL_SNAPSHOT (p_snapshot_dt IN DATE)
   IS
      /**
      <b>CREATE_ANNUAL_SNAPSHOT</b> - процедура створення річних знімків балансу
      %param

      %version 1.0
      %usage   створення річних знімків балансу.
      */
      title   CONSTANT VARCHAR2 (60)
                          := $$PLSQL_UNIT || '.CREATE_ANNUAL_SNAPSHOT' ;
      l_jan_01_dt      DATE;        -- перший   календарний день звітного року
      l_dec_01_dt      DATE;
      l_dat3           DATE;
      l_errmsg         VARCHAR2 (500);
      l_kf             agg_monbals.kf%TYPE;
   BEGIN
      bars_audit.trace ('%s: Start running with p_snapshot_dt=%s.',
                        title,
                        TO_CHAR (p_snapshot_dt, 'dd.mm.yyyy'));

      IF (p_snapshot_dt IS NULL)
      THEN
         raise_application_error (
            -20666,
            'Не вказано дату для формування знімку!');
      ELSE
         l_jan_01_dt := TRUNC (p_snapshot_dt, 'YEAR');
         l_dec_01_dt := ADD_MONTHS (l_jan_01_dt, 11);
         l_dat3 := ADD_MONTHS (l_jan_01_dt, -12);
      END IF;

      l_kf := SYS_CONTEXT ('bars_context', 'user_mfo');

      IF (l_kf IS NULL)
      THEN                                                       -- for all KF
         -- Перевірка на наявність усіх місячних знімків балансу в році



         IF (l_errmsg IS NOT NULL)
         THEN
            raise_application_error (
               -20666,
                  'Відсутній щомісячний знімок балансу за: '
               || l_errmsg);
         END IF;

         -- temporarry
         raise_application_error (
            -20666,
            'Не задано код філіалу (МФО) для формування знімку!');
      ELSE                                                       -- for one KF
         bars_audit.trace ('%s: running with kf=%s.', title, l_kf);

         -- Перевірка на наявність усіх місячних знімків балансу в році
         SELECT LISTAGG (TO_CHAR (k.FDAT, 'dd-mm-yyyy'), ', ')
                   WITHIN GROUP (ORDER BY k.FDAT)
           INTO l_errmsg
           FROM (    SELECT ADD_MONTHS (l_jan_01_dt, LEVEL - 1) AS FDAT
                       FROM DUAL
                 CONNECT BY LEVEL <= 12) k
          WHERE NOT EXISTS
                   (SELECT 1
                      FROM AGG_MONBALS
                     WHERE FDAT = k.FDAT AND KF = l_kf);

         IF (l_errmsg IS NOT NULL)
         THEN
            raise_application_error (
               -20666,
                  'Відсутній щомісячний знімок балансу за: '
               || l_errmsg);
         END IF;

         -- Перевірка наявності активного процесу формування знімку
         l_errmsg := BARS_UTL_SNAPSHOT.CHECK_SNP_RUNNING ('YEARBALS');

         IF (l_errmsg IS NOT NULL)
         THEN
            raise_application_error (
               -20666,
                  'формування річного знімку балансу вже запущено користувачем '
               || l_errmsg);
         ELSE
            -- Блокування від декількох запусків
            BARS_UTL_SNAPSHOT.SET_RUNNING_FLAG ('YEARBALS');
         END IF;

         DBMS_APPLICATION_INFO.set_client_info (
               'Формування річного знімку балансу за '
            || TO_CHAR (p_snapshot_dt, 'YYYY')
            || '-й рік.');

         EXECUTE IMMEDIATE 'truncate table AGG_YEARBALS_EXCHANGE';
      END IF;

      -- Фіксуємо SCN на якому формуємо знімок балансу по табл. SALDOY
      BARS_UTL_SNAPSHOT.SET_TABLE_SCN (
         'SALDOY',
         l_jan_01_dt,
         l_kf,
         DBMS_FLASHBACK.get_system_change_number ());

      INSERT /*+ APPEND */
            INTO  AGG_YEARBALS_EXCHANGE (FDAT,
                                         KF,
                                         ACC,
                                         RNK,
                                         OST,
                                         OSTQ,
                                         DOS,
                                         DOSQ,
                                         KOS,
                                         KOSQ,
                                         CRDOS,
                                         CRDOSQ,
                                         CRKOS,
                                         CRKOSQ,
                                         CUDOS,
                                         CUDOSQ,
                                         CUKOS,
                                         CUKOSQ,
                                         WSDOS,
                                         WSKOS,
                                         WCDOS,
                                         WCKOS)
         SELECT /*+ PARALLEL */
               l_jan_01_dt AS FDAT,
                NVL (b.KF, y.KF) AS KF,
                NVL (b.ACC, y.ACC) AS ACC,
                NVL (b.RNK, 1) AS RNK,
                NVL (b.ost, 0) AS OST,
                NVL (b.ostq, 0) AS OSTQ,
                NVL (b.dos, 0) AS DOS,
                NVL (b.dosq, 0) AS DOSQ,
                NVL (b.kos, 0) AS KOS,
                NVL (b.kosq, 0) AS KOSQ,
                NVL (y.RDOS, 0) AS CRDOS,
                NVL (y.RDOSQ, 0) AS CRDOSQ,
                NVL (y.RKOS, 0) AS CRKOS,
                NVL (y.RKOSQ, 0) AS CRKOSQ,
                NVL (y.UDOS, 0) AS CUDOS,
                NVL (y.UDOSQ, 0) AS CUDOSQ,
                NVL (y.UKOS, 0) AS CUKOS,
                NVL (y.UKOSQ, 0) AS CUKOSQ,
                0 AS WSDOS,
                0 AS WSKOS,
                0 AS WCDOS,
                0 AS WCKOS
           FROM (  SELECT KF,
                          ACC,
                          SUM (DECODE (FDAT, l_dec_01_dt, ost, 0)) OST,
                          SUM (DECODE (FDAT, l_dec_01_dt, ostq, 0)) OSTQ,
                          SUM (DOS) AS DOS,
                          SUM (DOSQ) AS DOSQ,
                          SUM (KOS) AS KOS,
                          SUM (KOSQ) AS KOSQ,
                          ABS (MAX (DECODE (FDAT, l_dec_01_dt, rnk, -rnk)))
                             AS RNK
                     FROM AGG_MONBALS
                    WHERE FDAT BETWEEN l_jan_01_dt AND l_dec_01_dt
                 GROUP BY KF, ACC) b
                FULL                                      -- корегуючі обороти
                    JOIN (SELECT NVL (r.KF, u.KF) AS KF,
                                 NVL (r.acc, u.acc) AS ACC,
                                 r.dos AS RDOS,
                                 r.dosq AS RDOSQ,
                                 r.kos AS RKOS,
                                 r.kosq AS RKOSQ,
                                 u.dos AS UDOS,
                                 u.dosq AS UDOSQ,
                                 u.kos AS UKOS,
                                 u.kosq AS UKOSQ
                            FROM (SELECT KF,
                                         FDAT,
                                         ACC,
                                         DOS,
                                         DOSQ,
                                         KOS,
                                         KOSQ
                                    FROM SALDOY
                                   WHERE FDAT = l_jan_01_dt) r -- корегуючі обороти виконані за звітний рік
                                 FULL JOIN (SELECT KF,
                                                   FDAT,
                                                   ACC,
                                                   DOS,
                                                   DOSQ,
                                                   KOS,
                                                   KOSQ
                                              FROM SALDOY
                                             WHERE FDAT = l_dat3) u -- корегуючі обороти виконані в звітному році (за попередній)
                                    ON (u.ACC = r.ACC)) y
                   ON (y.ACC = b.ACC);

      bars_audit.trace ('%s: %s row created.', title, TO_CHAR (SQL%ROWCOUNT));

      COMMIT;

      -- переоцінка валютних позицій (коригуючі проводки + корекція даних в AGG_YEARBALS_EXCHANGE)
      BARS_SNAPSHOT.ANNUAL_CURRENCY_REVALUATION;

      COMMIT;

      /*
      -- partition is first locked to ensure that the partition is created
      execute immediate 'LOCK TABLE AGG_YEARBALS PARTITION FOR (to_date('''
                        || to_char(l_jan_01_dt,'ddmmyyyy') || ''',''DDMMYYYY'')) IN SHARE MODE';

      execute immediate 'ALTER TABLE AGG_YEARBALS EXCHANGE PARTITION FOR (to_date('''
                        || to_char(l_jan_01_dt,'ddmmyyyy') || ''',''DDMMYYYY'')) WITH TABLE AGG_YEARBALS_EXCHANGE '
                        || 'INCLUDING INDEXES WITHOUT VALIDATION';

      execute immediate 'ALTER TABLE AGG_YEARBALS RENAME PARTITION FOR (to_date('''
                        || to_char(l_jan_01_dt,'ddmmyyyy') || ''',''ddmmyyyy'')) TO P_'
                        || to_char(l_jan_01_dt,'YYYYMMDD');
      */

      IF (l_kf IS NULL)
      THEN                                                       -- for all KF
         l_condition :=
            REPLACE (q'[ (to_date('%dt','ddmmyyyy')) ]',
                     '%dt',
                     TO_CHAR (l_jan_01_dt, 'ddmmyyyy'));

         -- bypass the RLS policies
         DM_UTL.EXCHANGE_PARTITION_FOR (
            p_source_table_nm   => 'AGG_YEARBALS_EXCHANGE_KF',
            p_target_table_nm   => 'AGG_YEARBALS',
            p_condition         => l_condition);

         DM_UTL.RENAME_PARTITION_FOR (
            p_table_nm       => 'AGG_YEARBALS',
            p_partition_nm   => 'P_' || TO_CHAR (l_jan_01_dt, 'YYYYMMDD'),
            p_condition      => l_condition,
            p_rename_sub     => 1);

         EXECUTE IMMEDIATE 'truncate table AGG_YEARBALS_EXCHANGE_KF';
      ELSE                                                       -- for one KF
         l_condition :=
            REPLACE (q'[ (to_date('%dt','ddmmyyyy'),'%kf') ]',
                     '%dt',
                     TO_CHAR (l_jan_01_dt, 'ddmmyyyy'));
         l_condition := REPLACE (l_condition, '%kf', l_kf);

         -- bypass the RLS policies
         DM_UTL.EXCHANGE_SUBPARTITION_FOR (
            p_source_table_nm   => 'AGG_YEARBALS_EXCHANGE',
            p_target_table_nm   => 'AGG_YEARBALS',
            p_condition         => l_condition);

         -- DM_UTL.RENAME_SUBPARTITION_FOR
         -- ( p_table_nm        => 'AGG_YEARBALS'
         -- , p_subpartition_nm => 'P_'||to_char(l_jan_01_dt,'YYYYMMDD')||'_SP_'||l_kf
         -- , p_condition       => l_condition
         -- );

         EXECUTE IMMEDIATE 'truncate table AGG_YEARBALS_EXCHANGE';
      END IF;

      DBMS_STATS.GATHER_TABLE_STATS (
         ownname       => 'BARS',
         tabname       => 'AGG_YEARBALS',
         cascade       => TRUE,
         method_opt    => 'FOR ALL COLUMNS SIZE AUTO',
         degree        => 4,
         granularity   => 'ALL');

      BARS_UTL_SNAPSHOT.PURGE_RUNNING_FLAG ();

      bars_audit.trace ('%s: Exit.', title);
   EXCEPTION
      WHEN OTHERS
      THEN
         BARS_UTL_SNAPSHOT.PURGE_RUNNING_FLAG ();
         bars_audit.error (
               title
            || ': '
            || DBMS_UTILITY.format_error_stack ()
            || CHR (10)
            || DBMS_UTILITY.format_error_backtrace ());
         RAISE;
   END CREATE_ANNUAL_SNAPSHOT;

   --
   --
   --
   PROCEDURE REMOVING_OBSOLETE_SNAPSHOTS
   IS
      /**
      <b>REMOVING_OBSOLETE_SNAPSHOTS</b> - процедура видалення застарілих
      знімків балансу (заміна проц. DROP_OBSOLETE_PARTITIONS з пакету BARS_ACCM_SNAP)
      %param

      %version 1.1
      %usage   видалення застарілих знімків балансу.
      */
      title    CONSTANT VARCHAR2 (64)
                           := $$PLSQL_UNIT || '.REMOVING_OBSOLETE_DM' ;
      l_min_dt          DATE;
      l_lmt_dt          DATE;
      PART_NOT_EXISTS   EXCEPTION;
      PRAGMA EXCEPTION_INIT (PART_NOT_EXISTS, -2149);
   BEGIN
      bars_audit.trace ('%s: Entry.', title);

      -- залишаємо щоденні знімки за поточний і попередній місяць
      l_lmt_dt := ADD_MONTHS (TRUNC (gl.gbd (), 'MM'), -1);

      SELECT MIN (FDAT)
        INTO l_min_dt
        FROM SNAP_BALANCES
       WHERE FDAT < l_lmt_dt;

      bars_audit.trace ('%s: l_lmt_dt=%s, l_min_dt=%s.',
                        title,
                        TO_CHAR (l_lmt_dt, 'dd.mm.yyyy'),
                        TO_CHAR (l_min_dt, 'dd.mm.yyyy'));

      FOR c IN (SELECT FDAT
                  FROM FDAT
                 WHERE FDAT >= l_min_dt AND FDAT < l_lmt_dt)
      LOOP
         BEGIN
            EXECUTE IMMEDIATE
                  'alter table SNAP_BALANCES drop partition for (to_date('''
               || TO_CHAR (c.FDAT, 'ddmmyyyy')
               || ''',''ddmmyyyy''))';

            bars_audit.trace ('%s: partition dropped for %.',
                              title,
                              TO_CHAR (c.FDAT, 'dd.mm.yyyy'));
         EXCEPTION
            WHEN PART_NOT_EXISTS
            THEN
               NULL;
            WHEN OTHERS
            THEN
               bars_audit.error (
                     title
                  || ': '
                  || DBMS_UTILITY.format_error_stack ()
                  || CHR (10)
                  || DBMS_UTILITY.format_error_backtrace ());
         END;
      END LOOP;

      -- залишаємо місячні знімки за поточний та попередній рік
      l_lmt_dt := ADD_MONTHS (TRUNC (gl.gbd (), 'YY'), -12);

      SELECT MIN (FDAT)
        INTO l_min_dt
        FROM AGG_MONBALS
       WHERE FDAT < l_lmt_dt;

      bars_audit.trace ('%s: l_lmt_dt=%s, l_min_dt=%s.',
                        title,
                        TO_CHAR (l_lmt_dt, 'dd.mm.yyyy'),
                        TO_CHAR (l_min_dt, 'dd.mm.yyyy'));

      WHILE (l_lmt_dt > l_min_dt)
      LOOP
         BEGIN
            EXECUTE IMMEDIATE
                  'alter table AGG_MONBALS drop partition for (to_date('''
               || TO_CHAR (l_min_dt, 'ddmmyyyy')
               || ''',''ddmmyyyy''))';

            bars_audit.trace ('%s: partition dropped for %.',
                              title,
                              TO_CHAR (l_min_dt, 'dd.mm.yyyy'));
         EXCEPTION
            WHEN PART_NOT_EXISTS
            THEN
               NULL;
            WHEN OTHERS
            THEN
               bars_audit.error (
                     title
                  || ': '
                  || DBMS_UTILITY.format_error_stack ()
                  || CHR (10)
                  || DBMS_UTILITY.format_error_backtrace ());
         END;

         l_lmt_dt := ADD_MONTHS (l_lmt_dt, 1);
      END LOOP;

      bars_audit.trace ('%s: Exit.', title);
   END REMOVING_OBSOLETE_SNAPSHOTS;
BEGIN
   l_mfo := gl.aMFO;
   l_baseval := gl.baseval;
   l_userid := gl.aUID;
   l_okpo := gl.aOKPO;
END BARS_SNAPSHOT;
/
show errors;

grant EXECUTE on BARS_SNAPSHOT to BARS_ACCESS_DEFROLE;
