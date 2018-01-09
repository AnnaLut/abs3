

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CP_EXPIRY.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CP_EXPIRY ***

CREATE OR REPLACE PROCEDURE P_CP_EXPIRY (P_CP_ID       IN     NUMBER,
                                              P_MODE        IN     NUMBER)
IS
/*2.4 2017.12.04*/
   MODCODE          CONSTANT CHAR (2) NOT NULL := 'CP';
   TITLE            CONSTANT CHAR (7) NOT NULL := 'CP_EXP:';
   ERRMSGDIM        CONSTANT NUMBER (38) NOT NULL := 3000;
   ROWSLIMIT        CONSTANT NUMBER (38) NOT NULL := 1000;
   AUTOCOMMIT       CONSTANT NUMBER (38) NOT NULL := 1000;

   P_RESULTTXT      VARCHAR2(2000);
   P_RESULTCODE     NUMBER := 0;

   L_MODE           NUMBER := NVL(P_MODE,1); -- 0 - вынос на просрочку номинала; 1 - вынос на просрочку купона

   TYPE T_CP_DEAL IS RECORD
   (ID              CP_DEAL.ID%TYPE,
    CP_ID           CP_KOD.CP_ID%TYPE,
    ND              OPER.ND%TYPE,
    CP_REF          CP_DEAL.REF%TYPE,
    EXPDATE         DATE,
    KOL             INT,
    DOK             CP_KOD.DOK%TYPE,
    DNK             CP_KOD.DNK%TYPE,
    RNK             CUSTOMER.RNK%TYPE,
    RYN             CP_ACCC.RYN%TYPE,
    VIDD            CP_ACCC.VIDD%TYPE,
    REF             OPER.REF%TYPE,
    KV              OPER.KV%TYPE,
    ACC             ACCOUNTS.ACC%TYPE,
    ACCR            ACCOUNTS.ACC%TYPE,
    ACCR2           ACCOUNTS.ACC%TYPE,
    NLSEXPN         ACCOUNTS.NLS%TYPE,
    NLSEXPR         ACCOUNTS.NLS%TYPE,
    NMSEXPN_SUB     ACCOUNTS.NMS%TYPE,
    NMSEXPR_SUB     ACCOUNTS.NMS%TYPE,
    NLSEXPN_SUB     ACCOUNTS.NLS%TYPE,
    NLSEXPR_SUB     ACCOUNTS.NLS%TYPE,
    ACCEXPN_SUB     ACCOUNTS.ACC%TYPE,
    ACCEXPR_SUB     ACCOUNTS.ACC%TYPE
   );

   TYPE T_CP_DATA IS TABLE OF T_CP_DEAL;

   EXPT_EXP         EXCEPTION;
   --
   -- переменные
   --
   L_BDATE          DATE := GL.BDATE;
   L_USERID         STAFF.ID%TYPE := GL.AUID;
   L_BASECUR        TABVAL.KV%TYPE := GL.BASEVAL;
   L_CP_DATA        T_CP_DATA;

   L_ACCC_EXPN      NUMBER :=0;
   L_ACCC_EXPR      NUMBER :=0;

   L_GRP_N          NUMBER;
   L_SEC_N          RAW (64);
   L_BRANCH_N       VARCHAR2(200);

   L_GRP_R          NUMBER;
   L_SEC_R          RAW (64);
   L_BRANCH_R       VARCHAR2(200);

   GRP_             INT;
   r1_              INT;
   L_REF_TAIL       VARCHAR2(10);

   L_DOCREC         OPER%ROWTYPE;
   L_TRANSIT        ACCOUNTS.NLS%TYPE := '37392555';

   L_TT             TTS.TT%TYPE := 'FX7'; -- ОПЕРАЦИЯ ВЫНОСА НА ПРОСРОЧКУ
   L_NAZN           OPER.NAZN%TYPE := CASE WHEN L_MODE = 1 THEN 'Прострочений купонних дохід, облігації *ISIN*, дог. *ND*, пакет *KOL*шт. Термін сплати *DATEXP*'
                                                              --'Перенесення залишку номіналу * на рахунок прострочення'
                                           WHEN L_MODE = 0 THEN 'Прострочений номінал облігації *ISIN*, дог. *ND*, пакет *KOL*шт. Термін сплати *DATEXP*'
                                                              --'Перенесення залишку нарахованого і придбаного купону * на рахунок прострочення'
                                      END;
   L_DK             OPER.DK%TYPE := 0;
   L_EXP_REF        OPER.REF%TYPE := 0;
   L_OST_R2         OPER.S%TYPE := 0;

   PROCEDURE CP_INIT_DOCREC (P_DOCREC IN OUT OPER%ROWTYPE)
   IS
   BEGIN
      P_DOCREC.REF := NULL;
      P_DOCREC.DK := NULL;
      P_DOCREC.VOB := NULL;
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
     L_UNSIGNED NUMBER := 0;
    BEGIN

        BEGIN
            SELECT COUNT (*)
            INTO L_UNSIGNED
              FROM OPLDOK
             WHERE FDAT >= P_DOK AND ACC = P_ACCB AND SOS > 0 AND SOS <> 5;
        EXCEPTION WHEN NO_DATA_FOUND
                  THEN L_UNSIGNED := 0;
        END;

         IF  L_UNSIGNED != 0 THEN
           BARS_AUDIT.TRACE (
                  '%s cp_get_docaccs: незавизированные документы по счету, {ACCA, ACCB} = {%s, %s}',
                  TITLE,
                  TO_CHAR (P_ACCA),
                  TO_CHAR (P_ACCB));
          P_RESULTTXT := P_RESULTTXT || 'незавизированные документы по счету (ACC = ' || TO_CHAR (P_ACCB)|| ')' ||chr(10) || chr(13);
          P_RESULTCODE := 7;
          raise_application_error(-20000, P_RESULTTXT);
          RETURN;
        END IF;

        BEGIN
           BARS_AUDIT.TRACE (
              '%s cp_get_docaccs: запуск, {ACCA, ACCB} = {%s, %s}',
              TITLE,
              TO_CHAR (P_ACCA),
              TO_CHAR (P_ACCB));

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
           THEN
              BARS_AUDIT.TRACE ('%s cp_get_docaccs: счета не найдены',
                                TITLE);
              P_RESULTTXT :=
                    P_RESULTTXT
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
                   CASE WHEN T.ACC  = P_ACCB THEN CASE WHEN T.OST_N_EXP > 0 THEN T.OST_N_EXP*100 ELSE 0 END
                        WHEN T.ACCR = P_ACCB THEN CASE WHEN T.OST_R_DIFF > 0 THEN T.OST_R_DIFF*100 ELSE 0 END
                   END
          INTO P_DOCREC.S
          from v_cpdeal_expcandidates t
          where T.ACC  = P_ACCB or T.ACCR = P_ACCB;
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
                    L_TRANSIT,
                    ABS(P_DOCREC.S2));

             PAYTT (NULL,
                    L_REF,
                    P_DOCREC.VDAT,
                    P_DOCREC.TT,
                    P_DOCREC.DK * SIGN(P_DOCREC.S),
                    P_DOCREC.KV,
                    L_TRANSIT,
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

    PROCEDURE CP_CHECK_EXPACC (P_NLS      IN     VARCHAR2,
                               P_KV       IN     NUMBER,
                               P_ACC         OUT NUMBER,
                               P_BRANCH      OUT VARCHAR2,
                               P_GRP         OUT NUMBER,
                               P_SEC         OUT RAW)
    IS
    BEGIN
       BEGIN
          SELECT ACC,
                 BRANCH,
                 GRP,
                 SEC
            INTO P_ACC,
                 P_BRANCH,
                 P_GRP,
                 P_SEC
            FROM ACCOUNTS
           WHERE NLS = P_NLS AND KV = P_KV AND DAZS IS NULL;
       EXCEPTION
          WHEN NO_DATA_FOUND
          THEN
             P_ACC := 0;
             BARS_AUDIT.TRACE ('%s Консолідований рахунок прострочки %s не знайдено (або він закрит)',TITLE,P_NLS || '\' || TO_CHAR (P_KV));
             P_RESULTTXT := NVL(P_RESULTTXT,'') || 'Консолідований рахунок прострочки '||P_NLS || '\' || TO_CHAR (P_KV)||' не знайдено (або він закрит)';
             raise_application_error(-20000, P_RESULTTXT);
       END;
    END CP_CHECK_EXPACC;

BEGIN
    BARS_AUDIT.TRACE('%s P_CP_EXPIRY.START %s', TITLE, to_char(P_CP_ID));
    P_RESULTTXT      := '';
    P_RESULTCODE     := 0;
    -- ОТБОР АКТИВНЫХ СДЕЛОК ПОД КОДОМ ЦП = P_CP_ID
    BEGIN
      SELECT DISTINCT   K.ID,
                        CK.CP_ID,
                        (SELECT ND FROM OPER WHERE REF = CD.REF) ND,
                        CD.REF,
                        K.EXPIRY_DATE,
                        (a.ostc / 100) / CK.cena KOL,
                        K.DOK,
                        CASE WHEN K.DNK > bankdate THEN K.DOK ELSE K.DNK END,
                        cK.RNK,
                        cd.RYN,
                        V.VIDD,
                        k.REF,
                        ck.KV,
                        k.ACC,
                        k.ACCR,
                        cd.ACCR2,
                        AC.NLSEXPN,
                        AC.NLSEXPR,
                        NULL,
                        NULL,
                        NULL,
                        NULL,
                        NULL,
                        NULL
          BULK COLLECT INTO L_CP_DATA
            FROM v_cpdeal_expcandidates k,
               cp_accc ac,
               CP_VIDD V,
               CP_PF CP,
               CP_KOD CK,
               cp_deal cd,
               accounts a,
               accounts accons
         WHERE     ck.id = k.id
               AND k.REF = cd.REF
               AND k.ACC = cd.ACC
               AND CP.PF = AC.PF
               and accons.nls in (ac.nlsexpr,ac.nlsexpn)
               AND AC.VIDD = V.VIDD
               --AND AC.VIDD = accons.nbs
               AND AC.RYN = cd.RYN
               AND AC.EMI = CK.EMI
               AND K.ID = P_CP_ID
               AND A.ACC = CD.ACC;
      EXCEPTION WHEN NO_DATA_FOUND
                THEN --RAISE_APPLICATION_ERROR(-20203,'Немає договорів до виносу на прострочку', TRUE);
                     BARS_AUDIT.TRACE('%s Немає договорів до виносу на прострочку для кода ЦП = %s', TITLE, P_CP_ID); --RETURN;
                     P_RESULTTXT := NVL(P_RESULTTXT,'') || 'Немає договорів до виносу на прострочку для кода ЦП = '||TO_CHAR(P_CP_ID)|| chr(10) || chr(13);
                     raise_application_error(-20000, P_RESULTTXT);
                     P_RESULTCODE := 3;
                     RETURN;
      END;
    BARS_AUDIT.TRACE('%s Количество сделок = %s', TITLE, TO_CHAR(L_CP_DATA.COUNT));

    IF L_CP_DATA.COUNT = 0
    THEN
    BARS_AUDIT.TRACE('%s Немає активних договорів до виносу на прострочку для кода ЦП = %s', TITLE, P_CP_ID); --RETURN;
                     P_RESULTTXT := NVL(P_RESULTTXT,'') || 'Немає договорів до виносу на прострочку для кода ЦП = '||TO_CHAR(P_CP_ID)|| CHR(10) || CHR(13);
                     raise_application_error(-20000, P_RESULTTXT);
                     P_RESULTCODE := 3;
                     RETURN;
    END IF;

    FOR I IN 1..L_CP_DATA.COUNT
    LOOP
     BARS_AUDIT.TRACE('%s шаг %s, Ref = %s', TITLE, TO_CHAR(I), TO_CHAR(L_CP_DATA(I).REF));
     -- 1. Проверить наличие и валидность консолидированных счетов cp_accc
     if P_MODE = 0
     then
       CP_CHECK_EXPACC(L_CP_DATA(I).NLSEXPN,  L_CP_DATA(I).KV, L_ACCC_EXPN, L_BRANCH_N, L_GRP_N, L_SEC_N);
     else
       CP_CHECK_EXPACC(L_CP_DATA(I).NLSEXPR,  L_CP_DATA(I).KV, L_ACCC_EXPR, L_BRANCH_R, L_GRP_R, L_SEC_R);
     end if;

     L_REF_TAIL    := SUBSTR('000000000'|| L_CP_DATA(I).REF, -8);

      IF L_ACCC_EXPN = 0 AND L_MODE = 0 OR L_ACCC_EXPR = 0 AND L_MODE = 1
      THEN
        BARS_AUDIT.TRACE('%s Не знайдено консолідованих рахунків прострочки для ЦП=%s субпортфеля %s портфеля %s',
        TITLE, TO_CHAR(L_CP_DATA(I).ID), TO_CHAR(L_CP_DATA(I).RYN), TO_CHAR(L_CP_DATA(I).VIDD));
        P_RESULTTXT := NVL(P_RESULTTXT,'') || 'Не знайдено конс.рах. прострочки для ЦП='||TO_CHAR(L_CP_DATA(I).ID)||' субпортфеля '||TO_CHAR(L_CP_DATA(I).RYN)||' портфеля '||TO_CHAR(L_CP_DATA(I).VIDD)|| chr(10) || chr(13);
        raise_application_error(-20000, P_RESULTTXT);
        P_RESULTCODE := 4;
        RETURN;
        --RAISE_APPLICATION_ERROR(-20203,'Не знайдено консолідованих рахунків прострочки для ЦП='||TO_CHAR(L_CP_DATA(I).ID)||' субпортфеля '||TO_CHAR(L_CP_DATA(I).RYN)||' портфеля '||TO_CHAR(L_CP_DATA(I).VIDD), TRUE);
      ELSE
        -- 2. Открыть несистемные счета под сделки с кодом ЦП (из вх. параметра)
       if p_mode = 0
       then
            BEGIN
                SELECT CD.ACCEXPN, A.NLS, A.NMS
                  INTO L_CP_DATA(I).ACCEXPN_SUB, L_CP_DATA(I).NLSEXPN_SUB, L_CP_DATA(I).NMSEXPN_SUB
                  FROM CP_DEAL CD, ACCOUNTS A
                 WHERE CD.REF = L_CP_DATA(I).REF
                   AND A.ACC = CD.ACCEXPN;
            EXCEPTION WHEN NO_DATA_FOUND
            THEN
                L_CP_DATA(I).NLSEXPN_SUB   := SUBSTR(L_CP_DATA(I).NLSEXPN,  1,4)||'_2'||L_REF_TAIL;

                SELECT SUBSTR(L_CP_DATA(I).ID||'/'||NMS,1,38)
                  INTO L_CP_DATA(I).NMSEXPN_SUB
                  FROM ACCOUNTS
                 WHERE ACC = L_ACCC_EXPN;

                BARS_AUDIT.TRACE('%s Внесистемный счет просрочки номинала: %s, %s ,%s',
                TITLE, TO_CHAR(L_CP_DATA(I).NMSEXPN_SUB), TO_CHAR(L_ACCC_EXPN),TO_CHAR(L_CP_DATA(I).NLSEXPN_SUB));

                CP.CP_REG_EX(mod_  =>  99,
                             p1_   =>  0,
                             p2_   =>  0,
                             p3_   =>  GRP_,
                             p4_   =>  r1_,
                             rnk_  =>  L_CP_DATA(I).RNK,
                             nls_  =>  L_CP_DATA(I).NLSEXPN_SUB,
                             kv_   =>  L_CP_DATA(I).KV,
                             nms_  =>  L_CP_DATA(I).NMSEXPN_SUB,
                             tip_  =>  'ODB',
                             isp_  =>  L_USERID,
                             accR_ =>  L_CP_DATA(I).ACCEXPN_SUB);
                  begin
                    insert into cp_accounts(CP_ACC, CP_ACCTYPE, CP_REF)
                    values (L_CP_DATA(I).ACCEXPN_SUB,'EXPN',L_CP_DATA(I).CP_REF);
                  exception when dup_val_on_index then null;
                  end;

                 BARS_AUDIT.TRACE('%s Открыт счет, асс = %s',TITLE,L_CP_DATA (I).ACCEXPN_SUB);
                 BARS_AUDIT.TRACE('%s Пытаемся проапдейтить счет %s',TITLE,L_CP_DATA(I).NLSEXPN_SUB);

                UPDATE ACCOUNTS
                   SET ACCC = L_ACCC_EXPN,
                       SECI = 4,
                       POS = 1,
                       DAOS = L_BDATE,
                       PAP = 3,
                       SEC = L_SEC_N,
                       GRP = L_GRP_N,
                       BRANCH = L_BRANCH_N
                 WHERE ACC = L_CP_DATA (I).ACCEXPN_SUB;

                BARS_AUDIT.TRACE('%s Открыт/найден внесистемный счет просрочки номинала АСС =  %s, ref = %s, nls = %s',
                TITLE,TO_CHAR(L_CP_DATA(I).ACCEXPN_SUB),TO_CHAR(L_CP_DATA(I).REF),L_CP_DATA(I).NLSEXPN_SUB);

                UPDATE CP_DEAL
                   SET ACCEXPN   = L_CP_DATA(I).ACCEXPN_SUB
                 WHERE REF = L_CP_DATA(I).REF
                   AND ACCEXPN IS NULL;
            END;

       ELSE
            BEGIN
                SELECT CD.ACCEXPR, A.NLS, A.NMS
                  INTO L_CP_DATA(I).ACCEXPR_SUB, L_CP_DATA(I).NLSEXPR_SUB, L_CP_DATA(I).NMSEXPR_SUB
                  FROM CP_DEAL CD, ACCOUNTS A
                 WHERE CD.REF = L_CP_DATA(I).REF
                   AND A.ACC = CD.ACCEXPR;
            EXCEPTION WHEN NO_DATA_FOUND
            THEN
                    L_CP_DATA(I).NLSEXPR_SUB   := SUBSTR(L_CP_DATA(I).NLSEXPR,  1,4)||'_3'||L_REF_TAIL;

                    SELECT SUBSTR(L_CP_DATA(I).ID||'/'||NMS,1,38)
                      INTO L_CP_DATA(I).NMSEXPR_SUB
                      FROM ACCOUNTS
                     WHERE ACC = L_ACCC_EXPR;

                    BARS_AUDIT.TRACE('%s Внесистемный счет просрочки купона: %s, %s ,%s',
                    TITLE,TO_CHAR(L_CP_DATA(I).NMSEXPR_SUB),TO_CHAR(L_ACCC_EXPR),TO_CHAR(L_CP_DATA(I).NLSEXPR_SUB));

                    BARS_AUDIT.TRACE('%s Открываем/находим внесистемные счета для РНК %s, сделка %s , исполнитель %s',
                    TITLE,TO_CHAR(L_CP_DATA(I).RNK),TO_CHAR(L_CP_DATA(I).ID),TO_CHAR(L_USERID));
                    CP.CP_REG_EX(mod_  =>  99,
                                 p1_   =>  0,
                                 p2_   =>  0,
                                 p3_   =>  GRP_,
                                 p4_   =>  r1_,
                                 rnk_  =>  L_CP_DATA(I).RNK,
                                 nls_  =>  L_CP_DATA(I).NLSEXPR_SUB,
                                 kv_   =>  L_CP_DATA(I).KV,
                                 nms_  =>  L_CP_DATA(I).NMSEXPR_SUB,
                                 tip_  =>  'ODB',
                                 isp_  =>  L_USERID,
                                 accR_ =>  L_CP_DATA(I).ACCEXPR_SUB);
                  begin
                    insert into cp_accounts(CP_ACC, CP_ACCTYPE, CP_REF)
                    values (L_CP_DATA(I).ACCEXPR_SUB,'EXPR',L_CP_DATA(I).CP_REF);
                  exception when dup_val_on_index then null;
                  end;
                    UPDATE ACCOUNTS
                       SET ACCC = L_ACCC_EXPR,
                           SECI = 4,
                           POS = 1,
                           DAOS = L_BDATE,
                           PAP = 3,
                           SEC = L_SEC_R,
                           GRP = L_GRP_R
                     WHERE ACC = L_CP_DATA(I).ACCEXPR_SUB;

                   BARS_AUDIT.TRACE('%s Открыт/найден внесистемный счет просрочки купона АСС =  %s, ref = %s, nls = %s',
                    TITLE,TO_CHAR(L_CP_DATA(I).ACCEXPR_SUB),TO_CHAR(L_CP_DATA(I).REF),L_CP_DATA(I).NLSEXPR_SUB);

                   UPDATE CP_DEAL
                      SET ACCEXPR   = L_CP_DATA(I).ACCEXPR_SUB
                    WHERE REF = L_CP_DATA(I).REF
                      AND ACCEXPR is null;
            END;
       end if;
        BARS_AUDIT.TRACE('%s Заполняем АСС счетов в параметры сделки CP_DEAL. Старт.',TITLE);
     END IF;
      -- 3. Выполнить вставку документов переноса на просрочку
      CP_INIT_DOCREC(L_DOCREC);

      -- 3.1 Заполняем реквизиты будущего документа

      IF L_MODE = 0     -- ВЫНОС НА ПРОСРОЧКУ НОМИНАЛА
       THEN
          CP_GET_DOCACCS(L_CP_DATA(I).ACCEXPN_SUB, L_CP_DATA(I).ACC, NULL,L_CP_DATA(I).DNK, L_DOCREC);
      ELSIF L_MODE = 1 -- ВЫНОС НА ПРОСРОЧКУ КУПОНА
       THEN
          CP_GET_DOCACCS(L_CP_DATA(I).ACCEXPR_SUB, L_CP_DATA(I).ACCR, L_CP_DATA(I).ACCR2,L_CP_DATA(I).DNK, L_DOCREC);
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
      L_NAZN := REPLACE(L_NAZN, '*DATEXP*',  TO_CHAR(L_CP_DATA(I).EXPDATE,'dd/mm/yyyy'));
      L_DOCREC.NAZN := SUBSTR(L_NAZN,1,160);
      if L_DOCREC.Vob is null then
        L_DOCREC.Vob := case when L_DOCREC.kv =  980 then 6 else 16 end;
      end if;  
      L_EXP_REF := CP_MAKE_DOC(L_DOCREC);
      begin
        insert into cp_payments(CP_REF,OP_REF)
        values (L_CP_DATA(I).CP_REF,L_EXP_REF);
      exception when dup_val_on_index then null;
      end;

    END LOOP;
    BARS_AUDIT.TRACE('%s P_CP_EXPIRY.FINISH', TITLE);

    IF P_RESULTCODE = 0 THEN P_RESULTTXT := 'Вынос на просрочку проведен успешно'; END IF;
    BARS_AUDIT.TRACE('%s '||P_RESULTTXT||'P_RESULTCODE ='||TO_CHAR(P_RESULTCODE), TITLE);


END P_CP_EXPIRY;
/
show err;

PROMPT *** Create  grants  P_CP_EXPIRY ***
grant EXECUTE                                                                on P_CP_EXPIRY     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CP_EXPIRY.sql =========*** End *
PROMPT ===================================================================================== 
