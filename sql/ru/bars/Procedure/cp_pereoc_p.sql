

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CP_PEREOC_P.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CP_PEREOC_P ***

  CREATE OR REPLACE PROCEDURE BARS.CP_PEREOC_P (mode_ in INT, p_vob in oper.vob%type)
IS
   -- v.1.5 23/11/2015
   title   CONSTANT VARCHAR2 (20) := 'CP_PEREOC_P:';
   ce               cp_deal%ROWTYPE;  -- реквизиты сделки с ЦП
   ar               accounts%ROWTYPE;
   ad               accounts%ROWTYPE; -- реквищиты счета переоценки (cp_deal.accs)
   ca               cp_accc%ROWTYPE;
   a6               accounts%ROWTYPE;
   op               oper%ROWTYPE;
   fl_              INT;
   S_               NUMBER;
   SQ_              NUMBER;
   dk_              INT;
   l_err            VARCHAR2 (4000);
   l_msg            VARCHAR2 (10);
   l_prev_vdat      DATE;             -- COBUSUPABS-3715 Необхідно, щоб переоцінка, що потребує згорнення, проводилась по курсу НБУ на дату її виникнення (дата проведення проводок по переоцінки в АБС).
   l_valdate	    DATE;             -- для корр проводок курс брать на дату последнего дня месяца
BEGIN
   bars_audit.trace('%s Начало работы. Инициализация.', title);

   if nvl(p_vob, 0) = 96
   then
    l_valdate := DAT_NEXT_U(last_day(add_months(gl.bdate,-1)),0);
    op.vob := p_vob;
    bars_audit.trace('%s gl.bdate = %s, op.vob = %s', title, to_char(gl.bdate), to_char(op.vob));
    op.tt := '096'; -- на случай припадка у Ф.
   else
    op.tt := 'FXP';
    l_valdate := gl.bdate;
   end if;
    -- делаем 'FXP' только с корр = с воб 096, а не идем на поводу у истерик
   op.tt := 'FXP';

   -- Проверка наличия кода и настроек операции op.tt
   BEGIN
      SELECT DECODE (SUBSTR (flags, 38, 1), '1', 2, 0)
        INTO FL_
        FROM tts
       WHERE tt = op.tt;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN bars_error.raise_nerror('DOC', 'TRANSACTION_DOES_NOT_EXIST', op.tt);
   END;

   -- Для бумаг из формы CP_PEREOC_V (ЦП Форма для переоцінки (Ощадбанк)), где поле Переоц-ка~пакет~ Грф.22 не равна нулю
    FOR K IN (     SELECT   SOS,    ND,     DATD,   SUMB,       DAZS,       DATP_A,     FL_REPO,
                   TIP,     REF,    ID,     NAME,   CP_ID,      MDATE,      CENA,       IR,
                   ERAT,    RYN,    VIDD,   KV,     KOL,        KOL_CP,     N,          D,
                   P,       R,      R2,     S,      BAL_VAR,    BAL_VAR1,   NKD1,       RATE_B,
                   K20,     K21,    K22,    OSTR,   OSTR_F,     OSTAF,      OSTS_P,     EMI,
                   DOX,     RNK,    PF,     PFNAME, DAT_ZV,     DAPP,       DATP,       QUOT_SIGN,
                   FL_ALG
              FROM CP_PEREOC_V
             WHERE K22 <> 0)
   LOOP
      l_err := '';
      l_msg := '';
      -- реквизиты сделки cp_deal
      BEGIN
         l_msg := 'ce';

         SELECT *
           INTO ce
           FROM cp_deal
          WHERE REF = k.REF
            AND accs IS NOT NULL;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN l_err := title||'Не найдены данные сделки cp_deal c заполненным счетом переоценки (accs) для ref='|| k.REF || ' ' || l_msg;
      END;
      -- реквизиты счета переоценки cp_deal.accs
      BEGIN
         l_msg := 'ad';

         SELECT *
           INTO ad
           FROM accounts
          WHERE acc = ce.accs
           AND dazs IS NULL;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN l_err := l_err||CHR(10)||CHR(13)||'Не найдены данные счета переоценки cp_deal.accs ('||to_char(ce.accs)||') для ref='|| k.REF || ' ' || l_msg;
      END;
      -- ACC консолидированного счета ad.accc
      BEGIN
         l_msg := 'ar';

         SELECT *
           INTO ar
           FROM accounts
          WHERE acc = ad.accc
            AND dazs IS NULL
            AND kv = ad.kv;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN l_err :=  l_err||CHR(10)||CHR(13)||'Не найдены данные консолидированного счета переоценки('||to_char(ad.accc)||') для ref='|| k.REF || ' ' || l_msg;
      END;
      -- данные консолидированных счетов сделки (поиск по субпортфелю и счету переоценки)
      BEGIN
         l_msg := 'ca';

         SELECT *
           INTO ca
           FROM cp_accc
          WHERE ryn = ce.ryn
            AND nlss = ar.nls;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN l_err := l_err||CHR(10)||CHR(13)||'Не найдены данные консолидированных счетов '||ar.nls ||' ryn = '|| to_char(ce.ryn)||') для ref='|| k.REF || ' ' || l_msg;
      END;
      -- реквизиты консолидированного счета переоценки
      BEGIN
         l_msg := 'a6';

         SELECT *
           INTO a6
           FROM accounts
          WHERE kv = 980
            AND dazs IS NULL
            AND nls = ca.NLS_FXP;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN l_err := l_err||CHR(10)||CHR(13)||'Не найдены реквизиты консолидированного счета переоценки ('||ca.NLS_FXP||') для ref='|| k.REF || ' ' || l_msg;
      END;

      bars_audit.trace('%s Поиск предыдущей переоценки', title);
      BEGIN                                                 --COBUSUPABS-3715
         SELECT MAX (fdat)
           INTO l_prev_vdat
           FROM opldok
          WHERE acc = ad.acc
            AND sos = 5
            AND fdat >= ad.daos
            AND fdat < gl.bdate;
         bars_audit.trace('%s Дата предыдущей переоценки = %s', title, to_char(l_prev_vdat,'dd.mm.yyyy'));
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN l_prev_vdat := gl.bdate;
              bars_audit.trace('%s Дата предыдущей переоценки не найдена', title);
      END;                                                  --/COBUSUPABS-3715
      IF l_err IS NULL
        THEN   bars_audit.trace('%s Инициализация - ОК', title);
        ELSE   bars_error.raise_nerror('BRS', 'NO_DATA_FOUND', l_err);
      END IF;
      bars_audit.trace('%s Переоценка - старт', title);

      --сумма переоценки от курса котировки поля Переоц-ка~пакет~ Грф.22
      op.s := ABS (k.k22) * 100;
      -- эквивалент переоценки на "сегодня"
      IF      ad.kv = a6.kv
        THEN  op.vob := nvl(op.vob,6);    op.s2 := op.S;
        ELSE  op.vob := nvl(op.vob,16);   op.s2 := gl.p_icurval (ad.kv, op.S, l_valdate);
      END IF;

      -- направление проводки переоценки
      IF      k.k22 > 0
        THEN  op.dk := 1;
        ELSE  op.dk := 0;
      END IF;

      op.nazn := 'Переоцiнка '
                || to_char(k.cp_id)
                || ' угода № '
                || to_char(k.ND)
                || ' по курсу '
                || to_char(k.k20)
                || ' дата '
                || to_char(k.dat_zv,'dd.mm.yyyy')
                || ' пакет '
                || to_char(k.kol_cp)
                || ' шт.';

      gl.REF (i_ref => op.REF);
      gl.in_doc3 (ref_     => op.REF,
                  tt_      => op.tt,
                  vob_     => op.vob,
                  nd_      => TO_CHAR (op.REF),
                  pdat_    => SYSDATE,
                  vdat_    => coalesce(l_valdate, gl.bdate),
                  dk_      => op.dk,
                  kv_      => ad.kv,
                  s_       => op.s,
                  kv2_     => a6.kv,
                  s2_      => op.s2,
                  sk_      => NULL,
                  data_    => gl.bdate,
                  datp_    => gl.bdate,
                  nam_a_   => SUBSTR (ar.nms, 1, 38),
                  nlsa_    => ar.nls,
                  mfoa_    => gl.aMfo,
                  nam_b_   => SUBSTR (a6.nms, 1, 38),
                  nlsb_    => a6.nls,
                  mfob_    => gl.amfo,
                  nazn_    => op.nazn,
                  d_rec_   => NULL,
                  id_a_    => gl.aOkpo,
                  id_b_    => gl.aOkpo,
                  id_o_    => NULL,
                  sign_    => NULL,
                  sos_     => 1,
                  prty_    => NULL,
                  uid_     => NULL);

            gl.payv (0,     op.REF,     coalesce(l_valdate, gl.bdate),
                     op.tt, op.dk,
                     ad.kv, ad.nls,     op.s,
                     a6.kv, a6.nls,     op.s2);
         bars_audit.trace('%s Переоценка - 1 часть - ОК, ref = %s', title, to_char(op.ref));
         --расформировать и сформировать наново
         S_ := 0;
         IF k.S <> 0
         THEN
            IF k.S > 0
              THEN DK_ := 1;
              ELSE DK_ := 0;
            END IF;

            S_  := ABS (k.S * 100);
            SQ_ := gl.p_icurval (k.kv, S_, coalesce(l_prev_vdat, gl.bdate));-- расформируем документ по предыдущему курсу

            PAYtt (0,           op.REF,     coalesce(l_valdate, gl.bdate),
                   op.tt,       DK_,
                   k.kv,        ad.NLS,     S_,
                   gl.baseval,  a6.nls,     SQ_);

         END IF;
      bars_audit.trace('%s Переоценка - 2 часть - ОК, S_ = %s, SQ_ = %s', title, to_char(op.ref), to_char(S_), to_char(SQ_));
      -- оплачиваем документ
      gl.pay (1, op.REF, coalesce(l_valdate, gl.bdate));

      bars_audit.trace('%s Переоценка - ОК', title);

      begin
       insert into cp_payments
       values(k.ref, op.ref);
      exception when dup_val_on_index then  bars_audit.trace('%s Проводка уже есть в cp_payments', title);
      end;


      DELETE FROM CP_RATES_SB
            WHERE REF = k.REF;

   END LOOP;
   bars_audit.trace('%s Финиш.', title);
END CP_PEREOC_P;
/
show err;

PROMPT *** Create  grants  CP_PEREOC_P ***
grant EXECUTE                                                                on CP_PEREOC_P     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CP_PEREOC_P.sql =========*** End *
PROMPT ===================================================================================== 
