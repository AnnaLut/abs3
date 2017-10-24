
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_op_rules.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_OP_RULES (
  TT_       VARCHAR2,
  OP_FIELD_ VARCHAR2,
  KVA_      NUMBER,
  KVB_      NUMBER,
  NLSA_     VARCHAR2,
  NLSB_     VARCHAR2
  )
RETURN VARCHAR2 IS RESULT_  VARCHAR2(200) ;
-- функция возвращает нужное значение реквизита в операциях ввода
--
-- Макаренко И.В. 09/2009 --
--
  nmkv_     VARCHAR2(70);
  ref_      NUMBER;
  userid_   NUMBER;
BEGIN

  CASE

    WHEN TT_ IN ('PKR','PKK') THEN
      CASE
        WHEN OP_FIELD_ = 'CDAC' THEN
          BEGIN
            SELECT NVL(o.card_acct,'-')
              INTO RESULT_
              FROM obpc_acct o, tabval t
             WHERE t.kv = KVB_
               AND o.currency = t.lcv
               AND o.lacct = decode(TT_,'PKK',NLSA_,
                                        'PKR',NLSB_);
--               AND o.status = '0'                          ;
          EXCEPTION WHEN NO_DATA_FOUND THEN
            RESULT_ := ' - ' ;
          END;
        WHEN OP_FIELD_ = 'FIO' THEN
          BEGIN
            SELECT NVL(c.nmk,'-')
              INTO RESULT_
              FROM customer c, accounts a
             WHERE a.rnk = c.rnk
               AND a.nls = NLSA_
               AND a.kv  = KVA_;
          EXCEPTION WHEN NO_DATA_FOUND THEN
            RESULT_ := ' - ' ;
          END;
      END CASE;

    WHEN TT_ IN ('CH1') THEN
      BEGIN
        IF OP_FIELD_ = 'OTRIM' THEN
          BEGIN
            SELECT userid INTO userid_ FROM oper WHERE ref=KVA_;
            BEGIN
              SELECT NVL( trim(fio),' - ')
                INTO RESULT_ FROM ch_userlist WHERE id=userid_;
            EXCEPTION WHEN NO_DATA_FOUND THEN
              RESULT_ := ' - ' ;
            END;
          END;
        END IF;
        IF OP_FIELD_ = 'PASPN' THEN
          BEGIN
            SELECT userid INTO userid_ FROM oper WHERE ref=KVA_;
            BEGIN
              SELECT NVL( trim(doc_pers),' - ')
                INTO RESULT_ FROM ch_userlist WHERE id=userid_;
            EXCEPTION WHEN NO_DATA_FOUND THEN
              RESULT_ := ' - ' ;
            END;
          END;
        END IF;
        IF OP_FIELD_ = 'CHFIO' THEN
          BEGIN
            SELECT userid INTO userid_ FROM oper WHERE ref=KVA_;
            BEGIN
              SELECT NVL( trim(fio),' - ')
                INTO RESULT_ FROM ch_userlist WHERE id=userid_;
            EXCEPTION WHEN NO_DATA_FOUND THEN
              RESULT_ := ' - ' ;
            END;
            IF RESULT_ <> ' - ' THEN
              RESULT_ := 'через ' || RESULT_;
            END IF;
          END;
        END IF;
      END;

  END CASE;

  RETURN TRIM(RESULT_);
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_op_rules.sql =========*** End ***
 PROMPT ===================================================================================== 
 