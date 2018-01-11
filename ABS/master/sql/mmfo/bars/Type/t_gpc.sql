
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_gpc.sql =========*** Run *** ========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_GPC as object (platej_data           date,
                             sum_platej            number,
                             pogash_telo_credit    number,
                             protent_credit        number,
                             ostatok_tela          number);
/

 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_gpc.sql =========*** End *** ========
 PROMPT ===================================================================================== 
 