
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/is_pensioner.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.IS_PENSIONER (P_RNK NUMBER)
   RETURN INT
IS
   /*
    version 2.0 12/11/2015
    Inga 30/03/2015 функция проверяет по РНК, является ли клиент пенсионером по справочнику dpt_dict_pension
   */
   L_RESULT   INTEGER := 0;
BEGIN
   BEGIN
      SELECT 1
        INTO L_RESULT
        FROM PERSON P, DPT_DICT_PENSION DP
       WHERE P.RNK = P_RNK AND P.SEX = DP.SEX
             AND (MONTHS_BETWEEN(to_date(to_char(gl.bd, 'yyyymmdd'), 'yyyymmdd'), to_date(to_char(BDAY, 'yyyymmdd'), 'yyyymmdd'))/12 >= DP.AGE
                  OR P.SEX = 2
                     AND (to_char(BDAY, 'yyyymmdd') BETWEEN to_char(DP.BDATE_START, 'yyyymmdd') AND to_char(DP.BDATE_END, 'yyyymmdd')));
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN L_RESULT := 0;
      WHEN TOO_MANY_ROWS
      THEN L_RESULT := 1;
   END;
   bars_audit.info('IS_PENSIONER, res = ' || to_char(L_RESULT)|| ', P_RNK = ' ||to_char(P_RNK));
   RETURN L_RESULT;
END;
/
 show err;
 
PROMPT *** Create  grants  IS_PENSIONER ***
grant EXECUTE                                                                on IS_PENSIONER    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on IS_PENSIONER    to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/is_pensioner.sql =========*** End *
 PROMPT ===================================================================================== 
 