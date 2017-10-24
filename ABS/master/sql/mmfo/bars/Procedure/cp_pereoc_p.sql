

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CP_PEREOC_P.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CP_PEREOC_P ***

  CREATE OR REPLACE PROCEDURE BARS.CP_PEREOC_P (mode_ in INT, p_vob in oper.vob%type)
IS
   -- v.1.13 19/04/2017
   title   CONSTANT VARCHAR2 (20) := 'CP_PEREOC_P:';
   --ce               cp_deal%ROWTYPE;  -- реквизиты сделки с ЦП
   l_accs           cp_deal.accs%type; -- счет переоценки /уценки/дооценки
   l_ryn            cp_deal.ryn%type;
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
   l_valdate        DATE;             -- для корр проводок курс брать на дату последнего дня месяца
   l_can3800_branch branch.branch%type;
BEGIN
   bars_audit.info('%s Начало работы. Инициализация.'|| title);

   if nvl(p_vob, 0) = 96
   then
    l_valdate := DAT_NEXT_U(last_day(add_months(gl.bd,-1)),-1);
    op.vob := p_vob;
    bars_audit.info('%s gl.bdate = %s, op.vob = %s'|| title|| to_char(gl.bdate)|| to_char(op.vob));
    op.tt := '096'; -- на случай припадка у Ф.
   else
    op.tt := 'FXP';
    l_valdate := gl.bd;
   end if;
    -- делаем 'FXP' только с корр = с воб 096, а не идем на поводу у истерик
   op.tt := 'FXP';
   begin
   select distinct branch
     into l_can3800_branch
     from accounts
    where nbs ='3800'
      and dazs is null
      and ob22 = (select substr(s3800, length(s3800)-4,2) from tts where tt = op.tt)
      and branch like '/'|| sys_context('bars_context','user_mfo') ||'/%';
   exception when no_data_found then bars_error.raise_nerror('CAC','Рахунку 3800 не існує');
   end;
   bc.go(l_can3800_branch);

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
             WHERE (K22 <> 0) or (BAL_VAR1 = RATE_B and MDATE = DAT_ZV))
   LOOP
      l_err := '';
      l_msg := '';
      bars_audit.info(title|| 'ID = ' || to_char(k.ID) ||',S = ' || to_char(k.S)||',K22='||to_char(k.K22)||',BAL_VAR1='||to_char(k.BAL_VAR1)||', RATE_B ='|| to_char(k.RATE_B));
      -- реквизиты сделки cp_deal
      BEGIN
         SELECT accs, ryn
           INTO l_accs, l_ryn
           FROM cp_deal
          WHERE REF = k.REF
            AND accs IS NOT NULL;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN l_err := title||'Не найдены данные сделки cp_deal c заполненным счетом переоценки (accs) для ref='|| k.REF;
      END;

      -- реквизиты счета переоценки cp_deal.accs
      BEGIN
         l_msg := 'ad';

         SELECT *
           INTO ad
           FROM accounts
          WHERE acc = l_accs
           AND dazs IS NULL;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN l_err := l_err||CHR(10)||CHR(13)||'Не найдены данные счета переоценки cp_deal.accs ('||to_char(l_accs)||') для ref='|| k.REF || ' ' || l_msg;
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
          WHERE ryn = l_ryn
            AND nlss = ar.nls;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN l_err := l_err||CHR(10)||CHR(13)||'Не найдены данные консолидированных счетов '||ar.nls ||' ryn = '|| to_char(l_ryn)||') для ref='|| k.REF || ' ' || l_msg;
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

      bars_audit.info( title|| '%s Поиск предыдущей переоценки');
      BEGIN                                                 --COBUSUPABS-3715
         SELECT MAX (o.fdat)
           INTO l_prev_vdat
           FROM opldok o, cp_payments cp
          WHERE o.acc = ad.acc
            AND o.sos = 5
            AND o.ref = cp.op_ref
            AND o.fdat >= ad.daos
            AND o.fdat < gl.bd
            AND cp.cp_ref = k.ref;
         bars_audit.info( title|| 'Дата предыдущей переоценки = '|| to_char(l_prev_vdat,'dd.mm.yyyy'));
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN l_prev_vdat := gl.bd;
              bars_audit.info(title|| 'Дата предыдущей переоценки не найдена');
      END;                                                  --/COBUSUPABS-3715
      IF l_err IS NULL
        THEN   bars_audit.info(title || ' Инициализация - ОК');
        ELSE   bars_error.raise_nerror('BRS', 'NO_DATA_FOUND', l_err);
      END IF;
      bars_audit.info(title|| ' Переоценка - старт' );

      -- направление проводки переоценки
      IF      k.k22 >= 0
        THEN  op.dk := 1;
              bars_audit.info(title||' направление проводки переоценки k.k22 >= 0 '||op.dk);
        ELSE  op.dk := 0;
              bars_audit.info(title||' направление проводки переоценки k.k22 < 0 '||op.dk);
      END IF;

      op.nazn := 'Переоцiнка '  || to_char(k.cp_id)
                || ' угода № '  || to_char(k.ND)
                || ' по курсу ' || to_char(k.k20)
                || ' дата '     || to_char(k.dat_zv,'dd.mm.yyyy')
                || ' пакет '    || to_char(k.kol_cp)
                || ' шт.';
      bars_audit.info(title|| op.nazn);

      if ca.pf != 1 or k.kv != 980
      then
         bars_audit.info(title|| 'ca.pf != 1 ,k.kv ='|| k.kv);
          --сумма переоценки от курса котировки поля Переоц-ка~пакет~ Грф.22
          op.s := ABS (k.k22) * 100;
          -- эквивалент переоценки на "сегодня"
          IF      ad.kv = a6.kv
            THEN  op.vob := nvl(op.vob,6);    op.s2 := op.S;
            ELSE  op.vob := nvl(op.vob,16);   op.s2 := gl.p_icurval (ad.kv, op.S, l_valdate);
          END IF;

          gl.REF (i_ref => op.REF);
          gl.in_doc3 (ref_     => op.REF,
                      tt_      => op.tt,
                      vob_     => op.vob,
                      nd_      => TO_CHAR (op.REF),
                      pdat_    => SYSDATE,
                      vdat_    => l_valdate,
                      dk_      => op.dk,
                      kv_      => ad.kv,
                      s_       => op.s,
                      kv2_     => a6.kv,
                      s2_      => op.s2,
                      sk_      => NULL,
                      data_    => gl.bd,
                      datp_    => gl.bd,
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

                gl.payv (0,     op.REF,     l_valdate,
                         op.tt, op.dk,
                         ad.kv, ad.nls,     op.s,
                         a6.kv, a6.nls,     op.s2);
             bars_audit.info(title|| ' Переоценка - 1 часть - ОК, ref =' || to_char(op.ref));
             --расформировать и сформировать наново
             S_ := 0;
             IF k.S <> 0
             THEN
                IF k.S > 0
                  THEN DK_ := 1;
                  ELSE DK_ := 0;
                END IF;

                S_  := ABS (k.S * 100);
                SQ_ := gl.p_icurval (k.kv, S_, l_prev_vdat);-- расформируем документ по предыдущему курсу

                PAYtt (0,           op.REF,     l_valdate,
                       op.tt,       DK_,
                       k.kv,        ad.NLS,     S_,
                       gl.baseval,  a6.nls,     SQ_);
             END IF;
      else
        bars_audit.info(title|| 'ca.pf = 1 ');
            --pf = 1 http://jira.unity-bars.com.ua:11000/browse/COBUPRVN-246
            /* Прохання доопрацювати АБС Барс "Millenium"- АРМ "Цінні папери", а саме - згідно Постанови НБУ № 400 переоцінка цінних паперів
               в портфелі на продаж повинна розраховуватись як різниця між попередньою і наступною переоцінкою (по дельті).
               Переоцінка в торговому портфелі повинна залишатись без зміни функціоналу, тобто згортається попередня в повному об’ємі і проводиться нова.
               Необхідно також врахувати переоцінку паперів, номінованих в іноземній валюті. А саме, в розрахунку дельти для переоцінки необхідно враховувати курс валюти попередньої переоцінки.
               Це необхідно для вирівнювання залишка рахунку переоцінки в портфелі на продаж 5102.
               Тобто, залишок рахунку 5102 (980) має дорівнювати залишку рахунку 1415 (840) по курсу нової переоцінки.
               Звертаємо увагу, що в балансовую вартість цінних паперів при розрахунку переоцінки (АРМ "Цінні папери"- функція" Форма розрахунку переоцінки",
               необхідно включити ( з мінусом ) суму резерву за попередню дату баланса, а також Кт-залишок по рахунках нарахованих процентів. */
             --сумма переоценки от курса котировки поля Переоц-ка~пакет~ Грф.22
          op.s := ABS (k.k22) * 100;
             if (op.s != 0) then
              -- эквивалент переоценки на "сегодня"
              IF      ad.kv = a6.kv
                THEN  op.vob := nvl(op.vob,6);    op.s2 := op.S;
                ELSE  op.vob := nvl(op.vob,16);   op.s2 := gl.p_icurval (ad.kv, op.S, l_valdate);
              END IF;

              bars_audit.info(title|| ' op.s='|| to_char(op.s)||', op.s2='|| to_char(op.s2));

              S_  := op.S;
              SQ_ := op.s2;-- сумма документа по предыдущему курсу для портфеля на продаж pf = 1

              IF   (k.k22 > 0)                
                THEN  op.dk := 1;
                ELSE  op.dk := 0;
              END IF;

              bars_audit.info(title|| '!!!===!!! k.S ='||to_char(k.S)||',op.dk ='||to_char(op.dk) ||',S='|| to_char(S_)||',SQ='|| to_char(SQ_));
              gl.REF (i_ref => op.REF);
              gl.in_doc3 (ref_     => op.REF,
                          tt_      => op.tt,
                          vob_     => op.vob,
                          nd_      => TO_CHAR (op.REF),
                          pdat_    => SYSDATE,
                          vdat_    => l_valdate,
                          dk_      => op.dk,
                          kv_      => ad.kv,
                          s_       => S_,
                          kv2_     => a6.kv,
                          s2_      => SQ_,
                          sk_      => NULL,
                          data_    => gl.bd,
                          datp_    => gl.bd,
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
                    gl.payv (0,     op.REF,     l_valdate,
                             op.tt, op.dk,
                             ad.kv, ad.nls,     S_,
                             a6.kv, a6.nls,     SQ_);
             end if;
          end if;
          bars_audit.info(title||' Переоценка - 2 часть - ОК,'|| to_char(op.ref)||' S_ = '||to_char(S_)||', SQ_ = '|| to_char(SQ_));
          -- оплачиваем документ
          --gl.pay (1, op.REF, coalesce(l_valdate, gl.bdate));

          bars_audit.info(title|| ' Переоценка - ОК');

          begin
           insert into cp_payments
           values(k.ref, op.ref);
          exception when dup_val_on_index then  bars_audit.info(title ||' Проводка уже есть в cp_payments');
          end;


          DELETE FROM CP_RATES_SB
                WHERE REF = k.REF;

   END LOOP;
   bars_audit.info(title|| ' Финиш.');
END CP_PEREOC_P;
/
show err;

PROMPT *** Create  grants  CP_PEREOC_P ***
grant EXECUTE                                                                on CP_PEREOC_P     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CP_PEREOC_P     to CP_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CP_PEREOC_P.sql =========*** End *
PROMPT ===================================================================================== 
