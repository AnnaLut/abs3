
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_tarif_zd.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_TARIF_ZD 
                 (ref_ NUMERIC,   -- референс
                  kod_ INTEGER,   -- код тарифа для f_tarif
                  kv_  INTEGER,   -- валюта операции
                  nls_ VARCHAR2,  -- бух.номер счета
                  s_   NUMERIC)   -- сумма операции
RETURN NUMERIC IS
  rnk_  NUMERIC;  -- регистрационный номер
  num_  NUMERIC;  -- к-во элементов для комиссии
  tar_  NUMERIC;  -- тариф за перечисление элемента зарплаты
  sk_   NUMERIC;  -- сумма комиссии
BEGIN
   BEGIN
      -- поиск rnk
      SELECT to_number(value)
      INTO   rnk_
      FROM   operw
      WHERE  ref=ref_ and tag='RNK  ';
   EXCEPTION WHEN NO_DATA_FOUND THEN
      rnk_ := -1;
   END;

   if rnk_>0 then
      BEGIN
         SELECT to_number(value)
         INTO   num_
         FROM   operw
         WHERE  ref=ref_ and tag='ZDNUM';
      EXCEPTION WHEN NO_DATA_FOUND THEN
         num_ := -1;
      END;
      if num_<=0 then
         sk_ := f_tarif(kod_,kv_,nls_,s_);
      else
         BEGIN
            SELECT to_number(value)
            INTO   tar_
            FROM   customerw
            WHERE  rnk=rnk_ and tag='KOMZD';
         EXCEPTION WHEN OTHERS THEN
            tar_ := -1;
         END;
         if tar_<=0 then
            sk_ := f_tarif(kod_,kv_,nls_,s_);
         else
            sk_ := tar_*num_;
         end if;
      end if;
   else
      sk_ := f_tarif(kod_,kv_,nls_,s_);
   end if;

   RETURN sk_;
END f_tarif_zd ;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_tarif_zd.sql =========*** End ***
 PROMPT ===================================================================================== 
 