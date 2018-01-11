
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_penaltyrec.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_PENALTYREC AS OBJECT
                  (deposit_id NUMBER,
                   n_int NUMBER,
                   n_tax NUMBER,
                   n_tax_mil NUMBER,
                   sh_int NUMBER,
                   sh_tax NUMBER,
                   sh_tax_mil NUMBER);
/

 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_penaltyrec.sql =========*** End *** =
 PROMPT ===================================================================================== 
 