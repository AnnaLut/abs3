
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/convert_swift_amount.sql =========*
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CONVERT_SWIFT_AMOUNT 
                   ( str_amount      IN   VARCHAR2    -- Original SWIFT field
                   , n_dig           IN   NUMBER      -- Fraction digits
                   , c_dk            IN   CHAR        -- Debit/Credit flag
                   )
RETURN NUMBER
IS
      l_amount    VARCHAR2(40);
BEGIN
    IF c_dk = 'C' THEN
        l_amount := str_amount;
    ELSE
        l_amount := '-'|| str_amount;
    END IF;
    RETURN TO_NUMBER( l_amount
                    , '9999999999999D999'
                    , ' NLS_NUMERIC_CHARACTERS = '',.''')
           *POWER(10, n_dig);
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/convert_swift_amount.sql =========*
 PROMPT ===================================================================================== 
 