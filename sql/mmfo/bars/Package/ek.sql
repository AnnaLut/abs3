
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/ek.sql =========*** Run *** ========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.EK IS

/*
03.09.2007 Sta    PUL- ������� ��� ���.��������
   ����� ������������ � ��.
   ���� ���� IGRA, ������� ���
   ������ : BIN\FIGURE.APD + ������ PUL + ������ EK + patchN26.ek

30.08.2007 Virko  �������� ��������� p_ek_pok_2day
28.08.2007 Virko  �������� �13, H13-1, H13-2
27.08.2007 Virko  �������� �7, H8, H9, H10
21.08.2007 Sta    �������� �7
*/

   ek6_   DECIMAL(24,2); --* ��������� (�)  ���i��� �����
   ek60_  DECIMAL(24,2); --* ��������� (��) ��������� ���i��� �����
   ek21_  DECIMAL(24,2); --* ��������� (��) ���� C����.��������.1 ������������
   ek22_  DECIMAL(24,2); --* ���������  �7 ����.������ �� 1 ������������
   ek23_  DECIMAL(24,2); --* ��������� (��) �������� ����i� "�������" ������i�
   ek24_  DECIMAL(24,2); --* ���������  �8 �������� "�������" ��������� �����i�
   ek25_  DECIMAL(24,2); --* ��������� (�i�) ���� C��.������. 1 i��������
   ek26_  DECIMAL(24,2); --* ���������  �9 �������� ����.����i�� �� �� 1 i��������
   ek27_  DECIMAL(24,2); --* ��������� (��i�) C������ �����������i��� ��i� i�������i�
   ek28_  DECIMAL(24,2); --* ���������  �11 �������� ����.���.����i�� �� �� ��i� i�������i�
   ek38_  DECIMAL(24,2); --* ��������� (��) �������� �i������ ������� �����i�
   ek39_  DECIMAL(24,2); --* ���������  �13 �������� �������� �i������i ��� ���
   ek381_ DECIMAL(24,2); --* ��������� (��-1) �������� ����� �i������ ������� �����i�
   ek391_ DECIMAL(24,2); --* ���������  �13-1 �������� �������� ����� �i������i ��� ���
   ek382_ DECIMAL(24,2); --* ��������� (��-2) �������� ������� �i������ ������� �����i�
   ek392_ DECIMAL(24,2); --* ���������  �13-2 �������� ��� ������� �i������ ��� ���
   ek40_  DECIMAL(24,2); --* ��������� (�i�) ��� �i������ ������� �����i� � ���
   ek41_  DECIMAL(24,2); --* ���������  �16 �������� MAX �i������i ��� ��� � ���
   ek42_  DECIMAL(24,2); --* ��������� (��) ��� �i������ ������� �����i� � H��
   ek43_  DECIMAL(24,2); --* ���������  �17 �������� MAX �i������i ��� ��� � H��
   ek44_  DECIMAL(24,2); --* ��������� (��) ��� �i������ ������� �����i� � ��
   ek45_  DECIMAL(24,2); --* ���������  �18 �������� MAX �i������i ��� ��� � ��
   exist_42_ boolean;
---------------------------------
   ek1_   DECIMAL(24,2); --  ��������� (��) O�����i ������
   ek2_   DECIMAL(24,2); --  ��������� (�)  Bi���������
   ek3_   DECIMAL(24,2); --  ��������� (��) O������� ���i���
   ek4_   DECIMAL(24,2); --  ��������� (��) ���������� ���i���
   ek5_   DECIMAL(24,2); --  ��������� (�1) ���i������������ ���i���
   ek7_   DECIMAL(24,2); --  ��������� (��) ������i, �� �������� ������
   ek8_   DECIMAL(24,2); --  ���������  �3  �������� ���������������i
   ek9_   DECIMAL(24,2); --  ��������� (��) �������i ������
   ek10_  DECIMAL(24,2); --  ���������  �6 �������� ������� �i��i�����i
   ek11_  DECIMAL(24,2); --            (���) ����� �� �������������� ��������
   ek12_  DECIMAL(24,2); --            (��) ����� � ���i
   ek13_  DECIMAL(24,2); --  \ ������i ������� ��� ���������� �5
   ek135_ DECIMAL(24,2); --  / ������i ������� ��� ���������� �5
   ek136_ DECIMAL(24,2); --  | ������i ������� ��� ���������� �6
   ek14_  DECIMAL(24,2); --  ���������  �4 �������� �������i �i��i�����i
   ek15_  DECIMAL(24,2); --  ������ ����. �� ����. �i��i�����i
   ek16_  DECIMAL(24,2); --  �����`������ ����� ��� �5
   ek166_ DECIMAL(24,2); --  �����`������ ����� ��� �6
   ek17_  DECIMAL(24,2); --             �5 �������� ������� �i��i�����i
   ek18_  DECIMAL(24,2); --            (��) �i��i��i ������
   ek19_  DECIMAL(24,2); --  ��������� (��) �����i ������
   ek20_  DECIMAL(24,2); --  ���������  �i���� �������i�. �� ���. �����i�
   ek29_  DECIMAL(24,2); --  ��������� (���) ���.���� ������� �i���� �����
   ek30_  DECIMAL(24,2); --  ���������  �12 �������� ����.���� ������� �� �����
   ek31_  DECIMAL(24,2); --  ��������� (��) ��� ���� ��� �������i������� ����i�
   ek32_  DECIMAL(24,2); --  ��������� (���) ��� ���� ��� �� �����
   ek33_  DECIMAL(24,2); --  ���������  �13 �������� ����.���� ����� �� �����
   ek34_  DECIMAL(24,2); --  ��������� (�i�)�����, ��i i�� �� ��������� ������
   ek46_  DECIMAL(24,2); --  ��������� (���) �������� �i��� �������������
   ek47_  DECIMAL(24,2); --  ���������      ���i� �� ������
   ek48_  DECIMAL(24,2); --  ���������      ���i� �� ���i���
   ek49_  DECIMAL(24,2);
   EK50_  DECIMAL(24,2);

---------------
FUNCTION ek_NULL RETURN DECIMAL;
FUNCTION ek_ALL  RETURN DECIMAL;

FUNCTION find_42(dat_ IN DATE) RETURN boolean;

FUNCTION ek6  (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek60 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek21 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek22 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek23 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek24 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek25 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek26 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek27 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek28 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;

FUNCTION ek38 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek39 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;

FUNCTION ek381 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek391 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;

FUNCTION ek382 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek392 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;

FUNCTION ek40 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek41 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek42 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek43 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek44 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek45 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
-----------------
PROCEDURE p_ek_pok_day(dat_ DATE);
PROCEDURE p_ek_pok_2day(kol_ number default 1);
-------------------

/*
FUNCTION ek1 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek2 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek3 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek4 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek5 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek15 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek16 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek166 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek18 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek19 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek20 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek29 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek30 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek31 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek32 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek33 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek34 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek46 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek48 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek49 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
*/

END ek;
/
CREATE OR REPLACE PACKAGE BODY BARS.EK IS
/*
30.08.2007 Virko  �������� ��������� p_ek_pok_2day
28.08.2007 Virko  �������� �13, H13-1, H13-2
27.08.2007 Virko  �������� �7, H8, H9, H10
21.08.2007 Sta    �������� �7
17/11/2015 Virko  �������� �������� �� ������� �5 �����
*/
------------
FUNCTION ek_null RETURN DECIMAL IS
  -- ������� ���� ���������� ��� ���������� �� �������
BEGIN
   ek6_   :=null; --* ��������� (�)  ���i��� �����
   ek60_  :=null;--* ��������� (��) ��������� ���i��� �����
   ek21_  :=null; --* ��������� (��) ���� C����.��������.1 ������������
   ek22_  :=null; --* ���������  �7 ����. ������ �� ������ ������������
   ek23_  :=null; --* ��������� (��) �������� ����i� "�������" ������i�
   ek24_  :=null; --* ���������  �8 �������� "�������" ��������� �����i�
   ek25_  :=null; --* ��������� (ǳ�) ���� C��.������. 1 i��������
   ek26_  :=null; --* ���������  �9 �������� ����.����i�� �� �� 1 i��������
   ek27_  :=null; --* ��������� (�ǳ�) C������ �����������i��� ��i� i�������i�
   ek28_  :=null; --* ���������  �10 �������� ����.���.����i�� �� �� ��i� i�������i�

   ek38_  :=null; --* ��������� (��) �������� �i������ ������� �����i�
   ek39_  :=null; --* ���������  �13 �������� �������� �i������i ��� ���

   ek381_ :=null; --* ��������� (��-1) �������� ����� �i������ ������� �����i�
   ek391_ :=null; --* ���������  �13-1 �������� �������� ����� �i������i ��� ���

   ek382_ :=null; --* ��������� (��-2) �������� ������� �i������ ������� �����i�
   ek392_ :=null; --* ���������  �13-2 �������� ��� ������� �i������ ��� ���

   ek40_  :=null; --* ��������� (�i�) ��� �i������ ������� �����i� � ���
   ek41_  :=null; --* ���������  �16 �������� MAX �i������i ��� ��� � ���
   ek42_  :=null; --* ��������� (��) ��� �i������ ������� �����i� � H��
   ek43_  :=null; --* ���������  �17 �������� MAX �i������i ��� ��� � H��
   ek44_  :=null; --* ��������� (��) ��� �i������ ������� �����i� � ��
   ek45_  :=null; --* ���������  �18 �������� MAX �i������i ��� ��� � ��
   exist_42_ := false;
-------------------
   ek1_   :=null; --  ��������� (��) O�����i ������
   ek2_   :=null; --  ��������� (�)  Bi���������
   ek3_   :=null; --  ��������� (��) O������� ���i���
   ek4_   :=null; --  ��������� (��) ���������� ���i���
   ek5_   :=null; --  ��������� (�1) ���i������������ ���i���
   ek7_   :=null; --  ��������� (��) ������i, �� �������� ������
   ek8_   :=null; --  ���������  �3  �������� ���������������i
   ek9_   :=null; --  ��������� (��) �������i ������
   ek10_  :=null; --  ���������  �6 �������� ������� �i��i�����i
   ek11_  :=null; --            (���) ����� �� �������������� ��������
   ek12_  :=null; --            (��) ����� � ���i
   ek13_  :=null; --  \ ������i ������� ��� ���������� �5
   ek135_ :=null; --  / ������i ������� ��� ���������� �5
   ek136_ :=null; --  | ������i ������� ��� ���������� �6
   ek14_  :=null; --  ���������  �4 �������� �������i �i��i�����i
   ek15_  :=null; --  ������ ����. �� ����. �i��i�����i
   ek16_  :=null; --  �����`������ ����� ��� �5
   ek166_ :=null; --  �����`������ ����� ��� �6
   ek17_  :=null; --             �5 �������� ������� �i��i�����i
   ek18_  :=null; --           (��) �i��i��i ������
   ek19_  :=null; --  ��������� (��) �����i ������
   ek20_  :=null; --  ���������  �i���� �������i�. �� ���. �����i�
   ek29_  :=null; --  ��������� (���) ���.���� ������� �i���� �����
   ek30_  :=null; --  ���������  �12 �������� ����.���� ������� �� �����
   ek31_  :=null; --  ��������� (��) ��� ���� ��� �������i������� ����i�
   ek32_  :=null; --  ��������� (���) ��� ���� ��� �� �����
   ek33_  :=null; --  ���������  �13 �������� ����.���� ����� �� �����
   ek34_  :=null; --  ��������� (�i�)�����, ��i i�� �� ��������� ������
   ek46_  :=null; --  ��������� (���) �������� �i��� �������������
   ek47_  :=null; --  ���������      ���i� �� ������
   ek48_  :=null; --  ���������      ���i� �� ���i���
   ek49_  :=null;
   EK50_  :=null;
   RETURN 0;
END ek_null;
------------
FUNCTION ek_all RETURN DECIMAL IS
BEGIN
   exist_42_ := find_42(null);
   ek6_ :=ek6 (NULL,0);
   ek60_:=ek60 (NULL,0);
   ek21_:=ek21(NULL,0);
   ek22_:=ek22(NULL,0);
   ek23_:=ek23(NULL,0);
   ek24_:=ek24(NULL,0);
   ek25_:=ek25(NULL,0);
   ek26_:=ek26(NULL,0);
   ek27_:=ek27(NULL,0);
   ek28_:=ek28(NULL,0);

   ek38_:=ek38(NULL,0);
   ek39_:=ek39(NULL,0);

   ek381_:=ek381(NULL,0);
   ek391_:=ek391(NULL,0);

   ek382_:=ek382(NULL,0);
   ek392_:=ek392(NULL,0);

   ek40_:=ek40(NULL,0);
   ek41_:=ek41(NULL,0);
   ek42_:=ek42(NULL,0);
   ek43_:=ek43(NULL,0);
   ek44_:=ek44(NULL,0);
   ek45_:=ek45(NULL,0);
   RETURN 0;
END ek_all;
------------
FUNCTION find_42(dat_ IN DATE) RETURN boolean is
  datf_ date:=nvl(dat_, gl.bDATE);
  exist_42 number:=0;
  exist_C5 number:=0;
BEGIN
  -- ��������� ������������ �� 42 ���� �� ��� ����
     select decode(cnt, 0, 0, 1)
	 into exist_42
	 from (
         select count(*) cnt
         from tmp_nbu
         where datf=datf_ and
            kodf='42');

    -- ���� ���� �� ������������ ��� ������� ���������� ����, �� ���������� ��� ������������
     if exist_42 = 0 or datf_=gl.bDATE then
      -- ��������� ������������ �� 42 ���� �� ��� ����
       select count(*)
       into exist_C5
       from otc_c5_proc
       where datf = dat_;
       
       if exist_C5 = 0 then
          P_FC5(dat_=>datf_);
       end if;
       
       P_F42_Nn(dat_=>datf_, pmode_=>1);
     end if;

    return true;
end find_42;
------------
FUNCTION ek6 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  -- ��������� (�) ���i��� �����
  d_ date;
BEGIN /* ������ ��������  �� ������� �� ����������, �� ��� ��� ������� */
   if dat_ is null then d_:=gl.bDATE; else d_:=dat_; end if;
   RETURN Rkapital (d_,NULL,NULL,3);
END ek6;
------------
FUNCTION ek60 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  -- ���������  ��������� ���i���
  d_ date;
  sum_SK_ number:=0;
  nn_ number;
BEGIN /* ������ ��������  �� ������� �� ����������, �� ��� ��� ������� */

IF ek60_ IS NULL THEN
If PR_=0 then
   if dat_ IS NOT NULL THEN
      -- �� ������������ ���� �� ������ ��� �� SALDOA
      SELECT nvl(SUM(s.ostf-s.dos+s.kos),0)INTO ek60_
      FROM  accounts a, saldoa s
      WHERE  a.acc=s.acc
        and a.kv= gl.baseval and a.nbs IN ('5000','5001','5002')
        and (s.acc,s.fdat)=
            (select acc, max(fdat) from saldoa
             where acc=s.acc and fdat<=DAT_ group by acc);
   else
      -- �� �������� ��� �� ACCOUNTS
      SELECT nvl(SUM(ostB),0)   INTO ek60_
      FROM accounts WHERE kv=gl.baseval and nbs IN ('5000','5001','5002');
          -- + ������� �� �� ACC_PLUS1
      SELECT nvl(SUM(ostB),0) INTO nn_ FROM ACC_PLUS1
      WHERE kv=gl.baseval and nbs IN ('5000','5001','5002');

Logger.info('EK Set_Mas_Ini - 60 do' );
      PUL.Set_Mas_Ini( 'EK60', TO_CHAR(ek60_+nn_), 'EK60' );
Logger.info('EK Set_Mas_Ini - 60 oposlja' );

   end if;
end if;
end if;
   RETURN ek60_;
END ek60;
------------
FUNCTION ek21 (DAT_ IN DATE, PR_ in numeric) RETURN DECIMAL IS
  nn_   decimal :=0;
  datf_ date:=nvl(dat_, gl.bDATE);
BEGIN
   If PR_=0 then
         -- ��������� ������������ �� 42 ���� �� ��� ����
         if not exist_42_ then
           exist_42_ := find_42(datf_);
         end if;

         -- �������� ������������ ���������� (�.�. �� ����� ���� ��������� ��
         -- ������ ������������)
         for cur in (select kodp, znap
                     from (
                        SELECT kodp, TO_NUMBER (znap) znap
                          FROM tmp_nbu t
                         WHERE t.kodp LIKE '01%'
                           AND t.datf = datf_
                           AND t.kodf = '42'
                           AND NOT EXISTS (
                                  SELECT 1
                                    FROM tmp_nbu n
                                   WHERE n.kodp = '05' || SUBSTR (t.kodp, 3)
                                     AND n.datf = datf_
                                     AND n.kodf = '42'
                                     AND n.znap = t.znap)
                        order by 2 desc)
                    where rownum=1) loop
            nn_ := cur.znap;
         end loop;
   end if;

   ek21_:=nn_;

   RETURN ek21_;
END ek21;
----------------
FUNCTION ek22 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  --���������  �7 ����.������ �� 1 ������������
  nn_ decimal;
BEGIN
   nn_:= ek6(dat_,pr_) ;
   if nn_ <> 0 THEN nn_:=  ek21(dat_,pr_)*10000/nn_ ; end if;
   ek22_:=nn_;
   RETURN ek22_;
END ek22;
--------------
FUNCTION ek23 (DAT_ IN DATE, PR_ in numeric) RETURN DECIMAL IS
  nn_ decimal :=0;
  datf_ date:=nvl(dat_, gl.bDATE);
BEGIN
   If PR_=0 then
         -- ��������� ������������ �� 42 ���� �� ��� ����
         if not exist_42_ then
           exist_42_ := find_42(datf_);
         end if;

         -- �������� ����������
         for cur in (SELECT kodp, TO_NUMBER (znap) znap
                          FROM tmp_nbu t
                         WHERE t.kodp LIKE '02%'
                           AND t.datf = datf_
                           AND t.kodf = '42') loop
            nn_ := cur.znap;
         end loop;
   end if;

   ek23_:=nn_;

   RETURN ek23_;
END ek23;
----------------
FUNCTION ek24 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  -- ���������  �8 �������� "�������" ��������� �����i�
  nn_ decimal;
BEGIN
   nn_:= ek6(dat_,pr_) ;
   if nn_ <> 0 THEN nn_:=  ek23(dat_,pr_)*10000/nn_ ; end if;
   ek24_:=nn_;
   RETURN ek24_;
END ek24;
--------------
FUNCTION ek25(DAT_ IN DATE, PR_ in numeric) RETURN DECIMAL IS
  nn_ decimal :=0;
  datf_ date:=nvl(dat_, gl.bDATE);
BEGIN
   If PR_=0 then
         -- ��������� ������������ �� 42 ���� �� ��� ����
         if not exist_42_ then
           exist_42_ := find_42(datf_);
         end if;

         -- �������� ������������ ���������� (�.�. �� ����� ���� ��������� ��
         -- ������ ������������)
         for cur in (select kodp, znap
                     from (
                        SELECT kodp, TO_NUMBER (znap) znap
                          FROM tmp_nbu t
                         WHERE t.kodp LIKE '03%'
                           AND t.datf = datf_
                           AND t.kodf = '42'
                        order by 2 desc)
                    where rownum=1) loop
            nn_ := cur.znap;
         end loop;
   end if;

   ek25_:=nn_;

   RETURN ek25_;
END ek25;
----------------
FUNCTION ek26 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  -- ���������  �9 �������� ����.����i�� �� �� 1 i��������
  nn_ decimal;
BEGIN
   nn_:= ek60(dat_,pr_) ;
   if nn_ <> 0 THEN nn_:=  ek25(dat_,pr_)*10000/nn_; end if;
   ek26_:=nn_;
   RETURN ek26_;
END ek26;
--------------
FUNCTION ek27(DAT_ IN DATE, PR_ in numeric) RETURN DECIMAL IS
  nn_ decimal :=0;
  datf_ date:=nvl(dat_, gl.bDATE);
BEGIN
   If PR_=0 then
         -- ��������� ������������ �� 42 ���� �� ��� ����
         if not exist_42_ then
           exist_42_ := find_42(datf_);
         end if;

         -- �������� ������������ ���������� (�.�. �� ����� ���� ��������� ��
         -- ������ ������������)
         for cur in (   SELECT kodp, TO_NUMBER (znap) znap
                          FROM tmp_nbu t
                         WHERE t.kodp LIKE '04%'
                           AND t.datf = datf_
                           AND t.kodf = '42') loop
            nn_ := cur.znap;
         end loop;
   end if;

   ek27_:=nn_;

   RETURN ek27_;
END ek27;
----------------
FUNCTION ek28 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  --���������  �7 ����.������ �� 1 ������������
  nn_ decimal;
BEGIN
   nn_:= ek60(dat_,pr_) ;
   if nn_ <> 0 THEN nn_:=  ek27(dat_,pr_)*10000/nn_; end if;
   ek28_:=nn_;
   RETURN ek28_;
END ek28;
--------------
FUNCTION ek38 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  -- ��������� (��) �������� �i������ ������� �����i�
  nn_ decimal;
BEGIN
IF ek38_ IS NULL THEN
   IF pr_=0 THEN
      if dat_ IS NOT NULL THEN
         -- �� ������������ ���� �� ������ ��� �� SALDOA
         SELECT nvl(SUM( ABS( gl.p_icurval(a.kv,s.ostf-s.dos+s.kos,dat_))),0)
         INTO ek38_
         FROM  accounts a, saldoa s
         WHERE  a.acc=s.acc
           and a.kv<> gl.baseval
           and a.acc in (select ACC3800 from vp_list)
           and (s.acc,s.fdat)=
               (select acc, max(fdat) from saldoa
                where acc=s.acc and fdat<=DAT_ group by acc);
      else
         -- �� �������� ��� �� ACCOUNTS
         SELECT nvl(SUM( ABS( EQV(kv,ostB) )),0)   INTO ek38_
         FROM   accounts WHERE  kv<> gl.baseval
           and acc in (select ACC3800 from vp_list);

         -- + ������� �� �� ACC_PLUS1
         SELECT nvl(SUM(ABS(ostb)),0) INTO nn_ FROM ACC_PLUS1  WHERE nbs='3800';
         PUL.Set_Mas_Ini( 'EK38', TO_CHAR(ek38_+nn_), 'EK38' );
      end if;
   end if;
end if;
   RETURN ek38_;
END ek38;
------------
FUNCTION ek39 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  --��������� �13 �������� �������� �i������i ��� ���
  nn_ decimal;  mm_ number;
BEGIN
   nn_:= ek6(dat_,pr_) ;
   if nn_ <> 0 THEN
      ek39_:=ek38(dat_,pr_)*10000/nn_;


      If pr_=0 and dat_ IS NULL then
Logger.info('EK- 1 ' );
         mm_:=to_number(PUL.Get_Mas_Ini_Val('EK38'));
Logger.info('EK- 2 ' ||mm_ || ' '||nn_ );
         If mm_ is not null then
            PUL.Set_Mas_Ini( 'EK39', TO_CHAR( mm_*10000/nn_), 'EK39' );
Logger.info('EK- 3 ' ||mm_ || ' '||nn_ );
         end if;
      end if;

   end if;
   RETURN ek39_;
END ek39;
------------
FUNCTION ek381 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  -- ��������� (��-1) �������� ����� �i������ ������� �����i�
  nn_ decimal;
BEGIN
IF ek381_ IS NULL THEN
   IF pr_=0 THEN
      if dat_ IS NOT NULL THEN
         -- �� ������������ ���� �� ������ ��� �� SALDOA
         SELECT ABS( SUM( nvl(gl.p_icurval(a.kv,s.ostf-s.dos+s.kos,dat_),0)))
         INTO ek381_
         FROM  accounts a, saldoa s
         WHERE  a.acc=s.acc
           and a.kv<> gl.baseval
           and a.acc in (select ACC3800 from vp_list)
           and (s.acc,s.fdat)=
               (select acc, max(fdat) from saldoa
                where acc=s.acc and fdat<=DAT_ group by acc)
	   and s.ostf-s.dos+s.kos>0;
      else
         -- �� �������� ��� �� ACCOUNTS
         SELECT abs(nvl(SUM(EQV(kv,ostB)),0))   INTO ek381_
         FROM   accounts WHERE  kv<> gl.baseval
           and acc in (select ACC3800 from vp_list)
	   and ostB>0;
         -- + ������� �� �� ACC_PLUS1
         SELECT nvl(SUM(ostB),0) INTO nn_
         FROM ACC_PLUS1 WHERE nbs='3800' and ostB>0;
         PUL.Set_Mas_Ini( 'EK381', TO_CHAR(ek381_+nn_), 'EK381' );
      end if;
   end if;
end if;
   RETURN ek381_;
END ek381;
------------
FUNCTION ek391 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  -- ���������  �13-1 �������� �������� ����� �i������i ��� ���
  nn_ decimal; mm_ number;
BEGIN
   nn_:= ek6(dat_,pr_) ;
   if nn_ <> 0 THEN
      ek391_:=  ek381(dat_,pr_)*10000/nn_ ;

      If pr_=0 and dat_ IS NULL then
         mm_:=to_number(PUL.Get_Mas_Ini_Val('EK381'));
         If mm_ is not null then
            PUL.Set_Mas_Ini( 'EK391', TO_CHAR( mm_*10000/nn_), 'EK391' );
         end if;
      end if;

   end if;
   RETURN ek391_;
END ek391;
------------
FUNCTION ek382 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  -- ��������� (��-2) �������� ������� �i������ ������� �����i�
  nn_ decimal;
BEGIN
IF ek382_ IS NULL THEN
   IF pr_=0 THEN
      if dat_ IS NOT NULL THEN
         -- �� ������������ ���� �� ������ ��� �� SALDOA
         SELECT nvl(SUM( ABS( gl.p_icurval(a.kv,s.ostf-s.dos+s.kos,dat_))),0)
         INTO ek382_
         FROM  accounts a, saldoa s
         WHERE  a.acc=s.acc
           and a.kv<> gl.baseval
           and a.acc in (select ACC3800 from vp_list)
           and (s.acc,s.fdat)=
               (select acc, max(fdat) from saldoa
                where acc=s.acc and fdat<=DAT_ group by acc)
	   and s.ostf-s.dos+s.kos <0;
      else
         -- �� �������� ��� �� ACCOUNTS
         SELECT nvl(SUM(EQV(kv,ostB)),0)   INTO ek382_
         FROM   accounts WHERE  kv<> gl.baseval
           and acc in (select ACC3800 from vp_list)
	   and ostB<0;

         -- + ������� �� �� ACC_PLUS1
         SELECT nvl(SUM(ostB),0) INTO nn_
	 FROM ACC_PLUS1 WHERE nbs='3800' and ostB<0;
         PUL.Set_Mas_Ini( 'EK382', TO_CHAR(ek382_+nn_), 'EK382' );
      end if;
   end if;
end if;
   RETURN ek382_;
END ek382;
------------
FUNCTION ek392 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  -- ���������  �13-2 �������� ��� ������� �i������ ��� ���
  nn_ decimal;  mm_ number;
BEGIN
   nn_:= ek6(dat_,pr_) ;
   if nn_ <> 0 THEN
      ek392_:=  ek382(dat_,pr_)*10000/nn_;

      If pr_=0 and dat_ IS NULL then
         mm_:=to_number(PUL.Get_Mas_Ini_Val('EK382'));
         If mm_ is not null then
            PUL.Set_Mas_Ini( 'EK392', TO_CHAR( mm_*10000/nn_), 'EK392' );
         end if;
      end if;

   end if;
   RETURN ek392_;
END ek392;
------------
FUNCTION ek40 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  --��������� (�i�) ��� �i������ ������� �����i� � ���
  nn_ decimal;
BEGIN
IF ek40_ IS NULL THEN
   IF pr_=0 THEN
      if dat_ IS NOT NULL THEN
         -- �� ������������ ���� �� ������ ��� �� SALDOA
         SELECT nvl(MAX(ABS(SUM(gl.p_icurval(a.kv,s.ostf-s.dos+s.kos,dat_)))),0)
         INTO ek40_
         FROM   accounts a,saldoa s, kl_r030 r
         WHERE  a.acc in (select acc3800 from vp_list)
           and a.kv=r.r030+0 and r.r031='2' and
                a.acc=s.acc and (s.acc,s.fdat)=
               (select acc, max(fdat) from saldoa
                where acc=s.acc and fdat<=DAT_ group by acc)
         GROUP BY a.kv ;
      else
         -- �� �������� ��� �� ACCOUNTS
         SELECT nvl(MAX(ABS( SUM( a.ostB ))),0)    INTO ek40_
         FROM   accounts a, kl_r030 r WHERE  a.kv<> gl.baseval
           and a.acc in (select ACC3800 from vp_list)
           and a.kv=r.r030+0 and r.r031='2'
         GROUP BY a.kv ;

         -- + ������� �� �� ACC_PLUS1
         SELECT nvl(MAX(ABS( SUM( a.ostB ))),0)
         INTO nn_ FROM ACC_PLUS1 a, kl_r030 r
         WHERE a.nbs='3800' and a.kv=r.r030+0 and r.r031='2'
         GROUP BY a.kv ;

         PUL.Set_Mas_Ini( 'EK40', TO_CHAR(ek40_+nn_), 'EK40' );
      end if;
   end if;
end if;
   RETURN ek40_;
END ek40;
------------
FUNCTION ek41 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  --��������� �16 �������� MAX �i������i ��� ��� � ���
  nn_ decimal; mm_ number;
BEGIN
   nn_:= ek6(dat_,pr_) ;
   if nn_ <> 0 THEN
      ek41_:=ABS(ek40(dat_,pr_))*10000/nn_;

      If pr_=0 and dat_ IS NULL then
         mm_:=to_number(PUL.Get_Mas_Ini_Val('EK40'));
         If mm_ is not null then
            PUL.Set_Mas_Ini( 'EK41', TO_CHAR( mm_*10000/nn_), 'EK41' );
         end if;
      end if;

   end if;
   RETURN ek41_;
END ek41;
-------------------
FUNCTION ek42 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  --��������� �� ��� �i������ ������� �����i� � H��
  nn_ decimal;
BEGIN
IF ek42_ IS NULL THEN
   IF pr_=0 THEN
      if dat_ IS NOT NULL THEN
         -- �� ������������ ���� �� ������ ��� �� SALDOA
         SELECT   nvl(MAX( ABS(SUM( gl.p_icurval(a.kv,s.ostf-s.dos+s.kos,dat_) ))),0)
         INTO ek42_
         FROM   accounts a,saldoa s,  kl_r030 r
         WHERE  a.acc in (select acc3800 from vp_list)
           and a.kv=r.r030+0 and r.r031='3'
           and a.acc=s.acc and (s.acc,s.fdat)=
               (select acc, max(fdat) from saldoa
                where acc=s.acc and fdat<=DAT_ group by acc)
         GROUP BY a.kv ;
      else
         -- �� �������� ��� �� ACCOUNTS
         SELECT nvl(MAX(ABS( SUM( a.ostB ))),0)    INTO ek42_
         FROM   accounts a, kl_r030 r WHERE  a.kv<> gl.baseval
           and a.acc in (select ACC3800 from vp_list)
           and a.kv=r.r030+0 and r.r031='3'
         GROUP BY a.kv ;

         -- + ������� �� �� ACC_PLUS1
         SELECT nvl(MAX(ABS( SUM( a.ostB ))),0)
         INTO nn_ FROM ACC_PLUS1 a, kl_r030 r
         WHERE a.nbs='3800' and a.kv=r.r030+0 and r.r031='3'
         GROUP BY a.kv ;

         PUL.Set_Mas_Ini( 'EK42', TO_CHAR(ek42_+nn_), 'EK42' );
      end if;
   end if;

end if;
   RETURN ek42_;
END ek42;
-------------------
FUNCTION ek43 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
   --��������� �17 �������� MAX �i������i ��� ��� � H��
   nn_ decimal; mm_ number;
BEGIN
   nn_:= ek6(dat_,pr_) ;
   if nn_ <> 0 THEN
      ek43_:=ABS(ek42(dat_,pr_))*10000/nn_;

      If pr_=0 and dat_ IS NULL then
         mm_:=to_number(PUL.Get_Mas_Ini_Val('EK42'));
         If mm_ is not null then
            PUL.Set_Mas_Ini( 'EK43', TO_CHAR( mm_*10000/nn_), 'EK43' );
         end if;
      end if;

   end if;
   RETURN ek43_;
END ek43;
---------------
FUNCTION ek44 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
   --��������� �� ��� �i������ ������� �����i� � ��
   nn_ decimal;
BEGIN
IF ek44_ IS NULL THEN
   IF pr_=0 THEN
      if dat_ IS NOT NULL THEN
         -- �� ������������ ���� �� ������ ��� �� SALDOA
         SELECT   nvl(MAX( ABS(SUM( gl.p_icurval(a.kv,s.ostf-s.dos+s.kos,dat_) ))),0)
         INTO ek44_
         FROM   accounts a, saldoa s, kl_r030 r
         WHERE  a.acc in (select acc3800 from vp_list)
           and a.kv=r.r030+0 and r.r031='4'
                and a.acc=s.acc and (s.acc,s.fdat)=
               (select acc, max(fdat) from saldoa
                where acc=s.acc and fdat<=DAT_ group by acc)
         GROUP BY a.kv ;
      else
         -- �� �������� ��� �� ACCOUNTS
         SELECT nvl(MAX(ABS( SUM( a.ostB ))),0)    INTO ek44_
         FROM   accounts a, kl_r030 r WHERE  a.kv<> gl.baseval
           and a.acc in (select ACC3800 from vp_list)
           and a.kv=r.r030+0 and r.r031='4'
         GROUP BY a.kv ;

         -- + ������� �� �� ACC_PLUS1
         SELECT nvl(MAX(ABS( SUM( a.ostB ))),0)
         INTO nn_ FROM ACC_PLUS1 a, kl_r030 r
         WHERE a.nbs='3800' and a.kv=r.r030+0 and r.r031='4'
         GROUP BY a.kv ;

         PUL.Set_Mas_Ini( 'EK44', TO_CHAR(ek44_+nn_), 'EK44' );
      end if;
   end if;
end if;
   RETURN ek44_;
END ek44;
---------------
FUNCTION ek45 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  --��������� �18 �������� MAX �i������i ��� ��� � ��-----
  nn_ decimal; mm_ number;
BEGIN
   nn_:= ek6(dat_,pr_) ;
   if nn_ <> 0 THEN
      ek45_:=ABS(ek44(dat_,pr_))*10000/nn_;

      If pr_=0 and dat_ IS NULL then
         mm_:=to_number(PUL.Get_Mas_Ini_Val('EK44'));
         If mm_ is not null then
            PUL.Set_Mas_Ini( 'EK45', TO_CHAR( mm_*10000/nn_), 'EK45' );
         end if;
      end if;

   end if;
   RETURN ek45_;
END ek45;
---------
PROCEDURE  p_ek_pok_day(dat_ DATE) IS
  --���������� ����������� �� ���� � ek_pok_day
  nn_ decimal;
BEGIN
  DELETE FROM ek_pok_day WHERE fdat=dat_;
  nn_  :=ek_null;
  exist_42_ := find_42(dat_);
  ek6_ :=ek6 (dat_,0);
  ek60_ :=ek60 (dat_,0);
  ek21_:=ek21(dat_,0);
  ek22_:=ek22(dat_,0);
  ek23_:=ek23(dat_,0);
  ek24_:=ek24(dat_,0);
  ek25_:=ek25(dat_,0);
  ek26_:=ek26(dat_,0);
  ek27_:=ek27(dat_,0);
  ek28_:=ek28(dat_,0);

  ek38_:=ek38(dat_,0);
  ek39_:=ek39(dat_,0);

  ek381_:=ek381(dat_,0);
  ek391_:=ek391(dat_,0);

  ek382_:=ek382(dat_,0);
  ek392_:=ek392(dat_,0);

  ek40_:=ek40(dat_,0);
  ek41_:=ek41(dat_,0);
  ek42_:=ek42(dat_,0);
  ek43_:=ek43(dat_,0);
  ek44_:=ek44(dat_,0);
  ek45_:=ek45(dat_,0);

  insert into ek_pok_day(fdat,pok,s) values (dat_,6 ,ek6_ );
  insert into ek_pok_day(fdat,pok,s) values (dat_,60 ,ek60_ );

  insert into ek_pok_day(fdat,pok,s) values (dat_,21,ek21_);
  insert into ek_pok_day(fdat,pok,s) values (dat_,22,ek22_);
  insert into ek_pok_day(fdat,pok,s) values (dat_,23,ek23_);
  insert into ek_pok_day(fdat,pok,s) values (dat_,24,ek24_);
  insert into ek_pok_day(fdat,pok,s) values (dat_,25,ek25_);
  insert into ek_pok_day(fdat,pok,s) values (dat_,26,ek26_);
  insert into ek_pok_day(fdat,pok,s) values (dat_,27,ek27_);
  insert into ek_pok_day(fdat,pok,s) values (dat_,28,ek28_);

  insert into ek_pok_day(fdat,pok,s) values (dat_,38,ek38_);
  insert into ek_pok_day(fdat,pok,s) values (dat_,39,ek39_);

  insert into ek_pok_day(fdat,pok,s) values (dat_,381,ek381_);
  insert into ek_pok_day(fdat,pok,s) values (dat_,391,ek391_);

  insert into ek_pok_day(fdat,pok,s) values (dat_,382,ek382_);
  insert into ek_pok_day(fdat,pok,s) values (dat_,392,ek392_);

  insert into ek_pok_day(fdat,pok,s) values (dat_,40,ek40_);
  insert into ek_pok_day(fdat,pok,s) values (dat_,41,ek41_);
  insert into ek_pok_day(fdat,pok,s) values (dat_,42,ek42_);
  insert into ek_pok_day(fdat,pok,s) values (dat_,43,ek43_);
  insert into ek_pok_day(fdat,pok,s) values (dat_,44,ek44_);
  insert into ek_pok_day(fdat,pok,s) values (dat_,45,ek45_);
  commit;
END p_ek_pok_day;
------------------
PROCEDURE p_ek_pok_2day(kol_ number default 1) is
-- �������� � ���������� � ����� ������ �� ��������� ���� �� ���. ����. ����
	cdat_   date:=gl.bDATE;
begin
    for i in (select fdat
	          from (
    	          select fdat
    	          from (
    	            SELECT fdat
                	FROM fdat
                	WHERE fdat<=cdat_
    				order by 1 desc)
    			  where rownum<=kol_)
			order by 1) loop
	    p_ek_pok_day(i.fdat);
	end loop;

end p_ek_pok_2day;
------------------
END ek;
/
 show err;
 
PROMPT *** Create  grants  EK ***
grant EXECUTE                                                                on EK              to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on EK              to START1;
grant EXECUTE                                                                on EK              to TECH006;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/ek.sql =========*** End *** ========
 PROMPT ===================================================================================== 
 