
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/bpk_get_product_sea.sql =========**
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.BPK_GET_PRODUCT_SEA (p_code IN VARCHAR2)
   RETURN VARCHAR2
IS
   v_code   VARCHAR2 (32);
   n        PLS_INTEGER;
BEGIN
   SELECT DISTINCT
          CASE
             WHEN CARD_CODE LIKE 'STND_SEA%' THEN 'ECONOM'
             ELSE UPPER (grp)
          END
    INTO v_code
     FROM (SELECT DECODE (SUBSTR (f.code, 1, 3),
                          'OBU', grp_code || 'S',
                          grp_code)
                     grp,
                  B.CARD_CODE
             FROM W4_acc b, w4_card c, w4_product f
            WHERE     C.CODE = B.CARD_CODE
                  AND c.product_code = f.code
                  AND B.ACC_PK = p_code);

   IF n > 0
   THEN
      v_code := RTRIM (SUBSTR (p_code, 1, n - 1), '_');
   END IF;

   RETURN v_code;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/bpk_get_product_sea.sql =========**
 PROMPT ===================================================================================== 
 