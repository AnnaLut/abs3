
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_currency_rates.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_CURRENCY_RATES 
as object
( CURRENCYID                               NUMBER(3),
 CURRENCYCODE                              CHAR(3),
 CURRENCYNAME                              VARCHAR2(35),
 BASECURRENCYID                            NUMBER,
 BASECURRENCYCODE                          CHAR(3),
 "Date"                                      DATE,
 "Size"                                      NUMBER(9,4),
 BUY                                       NUMBER(9,4),
 SALE                                      NUMBER(9,4),
 OFFICIAL                                  NUMBER(9,4),
 BUYPREV                                   NUMBER(9,4),
 SALEPREV                                  NUMBER(9,4),
 OFFICIALPREV                              NUMBER(9,4),
 BUYNEXT                                   NUMBER(9,4),
 SALENEXT                                  NUMBER(9,4),
 OFFICIALNEXT                              NUMBER(9,4))
/

 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_currency_rates.sql =========*** End *
 PROMPT ===================================================================================== 
 