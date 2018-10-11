

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_cp_pay_dividents_certif.sql ===*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view v_cp_pay_dividents_certif ***

  CREATE OR REPLACE VIEW BARS.v_cp_pay_dividents_certif ("ID","TXT") AS 
  SELECT 1 ID, 'довідка надана' TXT
     FROM dual
  union
  SELECT 0 ID, 'довідка не надана' TXT
     FROM dual;

COMMENT ON TABLE BARS.v_cp_pay_dividents_certif IS 'Довідник надання довідки при виплаті дивідентів по ЦП';
/


PROMPT *** Create  grants  v_cp_pay_dividents_certif ***
grant SELECT                                                                 on v_cp_pay_dividents_certif       to BARSREADER_ROLE;
grant SELECT                                                          on v_cp_pay_dividents_certif       to BARS_ACCESS_DEFROLE;
grant SELECT                                                          on v_cp_pay_dividents_certif       to CP_ROLE;
grant SELECT                                                                 on v_cp_pay_dividents_certif       to START1;
grant SELECT                                                                 on v_cp_pay_dividents_certif       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_cp_pay_dividents_certif.sql =========*** End *** ====
PROMPT ===================================================================================== 
