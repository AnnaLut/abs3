

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CP_PAYEXPIRY.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CP_PAYEXPIRY ***

  CREATE OR REPLACE PROCEDURE BARS.P_CP_PAYEXPIRY (P_REF       IN     NUMBER,
                                                 P_MODE      IN     NUMBER,
                                                 P_SUMN      IN     NUMBER DEFAULT 0,
                                                 P_SUMR      IN     NUMBER DEFAULT 0)
IS
/*1.1*/
   MODCODE          CONSTANT CHAR (2) NOT NULL := 'CP';
   TITLE            CONSTANT CHAR (13) NOT NULL := 'CP_PAYEXPIRY:';
   ERRMSGDIM        CONSTANT NUMBER (38) NOT NULL := 3000;
   ROWSLIMIT        CONSTANT NUMBER (38) NOT NULL := 1000;
   AUTOCOMMIT       CONSTANT NUMBER (38) NOT NULL := 1000;

   P_RESULTTXT      VARCHAR2(2000);
   P_RESULTCODE     NUMBER := 0;

   L_MODE           NUMBER := NVL(P_MODE,1); -- 0 - погашение просроченного номинала; 1 - погашение просроченного купона

   TYPE T_CP_EXPPAY_DEAL IS RECORD
   (ID              CP_DEAL.ID%TYPE,
    CP_ID           CP_KOD.CP_ID%TYPE,
    ND              OPER.ND%TYPE,
    KOL             INT,
    RNK             CUSTOMER.RNK%TYPE,
    RYN             CP_ACCC.RYN%TYPE,
    VIDD            CP_ACCC.VIDD%TYPE,
    REF             OPER.REF%TYPE,
    KV              OPER.KV%TYPE,
    ACC_TRANS       ACCOUNTS.ACC%TYPE,
    ACC             ACCOUNTS.ACC%TYPE,
    ACCR            ACCOUNTS.ACC%TYPE,
    ACCR2           ACCOUNTS.ACC%TYPE,
    ACCEXPN         ACCOUNTS.ACC%TYPE,
    ACCEXPR         ACCOUNTS.ACC%TYPE
   );

   TYPE T_CP_DATA IS TABLE OF T_CP_EXPPAY_DEAL;

   EXPT_EXP         EXCEPTION;
   --
   -- переменные
   --
   L_BDATE          DATE := GL.BDATE;
   L_USERID         STAFF.ID%TYPE := GL.AUID;
   L_BASECUR        TABVAL.KV%TYPE := GL.BASEVAL;
   L_CP_DATA        T_CP_DATA;

   L_SUMN           NUMBER; -- ДЛЯ ЧАСТИЧНОГО ПОГАЩЕНИЯ ПРОСРОЧКИ, ВВЕДЕННОГО ВРУЧНУЮ
   L_SUMR           NUMBER;


   L_DOCREC         OPER%ROWTYPE;
   L_TRANSIT        ACCOUNTS.NLS%TYPE := '37392555';

   L_TT             TTS.TT%TYPE := 'FX7'; -- ОПЕРАЦИЯ ВЫНОСА НА ПРОСРОЧКУ
   L_NAZN           OPER.NAZN%TYPE := CASE WHEN L_MODE = 1 THEN 'Погашення простроченого купонного доходу, облігації *ISIN*, дог. *ND*, пакет *KOL*шт.'
                                                              --'Перенесення залишку номіналу * на рахунок прострочення'
                                           WHEN L_MODE = 0 THEN 'Погашення простроченого номіналу облігації *ISIN*, дог. *ND*, пакет *KOL*шт.'
                                                              --'Перенесення залишку нарахованого і придбаного купону * на рахунок прострочення'
                                      END;
   L_DK             OPER.DK%TYPE := 1;
   L_EXP_REF        OPER.REF%TYPE := 0;
   L_OST_R2         OPER.S%TYPE := 0;

   PROCEDURE CP_INIT_DOCREC (P_DOCREC IN OUT OPER%ROWTYPE)
   IS
   BEGIN
      P_DOCREC.REF := NULL;
      P_DOCREC.DK := NULL;
      P_DOCREC.VOB := 6;
      P_DOCREC.TT := NULL;
      P_DOCREC.NAZN := NULL;
      P_DOCREC.USERID := NULL;
      P_DOCREC.VDAT := NULL;
      P_DOCREC.S := NULL;
      P_DOCREC.S2 := NULL;
      P_DOCREC.KV := NULL;
      P_DOCREC.KV2 := NULL;
      P_DOCREC.NLSA := NULL;
      P_DOCREC.NLSB := NULL;
      P_DOCREC.MFOA := gl.amfo;
      P_DOCREC.MFOB := gl.amfo;
      P_DOCREC.NAM_A := NULL;
      P_DOCREC.NAM_B := NULL;
      P_DOCREC.ID_A := NULL;
      P_DOCREC.ID_B := NULL;
      P_DOCREC.TOBO := NULL;
      L_OST_R2      := 0;
   END CP_INIT_DOCREC;

    PROCEDURE CP_GET_DOCACCS (P_ACCA     IN     ACCOUNTS.ACC%TYPE,
                              P_ACCB     IN     ACCOUNTS.ACC%TYPE,
                              P_ACCR     IN     ACCOUNTS.ACC%TYPE,
                              P_DOK      IN     CP_KOD.DOK%TYPE,
                              P_DOCREC   IN OUT OPER%ROWTYPE)
    IS
    BEGIN
        BEGIN
           BARS_AUDIT.TRACE ('%s cp_get_docaccs: запуск, {ACCA, ACCB} = {%s, %s}',TITLE,TO_CHAR (P_ACCA),TO_CHAR (P_ACCB));

           SELECT AP.NLS,
                  AP.KV,
                  SUBSTR (AP.NMS, 1, 38),
                  CP.OKPO,
                  AE.NLS,
                  AE.KV,
                  SUBSTR (AE.NMS, 1, 38),
                  CE.OKPO,
                  L_TT,
                  L_NAZN,
                  L_DK,
                  L_BDATE
             INTO P_DOCREC.NLSA,
                  P_DOCREC.KV,
                  P_DOCREC.NAM_A,
                  P_DOCREC.ID_A,
                  P_DOCREC.NLSB,
                  P_DOCREC.KV2,
                  P_DOCREC.NAM_B,
                  P_DOCREC.ID_B,
                  P_DOCREC.TT,
                  P_DOCREC.NAZN,
                  P_DOCREC.DK,
                  P_DOCREC.VDAT
             FROM ACCOUNTS AP,
                  CUSTOMER CP,
                  ACCOUNTS AE,
                  CUSTOMER CE
            WHERE     AP.ACC = P_ACCA
                  AND AE.ACC = P_ACCB
                  AND AP.RNK = CP.RNK
                  AND AE.RNK = CE.RNK;

           bars_audit.trace ('%s cp_get_docaccs: счета = {%s, %s}',
                             title,
                             p_docrec.nlsa,
                             p_docrec.nlsb);
        EXCEPTION
           WHEN NO_DATA_FOUND
           THEN BARS_AUDIT.TRACE ('%s cp_get_docaccs: счета не найдены', TITLE);
              P_RESULTTXT := P_RESULTTXT
                 || 'Cчета не найдены'
                 || TO_CHAR (P_ACCA)
                 || ','
                 || TO_CHAR (P_ACCB)
                 || CHR (10)
                 || CHR (13);
              P_RESULTCODE := 1;
              raise_application_error(-20000, P_RESULTTXT);
              RETURN;
        END;
      BEGIN
          select
                   CASE WHEN T.N_ACC  = P_ACCA THEN CASE WHEN T.N_OST > 0 THEN COALESCE(L_SUMN,T.N_OST)*100 ELSE 0 END
                        WHEN T.R_ACC = P_ACCA THEN CASE WHEN T.R_OST > 0 THEN COALESCE(L_SUMR, T.R_OST)*100 ELSE 0 END
                   END
          INTO P_DOCREC.S
          from v_cpdeal_exppay t
          where T.N_ACC  = P_ACCA or T.R_ACC = P_ACCA;
    EXCEPTION
       WHEN NO_DATA_FOUND
       THEN
          BARS_AUDIT.TRACE ('%s cp_get_docaccs: Сумма по сделке не определена', TITLE);
          P_RESULTTXT := P_RESULTTXT || 'Сумма по сделке не определена (ACC = ' || TO_CHAR (P_ACCB)|| ')' ||chr(10) || chr(13);
          raise_application_error(-20000, P_RESULTTXT);
          P_RESULTCODE := 6;
          RETURN;
    END;
    P_DOCREC.S2 := P_DOCREC.S;
    END cp_get_docaccs;
   --
   -- оплата документа
   --
    FUNCTION CP_MAKE_DOC (P_DOCREC IN OPER%ROWTYPE)
       RETURN OPER.REF%TYPE
    IS
       L_REF   OPER.REF%TYPE := NULL;
    BEGIN
       BEGIN
          BARS_AUDIT.TRACE (
             '%s cp_make_doc: запуск, %s -> %s, %s %s %s',
             TITLE,
                P_DOCREC.NLSA             || ' ('
             || TO_CHAR (P_DOCREC.S)      || '/'
             || TO_CHAR (P_DOCREC.KV)     || ')',
                P_DOCREC.NLSB             || ' ('
             || TO_CHAR (P_DOCREC.S2)     || '/'
             || TO_CHAR (P_DOCREC.KV2)    || ')',
             P_DOCREC.TT,
             TO_CHAR (P_DOCREC.VDAT, 'dd.mm.yy'),
             P_DOCREC.NAZN);

          IF (P_DOCREC.BRANCH <> SYS_CONTEXT ('bars_context', 'user_branch'))
          THEN                                    -- змінюємо код бранча документа
             -- для правильного підбору рахунку по формулі з катрки операції
             BARS_CONTEXT.SUBST_BRANCH (P_DOCREC.BRANCH);
          END IF;

          IF (P_DOCREC.S <> 0)
          THEN
             GL.REF (L_REF);

             GL.IN_DOC3 (REF_     => L_REF,
                         TT_      => P_DOCREC.TT,
                         VOB_     => P_DOCREC.VOB,
                         ND_      => SUBSTR (TO_CHAR (L_REF), 1, 10),
                         PDAT_    => SYSDATE,
                         VDAT_    => P_DOCREC.VDAT,
                         DK_      => P_DOCREC.DK * SIGN(P_DOCREC.S),
                         KV_      => P_DOCREC.KV,
                         S_       => ABS(P_DOCREC.S),
                         KV2_     => P_DOCREC.KV2,
                         S2_      => ABS(P_DOCREC.S2),
                         SK_      => NULL,
                         DATA_    => P_DOCREC.VDAT,
                         DATP_    => P_DOCREC.VDAT,
                         NAM_A_   => P_DOCREC.NAM_A,
                         NLSA_    => P_DOCREC.NLSA,
                         MFOA_    => P_DOCREC.MFOA,
                         NAM_B_   => P_DOCREC.NAM_B,
                         NLSB_    => P_DOCREC.NLSB,
                         MFOB_    => P_DOCREC.MFOB,
                         NAZN_    => P_DOCREC.NAZN,
                         D_REC_   => NULL,
                         ID_A_    => P_DOCREC.ID_A,
                         ID_B_    => P_DOCREC.ID_B,
                         ID_O_    => NULL,
                         SIGN_    => NULL,
                         SOS_     => 0,
                         PRTY_    => NULL,
                         UID_     => P_DOCREC.USERID);

             PAYTT (NULL,
                    L_REF,
                    P_DOCREC.VDAT,
                    P_DOCREC.TT,
                    P_DOCREC.DK * SIGN(P_DOCREC.S),
                    P_DOCREC.KV,
                    P_DOCREC.NLSB,
                    ABS(P_DOCREC.S),
                    P_DOCREC.KV2,
                    P_DOCREC.NLSA,
                    ABS(P_DOCREC.S2));

           ELSE  P_RESULTTXT :=
                   P_RESULTTXT
                || 'Нулевая сумма проводки '
                || P_DOCREC.NLSA
                || chr(10) || chr(13);
                raise_application_error(-20000, P_RESULTTXT);
             P_RESULTCODE := 2;
          END IF;
       EXCEPTION
          WHEN OTHERS
          THEN
             P_RESULTTXT :=
                   P_RESULTTXT
                || ' Ошибка при вставке проводки '
                || (SQLCODE)
                || (SQLERRM)
                || chr(10) || chr(13);
                raise_application_error(-20000, P_RESULTTXT);
             P_RESULTCODE := 2;
       END;

       BARS_AUDIT.TRACE ('%s cp_make_doc: ref = %s', TITLE, TO_CHAR (L_REF));
       RETURN L_REF;
    END CP_MAKE_DOC;

BEGIN
    BARS_AUDIT.TRACE('%s P_CP_PAYEXPIRY.START %s', TITLE, to_char(P_REF));
    P_RESULTTXT      := '';
    P_RESULTCODE     := 0;
    if P_SUMN = 0
    then L_SUMN := null;
    ELSE L_SUMN := P_SUMN;
    end if;
    if P_SUMR = 0
    then L_SUMR := null;
    ELSE L_SUMR := P_SUMR;
    end if;
    -- ОТБОР АКТИВНЫХ СДЕЛОК ПОД КОДОМ ЦП = P_CP_ID
    BEGIN
      SELECT DISTINCT   K.ID,
                        CK.CP_ID,
                        (SELECT ND FROM OPER WHERE REF = CD.REF) ND,
                        (a.ostc / 100) / CK.cena KOL,
                        cK.RNK,
                        cd.RYN,
                        SUBSTR(A.NLS,1,4),
                        k.REF,
                        ck.KV,
                        k.trans_acc,
                        CD.ACC,
                        CD.ACCR,
                        cd.ACCR2,
                        k.N_ACC,
                        k.R_ACC
            BULK COLLECT INTO L_CP_DATA
            FROM v_cpdeal_exppay k,
                 CP_KOD CK,
                 cp_deal cd,
                 accounts a
         WHERE K.REF = P_REF
           AND ck.id = k.id
           AND k.REF = cd.REF
           AND A.ACC = CD.ACC;
      EXCEPTION WHEN NO_DATA_FOUND
                THEN --RAISE_APPLICATION_ERROR(-20203,'Немає договорів до виносу на прострочку', TRUE);
                     BARS_AUDIT.TRACE('%s Немає договорів до погашення прострочки для пакету = %s', TITLE, P_REF); --RETURN;
                     P_RESULTTXT := NVL(P_RESULTTXT,'') || 'Немає договорів до погашення прострочки для пакету = '||TO_CHAR(P_REF)|| chr(10) || chr(13);
                     raise_application_error(-20000, P_RESULTTXT);
                     P_RESULTCODE := 3;
                     RETURN;
      END;
    BARS_AUDIT.TRACE('%s Количество сделок = %s', TITLE, TO_CHAR(L_CP_DATA.COUNT));

    IF L_CP_DATA.COUNT = 0
    THEN
    BARS_AUDIT.TRACE('%s Немає активних договорів до погашення прострочки для пакета  = %s', TITLE, P_REF); --RETURN;
                     P_RESULTTXT := NVL(P_RESULTTXT,'') || 'Немає договорів до погашення прострочки для пакета = '||TO_CHAR(P_REF)|| CHR(10) || CHR(13);
                     raise_application_error(-20000, P_RESULTTXT);
                     P_RESULTCODE := 3;
                     RETURN;
    END IF;

    FOR I IN 1..L_CP_DATA.COUNT
    LOOP
     BARS_AUDIT.TRACE('%s шаг %s, Ref = %s', TITLE, TO_CHAR(I), TO_CHAR(L_CP_DATA(I).REF));

      -- 3. Выполнить вставку документов переноса на просрочку
      CP_INIT_DOCREC(L_DOCREC);
      -- 3.1 Заполняем реквизиты будущего документа

      IF L_MODE = 0     -- ПОГАШЕНИЕ ПРОСРОЧКИ НОМИНАЛА
       THEN
          CP_GET_DOCACCS(L_CP_DATA(I).ACCEXPN, L_CP_DATA(I).ACC_TRANS, NULL,BANKDATE, L_DOCREC);
      ELSIF L_MODE = 1  -- ПОГАШЕНИЕ ПРОСРОЧКИ КУПОНА
       THEN
          CP_GET_DOCACCS(L_CP_DATA(I).ACCEXPR, L_CP_DATA(I).ACC_TRANS, L_CP_DATA(I).ACCR2,BANKDATE, L_DOCREC);
          BARS_AUDIT.TRACE(TO_CHAR(L_CP_DATA(I).ACCR2));
      ELSE
        BARS_AUDIT.TRACE('%s Неверный режим запуска. Указанный = %s, Возможные (0,1,2)', TITLE, TO_CHAR(L_MODE));
        P_RESULTTXT := NVL(P_RESULTTXT,'') || 'Неверный режим запуска. Указанный ='||TO_CHAR(L_MODE)||', Возможные (0,1,2)'|| chr(10) || chr(13);
        raise_application_error(-20000, P_RESULTTXT);
        P_RESULTCODE := 6;
      END IF;
      L_NAZN := REPLACE(L_NAZN, '*ISIN*',    TO_CHAR(L_CP_DATA(I).CP_ID));
      L_NAZN := REPLACE(L_NAZN, '*ND*',      TO_CHAR(L_CP_DATA(I).ND));
      L_NAZN := REPLACE(L_NAZN, '*KOL*',     TO_CHAR(-L_CP_DATA(I).KOL));
      L_DOCREC.NAZN := SUBSTR(L_NAZN,1,160);
      L_EXP_REF := CP_MAKE_DOC(L_DOCREC);
      begin
        insert into cp_payments
        values (P_REF,L_EXP_REF);
      exception when dup_val_on_index then null;
      end;

    END LOOP;
    BARS_AUDIT.TRACE('%s P_CP_PAYEXPIRY.FINISH', TITLE);

    IF P_RESULTCODE = 0 THEN P_RESULTTXT := 'Погашение просрочки проведено успешно'; END IF;
    BARS_AUDIT.TRACE('%s '||P_RESULTTXT||'P_RESULTCODE ='||TO_CHAR(P_RESULTCODE), TITLE);


END P_CP_PAYEXPIRY;
/
show err;

PROMPT *** Create  grants  P_CP_PAYEXPIRY ***
grant EXECUTE                                                                on P_CP_PAYEXPIRY  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CP_PAYEXPIRY.sql =========*** En
PROMPT ===================================================================================== 
