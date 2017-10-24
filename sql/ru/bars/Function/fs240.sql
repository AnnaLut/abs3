
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fs240.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FS240 (odat_ IN DATE, acc_ IN NUMBER,
    fdatb_ in date default null, fdate_ in date default null,
    p_mdate_ in date default null,
    p_s240_ in varchar2 default null) RETURN VARCHAR2
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :  Функция расчета кодов сроков до погашения
% COPYRIGHT   :  Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :  16/10/2015 (12/05/2015)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: odat_ - отчетная дата
               acc_ - идентификатор счета
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
23/09/2013 з 01/10/2013 вводиться код строку Z - строк погашення минув
25.10.2007 для бал.счетов не равных 1510,1521,1610,1621 и значении параметра
           S240='2' устанавливаем значение S240='1'.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
IS
   kod_      VARCHAR2 (2);
   nbs_      VARCHAR2 (4);
   mdate_    DATE;
   zm_date_  DATE:=TO_DATE('01072006', 'ddmmyyyy'); -- дата изменения классификатора
   zm_date2_ DATE:=TO_DATE('30092013', 'ddmmyyyy'); -- дата изменения классификатора
   tp_		 number:=(case when odat_ < zm_date_ then 1 else 2 end);
BEGIN
   SELECT nbs, a.mdate
     INTO nbs_, mdate_
     FROM ACCOUNTS a
    WHERE a.acc = acc_;

   if p_mdate_ is not null then
      mdate_ := p_mdate_;
   end if;

   IF mdate_ IS NULL THEN
      if trim(p_s240_) is null then
          BEGIN
             SELECT NVL(Trim(S240),'0')
             INTO kod_
             FROM specparam
             WHERE acc=acc_;
          EXCEPTION WHEN NO_DATA_FOUND THEN
             kod_:='0';
          END;
      else
          kod_ := nvl(trim(p_s240_), '0');
      end if;

      IF kod_='0' AND nbs_ in ('1600','1819','2600','2601','2603','2604','2605',
                               '2620','2625','2628','2650','2655','2900','2901',
                               '2902','2903','2905','2909') THEN
         kod_ := '1';
      END IF;

      IF kod_='0' AND nbs_ in ('4400','4409','4430','4431','4500','4509','4530') THEN
         kod_ := 'C';
      END IF;

      RETURN kod_;
   END IF;

   if odat_>= zm_date2_ and mdate_ < odat_ then
      if fdatb_ is not null and fdate_ is not null then
         if mdate_ between fdatb_ and fdate_  then
            kod_ := '1';
         else
      kod_ := 'Z';
         end if;
      else
         kod_ := 'Z';
      end if;

      RETURN kod_;
   end if;

   kod_ := f_srok(odat_, mdate_, tp_);

   if nbs_ not in ('1510','1521','1610','1621') and kod_ = '2' then
      kod_ := '1';
   end if;

   RETURN kod_;
END Fs240;
/
 show err;
 
PROMPT *** Create  grants  FS240 ***
grant EXECUTE                                                                on FS240           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FS240           to RPBN001;
grant EXECUTE                                                                on FS240           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fs240.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 