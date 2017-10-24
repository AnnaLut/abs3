 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/zvt_f.sql =========*** Run *** ====
 PROMPT ===================================================================================== 

CREATE OR REPLACE FUNCTION BARS.ZVT_F (NBSD_    VARCHAR2,          -- �� �����
                                       NBSK_    VARCHAR2,         -- �� ������
                                       BRD_     VARCHAR2, -- ����� �����-�����
                                       BRK_     VARCHAR2, -- ����� �����-������
                                       tt_      VARCHAR2, -- ��� �������� �� OPLDOK
                                       MFOA_    VARCHAR2,         -- OPER.MFOA
                                       MFOB_    VARCHAR2,         -- OPER.MFOB
                                       TTO_     VARCHAR2 -- ��� �������� �� OPER
                                                        )
   RETURN INT
   RESULT_CACHE

IS


/*
06.04.2017 COBUSUPABS-5756
�� ����� 26 ������� ��������� � ����� 84 ����.: ������ ������� (�������) �������� BM4 �� �������� BMY � ��������� �� ������� ������� 2909/23 � �������� 6399/14.

2017-02-07   COBUSUPABS-5433


1.    ��  ����� 20 ��������� �������� ������ �� ������� �볺��� ��������� � ����� 97 ����.����������� �������� �� ����� PS1.
2.    �� ����� 37 ����������� (������������) ������ ��������� � �����  80 ����. ����������� �������� �� ����� 38Z.
3.    �� ����� 13 �������� �λ, 15 �������� �λ  ��������� � ����� 80 ����. �����������.����������� �������� �� ������ ASG, ASP, ISG
4.     �� ����� 4 ������� �λ (�/�) ��������� � ����� 13 �������� �λ ������������ �������� � ��������������� ������� �� ������� 22 ��. � �������� 2620; ������� 2620 � �������� 22 ��., 6397.
5.     �� ����� 26 ������� �� ���������� � �볺����� ��������� � ����� 84 ����.: ������ �������� BN4 (��������� �� BNY ��������� �� (�� �������) �� ��������� ����� �� (���. ������ �� 2909 �� 6399));
6.    "�������� �2� �� 3739 �� 6110 ��������� � ����� 84, ����� �������� ������ � ����� 26 (�� ���������� ����� �� ����. ��������� ���) "




   ��������� ���� ����� ������ COBUSUPABS-4414.
2016_08_18
ARE. ��� ���������� ��������������� �������� ��������� ���, ������������� �������� �� ���������� � ����� � 87 (�� 2401 �� 7702) �� � � -87 (�� 7702 �� 2401)
2016_08_08
164. ��� ���������� ��������������� �������� ��������� ���, ������������� �������� �� ���������� � ����� � 35

2016_05_24
00J. ��� ���������� ��������������� �������� ��������� ���, ������������� �������� �� ���������� � ����� � 10

2016_04_28
455. ��� ���������� ��������������� �������� ��������� ���, ������������� �������� �� ���������� � ����� � 27 "�������".

2016_04_27

 1. NG1 � ��� ��������������� �������� ������������ ��� ���� �������� ������� �������� � ����� 35 (����� ������ � ����� 37).
   2. �� �������� DOR � ������� �������� DO2 �� ���� ���, ��� ���������� ��������������� �������� ������������ ���, �� ������� � ����� 37 (����� ������ � ����� 80)


2016_03_28
   �13/1-03/2680�� 25/03/2016  -����������������� 163 (���. ������ �� 3906 �� 1007) � ����� 37 ����������� (������������) ������ ��������� � ����� 80 ����:�����������.



   2016_02_xx
   �������� ����(�� ������ COBUSUPABS-4312):
   �� ����� 37 ����������� (������������) ������ ���������:
-    � ����� 80 ����. ����������� �������� �� ����� ASG � ��������� �� ������� ������� 3739 �� �������� 357 ����� �������; �17 ��������� �� ������� ������� 3739 �� �������� 2809; %�� ��������� �� ������� ������� 3904 �� �������� 3800;
-    � ����� 35 ����������� (�볺�����) ������ �������� �� ����� CV7;
-    � ����� 97 ����.����������� - �������� �� ����� PS1 � ���������� �� ������� ������� 25, 26��.,2909 �� �������� 25,26.

�� ����� 20 ��������� � ����� 32 ������� (������+����) �������� �� ����� �00 � ��������������� ������� �� ������� 2902 �� �������� 25 � 26 ��.
�� ����� 30 ��������� � ����� 14 ��� WAY4� �������� �� ����� OW3.


2016_02_12
    �� ��������� N12 �� �������� ������� ���������� �� �������������� ���������� �������� ������� �������� ��� � 2620/05
    � ��������� �����, ������������ �������� �� ���� ���������� ������� ���� (����� ���.� 3801/03; ������ ���.� 6110/F1),
    �������� � ����� � �26 � ������ �� ��������� � ����� � �84 � ���.:������.



   ���������� �� �������� ��������� ��� (18.09.2015)

         1. �� ����� 37 ����������� (������������) ������ ���������:
        � � ����� 80 ����: �����������
        - �������� �� �����: �00; CND; �2P; �2� (���.������ �� 3739 �� 3600); %15; MIL
        � � ����� 20 ��������� �������� �� ������� �볺���
        - �������� �� ����� 901 � ��������������� ������� �� ������� 3720 �� �������� 2 ��.;
        � � ����� 26 �������
         � � ����� 84 ����.������
        - �������� �� ����� �05 (���. ������ �� 3570 �� 6110)
        � � ����� 35 ����������� (�볺�����) ������
        - �������� �� ����� 301.

   -- 17.03.2015
      -- ��� ���������� ���� �� �������� ��������� ��� � �������� ��������
      -- ��� ��� ������������� ����� �������� ����� - '2570','2571','2572' ������ '1001','1002'
      -- ������ ����� � �5� �� �10�;
      --12,03,2015
      --��� ���������� ���� �� �������� ��������� ��� � �������� ���������
      --MUO���� ������������� ����� �������� � ����� ���.� 3739, ������ ���.� 3801,
      --������ ����� � �35� �� �80�;

   2015-01-30 nvv  �� ����. 024 �� 2608 �� 2604 ����� ������� � ����� 20 ��������� � ����� 80.
                ���������� ������ � ����������� ���.
               1.    ����. %15 � ����� 19 ���.������: �� 2608  �� 3622; �� 2608 �� 3800
               ��������� � ����� 80. �ᒺ�� �������� ����� � �������������� �� ��������.
               2.    ����. %15 � ����� 4  ���.������: �� 2628, 2638 �� 3622; �� 2628,2638 �� 3800
               ��������� � ����� 80. �ᒺ�� �������� ����� � �������������� �� ��������
               3.    ����. MIL � ����� 4 ���.������: �� 2628, 2638 �� 3622; �� 2628, 2638 �� 3800  ��������� � ����� 80.
               4.    ����. MIL � ����� 35 ���.������: �� 3801 �� 3622 ��������� � ����� 80.
               5.    ����. MIL � ����� 19  ���.������: �� 2608  �� 3622; �� 2608 �� 3800 ��������� � ����� 80.
                   ����. DU1 � ����� 20 ��������� � ����� 80

   2014-10-07 NVV  ��������� 901 ��������  � ����� 80, � ������� � � ����� 35.
                   � ����� ��������������  PS2 (3622, 2902) ��  ������� � �� ����� � 35 �����


   2014-08-21 NVV �������� ������� �������� <SchevchenkoSI@oschadbank.ua>

   ���. �������� ��������� � ��� ���� �����, ��� ���� ���� � ��� �����.
   1.    27 �������� ���. ������ ��/��  ��� 7702, 7720 � �������������� � ���. 3801
   2.    80 ����. ����������� - ��/��  3800 � ������. � ���. 2400
   3.    87 ����. ������- �� 7720,7702 �� 3599, 2400 � ������.
   ��� ���� � ��� ��������� ��� ����. AR*, ARE.
   ³��, �� ������ �� ��������, ���� �� �������� �� �����. ������� ������ �������� � ���� ����� 87  ����. ������???



   2014-06-17  NVV -  �������� ������� �������� <SchevchenkoSI@oschadbank.ua>
   ����. 405 �� �� �������� ��������: G05 � ������
   � 19 ����� (�� 2600 �� 3570),
   �� �05 ������ � 26 ����� (�� 3570 �� 6110).
   ��� ����� �05 (�� 3570 �� 6110) ��������� � ����� 84 ����. ������.


   05.02.2013 Sta - ������ �� �������� � ���
                  - ������ ����� ��� 4-�� �� � 1
                  - � �� (� 8) �������� 3541 + 3641
                  - �������� ������� �� �� +��

   � ������������_�� ������_� 2641, 2642,2643 ��������� � 30 �����, � ����_��� � 19. �/� �������� �._.���. 247-85-0333-38
   ('15','16','39') %%1 ������� � �����  91-92

           ���������� �������� ���������� ��������� ���, �� �������� � 76 ������, �� �� ����� �������� �������.
           1.    � ����� 35 ����������� (�����)� �������� �������� �� ����� PKR �� �������� � ����� 86 ����:2924-�����������.
           2.    � ����� 30 ����� (�������� ���)� �������� �������� �� ����� KL2 � ��������������� ������� ������� ������� (2062, 2063 �� ��.) �� ��������� � ����� 15 ��������.
           3.    � ����� 83 ����: �����. � KL1� �������� �������� � ��������������� ������� ������� ������� (2062, 2063 �� ��.) �� ��������� � ����� 15 ��������.
           4.    � ���������� ������������� �� �������� ����� 41 ����������� �����������. � ���������� ������ ����������� �������� �0�.
   *********

           ³� ����:    ���������� ��������� ����������-��������� ������������ ��������������� ����� �������� �.�.
           ����    25.09.2013
           REF �:    13/1-03/201


           1.    � �������� ��������� ��� ���. ���������� ����� 26 ������� �� 27 �������� � ���������� ������������� �������� ������ �1�  �� �������������� �� �� ������� �������.
           2.    ����� 97 ����. �����������.
           -    �� �������� �� ����� PS1 ���. �������� � ��������������� ������� �� �������� �� ������� 6, 7 ����� ��������� � ����� 26 ������� �� 27 �������� ��������;
           -    �� �������� �� ����� PS1 ���. �������� � ��������������� ������� �� ������� 29, 35, 36 ������ �� �������� ������� 25, 26 ������ �������� � ������������ ������ ����� 20 ��������� �������� ������ �� ������� �볺��� (����� ��)�, ��� ���� �� ��������� �� 21 �����. �� ������������ 20 ����� �������� ���� ���� ��������  �������������������� ����������� ����� �� ������� �볺��� (�� 2600, 2603, 2605, 2560, 2650) � �.�. ��.OW1 (���. �������� �� 2924/16 �� 2600, 2605, 2650) �� �������� �� ����� 024 (���. �������� �� 2909 �� 2560, 2600, 2603, 2650). ���������� ���������� ����� ���������: �� �� �������� ������ �� �260%�, �25%�, �265%�, �264%�; ��� �������� �� ���� �� (PS0, PS2).
           3.    �� ����� 35 ����������� (�����) �������� �� ����� 38V �������� �������� ������� �������� ��������� � 80 ����.�����������.
           4.    � ����� 96 ����:�������� �� ��ʻ �������� �� ����� PKA, PKD, PKQ, PKG, PKH, PKR, PKS, PKX, PKE, PKU, PKY, PKZ �������� � ����� 86.
           5.    � ������� ������ (15 ��������, 26 �������, ������� � ����, ��� �� �� (����� 27 ��������, 30 ����� (�������� ���))� ���������� ����) � �������� �� ��������� �� � ���������� ������� �� ������ ���������� ������ ����������� �� �������, � ��������� �� ��������.
           6.    � ����� 45 ����������� ����� ����������� ������������ � ��������������� ������� �� ������� 9900 �� �������� 9129 � ������� �� ��������� �� ����� OW1. ���������� � ����� 98 ����: ���������� �����.
           7.    ����� 45 ����������� ����������� �� �������� � ���������� �������������. ��� ����� ����������� �������� ������ �0�.

        ===========================================
      21.08.2012 ���� �_� 10,08,2012 � 14/2-1/1969

      �� 07.05.2012 17:14 �������� �.I. [SchevchenkoSI@oschadnybank.com]
         � ������� �� ���������_ ��������_� �� ������ �� WEY4.
         ����i��� �������� ���� ����� i �������� ��i ���. �������� �� ��  WEY4
         �� ����������� �� 2924/16 �� 2600 + �/� �� ����� �i����������� ��������
                     �� �� 2924 �� 1004.
         ���. 247-85-03 33-38

      �������    12-11-2011   ������_� 976 ���������_�  �� ������ �����_������ ����� _    �� �� � ��������� ������������
      ������_� ������ � 41 ����� ���������� ������    �����_��� ���_����� � ����� 45 ���������� _����

   1. � ����� 41 ��������� ���. �������� � ������������i��  �� �� i �� 9760,
      �� ����� �����i��� ��������� � ����� 45,

   2. ������� 2620/07 �� ����������� � ���i ����� � ��������� 2600,
      ��� ������i������� �������i ���� ��������� � ����� 30 I��i,
      ����� �� �i��������� �� ��� �� �� I����, � �� ��������� 2600.

   08-06-2011 ����� 32 - ��� ��� ������� ���� ��
   22-07-2010 ����� �������� �.�. +��������
      1) �������������� �����
        - ���������� ����� 19+20  � ���� � � 19
        - ����� �������.3801-6204 � ����� 93
        - ������� 3801-7041        � ����� 4
        - ����i���� ����� 35 �� ���:
          80) ���� , �������� ��� �� 'AR_','I0_'
          35) ������ - ���������
      2) �������������� ������
        ���i�� ������ ���� : �����  = �i��� ���������� ������i�.
        ����� �������� ���������� ��� ������� ��������,
        � ����:  ��� ������ �������� �����  = �i��� �������� ������� ����.
        ���� ������ ���.�����s,
        �� �������� ���� � ����� ����, ������� i ���� �������� �� ������-2
        i �� ���� �i���������� � ����i  ���� ������. �� ������-3,
        �.�. ���.�������� ������ �������� ����� ��������
        ���� � ���i� i� ��i� �������� �����
        � �i��������� ������� �� ������ ���������� �������.


   31-05-2010 Sta ���� �������� �.�.
   28-05-2010 Sta
    1) � ��� 21 ��.��. (�i�.��.)
                ����������  ���.70*     - ���.25*,26*  ;  ���.25*,26* - ���.70*
                �� ������ � ����� 27 �������.

    2) � ��� 96 ���: ���
                ����������  ���.7452    - ��� 3550, 2924
                �� ������ � ����� 27 �������.


   25-05-2010 Sta.� c���� � ������� (�� 21.05.2010, REF � 13/1-03/80 )
   27-04-2010 Sta ����� ���� � ��������� ������ +��������
   06-04-2010 Sta
              �������������� ����� ��� ����������� ������� �����
              ��������� ����� ����� � 3 ������ (��������) ��
   *******************************************************
   */

   t_      INT;                                      -- ��� ����� ��� ��������
   flag_   VARCHAR2 (1);           -- ���� �������� ����������� 0 - ������ - 1

   l_BRD   INT := LENGTH (BRD_);                   -- ����� ������ �����-�����
   l_BRK   INT := LENGTH (BRK_);                  -- ����� ������ �����-������
BEGIN
   SELECT SUBSTR (flags, 1, 1)
     INTO flag_
     FROM tts
    WHERE tt = tt_;


   IF NBSd_ LIKE '8%'
   THEN
      t_ := 99;
      RETURN t_;
   END IF;                                                          -- 8 �����

   IF NBSd_ LIKE '4%' OR nbsk_ LIKE '4%'
   THEN
      t_ := 1;
      RETURN t_;
   END IF;                                                          -- 4 �����

   ---------------------------------------------------------
   -- 9 �����
   IF NBSd_ LIKE '9%'
   THEN
      IF '9760' IN (NBSd_, NBSk_)
      THEN
         t_ := 45;
      ELSIF tt_ IN ('CR9', 'O99')
      THEN
         t_ := 98;
      ELSIF tt_ = 'OW1' AND (NBSd_ = '9129' OR NBSk_ = '9129')
      THEN
         t_ := 98;
      ELSIF (l_BRD > 15 OR l_BRK > 15)
      THEN
         t_ := 41;
      ELSIF (   NBSD_ LIKE '98%' AND l_BRD = 15
             OR NBSK_ LIKE '98%' AND l_BRK = 15)
      THEN
         t_ := 40;
      ELSE
         t_ := 45;
      END IF;

      RETURN t_;
   END IF;

     
   
   -----------------------------------------------------------
   -- 1-7 ������

   --------- �������� ������������   instr(tt_, '%') > 0
   IF tt_ IN ('%%1') AND (nbsd_ LIKE '2%' OR nbsk_ LIKE '6%'              --or
                                                            --substr(nbsd_,1,2) in    ('15','16','39','14','30','31','32')
                         )
   THEN
      t_ := 91;                                          -- ���:���.% �� ����.
   ELSIF tt_ IN ('%%1', 'DU%') AND (nbsk_ LIKE '2%' OR nbsd_ LIKE '7%'    --or
                                                                      -- substr(nbsk_,1,2) in ('15','16','39','14','30','31','32')
                                   )
   THEN
      t_ := 92;                                           -- ���:���.% �� ���.
   ELSIF tt_ = 'DBF'
   THEN
      t_ := 81;                                              --ABT:�����.� DBF
   ELSIF tt_ IN ('ALT', 'ALK')
   THEN
      t_ := 82;                                              --ABT:�����.� ALT
   ELSIF tt_ IN ('PFR', 'PFD', 'PFX')
   THEN
      t_ := 50;                                              -- ��������� ���
   ELSIF tt_ = 'CRV'
   THEN
      t_ := 9;                                                  -- �����������
   ELSIF     tt_ IN ('DU1')
         AND MFOA_ = MFOB_
         AND (   SUBSTR (nbsk_, 1, 3) IN ('260', '265', '264')
              OR SUBSTR (nbsk_, 1, 2) IN ('25'))
   THEN
      t_ := 80;
   ELSIF     tt_ IN ('R01', 'I00', 'ZG9', '%%9')
         AND NBSd_ LIKE '7%'
         AND SUBSTR (NBSd_, 1, 2) NOT IN ('73', '74')
   THEN
      t_ := 85;                                                --���.: �������
   ELSIF     tt_ IN ('R01', 'I00', 'ZG9', '%%9')
         AND NBSk_ LIKE '7%'
         AND SUBSTR (NBSk_, 1, 2) NOT IN ('73', '74')
   THEN
      t_ := -85;                                               --���.: �������
   ELSIF     tt_ IN ('R01', 'I00', 'ZG9', '%%9', 'IRR', '%MB', 'ELT','N12')
         AND NBSd_ LIKE '6%'
   THEN
      t_ := 84;                                                 --���.: ������
   ELSIF     tt_ IN ('R01', 'I00', 'ZG9', '%%9', 'IRR', '%MB', 'ELT','N12')
         AND NBSk_ LIKE '6%'
   THEN
      t_ := -84;                                                --���.: ������

   ELSIF     (tt_ LIKE 'AR_' OR tt_ = '096')
         AND SUBSTR (NBSd_, 1, 2) IN ('77', '38')
         AND NBSk_ IN
                ('1490',
                 '1491',
                 '1890',
                 '2400',
                 '2890',
                 '3801',
                 '3190',
                 '3290',
                 '3590',
                 '3599',
                 '3690')
   THEN
      t_ := -87;                                               --���.: �������
   ELSIF     (tt_ LIKE 'AR_' OR tt_ = '096')
         AND SUBSTR (NBSk_, 1, 2) IN ('77', '38')
         AND NBSd_ IN
                ('1490',
                 '1491',
                 '1890',
                 '2400',
                 '2890',
                 '3801',
                 '3190',
                 '3290',
                 '3590',
                 '3599',
                 '3690')
   THEN
      t_ := 87;

ELSIF
TT_='ARE' AND (nbsd_='7702' and nbsk_='2401')
  THEN
         t_ := -87;

ELSIF
TT_='ARE' AND (nbsd_='2401' and nbsk_='7702')
  THEN
         t_ := 87;
                                               --���.: �������
   ELSIF     tt_ IN ('%15', 'MIL')
         AND nbsd_ IN ('2608', '3801', '2628', '2638')
         AND nbsk_ IN ('3622', '3800')
   THEN
      t_ := 80;
   ELSIF     tt_ IN
                ('RT0',
                 'R02',
                 'D00',
                 'D02',
                 'D01',
                 'DT0',
                 'DT1',
                 'R01',
                 'R00',
                 'RT1')
         AND (   (nbsd_ LIKE '3%' AND nbsk_ LIKE '3%')
              OR (nbsd_ LIKE '1%' AND nbsk_ LIKE '3%')
              OR (nbsd_ LIKE '3%' AND nbsk_ LIKE '1%'))
         AND mfoa_ IS NULL
   THEN
      t_ := 89;                                                --ABT:��� �� ��
   ELSIF     tt_ IN ('PVP', 'SPM', 'RET', 'REV')
         AND SUBSTR (NbSD_, 1, 1) = 9
         AND SUBSTR (NbSk_, 1, 1) = 9
   THEN
      t_ := 90;                                   -- ���:������i��� ����������
   ELSIF    tt_ IN ('PVP', 'SPM', 'RET', 'REV')
         OR (NbSD_ IN ('3801', '6204') AND NbSk_ IN ('3801', '6204'))
   THEN
      t_ := 93;                                              -- ���:������i���
   ELSIF tt_ = 'RKO'
   THEN
      t_ := 94;                                          -- ���:���.���.�� ���
   ELSIF tt_ = 'OVR'
   THEN
      t_ := 95;                                               -- ���:���������
   ELSIF tt_ IN ('PKA', 'PKD', 'PKR','PKQ')           THEN      t_ := 36;   -- ���:���������� �����
   -- �������� ������ ���
   ELSIF     NbSD_ IN ('2625', '2605')    AND NbSK_ = '2924'
             AND SUBSTR (tt_, 1, 2) NOT IN ('KL')      THEN  t_ := -86;     -- ���:(2924<->2625)
   ELSIF     NbSK_ IN ('2625', '2605')    AND NbSD_ = '2924'
             AND SUBSTR (tt_, 1, 2) NOT IN ('KL')      THEN  t_ :=  86;      -- ���:(2924<->2625)



   --4.     �� ����� 4 ������� �λ (�/�) ��������� � ����� 13 �������� �λ ������������ �������� � ��������������� ������� �� ������� 22 ��. � �������� 2620; ������� 2620 � �������� 22 ��., 6397.
   elsif (NBSd_ like '22%'
         AND NBSk_ ='2620')
   then t_:= 13;

   elsif ((NBSk_ like '22%' or NBSk_='6397')
         AND NBSd_ ='2620')
   then t_:= -13;



   --------- �������� ������ -----
   ELSIF     NBSd_ IN ('3801', '7041')
         AND NBSk_ IN ('3801', '7041')
         AND tt_ NOT LIKE 'OW_'
   THEN
      t_ := 4;                                               -- ������ �� (�/�
   ELSIF     NBSd_ IN ('2620', '2630', '2635', '2628', '2638')
         AND tt_ NOT LIKE 'OW_'
   THEN
      IF NBSk_ IN ('1001', '1002')
      THEN
         t_ := -3;                                          -- ������ �� (���)
      ELSE
         t_ := -4;                                           -- ������ �� (�/�
      END IF;
   ELSIF     NBSk_ IN ('2620', '2630', '2635', '2628', '2638')
         AND tt_ NOT LIKE 'OW_'
   THEN
      IF NBSd_ IN ('1001', '1002')
      THEN
         t_ := 3;                                           -- ������ �� (���)
      ELSE
         t_ := 4;                                            -- ������ �� (�/�
      END IF;
  ELSIF ( ( tt_ IN ('���')
          AND NBSd_ IN ('2570', '2571', '2572')
          AND NBSk_ IN ('1001', '1002') )or
       (    tt_ IN ('00J')
          AND NBSk_ IN ('2570', '2571', '2572')
          AND NBSd_ IN ('1001', '1002')))
   THEN
      t_ := 10;
   --------- �������� ����� -----
   ELSIF     (NBSk_ LIKE '100_' OR NBSk_ LIKE '110_')
         AND NBSk_ NOT LIKE '___7'
         AND NBSk_ NOT LIKE '___4'
   THEN
      -- ����� �� ������� � �������� (������), ����� ������
      IF l_BRK = 15
      THEN
         t_ := -5;                                               -- ���� ����.
      ELSE
         t_ := -10;                                              -- ���� ����.
      END IF;
   ELSIF     (NBSd_ LIKE '100_' OR NBSd_ LIKE '110_')
         AND NBSd_ NOT LIKE '___7'
         AND NBSD_ NOT LIKE '___4'
   THEN
      -- ����� �� ������� � �������� (������), ����� ������
      IF l_BRD = 15
      THEN
         t_ := 5;                                                -- ���� ����.
      ELSE
         t_ := 10;                                               -- ���� ����.
      END IF;
   ELSIF nbsd_ = '1004'
   THEN
      t_ := 12;                                               -- ����-��������
   ELSIF nbsk_ = '1004'
   THEN
      t_ := -12;                                              -- ����-��������
   --08.05.2012
   --ElsIf  (nbsd_ ='2924' and nbsk_ ='2625')
   --       or (nbsk_ ='2924' and nbsd_ ='2625')                 then t_:= 86;
   ELSIF tt_ in ('OW3','OWI')
   THEN
      t_ := 14;

   ELSIF tt_ LIKE 'OW_' --and NOT (nbsd_='2924' and nbsk_='2600')
         AND mfoa_ = mfob_
   THEN
      t_ := 14;                                                   --   �� WEY4
   ELSIF (tt_ LIKE 'PK_' OR tt_ = 'R03') AND tt_ NOT IN ('PKK')
   THEN
      IF nbsd_ = '7452' AND nbsk_ IN ('3550', '2924')          THEN  t_ := 27;     -- �������
      -- 28-05-2010 � ��� 96 ���: ���
      -- ����������  ���.7452  - ��� 3550,2924
      -- �� ������ � ����� 27 �������.
      ELSIF tt_ IN  ('PKA', 'PKD', 'PKQ', 'PKG', 'PKH',
                     'PKR', 'PKS', 'PKX', 'PKE', 'PKU',
                     'PKY', 'PKZ')                             THEN   t_ := 86;                                                          --
                                                               ELSE   t_ := 96;  -- ���:�������� �� ���
      END IF;
   -- ������
   ELSIF     (NBSd_ LIKE '22%')
         AND tt_ IN  ( '015', '013',
                      'KK1', 'KK2', 'KK4', 'KK5', 'KL1',
                      'KL2', 'IB1', 'IB2', 'SNO',
                      '096')                                  THEN    t_ := 13;  --������� ��
   ELSIF     (NBSk_ LIKE '22%')
         AND tt_ IN  ( '015', '013',
                      'KK1', 'KK2', 'KK4', 'KK5', 'KL1',
                      'KL2', 'IB1', 'IB2','SNO',
                      '096')                                  THEN    t_ := -13; --������� ��
    ELSIF     (NBSd_ LIKE '20%' OR NBSd_ LIKE '21%')
         AND tt_ IN
                (
                 '015',
                 '013',
                 'KK1',
                 'KK2',
                 'KK4',
                 'KK5',
                 'KL1',
                 'KL2',
                 'IB1',
                 'IB2',

                 'SNO',
                 '096')
   THEN
      t_ := 15;                                                   --������� ��
   ELSIF     (NBSk_ LIKE '20%' OR NBSk_ LIKE '21%')
         AND tt_ IN
                (
                 '015',
                 '013',
                 'KK1',
                 'KK2',
                 'KK4',
                 'KK5',
                 'KL1',
                 'KL2',
                 'IB1',
                 'IB2',

                 'SNO',
                 '096')
   THEN
      t_ := -15;                                                  --������� ��
   ---
   ELSIF     SUBSTR (TT_, 1, 2) IN ('KL', 'IB')
         AND (   NBSD_ LIKE '260%'
              OR NBSD_ LIKE '25%'
              OR NBSD_ LIKE '265%'
              OR NBSD_ LIKE '2909')
   THEN
      t_ := 25;                                                 -- ��i���-����
   ELSIF TT_ IN ('KL1')
   THEN
      t_ := 83;                                                  --�����.� KL1
   -- 2015-01-16
   -- 024 ���.������: �� 2528, 2538, 2548, 2568,2608, 2658  �� 252 ��., 253 ��., 254 ��., 2600, 2650, 2560, 2604 ��������� � ����� 80

   ELSIF     tt_ = '024'
         AND nbsd_ IN ('2528', '2538', '2548', '2568', '2608', '2658')
         AND (   SUBSTR (nbsk_, 1, 3) IN ('252', '253', '254')
              OR nbsk_ IN ('2600', '2650', '2560', '2604'))
   THEN
      t_ := 80;
   --2016_04_28
   ELSIF TT_ IN ('455')
   THEN
      t_ := 27;

   --07-10-2013
   ------
   ELSIF regexp_like(nbsd_,'^(639[4,5,6]|64)')            then t_ :=-38;
   elsif regexp_like(nbsk_,'^(639[4,5,6]|64)')            then t_ := 38;
   ELSIF regexp_like(nbsd_,'^(739[2,4,5,6,7,9]|74|7900)') then t_ :=-39;
   elsif regexp_like(nbsk_,'^(739[2,4,5,6,7,9]|74|7900)') then t_ := 39;

   ELSIF tt_= '101'
         and   nbsd_ IN ('3570', '3739', '3600')
         and   nbsk_ IN ('3570', '3739', '3600')
        then  t_:= 35;

   --NG1 � ��� ��������������� �������� ������������ ��� ���� �������� ������� �������� � ����� 35

   ELSIF tt_= 'NG1' then  t_:= 35;

   ELSIF tt_= 'D66'
         and   nbsd_ IN ('3579', '3739')
         and   nbsk_ IN ('3579', '3739')
         then t_ :=35;

   ELSIF tt_= 'D07'
         and   nbsd_ IN ('3800')
         and   nbsk_ IN ('2924')
   then t_ :=80;


    --25/07/2015
    --   ����� 20 ��������� �������� ������ �� ������� �볺���:
    --    ������������ �������� � ��������������� ������� �� �� ������� �3500, 3510, 3519, 3610, 3619, 3653, 3678�  �� �� �� �������� ������ �� �260%� ���������� � ����� �� ��������� � ���� ����� ��������� �������� �� �������������� ����������;

   ELSIF tt_ = 'PS1'
         AND (    SUBSTR (nbsd_, 1, 2) IN ('29', '35', '36')
              AND SUBSTR (nbsk_, 1, 2) IN ('26', '25'))
         then

        if nbsd_ IN ('3500', '3510', '3519', '3610', '3619', '3653', '3678') AND (   SUBSTR (nbsk_, 1, 3) ='260')
           THEN
           t_ := 23; -- 23 �������� �������� �� �������������� ����������
           else
           t_ := 97; -- 20 �������� �������� ������ �� ������� �볺��� ����� ��

      end if;

   ELSIF tt_ = 'PS1'
         AND (SUBSTR (nbsd_, 1, 2) IN ('25','26') OR nbsd_ IN ('2909'))
         AND SUBSTR (nbsk_, 1, 2) IN ('25','26')
   THEN
      t_ := 97;

   ELSIF     tt_ NOT IN ('PS0', 'PS2', 'OW1', 'I00')
         AND MFOA_ = MFOB_
         AND (   SUBSTR (nbsk_, 1, 3) IN ('260', '265', '264')
              OR SUBSTR (nbsk_, 1, 2) IN ('25'))
   THEN

            if nbsd_ IN ('3500', '3510', '3519', '3610', '3619', '3653', '3678') AND (   SUBSTR (nbsk_, 1, 3) ='260')
              THEN
                t_ := 23; -- 23 �������� �������� �� �������������� ����������
              else
              if tt_ = 'PS1' then
              t_ := 97;
              else
              t_ := 20; -- 20 �������� �������� ������ �� ������� �볺��� ����� ��\
                end if;
            end if;

   ELSIF     (   NBSD_ LIKE '260%'
              OR NBSD_ LIKE '25%'
              OR NBSD_ LIKE '265%'
              OR NBSD_ LIKE '264%')
         AND MFOA_ = gl.aMFO
         AND tt_ NOT IN ('PS0', 'PS1', 'PS2', 'ELT')
   THEN
      t_ := 19;                                            --��.��.(���.��+��)
   ELSIF     (NBSK_ LIKE '260%' OR NBSK_ LIKE '25%' OR NBSK_ LIKE '265%')
         AND MFOB_ = gl.aMFO
         AND tt_ NOT IN ('PS0', 'PS1', 'PS2','I00')
   THEN
      IF MFOA_ = MFOB_
      THEN
         -- 28-05-2010
         -- � ��� 21 ��.��. (�i�.��.)
         -- ����������  ���.70*     - ���.25*,26*  ;  ���.25*,26* - ���.70*
         -- �� ������ � ����� 27 �������.
         IF NBSD_ LIKE '70%' AND SUBSTR (NBSK_, 1, 2) IN ('25', '26')
         THEN
            t_ := 27;                                                --�������
         ELSIF NBSK_ LIKE '70%' AND SUBSTR (NBSD_, 1, 2) IN ('25', '26')
         THEN
            t_ := -27;                                              -- �������
         ELSE
            t_ := 21;                                         --��.��.(�i�.��)
         END IF;
      ELSE
         t_ := 22;                                            --��.��.(�i�.��)
      END IF;
   ELSIF     MFOA_ <> MFOB_
         AND (   (    nbsd_ LIKE '39%'
                  AND nbsd_ NOT IN ('3900', '3901', '3906', '3907'))
              OR (    nbsk_ LIKE '39%'
                  AND nbsk_ NOT IN ('3900', '3901', '3739', '3906', '3907')))
         AND tt_ NOT IN ('R01', 'D01')
   THEN
      t_ := 29;                                               --�/� ����������
   ELSIF tt_ = 'VMO'
   THEN
      t_ := 29;                                               --�/� ����������
   -- ���������� ���

   ELSIF (   SUBSTR (nbsd_, 1, 3) IN
                ('151', '161', '152', '162', '131', '132')
          OR SUBSTR (nbsk_, 1, 3) IN
                ('151', '161', '152', '162', '131', '132'))
   THEN
      t_ := 2;                               -- ̳��������� �������/��������
   ELSIF (   SUBSTR (nbsd_, 1, 3) IN ('150', '160')
          OR SUBSTR (nbsk_, 1, 3) IN ('150', '160'))
   THEN
      t_ := 6;                                                 -- ������  ����
   ELSIF (   SUBSTR (nbsk_, 1, 2) IN ('14', '30', '31', '32')
          OR SUBSTR (nbsd_, 1, 2) IN ('14', '30', '31', '32')
          OR nbsk_ IN ('3541', '3641', '5102')
          OR nbsd_ IN ('3541', '3641', '5102'))
   -- and tt_ like 'F__'
   THEN
      t_ := 7;                                               -- Kt Cinni paper
   ELSIF tt_ IN ('FXM', 'FX%', 'F80')
   THEN
      t_ := 7;                                               -- Kt Cinni paper
   ELSIF     (   nbsk_ IN ('1880', '1919', '1819')
              OR nbsd_ IN ('1880', '1919', '1819'))
         AND (tt_ LIKE 'F__' OR tt_ IN ('CVO', 'C14', '8G2', '8C2', 'CV7'))
   THEN
      t_ := 8;                                               -- Dt Forex paper
   ELSIF tt_ = 'F10'
   THEN
      t_ := 8;                                               -- Dt Forex paper
   ELSIF NBSd_ LIKE '7%' AND tt_ NOT IN ('PS0')
   THEN
      t_ := 27;                                                         --����
   ELSIF NBSk_ LIKE '7%' AND tt_ NOT IN ('PS0')
   THEN
      t_ := -27;                                                        --����

    --5.     �� ����� 26 ������� �� ���������� � �볺����� ��������� � ����� 84 ����.: ������ �������� BN4 (��������� �� BNY ��������� �� (�� �������) �� ��������� ����� �� (���. ������ �� 2909 �� 6399));
   ELSIF NBSk_ = '6399' and NBSd_ = '2909' AND tt_  = ('BN4')
   THEN
      t_ := -84;    
   --�� ����� 26 ������� ��������� � ����� 84 ����.: ������ ������� (�������) �������� BM4 �� �������� BMY � ��������� �� ������� ������� 2909/23 � �������� 6399/14.                    
   ELSIF NBSk_ = '6399' and NBSd_ = '2909' AND tt_  = ('BM4')
   THEN
      t_ := 84; 

   ELSIF NBSk_ LIKE '6%' AND tt_ NOT IN ('PS0', 'K05','SN3' , 'K2K')
   THEN
      t_ := -26;                                                         --���
   ELSIF NBSd_ LIKE '6%' AND tt_ NOT IN ('PS0', 'K05', 'K2K')
   THEN
      t_ := 26;                                                          --���
   ELSIF TT_ = TTO_ AND MFOA_ <> MFOB_ AND tt_ NOT IN ('PS0', 'PS1', 'PS2')
   THEN
      IF     (   NBSd_ = '2924' AND NBSk_ = '3739'
              OR NBSk_ = '2924' AND NBSd_ = '3739'
              OR NBSd_ = '2902' AND NBSk_ = '3739'
              OR NBSd_ = '3739' AND NBSk_ = '3739')
         AND (   tt_ LIKE 'I0_'
              OR tt_ IN
                    ('W4D',
                     'W4B',
                     'W4A',
                     'R00',
                     'MND',
                     'MNK',
                     'D00',
                     'D01',
                     'R01',
                     'CS2',
                     '516'))
      THEN
         t_ := 32;                                              -- �/� �������
      ELSE
         IF MFOA_ = gl.aMFO
         THEN
            --26/07/2015
            --            ����� 30 ����� �������� ��ϻ:
            --   ������������ �������� � ��������������� ������� �� �� ������� �3500, 3510, 3519, 3610, 3619, 3653, 3622, 3678� ���������� � ����� �� ��������� � ���� ����� ����� �������� ��� (�� �������������� ����������)�.

            if NBSd_ in('3500', '3510', '3519', '3610', '3619', '3653', '3622', '3678')
            then
            t_ := 33;--���� �������� ��� (�� �������������� ����������)
            else
            t_ := 30;
            end if;
                                                     -- ���-������.
         ELSE
            t_ := 31;                                           -- ���-�i����.
         END IF;
      END IF;
   ELSIF     TT_ = TTO_
         AND MFOA_ <> MFOB_
         AND MFOB_ = '300465'
         AND tt_ IN ('PS2')
         AND NBSd_ IN ('3622', '2902')
   THEN
      t_ := 35;                                          -- �����i����i(����i)
   ELSIF tt_ IN ('PS0','PS2')
      THEN
      t_ := 97;

   ELSIF tt_ ='CV7'
      THEN
      t_ := 35;
                                                   -- ���-���.i��i
   ELSIF tt_ = '38V'
   THEN
      t_ := 80;                                             -- ���:�����i����i
   ELSIF    (tt_ IN ('W4V', 'IB5') AND NBSd_ = '2906' AND NBSk_ = '2924')
         OR (tt_ = 'Z16' AND NBSd_ = '3801' AND NBSk_ = '3902')
   THEN
      t_ := 80;                                             -- ���:�����i����i
   ELSIF (tt_ IN ('MUO') AND NBSd_ = '3739' AND NBSk_ = '3801')
   THEN
      t_ := 80;                                             -- ���:�����i����i

   ELSIF     tt_ IN ('ASG')
         AND nbsd_ IN ('3739')
         AND SUBSTR (nbsk_,1,3) IN ('357')
   THEN
      t_ := 80;

   ELSIF tt_ IN ('K17')
         AND nbsd_ IN ('3739')
         AND nbsk_ IN ('2809')
   THEN
      t_ := 80;

   ELSIF tt_ IN ('%MB')
         AND nbsd_ IN ('3904')
         AND nbsk_ IN ('3800')
   THEN
      t_ := 80;

   ELSIF     tt_ = 'I00'
         AND nbsd_ IN ('2902')
         AND SUBSTR (nbsk_,1,2) IN ('26','26')
   THEN
      t_ := 32;

   elsif  tt_ in ('I00','CND','K2P','%15','MIL')                   THEN t_ := 80;    -- ���:�����i����i

   elsif  tt_ in ('301')                                           THEN t_ := 35;    -- ����� 35 ����������� (�볺�����) ������

   elsif  tt_ in ('K2K') and nbsd_ = '3739' and nbsk_ = '3600'     THEN t_ := 80;    -- ���:�����i����i

   elsif   (tt_ in ('K05') and nbsd_ = '3570' and nbsk_ = '6110')
        or (tt_ in ('SN3') and  nbsk_ like '6%')                   THEN t_ := 84;    -- ����� 26 �������

   elsif  tt_ in ('901') and nbsd_ = '3720' and nbsk_ like '2%'    THEN t_ := 20;    -- � ����� 20  ��������� �������� �� ������� �볺���

   elsif (NBSd_ like '3%' or NBSk_ = '3%' ) and tt_ = 'D06'        then  t_ := 80;

     --���������� 164 (���. ������ �� 3907 �� 1007) � ����� 37 ����������� (������������) ������ ��������� � ����� 35.
   elsif (NBSd_ ='3907' and NBSk_ = '1007' and tt_='164')        then  t_ := 35;   -- � ����� 35 ����������� (�볺�����) ������

   ---    ������������ �������� � ��������������� ������� �� ������� ��/���  �������� 3 �����  ��������� � ���� ����� 37 �����������  (������������) ������.



   --�� �������� DOR � ������� �������� DO2 �� ���� ���, ��� ���������� ��������������� �������� ������������ ���, �� ������� � ����� 37 (����� ������ � ����� 80)


   elsif tt_<>'38Z' and (((NBSd_ like '3%' or NBSk_ = '3%' ) and flag_ = '1') or tt_='DO2')         then  t_ := 37;   -- 37 �����������  (������������) ������





   ELSE
      IF    SUBSTR (tt_, 1, 2) IN ('AR', 'I0')   OR tt_ IN
               ('VMO',  'KLR',  'R00',   'R01',
                '809',  '812',  'D06',   'D07',
                '437',  'K06',  'K07',   '%03',
                '516',  '%MB',  '%15',   'ELT', 'D01')
                                                                  THEN  t_ := 80;    -- ���:�����i����i
      ELSIF flag_ = '0' AND tt_ NOT IN ('901')                    THEN  t_ := 80;    -- ���:�����i����i

      ELSE                                                          t_ := 35;    -- �����i����i(����i)

      END IF;
   END IF;



   RETURN t_;
END ZVT_F;
/

show err;
 
PROMPT *** Create  grants  ZVT_F ***
grant EXECUTE                                                                on ZVT_F           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on ZVT_F           to RPBN001;
grant EXECUTE                                                                on ZVT_F           to START1;
grant EXECUTE                                                                on ZVT_F           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/zvt_f.sql =========*** End *** ====
 PROMPT ===================================================================================== 