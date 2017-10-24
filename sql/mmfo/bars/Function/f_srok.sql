
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_srok.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_SROK (datb_ IN DATE, date_ IN DATE, type_ in number) RETURN VARCHAR2 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :   Функция расчета срока (начального или до погашения)
% COPYRIGHT   :   Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :   15.05.2009 (19.09.2008, 19.02.2007)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры:
		datb_ - дата начала отсчета (дата начала договора или отчетная дата)
		datb_ - дата окончания договора
		type_ - тип расчета
			  1 - коды сроков от 1 до 9
			  2 - расширенный диапазон сроков (от 1 до Н без 8 и 9)
--------------------------------
15.05.2009 - для определения высокосного года изменен алгоритм
19.09.2008 - для кода "C" добавлено условие равно, а было только < 548
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   kod_     VARCHAR2 (1);
   delta_   NUMBER;
   god_     NUMBER;
   god1_    NUMBER;
   god2_    NUMBER;
   year_    NUMBER;
   add_		number:=0;
BEGIN
  if date_ is null or datb_ is null then
  	 return null;
  end if;

  delta_ := date_ - datb_;

  IF type_ = 1 THEN
      god1_ := MOD (TO_NUMBER (TO_CHAR (datb_, 'YYYY')), 4);
      god2_ := MOD (TO_NUMBER (TO_CHAR (date_, 'YYYY')), 4);

      IF (delta_ <= 0)
      THEN
         kod_ := '1';
      ELSIF (delta_ = 1)
      THEN
         kod_ := '2';
      ELSIF (delta_ < 8)
      THEN
         kod_ := '3';
      ELSIF (delta_ < 22)
      THEN
         kod_ := '4';
      ELSIF (delta_ < 32)
      THEN
         kod_ := '5';
      ELSIF (delta_ < 93)
      THEN
         kod_ := '6';
      ELSIF (delta_ < 184)
      THEN
         kod_ := '7';
      ELSIF (delta_ < 366 AND god1_ <> 0 AND god2_ <> 0)
         OR (delta_ < 366 AND god2_ <> 0 AND god1_ = 0 and
             datb_ > TO_DATE ('2902' || TO_CHAR (datb_, 'yyyy'),'ddmmyyyy'))
         OR (delta_ <= 366 AND god2_ <> 0 AND god1_ = 0 and
             datb_ <= TO_DATE ('2902' || TO_CHAR (datb_, 'yyyy'),'ddmmyyyy'))
         OR (delta_ < 366 AND god1_ <> 0 AND god2_ = 0 and
             date_ < TO_DATE ('2902' || TO_CHAR (date_, 'yyyy'),'ddmmyyyy'))
         OR (delta_ <= 366 AND god1_ <> 0 AND god2_ = 0 and
             date_ >= TO_DATE ('2902' || TO_CHAR (date_, 'yyyy'),'ddmmyyyy'))
      THEN
         kod_ := '8';
      ELSIF delta_ IS NOT NULL
      THEN
         kod_ := '9';
      ELSE
         kod_ := '0';
      END IF;
  elsif type_ = 2 then
      year_ := MONTHS_BETWEEN(date_, datb_)/12;

      IF year_ >= 1 THEN -- может быть 1 и больше высокосных годов
         god1_ := TO_NUMBER(TO_CHAR(datb_, 'yyyy'));
         god2_ := TO_NUMBER(TO_CHAR(date_, 'yyyy'));

         FOR i IN god1_..god2_ LOOP
            if substr(to_char(i),3,2) = '00' then
                god_ := MOD(i, 400);
            else
                god_ := MOD(i, 4);
            end if;

            IF (god_ = 0 and i <> god1_ and i <> god2_) OR
               (god_ = 0 AND (
               (i = god1_ AND datb_ < TO_DATE('2902'||TO_CHAR(i), 'ddmmyyyy')) OR
               (i = god2_ AND date_ >= TO_DATE('2902'||TO_CHAR(i), 'ddmmyyyy')))) THEN
               add_ := add_ + 1;
            END IF;
         END LOOP;
      END IF;

      IF (delta_ <= 0) THEN
         kod_ := '1';
      ELSIF (delta_ = 1) THEN
         kod_ := '2';
      ELSIF (delta_ < 8) THEN
         kod_ := '3';
      ELSIF (delta_ < 22) THEN
         kod_ := '4';
      ELSIF (delta_ < 32) THEN
         kod_ := '5';
      ELSIF (delta_ < 93) THEN
         kod_ := '6';
      ELSIF (delta_ < 184) THEN
         kod_ := '7';
      ELSIF (delta_ < 275) THEN
         kod_ := 'A';
      ELSIF delta_ < 366 + add_ THEN
         kod_ := 'B';
      ELSIF delta_ <= 548  + add_ THEN
         kod_ := 'C';
      ELSIF year_ <= 2 THEN
         kod_ := 'D';
      ELSIF year_ <= 3 THEN
         kod_ := 'E';
      ELSIF year_ <= 5 THEN
         kod_ := 'F';
      ELSIF year_ <= 10 THEN
         kod_ := 'G';
      ELSIF delta_ IS NOT NULL THEN
         kod_ := 'H';
      ELSE
      ------ ???? СЮДА НЕ ЗАЙДЕТ НИКОГДА !!!!!!!!!!!!!!!!!!!!
         NULL;
      END IF;
   else
   	   kod_ := '0';
   END IF;

   return kod_;
END;
/
 show err;
 
PROMPT *** Create  grants  F_SROK ***
grant EXECUTE                                                                on F_SROK          to BARS009;
grant EXECUTE                                                                on F_SROK          to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_srok.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 