CREATE OR REPLACE FUNCTION BARS.Rkapital_f42 (dat_ in DATE,
                                              kodf_ in VARCHAR2 DEFAULT NULL,
                                              userid_  in NUMBER DEFAULT NULL,
                                              type_  in NUMBER DEFAULT 3,  
                                              -- =1 - PK1 -- =2 - PK2, =3 - РК
                                              sumk_rk out Number,
                                              sumk_H9 out Number
                                             ) RETURN NUMBER IS
---------------------------------------------------------------------------
--- Функція розрахунку регулятивного капіталу і суми для Н9  ---
--- з врахуванням зміни версій	   	                    ---
---------------------------------------------------------------------------
----- 			  Версія від 28.03.2019                       -----
---------------------------------------------------------------------------
   fmt_       VARCHAR2(30):='999G999G999G990D99';

   PROCEDURE p_ins(p_kod_ VARCHAR2, p_val_ NUMBER) IS
        pragma     AUTONOMOUS_TRANSACTION;
   BEGIN
       IF kodf_ IS NOT NULL AND userid_ IS NOT NULL THEN
           INSERT INTO OTCN_LOG (kodf, userid, txt)
           VALUES(kodf_,userid_,p_kod_||TO_CHAR(p_val_/100, fmt_));
           commit;
       END IF;
   END;
BEGIN
   p_ins('Дата для регулятивного капіталу і суми для Н9: '||TO_CHAR(dat_,'dd.mm.yyyy'), NULL);

   SELECT nvl(a.sumrk, 0), nvl(a.sum_H9, 0)
   into sumk_rk, sumk_H9
   FROM REGCAPITAL a 
   WHERE a.fdat = (select max(fdat) 
                   from REGCAPITAL 
                   where fdat <= Dat_ and
                         nvl(a.sumrk, 0) <> 0);

   if sumk_H9 = 0 
   then
      sumk_H9 := sumk_rk;
   end if;

   p_ins('Регулятивний капітал (із REGCAPITAL): ', sumk_rk);
   p_ins('Сума для Н9 - (ОК+ДК-В1) (із REGCAPITAL): ', sumk_H9);

   RETURN 0;
END Rkapital_f42;
/
