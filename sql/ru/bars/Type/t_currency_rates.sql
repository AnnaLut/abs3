begin
  execute immediate 
'CREATE OR REPLACE TYPE t_currency_rates
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
 OFFICIALNEXT                              NUMBER(9,4))';
exception
  when others then if (sqlcode = -2303) then null; else raise; end if;
end;
/
 
 