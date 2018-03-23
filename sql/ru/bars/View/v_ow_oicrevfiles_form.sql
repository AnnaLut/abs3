

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_OICREVFILES_FORM.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_OICREVFILES_FORM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_OICREVFILES_FORM ("DOC_DATA", "BILL_AMOUNT", "ERR_TEXT") AS 
  select t.doc_data, o.s / 100 bill_amount, t.rev_message err_text
  from ow_locpay_match t
  join oper o on t.ref = o.ref 
       and t.revflag in(1, 2) 
       and (t.state = 0 or (t.state=10 and t.revfile_name is null))
       and o.pdat >= trunc(sysdate) - 10;

PROMPT *** Create  grants  V_OW_OICREVFILES_FORM ***
grant INSERT,SELECT,UPDATE                                                   on V_OW_OICREVFILES_FORM to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_OICREVFILES_FORM.sql =========*** 
PROMPT ===================================================================================== 
