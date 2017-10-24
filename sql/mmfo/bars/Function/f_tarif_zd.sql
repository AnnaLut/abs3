
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_tarif_zd.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_TARIF_ZD 
                 (ref_ NUMERIC,   -- ��������
                  kod_ INTEGER,   -- ��� ������ ��� f_tarif
                  kv_  INTEGER,   -- ������ ��������
                  nls_ VARCHAR2,  -- ���.����� �����
                  s_   NUMERIC)   -- ����� ��������
RETURN NUMERIC IS
  rnk_  NUMERIC;  -- ��������������� �����
  num_  NUMERIC;  -- �-�� ��������� ��� ��������
  tar_  NUMERIC;  -- ����� �� ������������ �������� ��������
  sk_   NUMERIC;  -- ����� ��������
BEGIN
   BEGIN
      -- ����� rnk
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
 