
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fs180.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FS180 (acc_ IN NUMBER,
  		   		  klass_ IN NUMBER default null,
				  odat_ in date default null,
                  bdat_ in date default null,
                  oz_kor_ in number default 0)
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :   ������� ������� ���� �����
% COPYRIGHT   :   Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :   16/08/2017 (15/02/2012)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ���������: acc_    - ������������� �����
               klass_  - ��� ��������� �������� ��-��������� - 0
                         ��� �������� - 1
                         ��� ��������� - NULL
               odat_   - �������� ����
               bdat_   - ���� ������ ��������, ���. ���������� �� ���� �������
                         �������� ��� ���� �������� ����� (��������, ��� ���������)
               oz_kor_ - ������, �� ����� �� ����� ���������� ������. ��� ������
                         (0 - �� ����� (��� ���. ������, � 1 - ����� (��� �������))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
15.02.2012 - ���� ���. odat_=null �� odat_=glb_bankdate ( ���� bankdate )
25.03.2011 - ������ ����� �������� oz_kor_
13.03.2010 - ��� ���.����� 2630 �������� ��� ����� �� "B" ���� �� "C","D" ...
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   RETURN VARCHAR2
IS
   kod_     VARCHAR2 (1);
   mdate_   DATE;
   dapp_    DATE;
   daos_    DATE;
   nbs_     VARCHAR2 (4);
   zm_date_ DATE:=TO_DATE('01022007', 'ddmmyyyy'); -- ���� ��������� ��������������
   dat_ 	  date:=nvl(odat_, glb_bankdate);
   klassR_	number:=klass_;
   tp_		  number:=(case when dat_ < zm_date_ then 1 else 2 end);

BEGIN
   if klassR_ = 1 then
   -- klassR_ = 1 - �������
      begin
--         SELECT a.wdate, a.sdate, substr(nls, 1, 4) nbs
--            INTO mdate_, dapp_, nbs_
--         FROM mbd_k a
--         WHERE a.acc=acc_
--           and dat_ between a.sdate and a.wdate;
           
        select d.wdate wdate, ad.wdate sdate, substr(a.nls, 1, 4)
            INTO mdate_, dapp_, nbs_
        from  cc_deal d,
              cc_add ad,
              cc_vidd v,
              accounts a
        where a.acc=acc_
          AND d.nd = ad.nd
          AND d.vidd = v.vidd
          AND v.custtype = 1
          AND LENGTH (v.vidd) = 4
          AND ad.accs = a.acc
          and dat_ between ad.wdate and d.wdate ;          

         kod_ := '0';
      exception
   		when no_data_found then
         klassR_ := null;
      end;
   end if;

   if klassR_ is null or klassR_ not in ('0','1') then
      BEGIN
         SELECT NVL (Trim (s180), '0')
            INTO kod_
         FROM SPECPARAM
         WHERE acc = acc_;
      EXCEPTION
	      WHEN NO_DATA_FOUND
      THEN
         kod_ := '0';
      END;

      if kod_ = '0' then
         begin
            SELECT a.mdate, a.dapp, a.daos, nbs
               INTO mdate_, dapp_, daos_, nbs_
            FROM ACCOUNTS a
            WHERE a.acc = acc_;
         exception
                   when no_data_found then -- ���� ��� �����-������ ������� ����
            kod_ := '0';
         end;

         IF dapp_ IS NULL or abs(dapp_ - daos_) > 10 
         THEN
            dapp_ := daos_;
         END IF;
      end if;
   end if;

   IF kod_ = '0' or klass_ = '0'
   THEN
      if mdate_ is not null then
         -- ���� ������ ���� �������� ��������, �������� �� ���� �������
         -- �������� ��� ���� �������� �����
         if bdat_ is not null then
            dapp_ := bdat_;
         end if;

         kod_ := nvl(f_srok(dapp_, mdate_, tp_), '0');
         -- ��� ��� �������, ���� ���� ��������� ����������� �������,
         -- ��� ����������� ������� �� ����� 2630 (��������, ��������)
         if oz_kor_ = 1 then
             if nbs_ = '2620' and kod_ > 'B' then
                kod_ := 'B';
             end if;

             if nbs_ = '2630' and kod_ > 'B' then
                kod_ := 'B';
             end if;
         end if;
      end if;

      -- ��������� �� ����
      IF nbs_ IN ('1521', '1621','1310','1510','1610')
      THEN
       kod_ := '2';
      END IF;

      -- �������� �� ���������
      IF kod_ = '0'   THEN
         kod_ := Fs180_DEF (nbs_, tp_);
      END IF;
   END IF;

   RETURN kod_;
END Fs180;
/
 show err;
 
PROMPT *** Create  grants  FS180 ***
grant EXECUTE                                                                on FS180           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fs180.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 