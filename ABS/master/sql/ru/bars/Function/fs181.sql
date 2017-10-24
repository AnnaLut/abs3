
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fs181.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FS181 (acc_ IN NUMBER,
                                  odat_ in date default null,
                                  ps180_ in varchar2 default null,
                                  bdat_ in date default null) RETURN VARCHAR2 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :   ‘ункци€ расчета параметра "—рочность"
% COPYRIGHT   :   Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :   06.10.2010 (01.02.2007)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: acc_ - идентификатор счета
			   odat_ - отчетна€ дата
               bdat_ - дата начала договора, кот. отличаетс€ от даты первого
                    движени€ или даты открыти€ счета (например, дл€ депозитов)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   kod0_     Varchar2(1):='0';
   kod_     Varchar2(1):='0';
   kod2_     Varchar2(1):='0';
   s180_    Varchar2(1):=nvl(ps180_, '0');
BEGIN
   if s180_ = '0' then
	   BEGIN
	      SELECT NVL(S181,'0'), NVL(S180,'0')
		  INTO kod0_, kod2_
	      FROM specparam
		  WHERE acc = acc_;
	   EXCEPTION WHEN NO_DATA_FOUND THEN
	      null;
	   END;

--	   IF kod_='0' THEN
	   	  if kod2_ = '0' then
      	 	 s180_ := nvl(FS180(acc_, '1', odat_, bdat_), '0'); -- "1" - на вс€кий случай - вдруг это межбанк
		  else
		  	 s180_ := kod2_;
		  end if;
--	   end if;
   end if;

--   IF kod_='0' THEN
      IF s180_ <> '0' THEN
		   BEGIN
		      SELECT NVL (s181, '0')
		        INTO kod_
		        FROM kl_s180
		       WHERE s180 = s180_;
		   EXCEPTION
		      WHEN NO_DATA_FOUND THEN
		         kod_ := '0';
		   END;
	   else -- если не смогли определить по s180, то берем то, что стоит в specparam дл€ s181
	   	   kod_ := kod0_;
   	   END IF;
--   end if;

   RETURN kod_;

END FS181;
/
 show err;
 
PROMPT *** Create  grants  FS181 ***
grant EXECUTE                                                                on FS181           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fs181.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 