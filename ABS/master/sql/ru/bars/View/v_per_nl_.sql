
/* Formatted on 2011/06/06 18:31 (Formatter Plus v4.8.8) */
CREATE OR REPLACE FORCE VIEW bars.v_per_nl_ (REF,
                                             nlsa,
                                             s,
                                             datd,
                                             nazno,
                                             bproc,
											 aproc, 
											 ACC,
											 KVA,
											 TIP
                                            )
AS
   SELECT   REF,
            nlsa, 
            s / 100 s, 
            datd, 
            nazno,
            utl_url.escape(url=> 'BEGIN NULL; END;@NLK_REF_WEB('|| REF|| ',:REF,'||acc||',1);', url_charset=>'AL32UTF8') bproc,
            utl_url.escape(url=> 'BEGIN NULL; END;@NLK_REF_WEB('|| REF|| ',:REF,'||acc||',2);', url_charset=>'AL32UTF8') APROC,
            ACC,
            KVA,
            TIP
       FROM (SELECT a.nls nlsa, 
                    a.kv kva,
                    (SELECT datd FROM oper WHERE REF = o.REF) datd, 
                    o.s s, 
                    (SELECT nazn FROM oper WHERE REF = o.REF) nazno, 
                    o.REF, 
                    n.acc,
                    a.tip
               FROM opldok o, 
                   (select * from nlk_ref nn where REF2 IS NULL 
                     or exists (select 1 from oper where ref = nn.REF2 and sos < 0) 
                                                      )  n,                   
                    v_gl a
              WHERE a.acc = o.acc
                AND a.tip  like 'NL_'
                AND n.REF1 = o.REF  --AND n.REF2 is null   
                AND n.acc = a.acc and a.dazs is null
                AND o.sos = 5
                AND o.dk = 1)
   ORDER BY ref desc
  ;


GRANT SELECT, DELETE, FLASHBACK ON BARS.V_PER_NL_ TO BARS_ACCESS_DEFROLE;

GRANT SELECT, DELETE, FLASHBACK ON BARS.V_PER_NL_ TO START1;

GRANT SELECT ON BARS.V_PER_NL_ TO RCC_DEAL;

GRANT DELETE, INSERT, SELECT, UPDATE, FLASHBACK ON BARS.V_PER_NL_ TO WR_ALL_RIGHTS;

GRANT SELECT, FLASHBACK ON BARS.V_PER_NL_ TO WR_REFREAD;



CREATE OR REPLACE TRIGGER BARS.tsu_V_PER_NL_
INSTEAD OF DELETE ON BARS.V_PER_NL_ FOR EACH ROW
DECLARE
  sos_ NUMBER;
BEGIN
delete nlk_ref nn WHERE ref1=:OLD.ref AND (ref2 is null or exists (select 1 from oper where ref = nn.REF2 and sos < 0)) and acc = :OLD.acc;
    IF SQL%ROWCOUNT=0 THEN
      raise_application_error(-(20000+999),'Увага!!! Документ вже був оплачений, обновіть екрану форму ',TRUE);
	  else
	  bars_audit.info(' Вилучено документ з картотеки  - ref: '||:OLD.ref );
   END IF;
   
END;
/
