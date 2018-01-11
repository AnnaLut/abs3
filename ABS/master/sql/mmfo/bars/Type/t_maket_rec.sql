
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_maket_rec.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_MAKET_REC as object
(
     cps         varchar2(10), -- оригинальное поле cps
     cps_decoded varchar2(100), -- декодированно поле cps
     term_id     varchar2(10),
     br3         varchar2(100), -- оригинальный код отделения
     br3_decoded varchar2(30), -- декодированный код отделения
     tran_amt    number,
     tran_cnt    number(10),
     tot_amt     number,
     fee_amt_i   number,
     fee_amt_a   number,
     fee_amt     number
);
/

 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_maket_rec.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 