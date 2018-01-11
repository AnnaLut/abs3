
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/tp_240.sql =========*** Run *** =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.TP_240 AS OBJECT
(
  S240  VARCHAR2(1),
  OST   VARCHAR2(255),
  S242  VARCHAR2(1),
  ldate DATE,
  nd    number,
  comm  VARCHAR2(255)
);
/

 show err;
 
PROMPT *** Create  grants  TP_240 ***
grant EXECUTE                                                                on TP_240          to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/tp_240.sql =========*** End *** =======
 PROMPT ===================================================================================== 
 