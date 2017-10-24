
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fs_180_242.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FS_180_242 (nbs_ in varchar2,
                                       acc_  in number,
                                       dat_ in date,
                                       mdate_ in date,
                                       sdate_ in date,
                                       s181_ out varchar2,
                                       s242_  out varchar2,
                                       fdatb_ in date default null,
                                       fdate_ in date default null
                                       ) RETURN number Is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :   ‘-€ расчета кодов срока (s180) или срока до погашени€ (s240)
% 			  :   по счетам, полученным извне
% COPYRIGHT   :   Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :   01/08/2014 (23/07/2014)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: acc_ - идентификатор счета
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
	zm_date_  DATE:=TO_DATE('01072006', 'ddmmyyyy'); -- дата изменени€ классификатора †
    zm_date2_ DATE:=TO_DATE('30092013', 'ddmmyyyy'); -- дата изменени€ классификатора
	s180_	  varchar2(1):='0';
	s240_	  varchar2(1);
	tp_		  number;
begin
   s181_ := '0';
   s242_ := '0';

   if mdate_ is null then
	  return 0;
   elsif acc_=-1 and nbs_='2635' and (mdate_-sdate_) in (365,366) THEN
      s181_:='2';
   END IF;

   if s181_ = '0' then
	   -- параметр s181 ("—рочность")
	   tp_ :=(case when dat_ < to_date('01022007', 'ddmmyyyy') then 1 else 2 end);

	   s180_ := nvl(f_srok(sdate_, mdate_, tp_), '0');

	 	  -- значени€ по умолчанию
	   IF s180_ = '0' THEN
	      s180_ := Fs180_DEF (nbs_, tp_);
	   END IF;

	   IF s180_ <>'0' THEN
	   	  s181_ := fs181(null, dat_, s180_);
	   ELSE
	      s181_:='0';
	   END IF;
   end if;

   -- параметр s240 или s242 (" од строка до погашени€" или "ќбобщенный код строка до погашени€")
   tp_ :=(case when dat_ < TO_DATE('01072006', 'ddmmyyyy') then 1 else 2 end);

   if dat_>= zm_date2_ and mdate_ < dat_ then
      if fdatb_ is not null and fdate_ is not null then
         if mdate_ between fdatb_ and fdate_  then
            s242_ := '1';
         else
            s242_ := 'Z';
         end if;
      else
         s242_ := 'Z';
      end if;

      RETURN 0;
   end if;

   s240_ := NVL(f_srok(dat_, mdate_, tp_), '0');

   -- значени€ по умолчанию
   IF s240_ = '0' THEN
      s240_ := Fs240_DEF (nbs_, tp_);
   END IF;

   IF dat_ < zm_date_ THEN
      s242_:=fs242(null, null, s240_);
   ELSE
      s242_:=s240_;
   END IF;

   return 0;
end FS_180_242;
/
 show err;
 
PROMPT *** Create  grants  FS_180_242 ***
grant EXECUTE                                                                on FS_180_242      to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fs_180_242.sql =========*** End ***
 PROMPT ===================================================================================== 
 