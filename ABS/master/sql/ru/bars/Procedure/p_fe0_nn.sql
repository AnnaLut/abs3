

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FE0_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FE0_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_FE0_NN (Dat_ DATE, sheme_ varchar2 default 'G')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	��������� ������������ ����� #E0 ��� �� (�������������)
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 09/02/2015 (04.02.2015,03.02.2015,17.01.2015,16.01.2015)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ���������: Dat_ - �������� ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
09.02.2015 - ��� �� � ��� 318 ����� ��������� ��������
             �� 100*  �� 2902 OB22=('09','15')
04.02.2015 - �� ��������� �������������� �������� � ���������� 219 �.�.
             �� ������������ ���������� 218.
             ������ ������� ��������� ���������� 218 � ����� �����
             �������� �������������� �������� �� ���������� 219
             ������� ���������� 218
03.02.2015 - � 01.01.2015 ����������� ���������� ��� �� (118,119,218)
             � ���������� 219 ����������� �������� ������� ������
             ��� ��������� ������� (AAL, AAE)
17.01.2015 - ��� ��� � ��� 318 ����� ��������� ��������
             �� 7419 �� 362259537
16.01.2015 - ��� �������� �� 100*, 2900 �� 2902 ��������� ���������
             ���������� ������� '%2%� ����.����%,'%0.5%� ����_���� ����%'
04.11.2014 - ��� �� (300465) � ���� 119 ������� ���������� �������
             ("���_��� _�������_ ������")
08.10.2014 - ��� ����� 300205 � ��� 318 �������� ����� ��������
             �� 100* �� 290249567
02.10.2014 - ��� ����� 300465 ����� �������� �������� �������������
             �� ����� �� 7419 �� 3622
25.09.2014 - �� �������� �������� � TT in ('I02','I03')
18.09.2014 - �������� �������� �� 2900 �� 3739 TT='310' � ����������
             '�� ������'
             ��� 300465 ������� �������� ��� �������� ���� 3801 OB22='09'
16.09.2014 - ��������� �������� �� 3801 �� 100* � ����������
             ������� '%���������� ����� ����� ��������%'
             � ��������� �������� �� 3801 �� 100* ��� ������� ��������
             �������� �� 2909 �� 3800 (�������� "MUX")
21.08.2014 - ��� �������� �� 3801 �� 100* ��������� ������� ��� ����������
             ������� "lower(t.nazn) not like '%�����%'"
             (�� ���������� �������� ��� � ���������� ��� ����� '959')
12.08.2014 - ��������� ������������ ��������� ����� ��� ������ MFOU_
             ���� ����
28.07.2014 - ��� �� (300465) � ���� 119 ������� ���������� �������
             ("���_��� ������")
24.07.2014 - ��� ����� ������ ��� ������������ ���� 119 ������� �������
             NLSD not like '29003%' �� NLSD <> '29003'
04.07.2014 - ��� 300465 � ���� 318 ������� �������� �� 26��, 3541, 3739
             �� 2902. �� ����� ���������� BAK �������� ���
             �� 100*  �� 2902
23.06.2114 - ��� ����� ������ ��� 119 ��������� ���� �� 2900 �� 29003
13.06.2014 - ��� 300120 ��������� �������� "�_2"  � ��� ���� 319 ������
             ������� ����� 3739 ���������� ���� 3929
06.06.2014 - ��� 353575 � ��� 318 ����� �������� ��������
             �� 7419 �� 362268007
05.06.2014 - �������������� ���������
03.06.2014 - �������� �������� ��7419  ��3622 � ���������� "� ����.����"
             (��������� ���)
02.06.2014 - ��� ����� ����� ��������� �������� ��� ������� TT='013'
             � �� 2909 �� �� 20* � �� 1919, �� 3739 �� �� 20* � �� 1919
             �� 3801 �� 6397  � �������� ���.���������  D1#E0='0'
29.05.2014 - ��������� ������������ ����� 118,119 ��� ����� �����
             � ���� 318 ��� ����� ������
23.05.2014 - ��������� ��� ����� �����
20.05.2014 - ��� 380764 � ���������� 118 ��������� �� 2900 �� 1819
19.05.2014 - ��� 300120 ������� ���������� ��������� 2902, 3622
16.05.2014 - ����� ��������� ���������� � ��������� ����� ����������
19.03.2010 - ��� ������������� �� ������ ���� 110 ����� �������� ��� 120
10.03.2010 - ��� ���������� KURS_ ��������� ���������� �� 4 ������ �����
             �������
07.02.2010 - ������� ������������ ����� ���-��
03.02.2010 - �������� ������ ����� #39 ��� 112 ������� ������ �
             ����� #2A ���� 131,132 ������� ������ �� ���. ��� ��������
01.02.2010 - �������� ������ ����� #39 ��� 112 ������� ������ �
             ����� #2A ��� 110 ������� ������ �� ���. � �������� �����
31.08.2007 - �������� ������ ����� #39 ��� 112 ������� ������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='E0';
fmt_     varchar2(20):='999990D0000';
--mn_      number:=100; -- ��� �������������� �������� � �����, ���� ���� � OPERW �� ������� ������
dl_      number:=100; -- ��� ��������
DatP_	 date; -- ���� ������ �������� ����, ���. ������������ ������� ����
Dat_pmes date; -- ��������� ������� ���� ����������� ������
buf_	 number;

typ_     number;
kv_      number;
kv1_     number;
ref_     number;
ref1_    number;
tt_      varchar2(3);
nls_     varchar2(15);
nlsk_    varchar2(15);
nls1_    varchar2(15);
nlsb_    varchar2(15);
mfo_     Varchar2(12);
mfou_    Number;
mfoa_    Varchar2(12);
mfob_    Varchar2(12);
comm_    Varchar2(200);
dat1_    Date;
data_    date;
kol_     number;
dig_     number;
bsu_     number;
sum_     number;
sum1_    number;
sum0_    number;
sun1_    number;
sun0_    number;
kodp_    varchar2(10);
kodp1_   varchar2(10);
znap_    varchar2(30);
VVV      varchar2(3) ;
ddd39_   varchar2(3) ;
ddd_     varchar2(3) ;
d39_     varchar2(200) ;
kurs_    varchar2(200) ;
tag_     varchar2(5) ;
a_       varchar2(20);
b_       varchar2(20);
userid_  number;
nbuc1_   varchar2(12);
nbuc_    varchar2(12);
acc_     number;
accd_    number;
acck_    number;
pr_      number;
rate_o_  number;
div_     number;
nazn_    Varchar2(200);
dat_izm1 date := to_date('31/12/2014','dd/mm/yyyy');

CURSOR OPL_DOK IS
   SELECT a.tt, a.accd, a.nlsd, a.kv, a.acck, a.nlsk, a.ref, a.fdat,
          a.s*100, a.isp, a.nazn
   FROM tmp_file03 a
   WHERE a.kv = 980
ORDER BY 10, 8, 7;

CURSOR Basel IS
   SELECT nbuc, kodp, SUM(TO_NUMBER (znap))
   FROM RNBU_TRACE a
   WHERE userid=userid_
   GROUP BY nbuc, kodp;
-----------------------------------------------------------------------
BEGIN
-------------------------------------------------------------------
userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
EXECUTE IMMEDIATE 'TRUNCATE TABLE TMP_FILE03';

mfo_ := F_OURMFO();

-- ��� "��������"
BEGIN
   SELECT mfou
      INTO mfou_
   FROM BANKS
   WHERE mfo = mfo_;
EXCEPTION WHEN NO_DATA_FOUND THEN
   mfou_ := mfo_;
END;

p_proc_set(kodf_,sheme_,nbuc1_,typ_);
Datp_ := calc_pdat(dat_);
Dat1_:= TRUNC(Dat_,'MM');

-- � 01.01.2015 ���������� 118,119,218 �� ������ �������������
if Dat_ <= dat_izm1 then

-- ��� 118
if mfou_ not in (380764) then
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 118
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and nbsd like '3640%' and nbsk like '2900%'
   ) ;

    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 118
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and nbsd like '3801%' and nbsk  like '1819%'
      and LOWER(nazn) like '%���_���%'
      and LOWER(nazn) not like '%swap%'
   ) ;

end if;

if mfou_ not in (300205, 380764) then
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 118
    from provodki_otc
    where fdat between Dat1_ and dat_
      and kv=980
      and nbsd like '3801%' and nbsk  like '2900%'
      and LOWER(nazn) like '%���_��� �� �������%'
   ) ;
end if;

if mfou_ = 300205 then
   -- ��� 118
    insert into tmp_file03
                (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 118
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and nbsd like '3801%' and nlsk  like '290009228%'
   ) ;

   -- ��� 119
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 119
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and (nlsd like '2900%' and nlsd not like '290009228%')
      and nlsk like '290009228%'
   ) ;
end if;

if mfou_ = 380764 then
   -- ��� 118
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, -S, -SQ, FDAT, NAZN, ACCK, NLSK, 118
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and nbsd like '2900%'
      and nbsk like '1819%'
   ) ;

   -- ��� 118
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 118
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and nlsd like '34099000000001%'
      and nbsk like '2909%'
      and ref in (144533604,141436535)
   ) ;

   -- ��� 118
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 118
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and (nlsd like '29002300386007%' or nlsd like '29002300386502%')
      and nbsk like '2900%'
   ) ;

   -- ��� 118
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 118
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and ( (nbsd like '1819%' and nbsk like '3640%') or
            (nlsd like '19197300386513%' and nbsk like '2900%')
          )
   ) ;

   -- ��� 119
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 119
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and tt like '013%'
      and ( ( (nbsd like '220%' or nbsd like '223%' or nbsd like '2600%') and
               nbsk like '3801%') or
            (nbsd like '3801%'  and nbsk like '6397%') or
            (nbsd like '2909%'  and nbsk not like '20%' and nbsk not like '1919%')
          )
   ) ;

   -- ��� 119
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 119
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and nbsd like '2900%'
      and (nlsk like '29002300386007%' or nlsk like '29002300386502%')
   ) ;

   -- ��� 119
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select p.ACCD, p.TT, p.REF, p.KV, p.NLSD, p.S, p.SQ, p.FDAT, p.NAZN, p.ACCK, p.NLSK, 119
    from provodki_otc p
    where p.fdat between Dat1_ and Dat_
      and p.kv=980
      and p.tt like '013%'
      and ( (p.nbsd like '3739%' and p.nbsk like '3801%') or
            (p.nbsd like '3801%' and p.nbsk like '3579%')
          )
      and exists ( select 1 from operw w
                   where w.ref = p.ref
                     and w.tag like 'D1#E0%'
                     and NVL(trim(w.value),'0') = '1'
                 )
   ) ;

end if;

if mfou_ = 300120 then   --not in (300205, 300465, 353575, 380764) then
   -- ��� 119
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 119
    from provodki_otc
    where fdat between Dat1_ and dat_
      and kv=980
    --and (nlsd not like '2900%' and nlsd not like '3640%' and nlsd not like '2902%') and nlsk  like '2900%' and kv=980
      and nbsd like '2900%' and nbsk like '2900%'
      and LOWER(nazn) like '%���_��_%'
   ) ;
end if;

if mfou_ = 300465 then
   -- ��� 119
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 119
    from provodki_otc
    where fdat between Dat1_ and dat_
      and kv=980
      and nbsd like '2900%' and nbsk like '3739%'
      and ( LOWER(nazn) like '%��� ���_��_%' or
            LOWER(nazn) like '%�� ���_��_%' or
            LOWER(nazn) like '%���_��_ ������%' or
            LOWER(nazn) like '%���_��_ _�������_ ������%'
          )
      and ob22d='01'
      and tt='310'
   ) ;
end if;

if mfou_ = 353575 then
   -- ��� 119
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 119
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and (nlsd like '2900%' and nlsd <> '29003')
      and nlsk like '29003%'
   ) ;
end if;

end if;
-- c 01.01.2015 ���� 118,119,218 �� ����� �������������

-- ��� 218
 insert into tmp_file03
                (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
select * from
(
select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 218
from provodki_otc
where fdat between Dat1_ and Dat_
and kv=980
and nbsd like '3801%' and nbsk like '100%'
) ;

-- ������ ��� ����� �����
if mfou_ = 380764 then
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 218
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and nbsd like '2909%' and nbsk like '100%'
      and ( lower(nazn) like '%�_����� ���������� _��_�������%'        or
            lower(nazn) like '%�_���� ���������� _��_������_%'         or
            lower(nazn) like '%������ �� �������� _������� ������%'    or
            lower(nazn) like '%�_����� ������_����� �������%'
        )
   ) ;
end if;


-- ��� 219
 insert into tmp_file03
                (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
select * from
(
select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 219
from provodki_otc
where fdat between Dat1_ and Dat_
   and kv=980
   and nbsd like '100%'  and nbsk  like '3801%'
   and tt not in ('AAL','AAE')
) ;

-- ��� 318
if mfou_ not in (300120, 300205, 300465, 380764, 353575) then
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and (nbsd like '3522%' or nbsd like '7419%') and nbsk  like '3622%'
      and ( lower(nazn) like '%��%'                            or
            lower(nazn) like '%���%'                           or
            lower(nazn) like '%� ����.����%'                   or
            lower(nazn) like '%�_���������� ����� �� ����%'    or
            lower(nazn) like '%����������� ���� ����� �� ����_����� �����%'    or
            lower(nazn) like '%��_� �� ������.����.�����%'     or
            lower(nazn) like '%����%�� ������� �����_%'        or
            lower(nazn) like '%����%�� ����������� �����_%'    or
            lower(nazn) like '%��_�%�_� ���_��_%'              or
            lower(nazn) like '%����_������%����. �����������%' or
            lower(nazn) like '%����_������%����_��� �����������%'
          )
   ) ;
end if;

-- ��� 318
if mfou_ not in (300120, 300205, 300465, 380764, 353575) then
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and (nbsd like '100%' or nbsd like '2900%')  and nbsk  like '2902%'
      and ( lower(nazn) like '%��%'                            or
            lower(nazn) like '%���%'                           or
            lower(nazn) like '%0.5%� ����.����%'               or
            lower(nazn) like '%0.5%� ����_���� ����%'          or
            lower(nazn) like '%2%� ����.����%'                 or
            lower(nazn) like '%�_���������� ����� �� ����%'    or
            lower(nazn) like '%��_� �� ������.����.�����%'     or
            lower(nazn) like '%����%�� ������� �����_%'        or
            lower(nazn) like '%����%�� ����������� �����_%'    or
            lower(nazn) like '%��_�%�_� ���_��_%'              or
            lower(nazn) like '%����_������%����. �����������%' or
            lower(nazn) like '%����_������%����_��� �����������%'
          )
   ) ;
end if;

if mfou_ = 300120 then
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and (nbsd like '3522%' or nbsd like '7419%')
      and (nlsk like '3622800050%' or nlsk like '3622600003%')
   ) ;

    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and (nbsd like '100%' or nbsd like '2900%')
      and (nlsk like '2902700015%' or nlsk like '2902800061%')
   ) ;
end if;

if mfou_ = 300205 then
   -- insert into tmp_file03
   --                (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   --select * from
   --(
   -- select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
   -- from provodki_otc
   -- where fdat between Dat1_ and Dat_
   --   and kv=980
   --   and nbsd like '7419%'
   --   and (nlsk like '362289536%'or  nlsk like '362259537%')
   --) ;

   -- insert into tmp_file03
   --                (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   --select * from
   --(
   -- select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
   -- from provodki_otc
   -- where fdat between Dat1_ and Dat_
   --   and kv=980
   --   and (nbsd like '100%' or nbsd like '2900%')
   --   and (nlsk  like '290279566%' or nlsk  like '290249567%')
   --) ;

    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and nbsd like '100%' and nlsk  like '290249567%'
   ) ;

end if;

if mfou_ = 380764 then
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and (nbsd like '3409%' or nbsd like '3522%' or nbsd like '7419%')
      and nbsk  like '3622%'
      and ob22k in ('15','16')
   ) ;

    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and (nbsd like '100%' or nbsd like '2900%')
      and nbsk  like '2902%'
      and ob22k in ('06','07')
   ) ;

end if;

if mfou_ = 300465 then
   if dat_ <= to_date('31122014','ddmmyyyy') then
      insert into tmp_file03
                     (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
     select * from
     (
      select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
      from provodki_otc
      where fdat between Dat1_ and Dat_
        and kv=980
        and nbsd like '7419%' and nbsk  like '3622%'
        and ob22k in ('12','35')
      UNION
      select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
      from provodki_otc
      where fdat between Dat_ and Dat_ + 25
        and kv=980
        and vob = 96
        and nbsd like '7419%' and nbsk  like '3622%'
        and ob22k in ('12','35')
     ) ;

      insert into tmp_file03
                     (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
     select * from
     (
      select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
      from provodki_otc
      where fdat between Dat1_ and Dat_
        and kv=980
        and (nbsd like '100%' or nbsd like '26%' or nbsd like '2900%' or
             nbsd like '3541%' or nbsd like '3739%' or nbsd like '7399%')
        and nbsk  like '2902%'
        and ob22k in ('09','15')
     ) ;
   end if;

   if Dat_ > to_date('31122014','ddmmyyyy') then
      insert into tmp_file03
                     (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
       select * from
       (
        select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
        from provodki_otc
        where fdat between Dat1_ and Dat_
          and kv=980
          and nbsd like '100%'
          and nbsk  like '2902%'
          and ob22k in ('09','15')
       ) ;
   end if;

end if;

if mfou_ = 353575 then
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and nbsd like '7419%'
      and (nlsk like '362268007%' or nlsk like '362210107%')
   ) ;

    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and (nbsd like '100%' or nbsd like '2900%')
      and (nlsk  like '29027010%' or nlsk like '290230110%' or
           nlsk like '362210107%' or nlsk like '362268007%')
   ) ;

end if;

-- ��� 319
if mfou_ not in (300120, 300465, 380764, 353575) then
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 319
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and (nbsd like '2902%' or nbsd like '3622%') and nbsk  like '3739%'
      and ( lower(nazn) like '%��_� �� ����.����.����.�����%'              or
            lower(nazn) like '%��_� �� ����_���. ����. ����. �����%'       or
            lower(nazn) like '%� ���_��_ ������_�����_ _�������_ ������%'  or
            lower(nazn) like '%05%���_�_� ��� ���_��_ �����_%'             or
            lower(nazn) like '%� ���_��_ ���_�����_ _�������_ ������%'     or
            lower(nazn) like '%����_���� ��_�%'                            or
            lower(nazn) like '%��_�%� ��%'                                 or
            lower(nazn) like '%��_�%� ���%'
          )
   ) ;
end if;

if mfou_ = 300120 then
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 319
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv = 980
      and ( ( (nlsd like '2902700015%' or nlsd like '2902800061%') and nbsk  like '3929%' ) or
            ( (nlsd like '3622800050%' or nlsd like '3622600003%') and nbsk  like '3929%' )
          )
   ) ;
end if;

if mfou_ = 353575 then
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 319
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv = 980
      and ( ( (nlsd like '29027010%' or nlsd like '290230110%' or
               nlsd like '362210107%' or nlsd like '362268007%' ) and nbsk  like '3929%' )
          )
   ) ;
end if;

if mfou_ = 380764 then
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 319
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv = 980
      and ( (nbsd like '2902%' and nbsk  like '3739%' and ob22d in ('06','07')) or
            (nbsd like '3622%' and nbsk  like '3739%' and ob22d in ('15','16'))
          )
   ) ;
end if;

if mfou_ = 300465 then
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 319
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv = 980
      and ( (nbsd like '2902%' and nbsk  like '3739%' and ob22d in ('09','15')) or
            (nbsd like '3622%' and nbsk  like '3739%' and ob22d in ('12','35'))
          )
   ) ;
end if;

if mfou_ not in (380764) then
   -- �������� �������� �� 2900 �� 2900 � ������������ ���������� �������
   delete from tmp_file03
   where nlsd like '2900%' and nlsk like '2900%'
   and ( lower(nazn) like '%���������� ����� �������������%' or
         lower(nazn) like '%���������� ������� ����_�%'      or
         lower(nazn) like '%���������� ����_�%'              or
         lower(nazn) like '%������� ������� �������������%'  or
         lower(nazn) like '%������� �������%'                or
         lower(nazn) like '%������� ���������������� ��-�%'  or
         lower(nazn) like '%������� ������������� �������%'  or
         lower(nazn) like '%������� ��-� , �������������%'   or
         lower(nazn) like '%������� ��-� ������������� �� �������%'
       );
   --and lower(nazn) not like '%��������� ������� ��-� ������������� �� �������%';
end if;


-- �������� �������� �� 3801 �� 100 � ������������ ���������� �������
--delete from tmp_file03
--where nlsd like '3801%' and nlsk like '100%'
--and ( lower(nazn) like '%���������� ����_� ��_��� ��������%'
--    );

-- �������� �������� �� ������ ��������� (�������� "MUX")
   DELETE FROM tmp_file03 t
   WHERE t.nlsd like '3801%' and t.nlsk like '100%'
     and exists ( select 1
                  from provodki_otc o
                  where o.fdat between Dat1_ and Dat_
                    and o.ref = t.ref
                    and o.kv <> 980
                    and o.nbsd like '2909%'
                    and o.nbsk like '3800%');

-- �������� �������� �� ��������
   DELETE FROM tmp_file03 t
   WHERE ( (t.nlsd like '100%' and t.nlsk like '3801%') or
           (t.nlsd like '3801%' and t.nlsk like '100%')
         )
     and exists ( select 1
                  from provodki_otc o
                  where o.fdat between Dat1_ and Dat_
                    and o.ref = t.ref
                    and o.kv in (959,961,962,964)
               );

   DELETE FROM tmp_file03 t
   WHERE ( (nlsd like '100%' and nlsk like '3801%') or
           (nlsd like '3801%' and nlsk like '100%')
         )
     and ( lower (t.nazn) like '%959%' or lower (t.nazn) like '%xau%' or
           lower (t.nazn) like '%961%' or lower (t.nazn) like '%xag%' or
           lower (t.nazn) like '%962%' or lower (t.nazn) like '%xpt%' or
           lower (t.nazn) like '%964%' or lower (t.nazn) like '%xpd%' or
           lower (t.nazn) like '%�����%' or
           lower (t.nazn) like '%������%' or
           lower (t.nazn) like '%������%' or
           lower (t.nazn) like '%�����%'
         )
     and lower (t.nazn) not like '%�_���%';

   if mfou_ = 300465 then
      -- �������� �������� �� ��������
      DELETE FROM tmp_file03 t
      WHERE ( (t.nlsd like '100%' and t.nlsk like '3801%') or
              (t.nlsd like '3801%' and t.nlsk like '100%')
            )
         and exists ( select 1
                      from provodki_otc o
                      where o.fdat between Dat1_ and Dat_
                        and o.ref = t.ref
                        and (o.nbsd like '3801%' or o.nbsk like '3801%')
                        and (o.ob22d ='09' or o.ob22k = '09')
                    );

      -- �������� �������� �� 100 �� 3801 �������� I02, I03
      DELETE FROM tmp_file03
      WHERE ( (nlsd like '3801%' and nlsk like '100%') or
              (nlsd like '100%' and nlsk like '3801%')
            )
        and tt in ('I02','I03');

   end if;

-- �������� �������������� ��������
   DELETE FROM tmp_file03
   WHERE ( (nlsd like '100%' and nlsk like '3801%') or
           (nlsd like '3801%' and nlsk like '100%') or
           (nlsd like '100%' and nlsk like '2902%') or
           (nlsd like '2902%' and nlsk like '100%')
         )
     and ref in ( select o.ref
                  from tmp_file03 o
                  where o.tt = 'BAK');

-- �������� BAK ��������
   DELETE FROM tmp_file03
   WHERE ( (nlsd like '100%' and nlsk like '3801%') or
           (nlsd like '3801%' and nlsk like '100%') or
           (nlsd like '100%' and nlsk like '2902%') or
           (nlsd like '2902%' and nlsk like '100%')
         )
     and tt = 'BAK';

-- � 01.01.2015 ���������� 118,119,218 �� ������ �������������
-- ��������� ��� 218 ��� �������� �������������� �������� (�������� "BAK")
if Dat_ > dat_izm1 then
   -- �������� ���� 218
   DELETE FROM tmp_file03
   WHERE isp = 218;
end if;

-- �������� ���� �� ����������� �����
if mfou_ = 300120 then
   DELETE FROM tmp_file03
   WHERE nlsd like '100%' and nlsk like '3801%'
     and tt in ('�2', '�_2') ;
end if;

if mfou_ = 380764 then
   DELETE FROM tmp_file03
   WHERE nlsd like '29002300386007%' and nlsk like '29002300386502%' ;

   DELETE FROM tmp_file03
   WHERE nlsd like '100%' and nlsk like '3801%'
     and tt = 'AA8' ;

   --DELETE FROM tmp_file03
   --WHERE nlsd like '2900%'
   --  and (nlsk like '2900%' and nlsk not like '29002300386007%' and nlsk not like '29002300386502%') ;

   delete from tmp_file03
   where (nlsd like '29002300386007%' or nlsd like '29002300386502%')
     and nlsk like '2900%'
     and isp = 118;

   -- �������� �������������� ��������
   DELETE FROM tmp_file03 t
   WHERE t.tt = '013'
     and ( (t.nlsd like '2909%' and t.nlsk not like '20%' and t.nlsk not like '1919%') or
           (t.nlsd like '3739%' and t.nlsk like '3801%') or
           (t.nlsd like '3801%' and (t.nlsk like '3579%' or  t.nlsk like '6397%'))
         )
     and exists ( select 1
                  from operw o
                  where o.ref = t.ref
                    and o.tag like 'D1#E0%'
                    and NVL(trim(o.value),'0') = '0');

   for k in ( select ref, s
              from tmp_file03
              where (nlsd like '29002300386007%' or nlsd like '29002300386502%')
                and nlsk like '2900%'
                and nlsk not like '29002300386007%' and nlsk not like '29002300386502%'
                and ( lower(nazn) like '%������� ������� �������������%'                    or
                      lower(nazn) like '%���������� ����� �������������%'                   or
                      lower(nazn) like '%���������� ����_� ���_���� � ������������ ������%' or
                      lower(nazn) like '%������� ���������������� ��-�%'                    or
                      lower(nazn) like '%��������� ������� ��-�%'                           or
                      lower(nazn) like '%������� ��-� , �������������%'                     or
                      lower(nazn) like '%������� ��-� ,�������������%'                      or
                      lower(nazn) like '%������� ������������� ������� �� �������%'         or
                      lower(nazn) like '%������� ��-� ������������� �� �������%'
                    )
            )
      loop

         update tmp_file03 t set ISP=119, t.s = 0 - t.s
         WHERE t.ref = k.ref
           and t.s = k.s ;

      end loop;

end if;

-- �������
OPEN OPL_DOK;
LOOP
   FETCH OPL_DOK INTO tt_, accd_, nls_, kv_, acck_, nlsk_, ref_, data_, sum1_, ddd_, nazn_ ;
   EXIT WHEN OPL_DOK%NOTFOUND;

   IF SUM1_ != 0 then

      IF ddd_ in ('118','119','219','318') THEN
         nls1_:=nls_;
         acc_:=accd_;
      ELSE
         nls1_:=nlsk_;
         acc_:=acck_;
      END IF;

      IF mfou_ = 380764 and
         (nls_ like '29002300386007%' or nls_ like '29002300386502%')
         and nlsk_ like '2900%'
         and ddd_ in ('118','119') THEN
         nls1_:=nlsk_;
         acc_:=acck_;
      END IF;

      IF nls_ like '7419%' and nlsk_ like '3622%'
      THEN
         BEGIN
            select accd
               into acc_
            from provodki_otc
            where ref = ref_
              and nlsd like '100%'
              and rownum = 1;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            BEGIN
               select acck
                  into acc_
               from provodki_otc
               where ref = ref_
                 and nlsk like '100%'
                 and rownum = 1;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               null;
            END;
         END;
      END IF;

      -- ���������� ��� �������
      if typ_ > 0 then
         nbuc_ := nvl(f_codobl_tobo(acc_,typ_),nbuc1_);
      else
         nbuc_ := nbuc1_;
      end if;

      if ddd_ = '319' then
         nbuc_ := nbuc1_;
      end if;

      kodp_:= '1' || ddd_ || '000' ;
      znap_:= TO_CHAR(sum1_);

      comm_ := substr('TT = '||tt_ ||' �� = ' || nls_ || ' �� = ' || nlsk_ || ' Ref = ' || to_char(ref_) || ' Nazn = ' || nazn_, 1, 200);

      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, comm, ref) VALUES
                             (nls1_, kv_, data_, kodp_, znap_, nbuc_, comm_, ref_);
   END IF;

END LOOP;
CLOSE OPL_DOK;
---------------------------------------------------
DELETE FROM tmp_nbu where kodf=kodf_ and datf=dat_;
---------------------------------------------------
OPEN basel;
   LOOP
      FETCH basel
      INTO nbuc_, kodp_, sum0_;
      EXIT WHEN basel%NOTFOUND;

      IF sum0_<>0 then

         -- �����
         INSERT INTO tmp_nbu
              (kodf, datf, kodp, znap, nbuc)
         VALUES
              (kodf_, Dat_, kodp_, to_char(sum0_), nbuc_) ;

      end if;

   END LOOP;
CLOSE basel;
----------------------------------------
END p_fE0_NN;
/
show err;

PROMPT *** Create  grants  P_FE0_NN ***
grant EXECUTE                                                                on P_FE0_NN        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FE0_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
