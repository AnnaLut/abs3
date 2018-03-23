CREATE OR REPLACE PROCEDURE BARS.p_fd8_nn (
   dat_     DATE,
   sheme_   VARCHAR2 DEFAULT 'G',
   prnk_    NUMBER DEFAULT NULL
)
IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : ��������� ������������ #D8 ��� �� (�������������)
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 13/02/2018 (09/02/2018, 08/02/2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ���������: Dat_ - �������� ���� 
               sheme_ - ����� ������������
               prnk_ - ��� �����������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
!!! ��� ��������� ������ ��� ����������� ������� ��� VIEW CUST_BUN (20
    ����� � ������) � ��� ������� � �������� ���� ��������� ����
    ����������� � ���� RNKA (� RNKB ����������� ������� ������ ����� ���
    ������ �������� ��� �� �������� �����)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%13/02/2018 - ��� ����������� �� ���������� ������� ���� RNK=LINK_GROUP
%09/02/2018 - ������� ���� �������� ³���
%08/02/2018 - �������� ���������� 060 (��� ��������� ����� ����������� ��
              CUSTOMER_UPDATE ������ CUSTOMER
%07/02/2018 - �� ������������� ���������� 090, 091, 092 ���� ��������
              ������ �������� ���� ��� 'N ���.' 
%30/01/2018 - � ���������� 128 ����� ���������� H � K140 ����� 
              ������������� ��������
%29/01/2018 - ��������� ����. OTCN_F71_CUST - ��������� ���� K021 �.�.
              ���� CUSTTYPE ������������ ��� K021 ������ ����������
              (���� CUSTTYPE �������� � K021 ����� � ���������� ��������)
%26/01/2018 - �� 01.01.2018 ����� ��������� ���������� 
              ��� ���������� 083 �������� ������ ��������� ���.�����
              � ���������� R013
              1602/1,2602/1,2622/1,9030/1,9031/1,9036/1,9500/1,3   
%16/11/2017 - ���������� ������� � ������� ��� 9129 � R013='9' 
%08/11/2017 - �������� ������������ ���������� 161 ��� ����������������
              (����� �������� 4, 5, 6)
%13/10/2017 - ���� �������� ����� ���� ���������� ZZZZZZZZZZ �����������
              ��� ����� � ����� �������� �� �������� ��������� K021='9'
%15/08/2017 - �������� ���� ND (����� ��������) � ������� OTCN_F71_TEMP
              �� ����� ������������ �������� (���� NDG � CC_DEAL)
%14/08/2017 - ��� ������.������ 9208 ���������� 090, 092, 112 ����� 
              ���������� �� ������� FX_DEAL ��� � ��� 9200, 9202
%26/04/2017 - ���������� 171-179 ��������� ������� �� ������ ������� � 
              ���� ��� ������ ������� �� �� 9129 � ���� ��� 9129 �� �� 
              ������ 3 ������  
%14/04/2017 - ��������� ����� 3115,3578 ��� ����������� R013
              ������������� ����� ���������� ������ 27 (�����)
%04/04/2017 - ��� ���-�� �������� (����=00013480) ������� ���.���� 3040
%27/03/2017 - �������� ������������ ���������� 081 ��� ����������� 
              ����������� (��� ���������� ������� RNK � ��������� ������   
              ���������� �� ���������) 
              ��� 2400, 2401 � R013='8' � ����� ��� 1590 � R013='7' 
              ����� ������������� W='1'
%16/03/2017 - ��� ������.������ 9200,9202 ���������� 090, 092, 112
              ����� ���������� �� ������� FX_DEAL
%07/03/2017 - ������������ ������������ ���������� 125 � ����� �����������
              121+122+123+124+119
%28/02/2017 - ��� 3540 � R013 not in (4,5,6,7) W='2' 
              ��� 3578 � R013 not in (3,5) W='2' 
%27/02/2017 - ��� �������� ���� 30.12.2016 � ���.����� 9129 � ��������� �
              ������ ������� � R013='9' �������� R013 �� "1" 
              (����� ������ ��� ���� ����� ����)
%13/02/2017 - ���������� 055 �� ����� ������������� ��� ������������ 
%09/02/2017 - �������� ���������� S085_ �� 2-� ��������
%27/01/2017 - ����� ���������� ��� ����������� ��� ������ ������������ 
              (��� 306)
%24/01/2017 - �� 01.02.2017 ����� ������������� ���������� 055
              ������� 14_5, 14_6, 14_7, 14_8, 14_9 ��� ������� �������� 
              ����� 1400,1401,1402,1410,1411,1412,1420,1421,1422        
              (������� ������� ��� ���� �������� ����� (���� DAZS)      
              �.�. ��� �������� ����� 1410 ����� 17.01.2017             
              �� ��� ����� 14_5, 14_6, 14_7, 14_8, 14_9 ���������       
%20/01/2017 - ��� �������� ���� 30.12.2016 � ���.����� 9129 � ��������� �
              ������ ������� � R013='9' �������� R013 �� "1" 
%13/12/2016 - ��� MFO=300465 � RNK in (940143,946362) ������������� 
              OBS_ ������ "4"
%12/12/2016 - ������������ ������ ������ P_OBRAB_PKD (2) 
%09/12/2016 - ��� ������� ���� ������������ �� � �� ���������������
              � ����� ����� ���� ����� ����������� ������ ���������� 
              K074, K110 � �������� �� ��������������� �� ��������� � 
              �������� ����� ��
%07/12/2016 - ������������� ����� ���������� ������ 58, 655 � ������� 
              � �� ����� ������ 2 ��� �� �� ���� ������� �� ������ 2 ���
%05/12/2016 - �� ����� ���������� ����������� ��� ������� ��� RNK 
              ��������� � ����� ������ (���� LINK_GROUP) ������� 
              D8_CUST_LINK_GROUPS.
              ����� ���������� ��� ����������� ��� ������ ����� (��� 655)
%02/12/2016 - ����� ����������� ������������ ���������� 125 �� ����� 
              ����������� 121+122+123+124+119
%29/11/2016 - ��� ������ �� � ��������� � ���� ���������� ��� ����������� 
              (S031) �� ����� ����������� �������� '00'���� ���� ����� 
              �����������
%25/11/2016 - ������� 14_5, 14_6, 14_7, 14_8, 14_9 ��� ������� �������� 
              ����� 1400,1401,1402,1410,1411,1412,1420,1421,1422  
%17/11/2016 - ��� ���� 132 ������� �������� ���.������ ���������� � ���� 
              ���������� (�������� ���.���� 2627)
%11/11/2016 - ������� ������������ ���������� custtype_ ����� ���� 
%             DECODE (c.custtype, 3, 2, 1) � c����� ����� �����
%10/11/2016 - ��� ���������� ���.����� 2067 ����� ������������� 
%             ���������� 131 ...... 
%06/11/2016 - ������� ���� ������ ������ �� ����. OTCN_F71_RNK
%             ��������� ������ ���.������� � S240='Z' ������������ 
%             ���������� 126
%28/10/2016 - ������������ ����� ����� �������� ����� ������������� 
%             �� ������ ��������  (���� LINK_GROUP � ����. 
%             D8_CUST_LINK_GROUPS) 
%18/10/2016 - ��� ��������� ���������� 085 ��������� ������� 
%07/10/2016 - ��� ������� ��������� ����� ���������� ��� ������� 
              �� ���.������ 3578,3579 (���������� ������ ��������� OB22)  
%04/07/2016 - ��� 1590 � R013=4,6, 3115  "W" - ����� ������������� 1  
              ��� ���.������ 1502,1524, 300 ������, 301 ������, 
              310 ������, 3212, 3540 � ������������ �������� R013 
              ����� ������������� W='1' ��� ��������� �������� R013 W='2'    
              ��� ������ ���.������ 181 ��� ����������� ����� "00"
%30/06/2016 - ��������� ��������� ����� ���������������� 15,16,17
              ��������� ��������� ������������� ��������� W ��� ������ 
              �������, ��� ��������� ��� ���� ����������� ����� '00'   
%17/06/2016 - ��� ������ ��������� �� �� ���������� �������������� 
              �������� ����� ��������� �� ����� ACCR, ACCR2, ACCR3 
              (����� ���� ACCR)
%13/06/2016 - ��� 081 �� ����� ����������� ���� ����� ����������� ����� 0
              �� ������������ ��� ���� ����������� 90. ���������.
%09/06/2016 - �������� �������� ���������� ����� ���������������� ���
              �������������  
%31/05/2016 - �������� ������������ ��������� W ��� ���.����� 3579
              (����� ������������� W='2')
%06/06/2016 - ����� ����������� ���������� 081 � ����� ����������� 90 �
              ��������� ���������� '0'
%01/06/2016 - ��� ���������� 083 �������� ������ ��������� ���.�����
              � ���������� R013
              1602/1,2602/1,2622/1,9010/1,9015/1,9030/1,9031/1,9036/1,
              9500/1,3   
%31/05/2016 - �������� ������������ ��������� W ��� ������ �������,
              ��� ������ ����������� � ������������ ���������
%30/05/2016 - ���.���� ������� ���������� ��� � ��� ������ #C5, #A7
%18/05/2016 = ��� ������ ������������ �������� ��� ������ ��������� ��� 
              �� ������� OKPO � D8_CUST_LINK_GROUPS � RNK � CUSTOMER 
%17/05/2016 - ��� ���������� �� ��������� 9129 � R013='9'. ����������.  
%16/05/2016 - �� �� ������� � ������� ������ ACTIVE in (1, -1)
%             (���� ����� ACTIVE = 1) �.�. �� ���������� �������������� 
%             ���� ������
%12/05/2016 - �������� ������������ ����������� 085, 111, 130 �� ��
%11/05/2016 - ��� ������������ ���������� 085 (���� ��������) ������� 
%             ������� NVL �.�. ��� ��������� ����� FIN=NULL
%06/05/2016 - ��� ���.����� 3041 ����� ����������� ����������� � ������� 
%             ������������ ������
%29/04/2016 - ���.�������� "DB_SS" ������������ � ���������� 092 ������ 
%             ���������� 111 
%25/04/2016 - � ����� � ��������� ��������� ��������� �� �� � ��� 
              ������ ���.�������� "DB_SS" - ���� ������������� ������� 
              ������� ����� �������������� ��� ������������ ���������� 111
%21/04/2016 - ��� ������������ ���������� 040 ��� �� �� CUST_BUN ��������
              ������ �� ������� RNKA=RNK  � �� �������� �� RNKB
              (��������� ���������� - ������ �������� ���������)  
%19/04/2016 - ������� ��� ���������� P140_ c SMALLINT �� VARCHAR2(3)
%15/04/2016 - ��� ������ ����������� � ������������ ��������� �������� 
              ������ �������� ������� 
              ��� ���������� ��������� ���������� 040 �� �������� ����� 
              ����� �������� (����� ���� 150 000.00)
%13/04/2016 - �� ���������� 128 �������� ���.���� 3578
%04/04/2016 - ��� 3541 ����� �������� ������ �������� �����
              (������� �� OTCN_ACC, OTCN_SALDO) 
%01/04/2016 - �� 01.04.2016 ����� ������������� ����� ����� ���������� 
              ��� "A" - ������ ����������������� ���� (�������� K021) 
              ��� "W" 
              1-����, �� ����������� �� ���������� ��������� ���������� 
                ������
              2-����, �� �� ����������� �� ���������� ��������� ���������� 
                ������
              ��� "OO" - ��� ���� ������������ �������
%10/03/2016 - ���� ������� i.id = 0 ������� �� i.id(+) = 0 �.�. �� 
              ���������� ����� ����������� ���������
%16/02/2016 - ���������� 130 ����� ����������� ������� ���� � ������� 
              INT_ACCN ��������� ���� STP_DAT � �������� ��� <=  
              �������� ����
%10/02/2016 - ��� 3541 ����� �������� ������ ������������ �����
              (������� �� OTCN_ACC, OTCN_SALDO) 
%29/01/2016 - ��� 3541 ����� �������� ������ �������� ����� 
%10/12/2015 - ������� ��������� ���� ����� "XOZ"
%11/11/2015 - ��� ������ ����������� (TIP='W4B') ������������� �����
              �������� ���� ND � NKD �� SPECPARAM
%10/11/2015 - ���������� ���-�� ������� ��� ������� �� ACC �� �� �������
              CC_TRANS � �� VIEW CC_TRANS_DAT ������ � ��������� �����
              ������� (�� ������ ���� ������ �� VIEW ��� �������� ����
              � ����� �� ������������ ���������� 121...... - �������)
%11/09/2015 - ��� ������������ ���������� 021 ����� ����� '2'
              (��������� ���)
%19/05/2015 - ������� ��������� ����������� 27/01/2015 ������ ��� �����
              ������ ����������� 080,082 �� �������� ��������������
              28.11.2014
%18.05.2015 - � ������� BASEL2 ��� ���� ���������� 081 �� ����� ���������
              ������� ���������
%05.03.2015 - ��� ������� �� ����� ������������
              rkapital (dat_, kodf_, userid_, 1) - �� ����������� ����������
              ������  rkapital (dat_, kodf_, userid_);
%25/02/2015 - ��� ������������ ���������� 021 ����� '0' � ���������� 025
              ����� '00000' (������� ��� �������� ����� ��� ����
              ����� ��������� �������� ISE(K070), VED(K110) )
%09/02/2015 - ���������� 111 ����� ����������� ��� ������ �� ������
              � ��� ���������� �� ������� ��� ���� ������ �� CC_ADD
              ���� WDATE
%18/12/2014 - � ����� ������������ ���������� 111 �� FROM ��������� ����.
              SPECPARAM
%03/12/2014 - ���������� 111 ����� ����������� ��� ������ �� ������
              �� ������ ���� "SS" � ���� ��� ����� ������ �� �� ������
              9000, 9001, 9002, 9003, 9020, 9023, 9100, 9122, 9129(R013=1)
%07/11/2014 - ��� 300465 �� ���� �������� ( � �� ������ ��������� ������)
              ���������� 111 ����� ����������� ��� ������ �� ������
              �� ������ ���� "SS" ��� �� ������ 9000,9001,9002,9003,
              9020, 9023, 9100, 9122
%30/10/2014 - ��� ������������ ���� ������� �������� �� SALDOA
              ��������� �� NLS, DAOS (���� DAOS, NLS)
%24/10/2014 - ��� ��� �������� ���������� 080 ����� ������������� '33' �
              �������� ��� ���������� 081 ����� ������������� 0 (����)
%08/10/2014 - ����� ������������ �������� 0 (����) ��� ���������� 021
              � ������� ��������� ����������� �����
%16/09/2014 - �� 01.10.2014 ����� ����������� ������������ ���������� 021
%11/09/2014 - ������� ������� if data_ is not null
              ��� ���������� ���������  p_ins_kredit (ptype_);
              ���� ��� ����� ��������� ND (N ��������)
%09/09/2014 - ��� ���������� 118 (9129 R013='9') �������� ����� �������
              �� ��������� NKD � ������� SPECPARAM
%19/08/2014 - ��� ����������� 092,111,112 ������� ���������� �� NLS
              ����� �������� ����� ���� ������� � ����� 9 �����
%13/08/2014 - ��� ����� 280,351,354,357 � ��������� � ����.CCK_RESTR
              ����� ����������� ��� ���������������� '2'
%08/08/2014 - ��� 322669 (���������), 353553 (��������)
              �� ��������� ������ ���������� 111 �����
              ����������� ��� ������ �� ������ �� ������ ���� "SS" ���
              �� ������ 9020, 9021, 9023
%07/08/2014 - ��� 300465 �� ��������� ������ ���������� 111 �����
              ����������� ��� ������ �� ������ �� ������ ���� "SS" ���
              �� ������ 9020, 9021, 9023
%29/07/2014 - ��� ����� (324805) ���������� 091 ��������� ����� ��������
              '726614110000' ��� ����������� (��� ������� 11) �
              '726614290000' ��� ����������� (��� ������� 29)
%16/07/2014 - ��� 300465 �������� ����� 3578,3579  � ���������� OB22
              3578 (19,24.30), 3579 (47,54,63)
%10/07/2014 - ��� VIEW CC_TRANS_DAT ����� ������� FDAT <= Dat_
%20/06/2014 - ��� VIDD_ in (2,3,12,13) ���� ������������� �������������
              ���������� ��� ������ �������� �� ����� 8999
%14/05/2014 - ���� ��������� ��� ������� �������� �� ���� D_PLAN ������
              D_FAKT ���� D_FAKT ������ �������� ���� (�����. ��������)
%13/05/2014 - ��� ������������ ����� �� ������� ����� ������������ VIEW
              CC_TRANS_DAT ������ CC_TRANS  � CC_TRANS_UPDATE
%12/05/2014 - ������� ������� ��� ������ ���������� �����
              ����� �������� �� CC_TRANS_UPDATE
%08/05/2014 - �� CC_TRANS �������� ����� ������� �������� �� FDAT,REF
%08/04/2014 - ���� ��������� ���� REFP � ���� �������� ������ ��������
              ���� � ��������� ���� SZ � SZ ������ ����� ��������
              �� ����� ������� SZ ����� ����� ��������
%07/04/2014 - �������� ����� �������� �� REFP �� �� ������ �������� SZ
%02/04/2014 - �� ���������� ����� ������� ���� ���� ��������� ���������
              �� �������� ���� (��������� ���)
%01/04/2014 - ��� ���������� ��������� ������ ����� �������� ���������
              ������� �������
%29/03/2014 - ������� ���� ��� ������ ���� ������� (����� ����������
              ����� �������� ���� (��������� ���� REFP � ������ D_FAKT)
%27/03/2014 - �� ������� ���.���������� CC_ADD ��������
              ���� ������ �������� BDATE ������ ���� ������ WDATE
              (��������� ������������ ��)
%20/03/2014 - ��� ������� (��������� ������ �� ������ ��������) ���������
              ������������ ����� 123,125,130 ��� ������� �� ������
%19/03/2014 - ��� ������� (��������� ������ �� ������ �������� ��
              ������������� 085,111,112,160,161 ��� ������� �� ������
%18/03/2014 - ��� ������ ��������� (��.280, 351, 357) ���� �����������
              080, 082, 085 ����� ����������� �������� "0"
              ��� ���������, ���������, �� ��� 161 ����� ������ "2"
%17/03/2014 - ��� ������� ������� � ������� � ��� ACC ����� ND �.�.
              �� ������ �������� ���������� ��������� ������
%13/03/2014 - ��� ���������� ������� ����� �������� ���� �������� ������
              ���� SV � �� ������� SV-SZ
%12/03/2014 - ��� ����� ������������ ����� ���� ��� �������� 3578, 3579
              ���� ������ ������ ��� � ND_ACC (����������� � ��)
%11/03/2014 - ��������� ��� ����� ��������� �����������
%28/02/2014 - �� 01.03.2014 �� ���������� ���������� �������
%18/02/2014 - ��������� ��� ���� 28.02.2014
              ��� ���.��� �������� ID_REL in (5,12) ����� ���� ������ 5
%07/02/2014 - ���.����� 3103, 3105 ����� �������� �� �����
              ���������� ��������� R013 (����� ���� ����� '2')
              ���������� 040 ��������� � ��� �������� ���������
%05/02/2014 - �� ������ �� �� ��������� ������� � ������� ��������
              ��������� NVL (r.nkd, 'N ���.') = nkd_ ��
              NVL (r.nkd, 'N ���.') = NVL(nkd_, 'N ���.')
              ����� ������� ��������� � ��� ������ �������, ������
%22/01/2014 - �������� ���� ������������� ������������� ��� ND=NULL
              ���������� ��� ������������ ���� �� SALDOA
%20/01/2014 - ��������� 1508 ������ ��� 1502 (���� � ��� 1500)
%13/01/2014 - � ��������� ��� ���������� "txt_sql" ��������� ����� RNK
              ��� ���� � ������ ��������� �� 07.10.2013
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   kodf_        VARCHAR2 (2)          := 'D8';
   fmt_         VARCHAR2 (20)         := '9999999990D0000';
   fmt1_        VARCHAR2 (20)         := '9999990D00';
   fmt2_        VARCHAR2 (20)         := '999990D000';
   fmtkap_      VARCHAR2 (30)         := '999G999G999G990D00';
   dfmt_        VARCHAR2 (8)          := 'ddmmyyyy';
   ise_         customer.ise%TYPE;   
   ved_         customer.ved%TYPE;
   k110_        VARCHAR2 (5);
   reg_         customer.c_reg%TYPE;
   s031_        specparam.s031%TYPE;
   s031_1       specparam.s031%TYPE;
   nkd_         specparam.nkd%TYPE;
   dat_nkd_     DATE;
   pdat_        DATE;
   sum_d_       NUMBER;
   sum_zd_      NUMBER;
   smax_        NUMBER                := 200000000;
   -- ����������� ���� �� ������ �����������
   tip_         accounts.tip%TYPE;
   dat1_        DATE;                               -- ���� ������ ������ !!!
   dat2_        DATE;                      -- ���� ��������� ����. ������ !!!
   dc_          INTEGER;
   pog_         BOOLEAN;          -- ������ ������� � ������� �������� ������
   kol_         NUMBER;
   kolvo_       NUMBER;
   kol_trans    NUMBER;
   ret_         NUMBER;
   nls_         VARCHAR2 (15);
   nbs_r013_    VARCHAR2 (5);
   data_        DATE;
   datrez_      DATE;
   kv_          SMALLINT;
   cust_        SMALLINT;
   kodp_        VARCHAR2 (35);
   znap_        VARCHAR2 (70);
   mfo_         NUMBER;
   mfou_        NUMBER;
   rnk_         NUMBER;
   rnk_3041     NUMBER;
   acc_         NUMBER;
   acc1_        NUMBER;
   vidd_        NUMBER;
   vidd_kl      NUMBER;
   p010_        VARCHAR2 (70);
   p021_        CHAR (1);
   p030_        CHAR (14);
   kod_okpo     VARCHAR2 (10);
   okpo_nerez   VARCHAR2 (10);
   rez_         SMALLINT;
   p040_        SMALLINT;
   p041_        VARCHAR2(3);
   p042_        VARCHAR2(3);
   p050_        SMALLINT;
   p060_        SMALLINT;
   p060_1       SMALLINT;
   p070_        VARCHAR2 (4);
   p070_rez_    VARCHAR2 (4);
   p080_        VARCHAR2 (70);
   p080_list    VARCHAR2 (70);
   p080f_       VARCHAR2 (2);
   p081_        VARCHAR2 (70);
   p081_d       NUMBER;
   p083_        NUMBER;
   p085_        VARCHAR2 (70);
   p085_p       VARCHAR2 (70);
   ccf_         Number; 
   p090k_       specparam.nkd%TYPE;  --VARCHAR2 (20);
   p090_        specparam.nkd%TYPE;  --VARCHAR2 (20);
   p100_        VARCHAR2 (1);
   p111_        DATE;
   p111_1       DATE;
   p111p_       DATE;
   p111p_saldoa DATE;
   p112_        DATE;
   p112_2       DATE;
   p112p_       DATE;
   p113_        DATE;
   f71k_        NUMBER;
   p120_        NUMBER;
   p125_        NUMBER;
   ndk_         NUMBER;
   nd_          NUMBER;
   nd_trans     NUMBER;
   nd_p082      NUMBER;
   refn_        NUMBER;
   nnnn_        NUMBER;
   kod_nnnn     VARCHAR2 (4);
   sum_k_       DECIMAL (24);
   sum_sk_      DECIMAL (24);                     -- ���� ���������� ���i����
   sum_ob_      NUMBER;
   sum_obp_     NUMBER;
   sum_obi_     NUMBER;
   sum_rez_     NUMBER;
   sum_71       DECIMAL (24);
   sum_71o      NUMBER;
   sum_lim      NUMBER;
   sum_proc     NUMBER                :=20;  -- ����� ������� �������
   srez_        NUMBER;
   ek2_         DECIMAL (24);
   ek3d_        DECIMAL (24);
   ek3k_        DECIMAL (24);
   ek4_         DECIMAL (24);
   p130_        NUMBER;
   p140_        VARCHAR2(3);
   p150_        VARCHAR2 (20);
   p170_        VARCHAR2 (70);
   p171_        VARCHAR2 (70);
   p172_        VARCHAR2 (70);
   p173_        VARCHAR2 (70);
   p174_        VARCHAR2 (70);
   p175_        VARCHAR2 (70);
   p176_        VARCHAR2 (70);
   p179_        VARCHAR2 (70);
   s181_        VARCHAR2 (1);
   s080_        VARCHAR2 (2);
   s081_        VARCHAR2 (2);
   s085_        VARCHAR2 (2);
   lgd_         NUMBER;
   pd_          NUMBER;
   fin_         VARCHAR2 (1);
   s250_23_     VARCHAR2 (1);
   r013_        VARCHAR2 (1);
   kol_dz       NUMBER;
   pr_          NUMBER (10, 2);
   userid_      NUMBER;
   p_rnk_       NUMBER                := NULL;              -- ���������� rnk
   p_nd_        NUMBER                := NULL;          -- ���������� �������
   p_sum_zd_    NUMBER                := NULL;
   p_p111_      DATE                  := NULL;
   p_p112_      DATE                  := NULL;
   p_p090_      specparam.nkd%TYPE;  --VARCHAR2 (20)         := '------';
   p_p080_      VARCHAR2 (20);
   p_p081_      NUMBER;
   p_p130_      NUMBER;
   p_p140_      SMALLINT;
   doda_        VARCHAR2 (100);
   acck_        NUMBER;
   acco_        NUMBER;                                    -- ���� ����������
   accn_        NUMBER := NULL;                            -- ���� ����������� %%
   i_opl_       NUMBER                := 0;
   our_reg_     NUMBER;
   b040_        VARCHAR2 (20);
   nbuc_        VARCHAR2 (20);
   nbuc1_       VARCHAR2 (20);
   typ_         NUMBER;
   custtype_    NUMBER;
   sab_         VARCHAR2 (4);
   isp_         NUMBER;
   dbuf_        DATE;
   period_      kl_f00.period%TYPE;
   ddd_         VARCHAR2 (3);
   ncontr_      NUMBER                := 0;
   sum_contr_   NUMBER                := 0;
   sql_         VARCHAR2 (1000);
   f1502_       NUMBER;
   txt_sql      VARCHAR2 (10000);
   glb_         Number;
   stp_dat1_    DATE;
   k021_        Varchar2(1);
   w_           varchar2(1);
   k140_        Varchar2(1);
   H_           Varchar2(1);
   pd_0_        Number;

   TYPE ref_type_curs IS REF CURSOR;

   rezid_       NUMBER;
   flag_over_   BOOLEAN               := FALSE;
   saldo        ref_type_curs;

   our_okpo_    Varchar2(14);
   our_rnk_     NUMBER;
   vid_         NUMBER;
   cur_sum_     NUMBER;
   s_v          number;
   s_25         number;
   s_26         number;
   s_29         number;
   s_31         number;
   pawn_        number;
   dat23_       Date;
   sql_acc_     VARCHAR2(2000):='';
   dat_izm1     date := to_date('31/08/2013','dd/mm/yyyy');
   dat_izm2     date := to_date('28/02/2014','dd/mm/yyyy');
   dat_izm3     date := to_date('31/03/2016','dd/mm/yyyy');
   dat_izm4     date := to_date('31/10/2016','dd/mm/yyyy');
   dat_izm5     date := to_date('30/12/2016','dd/mm/yyyy');
   dat_izm6     date := to_date('29/12/2017','dd/mm/yyyy');
   n_trans      number;
   kod_mm       Varchar2(2);
   nls_9129_9   VARCHAR2 (15);
   kol_9129_9   Number;
   s9129_9      Number;
   rnum_        number;
   sum_tr_      number;
   s_tr_        number;
   tr_end       number;
   freq_        NUMBER;
   comm_        rnbu_trace.comm%TYPE;
   isspe_       Varchar2(1);
   
   -- �� 30 ����
   o_r013_1     VARCHAR2 (1);
   o_se_1       DECIMAL (24);
   o_comm_1     rnbu_trace.comm%TYPE;
   -- ����� 30 ����
   o_r013_2     VARCHAR2 (1);
   o_se_2       DECIMAL (24);
   o_comm_2     rnbu_trace.comm%TYPE;
   s190_        Number;
   s190s_       VARCHAR2 (1);
   s080_131     Number;
   rate_        Number;
   vers_        Number;
   cnt_         Number;
   zamina_a     Varchar2(1);

   p111_dop     date;

--- ���� ������� ��� ���������� �����
   CURSOR kredit
   IS
      SELECT   b.s031, a.nd                              --, NVL(c.pawn,90)
      FROM cc_accp a, cc_pawn b, pawn_acc c, otcn_saldo s       -- accounts d
      WHERE a.accs = acc_
        AND a.acc = c.acc
        AND a.acc = s.acc
        --AND s.fdat = dat_
        AND decode(s.kv, 980, s.ost-s.dos96+s.kos96, s.ostq-s.dosq96+s.kosq96) <> 0 
        AND c.pawn = b.pawn                         -- ������� 31.03.2008
      GROUP BY b.s031, a.nd;

-- ������������
   CURSOR c_cust
   IS
      SELECT   c.rnk, c.okpo, c.rez, c.k021/*c.custtype*/, c.p010, c.p020, c.p025, 
               c.p040, c.p050, c.p055, c.p060, c.p085, G.LINK_CODE
      FROM otcn_f71_cust c, tmp_link_group g
      where c.rnk = g.rnk
      ORDER BY c.okpo, c.rnk;

-- ��� �������� �� ������ �����������
   CURSOR c_cust_dg
   IS
      SELECT   t.acc, t.nd,  t.p090, t.p080, t.p081, t.p110, t.p111, t.p112,
               t.p113, t.p160, t.nbs, t.kv, t.ddd, t.p120, t.p125, t.p130,
               t.p150, t.nls, t.fdat, t.isp,
               abs(sum(case when substr(t.nbs,4,1) not in ('8', '9') then t.p120 else 0 end) over (partition by t.rnk, t.nd, t.p090)) cur_sum,
               NVL(sum(t.p081) over (partition by t.rnk, t.p090),0) p081_d,
               row_number() over (partition by t.rnk, t.nd, t.p090, t.kv order by t.rnk, t.nd, t.p090, t.kv, t.nls) rnum
          FROM otcn_f71_temp t
         WHERE t.rnk = rnk_
      ORDER BY t.nd, t.p090, t.kv, t.ddd, t.nbs;

-- ��������� ����������� � ���������� �������� (���������)
   CURSOR basel
   IS
      select kodp, znap from
          (SELECT DISTINCT r.kodp, r.znap
               FROM ( SELECT * FROM rnbu_trace
                      WHERE SUBSTR (kodp, 1, 3) IN
                             ('010',
                              '019',
                              '021',
                              '025',
                              '040',
                              '041',
                              '042',
                              '050',
                              '055',
                              '060',
                              '080',
                              '082',
                              '085',
                              '090',
                              '091',
                              '110',
                              '113',
                              '160',
                              '161',
                              '164'
                             )
                      ORDER BY SUBSTR (kodp, 4, 10),
                               SUBSTR (kodp, 33),
                               SUBSTR (kodp, 1, 3),
                               recid ) r
                 ORDER BY SUBSTR (r.kodp, 4, 10),
                          SUBSTR (r.kodp, 33),
                          SUBSTR (r.kodp, 1, 3) )
            union all
            -- ��� 150
            SELECT  kodp, max(znap)
            FROM rnbu_trace
            WHERE substr(kodp,1,3) = '150'
            GROUP BY kodp 
            union all
            select kodp, znap from
            (SELECT DISTINCT r.kodp, r.znap
               FROM (  SELECT * FROM rnbu_trace
                       WHERE SUBSTR (kodp, 1, 3) IN ('162', '163')
                         and nls not like '9129%' 
                         and nls not like '3%'
                      UNION 
                       SELECT * FROM rnbu_trace r2
                       WHERE SUBSTR (r2.kodp, 1, 3) IN ('162', '163')
                         and r2.nls like '9129%' 
                         and not exists ( select 1 
                                          from rnbu_trace r3 
                                          where SUBSTR (r3.kodp, 1, 3) IN ('162', '163')
                                            and substr(r3.kodp, 4, 21) = substr(r2.kodp, 4, 21) 
                                            and r3.nls not like '9129%'
                                        )         
                      UNION 
                        SELECT * FROM rnbu_trace r4
                        WHERE SUBSTR (r4.kodp, 1, 3) IN ('162', '163')
                           and r4.nls like '3%' 
                           and not exists ( select 1 
                                            from rnbu_trace r5 
                                            where SUBSTR (r5.kodp, 1, 3) IN ('162', '163')
                                              and substr(r5.kodp, 4, 21) = substr(r4.kodp, 4, 21)  
                                              and r5.nls not like '3%'
                                          ) 
                    ) r
                 ORDER BY SUBSTR (r.kodp, 4, 10),
                          SUBSTR (r.kodp, 33),
                          SUBSTR (r.kodp, 1, 3) )
            union all
            select kodp, znap from
            (SELECT DISTINCT r.kodp, r.znap
               FROM (  SELECT * FROM rnbu_trace
                       WHERE SUBSTR (kodp, 1, 3) IN ('170','171','172','173','174','175','179')
                         and nls not like '9129%' 
                         and nls not like '3%'
                      UNION 
                       SELECT * FROM rnbu_trace r6
                       WHERE SUBSTR (r6.kodp, 1, 3) IN ('170','171','172','173','174','175','179')
                         and r6.nls like '9129%' 
                         and not exists ( select 1 
                                          from rnbu_trace r7 
                                          where SUBSTR (r7.kodp, 1, 3) IN ('170','171','172','173','174','175','179')
                                            and substr(r7.kodp, 4, 14) = substr(r6.kodp, 4, 14) 
                                            and r7.nls not like '9129%'
                                        )         
                      UNION 
                        SELECT * FROM rnbu_trace r8
                        WHERE SUBSTR (r8.kodp, 1, 3) IN ('170','171','172','173','174','175','179')
                           and r8.nls like '3%' 
                           and not exists ( select 1 
                                            from rnbu_trace r9 
                                            where SUBSTR (r9.kodp, 1, 3) IN ('170','171','172','173','174','175','179')
                                              and substr(r9.kodp, 4, 14) = substr(r8.kodp, 4, 14)  
                                              and r9.nls not like '3%'
                                          ) 
                    ) r
                 ORDER BY SUBSTR (r.kodp, 4, 14),
                          SUBSTR (r.kodp, 1, 3) )
            union all
      select kodp, znap
      from (
            SELECT DISTINCT r.kodp, r.znap
            FROM (SELECT * FROM rnbu_trace
                  WHERE SUBSTR (kodp, 1, 3) IN
                         ('092',
                          '111',
                          '112'
                         )
                  ORDER BY SUBSTR (kodp, 4, 10),
                           SUBSTR (kodp, 33),
                           SUBSTR (kodp, 1, 3),
                           recid,
                           to_date(znap, 'ddmmyyyy')) r
             ORDER BY SUBSTR (r.kodp, 4, 10),
                      SUBSTR (r.kodp, 33),
                      SUBSTR (r.kodp, 1, 3));

-- ���������� ������  (����������������)
   CURSOR basel1
   IS
      SELECT   a.kodp, sum(to_number(decode (nvl(b.znap,'0'),'0',1,b.znap))),
               sum(to_number(decode (nvl(b.znap,'0'),'0',1,b.znap)) * TO_NUMBER (a.znap) * 10000)
          FROM rnbu_trace a, rnbu_trace b
         WHERE SUBSTR (a.kodp, 1, 3) IN ('130')
           --and to_number(nvl(b.znap,'0')) <> 0
           and substr (a.kodp,4,14) = substr (b.kodp,4,14)
           and substr (a.kodp,22,5) = substr (b.kodp,22,5)
           and a.nls = b.nls
           and a.kv = b.kv
           and substr (b.kodp, 1, 3) in ('119','121')
      GROUP BY a.kodp;

-- ������������� ��������� ����. ��������
   CURSOR basel2
   IS
      SELECT   kodp, SUM (TO_NUMBER (znap)) znap
              FROM rnbu_trace
             WHERE SUBSTR (kodp, 1, 3) IN
                         ('081','083','084','086', '118', '119', '121', '122', '123', 
                          '124','125','126','127','128','131','132'
                         )
      GROUP BY kodp
      ORDER BY SUBSTR (kodp, 4, 10), SUBSTR (kodp, 27), SUBSTR (kodp, 1, 3);

-------------------------------------------------------------------
   PROCEDURE p_ins (
      p_kodp_   IN   VARCHAR2,
      p_znap_   IN   VARCHAR2,
      p_nls_    IN   VARCHAR2 DEFAULT NULL,
      p_trans   IN   VARCHAR2 DEFAULT '',
      p_K021    IN   VARCHAR2 DEFAULT '0',
      p_W       IN   VARCHAR2 DEFAULT '0',
      p_OO      IN   VARCHAR2 DEFAULT '00',
      p_s083    IN   VARCHAR2 DEFAULT '0',
      p_k140    IN   VARCHAR2 DEFAULT '0',
      p_comm    IN   VARCHAR2 DEFAULT ''
   )
   IS
      l_isp_   NUMBER := isp_;
      l_acc_   NUMBER := acc_;
      l_trans  VARCHAR2(2):='';
   BEGIN
      IF p_nls_ IS NULL
      THEN
         l_isp_ := NULL;
         l_acc_ := NULL;
      END IF;

      if dat_ >= dat_izm2 and (p_trans is null or p_trans='')
      then
         l_trans := '00';
      else
         l_trans := p_trans;
      end if;

      if dat_ < dat_izm3
      then
         INSERT INTO rnbu_trace
                     (acc, nls, kv, odate, isp, rnk,
                      kodp, znap, nd
                     )
              VALUES (l_acc_, p_nls_, kv_, data_, l_isp_, rnk_,
                      SUBSTR (p_kodp_ || l_trans  || TO_CHAR (rnk_), 1, 35), p_znap_, nd_
                     );
      else 
         if dat_ < dat_izm6 
         then
            INSERT INTO rnbu_trace
                        (acc, nls, kv, odate, isp, rnk,
                         kodp, znap, nd, comm
                        )
                 VALUES (l_acc_, p_nls_, kv_, data_, l_isp_, rnk_,
                         SUBSTR (p_kodp_ || l_trans || p_K021 || p_W || p_OO || TO_CHAR (rnk_), 1, 35), p_znap_, nd_, p_comm
                        );
         else
            INSERT INTO rnbu_trace
                        (acc, nls, kv, odate, isp, rnk,
                         kodp, znap, nd, comm
                        )
                 VALUES (l_acc_, p_nls_, kv_, data_, l_isp_, rnk_,
                         SUBSTR (p_kodp_ || l_trans || p_K021 || p_W || p_OO || p_s083 || p_k140 || TO_CHAR (rnk_), 1, 35), p_znap_, nd_, p_comm
                        );
         end if;
            
      end if;
   END;

-------------------------------------------------------------------
   PROCEDURE p_ins_contr
   IS
--- ������ ���������� �����������
      kodp_   VARCHAR2 (35);
   BEGIN
      -- ��� ����?� ��������?�
      IF rez_ = 1 then
         BEGIN
            select NVL(rc.glb,0)
               into glb_
            from custbank cb, rcukru rc
            where cb.rnk = rnk_
              and cb.mfo = rc.mfo(+);

            kod_okpo := LPAD( TO_CHAR(glb_), 10, '0');
         EXCEPTION WHEN NO_DATA_FOUND THEN
            kod_okpo := '0000000000';  --null;
         END;
         k021_ := '3';
      END IF;

      -- ��� ����?� ����������?�
      IF rez_ = 2 then
         BEGIN
            select NVL(cb.alt_bic,0)
               into glb_
            from custbank cb
            where cb.rnk = rnk_;

            kod_okpo := LPAD( TO_CHAR(glb_), 10, '0');
         EXCEPTION WHEN NO_DATA_FOUND THEN
            kod_okpo := '0000000000';  --null;
         END;
         k021_ := '4';
      END IF;

      IF (TRIM (kod_okpo) IN ('00000', '00000000', '000000000', '0000000000', '99999') and
          rez_ not in (1,2)) or rez_ in (4,6)
      THEN
         IF rez_ in (4,6)
         THEN
            IF TRIM (kod_okpo) NOT IN ('00000', '00000000', '000000000', '0000000000', '99999')
            THEN
               kod_okpo := TRIM(kod_okpo);
            ELSE
               --ncontr_ := ncontr_ + 1;
               --kod_okpo := 'IN' || LPAD (TO_CHAR (ncontr_), 8, '0');
               kod_okpo := 'I' || LPAD (TO_CHAR (rnk_), 9, '0');
            END IF;
            k021_ := '9';
         ELSE
            IF custtype_ = 2
            THEN
               BEGIN
                  SELECT LPAD (SUBSTR (TRIM (ser) || TRIM (numdoc), 1, 10),
                               10,
                               '0'
                              )
                    INTO kod_okpo
                    FROM person
                   WHERE rnk = rnk_;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     kod_okpo := 'RNK' || LPAD (SUBSTR (rnk_, 1, 7), 7, '0');
               END;
               k021_ := '6';
            ELSE
               kod_okpo := 'RNK' || LPAD (SUBSTR (rnk_, 1, 7), 7, '0');
               k021_ := 'E';
            END IF;
         END IF;
      ELSE
         kod_okpo := LPAD (kod_okpo, 10, '0');
         if rez_ = 3 then 
            select ise 
                into ise_
            from customer 
            where rnk = rnk_;

            k021_ := '1';
            if ise_ in ('13110','13120','13131','13132') 
            then 
               k021_ := 'G';
            end if;
         end if;

         if rez_ = 5 then
            k021_ := '2';
         end if;
      END IF;

      -- ����������� ���� ������������� ������������
      k110_ := NVL (ved_, '00000');

      -- ����������� ���� �������
      IF NVL (reg_, 0) > 0
      THEN
         BEGIN
            SELECT ko
              INTO reg_
              FROM kodobl_reg o
             WHERE o.c_reg = reg_;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               reg_ := our_reg_;
         END;
      ELSE
         reg_ := our_reg_;
      END IF;

      -- ��� ������������ ��������
      IF rez_ in (2,4,6)
      THEN
         k110_ := '00000';                      -- ��� ������. ������������
         p021_ := '2';                          -- ��� ������� ��������� ��� ������������ 0 (����) (��� ����� �������������)
         reg_ := 0;
      END IF;

      -- �_���_��� � ����������� �������_�, ������ ���� 20 �� �_���� %% ���������� �����
      IF    (p060_ <> 99 AND custtype_ = 2)   -- AND sum_contr_ < 15000000)  --8000000)
         OR (pog_ AND sum_zd_ = 0)
         OR (pog_ AND p120_ = 0 AND p125_ = 0)
      THEN                                   -- ��������� ��� �������� �������
         p040_ := 0;
      ELSE
         BEGIN
            IF custtype_ = 2
            THEN                                         -- ��� �_������ ��_�
               SELECT COUNT (*)
                  INTO p040_
               FROM
                  ( SELECT distinct a.rnk
                    FROM ( SELECT rnkb rnk
                           FROM cust_bun
                           WHERE rnka = rnk_ 
                             and id_rel in (5, 12)
                             and nvl(edate, Dat_)>=Dat_            --(c 29.08.08 - 10%)
                             and nvl(bdate, Dat_)<=Dat_
                         ) a
                  );
            ELSE
               SELECT COUNT (*)
                  INTO p040_
               FROM (SELECT b.rnka, b.rnkb, b.okpo_u, b.doc_number, min(b.id_rel)
                     FROM cust_bun b
                     WHERE b.rnka = rnk_
                       AND b.id_rel IN (1, 4)
                       AND NVL (b.vaga1, 0) + NVL (b.vaga2, 0) >= sum_proc   --20;
                       AND nvl(b.edate, Dat_)>=Dat_            --(c 29.08.08 - 10%)
                       AND nvl(b.bdate, Dat_)<=Dat_
                     GROUP BY b.rnka, b.rnkb, b.okpo_u, b.doc_number);
            END IF;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               p040_ := 0;
         END;
      END IF;

      INSERT INTO otcn_f71_cust
                  (rnk, okpo, rez, custtype, p010, p020, p025,
                   p040, p050, p055,
                   p060, p085, k021
                  )
           VALUES (rnk_, kod_okpo, rez_, custtype_, p010_, p021_, k110_,
                   TO_CHAR (p040_), TO_CHAR (p050_), TO_CHAR (reg_),
                   LPAD(TO_CHAR (p060_),2,'0'), s085_, k021_
                  );

      p_rnk_ := rnk_;
   END;

   PROCEDURE p_ins_kredit (ptype_ IN NUMBER)
   IS
-- ������ ���������� ��������� ���������
   BEGIN

      p080_list := '';

      --- ��������� ����������� ����������� ������ ��� ��������� �����������
      IF p_rnk_ IS NULL OR p_rnk_ <> rnk_
      THEN
         p_ins_contr;
      END IF;

      if Dat_ < dat_izm3
      then
         -- �i������ ���� �������� �������������i �����������
         IF ddd_ IN ('119', '121', '123')
         THEN
            IF p060_ <> 99
            THEN                                                    -- ���������
               IF sum_sk_ > 0
               THEN
                  p150_ :=
                     LTRIM (TO_CHAR (ROUND ((ABS (p120_) / sum_sk_) * 100, 4),
                                     fmt_
                                    )
                           );
               ELSE
                  p150_ := '0';
               END IF;
            ELSE
               IF sum_k_ > 0
               THEN
                  p150_ :=
                     LTRIM (TO_CHAR (ROUND ((ABS (p120_) / sum_k_) * 100, 4),
                                     fmt_)
                           );
               ELSE
                  p150_ := '0';
               END IF;
            END IF;
         ELSE
            p150_ := '0';
         END IF;
      end if;

      IF accn_ IS NOT NULL
      THEN
         acc_ := accn_;
      END IF;

      -- ����i��� ������������ �������
      IF p120_ <> 0 AND ddd_ IN ('121', '122', '123', '119') then
         if Dat_ <= to_date('30112012','ddmmyyyy') then
            if rezid_ IS NOT NULL
            THEN
                -- �������� �� ������� ������� �� ����� ������
                BEGIN
                   SELECT t.soq, gl.p_icurval(t.kv, nvl(t.sz1, t.sz), t.dat)
                     INTO sum_ob_, sum_rez_
                     FROM tmp_rez_risk t
                    WHERE t.acc = acc_ AND dat = dat_ AND ID in (select userid from rez_protocol where dat=Dat_);  --ID = rezid_;
                EXCEPTION
                   WHEN NO_DATA_FOUND
                   THEN
                      sum_ob_ := 0;
                      sum_rez_ := 0;
                END;
             ELSE
             -- ������� 17.03.2008 ��� ������ ������ � �������������� ������
                sum_rez_ := gl.p_icurval (kv_, rez1.ca_f_rezerv (acc_, dat_), dat_);
            end if;
         else
            -- �������� �� ������� ������� �� ������ ������ �� V_TMP_REZ_RISK (NBU23_REZ)
            BEGIN
               SELECT t.rezq*100, to_char(t.k)
                  INTO sum_rez_, p150_ 
               FROM nbu23_rez t                         
               WHERE t.acc = acc_
                 and t.fdat = dat23_
                 and rownum = 1;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  sum_rez_ := 0;
                  p150_ := 0;
            END;
            
            if substr(nls_, 1, 4) in ('3578','3579') and p150_ = '0'
            then

               BEGIN
                  SELECT to_char(t.k)
                     INTO p150_ 
                  FROM nbu23_rez t                         
                  WHERE t.acc <> acc_
                    and t.fdat = dat23_
                    and t.nd = nd_
                    and t.tip in ('SS', 'SP', 'SN', 'SPN')
                    and rownum = 1;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     null;
               END;

            end if;

         end if;
      else
         sum_rez_ := 0;
      END IF;

      -- dbms_output.put_line('REZ='||to_char(sum_rez_));

      --07.05.2008 ������� �� ��������� ����� ����
      --(������ ���� ����� ����� �����������, � �� �����������)
      -- ����i��� ������������ �������
      IF p120_ <> 0 AND ddd_ IN ('121', '123', '119') and accn_ IS NULL
      THEN
         null;
      ELSE
         sum_ob_ := 0;
      END IF;

      if dat_ >= to_date('29122012','ddmmyyyy') then
         begin
            select nvl(sum(t.SALLq), 0) --, p080_list||t.pawn  --nvl(sum(gl.p_icurval(t.kv, t.SALL, Dat_)),0)
              into sum_ob_  --, p080_list
            from tmp_rez_zalog23 t  -- tmp_rez_obesp23 t
            where t.accs = acc_
              and t.dat = dat23_;
         EXCEPTION WHEN NO_DATA_FOUND THEN
              sum_ob_ := 0;
              -- ������� 19.06.2013
              --sum_ob_ := ca_fq_zalog (acc_, dat_);
         end;
      end if;

      p081_ := round (ABS (sum_ob_), 0);

      p125_ := ROUND (ABS (sum_rez_), 0);

      if nd_ is null
      then
         -- �������� ���� ������������� �������������
         BEGIN
            SELECT NVL (MAX (fdat), p111_)
              INTO p111p_
              FROM saldoa
             WHERE acc = acc_
               AND fdat <= dat_
               AND (   ostf = 0
                    OR (    ostf < 0
                        AND kos >= ABS (ostf)
                        AND ostf - dos + kos < 0
                       )
                   );
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               p111p_ := p111_;
         END;
      end if;

      if nd_ is null and p090_ is null
      then
         begin
            select NVL(s.nkd, 'N ���.')
               into p090_ 
            from specparam s
            where acc_ = s.acc(+);
         exception when no_data_found then
            null;
         end;

         p112p_ := null;

         select daos 
            into dat_nkd_
         from accounts 
         where acc = acc_;

      end if;

      if substr(nls_,1,4) in ('2625','2627','2202','2203','2208','9129')
         and trim(tip_) not in ('SS','SP','SN')
      then

         begin
            select dat_end
               into p112p_
            from bpk_acc
            where acc_  in  (acc_pk, acc_ovr, acc_2207, acc_2208, acc_2209, acc_9129);
         exception when no_data_found then
            begin
               select w.nd, NVL(s.nkd, 'N ���.'), w.dat_begin, w.dat_end
                  into nd_, p090_, dat_nkd_, p112p_
               from w4_acc w, specparam s
               where acc_ in (w.acc_pk, w.acc_ovr, w.acc_2207, w.acc_2208, w.acc_2209, w.acc_2627, w.acc_9129)
                 and w.acc_pk = s.acc(+);
            exception when no_data_found then
               null;
            end;
         end;
         p080_ := '33';
         p081_ := 0;
      end if;

      if substr(nls_,1,3) in ('140','141','142','300','301','310','311','321')
      then
         begin
            select max(NVL(initial_ref,0))
               into refn_
            from cp_deal 
            where acc_  in  (acc, accd, accp, accr, accr2, accr3,   
                             accs, accexpn, accexpr, accunrec)
              and active in (1, -1)
              and op = 3
              and initial_ref is not null;
         exception when no_data_found then
            refn_ := 0;
         end;

         if refn_ <> 0 
         then
            begin
               select cd.dat_ug, cd.dat_ug 
                  into dat_nkd_, p111p_
               from cp_deal cd, cp_kod ck 
               where cd.ref = refn_
                 and cd.id = ck.id
                 and cd.active in (1, -1)
                 and rownum = 1;  
            exception when no_data_found then
               null;
            end;
         end if;

         if refn_ <> 0 
         then
            begin
               select cd.ref, ck.cp_id, ck.datp 
                  into nd_, p090_, p112p_
               from cp_deal cd, cp_kod ck 
               where acc_  in  (cd.acc, cd.accd, cd.accp, cd.accr, cd.accr2, cd.accr3,   
                                cd.accs, cd.accexpn, cd.accexpr, cd.accunrec)
                 and cd.id = ck.id
                 and cd.active in (1, -1) 
                 and rownum = 1;  
            exception when no_data_found then
               begin
                  select NVL(s.nkd, 'N ���.')
                     into p090_ 
                  from specparam s
                  where acc_ = s.acc(+);
               exception when no_data_found then
                  null;
               end;
            end;
         else 
            begin
               select cd.ref, ck.cp_id, cd.dat_ug, cd.dat_ug, ck.datp 
                  into nd_, p090_, dat_nkd_, p111p_, p112p_
               from cp_deal cd, cp_kod ck 
               where acc_  in  (cd.acc, cd.accd, cd.accp, cd.accr, cd.accr2, cd.accr3,    
                                cd.accs, cd.accexpn, cd.accexpr, cd.accunrec)
                 and cd.id = ck.id
                 and cd.active in (1, -1) 
                 and rownum = 1;  
            exception when no_data_found then
               begin
                  select NVL(s.nkd, 'N ���.')
                     into p090_ 
                  from specparam s
                  where acc_ = s.acc(+);
               exception when no_data_found then
                  null;
               end;
            end;
         end if;

         p130_ := acrn_otc.fprocn(acc_, 0, dat_);  
      end if;

      -- ����������� 3041 
      if substr(nls_,1,4) in ('3041')
      then
         begin
            select fx.deal_tag, fx.dat, fx.dat_a 
               into p090_, dat_nkd_, p111p_
            from fx_deal fx
            where fx.ref = ( select min(t.ref) 
                             from TMP_VPKLB t
                             where t.sk = rnk_
                             group by t.sk);  
         exception when no_data_found then
            null;
         end;

         begin
            select fx.dat_a 
               into p112p_
            from fx_deal fx
            where fx.ref = ( select max(t.ref) 
                             from TMP_VPKLB t
                             where t.sk = rnk_
                             group by t.sk);  
         exception when no_data_found then
            null;
         end;
      end if;

      -- ���������� 090, 092, 112 ��� 9200, 9202  
      if substr(nls_,1,4) in ('9200', '9202', '9208')
      then
         begin
            select fx.ntik, fx.dat, fx.dat_a 
               into p090_, dat_nkd_, p112p_
            from fx_deal fx
            where fx.acc9a = acc_
              --and fx.sos <> 15
              and fx.dat_a > dat_
              and rownum = 1;
         exception when no_data_found then
            null;
         end;
      end if;
   
      if p120_ <> 0 
      then
    
         begin
            INSERT INTO otcn_f71_temp
                        (rnk, acc, tp, nd, p090, p080, p081, p110,
                         p111, p112, p113, p160, nbs, kv, ddd,
                         p120, p125, p130, p150, nls, fdat, isp
                        )
                 VALUES (rnk_, acc_, ptype_, nd_, p090_, p080_, p081_, sum_zd_,
                         p111p_, p112p_, dat_nkd_, s080_, p070_, kv_, ddd_,
                         p120_, p125_, p130_, p150_, nls_, data_, isp_
                        );
         exception
           when others then
               logger.info ('P_FD8_NN: Error rnk = '||to_char(rnk_));
         end;

         INSERT INTO otcn_f71_history
                     (datf, acc, ostf, nd, p080, p081, p090, p110,
                      p111, p112, p130, p040, rnk
                     )
              VALUES (dat_, acc_, p120_, nd_, p080_, p081_, p090_, sum_zd_,
                      p111p_, p112p_, p130_, kv_, rnk_
                     );
      end if;

   END;
---------------------------------------------------------------------------
   PROCEDURE p_over_1 (acc_ IN OUT NUMBER)
   IS
      acco_ number;
   BEGIN
      IF p070_ = '3578'
      THEN
         accn_ := acc_;

         SELECT COUNT (*)
           INTO kol_dz
           FROM otcn_acc a, int_accn i, otcn_acc b, acc_over c
          WHERE a.acc = accn_
            AND a.acc = i.acra
            AND i.acc = b.acc
            AND b.acc = c.acc_8000;

         IF kol_dz = 0
         THEN
            SELECT (-1) * COUNT (*)
              INTO kol_dz
              FROM otcn_acc a, int_accn i, otcn_acc b, acc_over_archive c
             WHERE a.acc = accn_
               AND a.acc = i.acra
               AND i.acc = b.acc
               AND b.acc = c.acc_8000;
         END IF;

         IF kol_dz > 0
         THEN
            SELECT c.acc, c.acc_9129
              INTO acc_, acco_
              FROM otcn_acc a, int_accn i, otcn_acc b, acc_over c
             WHERE a.acc = accn_
               AND a.acc = i.acra
               AND i.acc = b.acc
               AND b.acc = c.acc_8000;
         ELSIF kol_dz < 0
         THEN
            SELECT c.acc, c.acc_9129
              INTO acc_, acco_
              FROM otcn_acc a, int_accn i, otcn_acc b, acc_over_archive c  
             WHERE a.acc = accn_
               AND a.acc = i.acra
               AND i.acc = b.acc
               AND b.acc = c.acc_8000;
         END IF;

         IF kol_dz <> 0
         THEN
            BEGIN
               SELECT ABS (SUM (gl.p_icurval (s.kv, s.ost, s.fdat)))
                 INTO sum_71
                 FROM sal s
                WHERE s.acc IN (acc_, acco_) AND s.ost < 0 AND s.fdat = pdat_;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  sum_71 := 0;
            END;
         END IF;
      ELSE
         sum_71 := ABS (p120_);

         IF p070_ IN ('2067', '2069', '2096')
         THEN
            BEGIN
               SELECT COUNT (*)
                 INTO kol_dz
                 FROM acc_over c
                WHERE acc_ IN (c.acc_2067, c.acc_2069, c.acc_2096)
                  AND NVL (c.sos, 0) <> 1;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  kol_dz := 0;
            END;

            IF kol_dz = 0
            THEN
               BEGIN
                  SELECT (-1) * COUNT (*)
                    INTO kol_dz
                    FROM acc_over_archive c
                   WHERE acc_ IN (c.acc_2067, c.acc_2069, c.acc_2096);
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     kol_dz := 0;
               END;
            END IF;

            IF kol_dz > 0
            THEN
               BEGIN
                  SELECT NVL (ABS (SUM (gl.p_icurval (s.kv, s.ost, s.fdat))),
                              0
                             )
                    INTO sum_71o
                    FROM sal s, acc_over c
                   WHERE acc_ IN (c.acc_2067, c.acc_2069, c.acc_2096)
                     AND NVL (c.sos, 0) <> 1
                     AND s.acc = c.acc
                     AND s.ost < 0
                     AND s.fdat = pdat_;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     sum_71o := 0;
               END;
            END IF;
         ELSIF p070_ IN ('9129', '9100')
         THEN
            BEGIN
               SELECT COUNT (*)
                 INTO kol_dz
                 FROM acc_over c
                WHERE c.acc_9129 = acc_ AND NVL (c.sos, 0) <> 1;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  kol_dz := 0;
            END;

            IF kol_dz = 0
            THEN
               BEGIN
                  SELECT (-1) * COUNT (*)
                    INTO kol_dz
                    FROM acc_over_archive c
                   WHERE c.acc_9129 = acc_;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     kol_dz := 0;
               END;
            END IF;

            IF kol_dz > 0
            THEN
               BEGIN
                  SELECT ABS (gl.p_icurval (s.kv, s.ost, s.fdat)),
                         acrn_otc.FPROCN(c.acco, 0, s.fdat)
                    INTO sum_71o, p130_
                    FROM sal s, acc_over c
                   WHERE c.acc_9129 = acc_
                     AND s.acc = c.acc
                     AND s.ost < 0
                     AND s.fdat = pdat_
                     AND NVL (c.sos, 0) <> 1;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     sum_71o := 0;

                     begin
                         SELECT acrn_otc.FPROCN(c.acco, 0, dat_)
                         INTO p130_
                         FROM acc_over c
                         WHERE c.acc_9129 = acc_
                            AND NVL (c.sos, 0) <> 1;
                     exception
                        When No_Data_Found then null;
                     end;
               END;
            ELSIF kol_dz < 0
            THEN
               BEGIN
                  SELECT ABS (gl.p_icurval (s.kv, s.ost, s.fdat)),
                         acrn_otc.FPROCN(c.acco, 0, s.fdat)
                    INTO sum_71o, p130_
                    FROM sal s, acc_over_archive c
                   WHERE c.acc_9129 = acc_
                     AND s.acc = c.acc
                     AND s.ost < 0
                     AND s.fdat = pdat_
                     AND rownum = 1;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     sum_71o := 0;

                     begin
                         SELECT acrn_otc.FPROCN(c.acco, 0, dat_)
                         INTO p130_
                         FROM acc_over_archive c
                         WHERE c.acc_9129 = acc_
                           and rownum = 1;
                     exception
                        When No_Data_Found then null;
                     end;
               END;
            else -- ��� ���, ���� ������� ������ 9129 ���������
               if mfou_ = 300465 then
                  declare
                     acc_ovr_ number;
                  begin
                     execute immediate 'select ACC_OVR from bpk_acc where acc_9129 = :acc_'
                     into acc_ovr_ using acc_;

                     if acc_ovr_ is not null then
                        p130_ := acrn_otc.FPROCN(acc_ovr_, 0, dat_);
                     end if;
                  exception
                     when no_data_found then
                          null;
                  end;
               end if;
            END IF;
         ELSE
            --          sum_71:=ABS(p120_);
            --
            BEGIN
               SELECT COUNT (*)
                 INTO kol_dz
                 FROM acc_over c
                WHERE c.acc = acc_;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  kol_dz := 0;
            END;

            IF kol_dz = 0
            THEN
               BEGIN
                  SELECT (-1) * COUNT (*)
                    INTO kol_dz
                    FROM acc_over_archive c
                   WHERE c.acc = acc_ AND NVL (c.sos, 0) <> 1;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     kol_dz := 0;
               END;
            END IF;

            IF kol_dz > 0
            THEN
               BEGIN
                  SELECT ABS (gl.p_icurval (s.kv, s.ost, s.fdat)),
                         acrn_otc.FPROCN(c.acco, 0, s.fdat)
                    INTO sum_71o, p130_
                    FROM sal s, acc_over c
                   WHERE c.acc = acc_ AND s.acc = c.acc_9129
                         AND s.fdat = pdat_
                         AND s.ost<0
                         AND NVL (c.sos, 0) <> 1;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     sum_71o := 0;
               END;
            END IF;
         END IF;

         sum_71 := sum_71 + NVL (sum_71o, 0);
      END IF;
   END;

------------------------------------------------------------------
   PROCEDURE p_over_2 (acc_ IN NUMBER)
   IS
      proc_   NUMBER := 0;
      acco_   NUMBER;
   BEGIN
      IF p070_ IN ('2067', '2069', '2096')
      THEN
         IF kol_dz > 0
         THEN
            SELECT c.ndoc, NVL (c.datd, p112_ - c.DAY),
                   NVL (c.datd, p112_ - c.DAY), c.datd2,
                   gl.p_icurval (kv_, c.sd, dat_), c.nd,
                   acco
              INTO p090_, dat_nkd_,
                   p111p_, p112p_,
                   sum_71, nd_, acco_
              FROM acc_over c
             WHERE acc_ IN (c.acc_2067, c.acc_2069, c.acc_2096)
               AND NVL (c.sos, 0) <> 1
               and c.datd is not null
               AND ROWNUM = 1;
         ELSE
            SELECT c.ndoc, NVL (c.datd, p112_ - c.DAY),
                   NVL (c.datd, p112_ - c.DAY), c.datd2,
                   gl.p_icurval (kv_, c.sd, dat_), NVL (c.pr_9129, 0), c.nd,
                   acco
              INTO p090_, dat_nkd_,
                   p111p_, p112p_,
                   sum_71, proc_, nd_, acco_
              FROM (SELECT   *
                        FROM acc_over_archive
                       WHERE acc_ IN (acc_2067, acc_2069, acc_2096)
                    ORDER BY datd DESC, ndoc DESC) c
             WHERE ROWNUM = 1;
         END IF;
      ELSIF p070_ IN ('9129', '9100')
      THEN
         IF kol_dz > 0
         THEN
            SELECT c.ndoc, NVL (c.datd, p112_ - c.DAY),
                   NVL (c.datd, p112_ - c.DAY), c.datd2,
                   c.nd, acrn_otc.FPROCN(c.acco, 0, pdat_), acco
              INTO p090_, dat_nkd_,
                   p111p_, p112p_, nd_, p130_, acco_
              FROM acc_over c
             WHERE c.acc_9129 = acc_ AND 
                   NVL (c.sos, 0) <> 1 AND 
                   c.datd is not null and 
                   ROWNUM = 1;
         ELSE
            SELECT c.ndoc, NVL (c.datd, p112_ - c.DAY),
                   NVL (c.datd, p112_ - c.DAY), c.datd2,
                   gl.p_icurval (kv_, c.sd, dat_), NVL (c.pr_9129, 0), c.nd,
                   acrn_otc.FPROCN(c.acco, 0, pdat_),acco
              INTO p090_, dat_nkd_,
                   p111p_, p112p_,
                   sum_71, proc_, nd_, p130_, acco_
              FROM (SELECT   *
                        FROM acc_over_archive
                       WHERE acc_9129 = acc_
                    ORDER BY datd DESC, ndoc DESC) c
             WHERE ROWNUM = 1;
         END IF;
      ELSE
         IF kol_dz > 0
         THEN
            SELECT c.ndoc, NVL (c.datd, p112_ - c.DAY),
                   NVL (c.datd, p112_ - c.DAY), c.datd2,
                   c.nd, acco
              INTO p090_, dat_nkd_,
                   p111p_, p112p_,
                   nd_, acco_
              FROM acc_over c
             WHERE c.acc = acc_ AND NVL (c.sos, 0) <> 1 and c.datd is not null;
         ELSE
            SELECT c.ndoc, DECODE (c.datd, NULL, p112_ - c.DAY, c.datd),
                   DECODE (c.datd, NULL, p112_ - c.DAY, c.datd),
                   c.datd2, gl.p_icurval (kv_, c.sd, dat_),
                   NVL (c.pr_komis, 0), c.nd, acco
              INTO p090_, dat_nkd_,
                   p111p_,
                   p112p_, sum_71,
                   proc_, nd_, acco_
              FROM (SELECT   *
                        FROM acc_over_archive
                       WHERE acc = acc_
                    ORDER BY datd DESC, ndoc DESC) c
             WHERE ROWNUM = 1;
         END IF;
      END IF;

      IF kol_dz < 0 AND p130_ = 0
      THEN
         IF proc_ <> 0
         THEN
            p130_ := proc_;
         ELSE
            p130_ := acrn_otc.fprocn (acc_, 0, data_ - 1);
         END IF;
      elsif p130_ = 0 and p070_ IN ('9129', '9100') then
         p130_ := acrn_otc.fprocn (acco_, 0, dat_);
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20011,
                                     '���� ����������: acc='
                                  || acc_
                                  || ' ������: '
                                  || SQLERRM
                                 );
   END;

------------------------------------------------------------------
   PROCEDURE p_obrab_kd
   IS
-- ����������� �������� ���������� ��
   BEGIN
      sum_71 := 0;
      sum_71o := 0;
      sum_lim := 0;

      IF    TRIM (tip_) IN
               ('ODB',
                'SS',
                'SN',
                'SNA',
                'SNO',
                'SPN',
                'SP',
                'SL',
                'SLN',
                'SDI',
                'SPI',
                'SK0',
                'SK9',
                'SKA',
                'XOZ'
               )
         OR p070_ = '9129'
      THEN

         BEGIN
            if vidd_ IN (9, 19, 29, 39) then
               SELECT n.nd, NVL (c.cc_id, nkd_), 
                      c.sdate, c.wdate, 
                      c.wdate, c.vidd
                 INTO nd_, p090_, dat_nkd_, p111p_, p112p_, vidd_
               FROM nd_acc n, cc_deal c
               WHERE n.acc = acc_
                 AND n.nd = c.nd
                 AND (c.sdate, c.nd) =
                        (SELECT MAX (p.sdate), MAX (p.nd)
                         FROM nd_acc a, cc_deal p
                         WHERE a.acc = acc_
                           AND a.nd = p.nd
                           AND p.sdate <= dat_);

               -- ��������: ���������� �� �����-���� ����� �� ����� �������� � ������. ����
               SELECT COUNT (*)
                 INTO kolvo_
                 FROM otcn_f71_history
                WHERE nd = nd_ AND datf = dat2_ AND ostf <> 0;

               IF kolvo_ > 0
               THEN
                  pog_ := TRUE;
               END IF;
               if dat_ >= dat_izm3 
               then 
                  pog_ := FALSE;
               end if;
            else
               SELECT n.nd, NVL (c.cc_id, nkd_), 
                      c.sdate, s.wdate, 
                      c.wdate, c.vidd
                 INTO nd_, p090_, dat_nkd_, p111p_, p112p_, vidd_
               FROM nd_acc n, cc_deal c, cc_add s
               WHERE n.acc = acc_
                 AND n.nd = c.nd
                 AND s.nd(+) = c.nd
                 AND NVL(s.adds,0) = 0
                 AND (c.sdate, c.nd) =
                        (SELECT MAX (p.sdate), MAX (p.nd)
                         FROM nd_acc a, cc_deal p
                         WHERE a.acc = acc_
                           AND a.nd = p.nd
                           AND p.sdate <= dat_);

               -- ��������: ���������� �� �����-���� ����� �� ����� �������� � ������. ����
               SELECT COUNT (*)
                 INTO kolvo_
                 FROM otcn_f71_history
                WHERE nd = nd_ AND datf = dat2_ AND ostf <> 0;

               IF kolvo_ > 0
               THEN
                  pog_ := TRUE;
               END IF;
               if dat_ >= dat_izm3 
               then 
                  pog_ := FALSE;
               end if;
            end if;

            -- ��� ��������� �������� ���.�������� ���� ���������� (DEB02)
            if TRIM (tip_) = 'XOZ'
            then
               BEGIN
                  select deb02
                     into dat_nkd_
                  from specparam_int
                  where acc = acc_;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
                  null;
               END;
            end if;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               nd_ := NULL;
               p090_ := nkd_;
               dat_nkd_ := p111_;
               p111p_ := p111_;
               p112p_ := p112_;
               vidd_ := 0;
            WHEN TOO_MANY_ROWS
            THEN
               raise_application_error
                         (-20008,
                             '���� '''
                          || nls_
                          || ''' (acc='
                          || acc_
                          || ',rnk='
                          || rnk_
                          || ') ������������ � ���������� ������. ���������!!! '
                         );
            WHEN OTHERS
            THEN
               raise_application_error (-20002,
                                        'acc=' || acc_ || ' ������ : '
                                        || SQLERRM
                                       );
         END;
      END IF;

      -- ���������� ��� ��������� ����� (�_������������, ���_������������)
      BEGIN
         select nvl(trim(txt),'0')
            into vidd_kl
         from nd_txt
         where nd = nd_
           and tag like 'I_CR9%';
      EXCEPTION WHEN NO_DATA_FOUND THEN
         vidd_kl := 0;
      END;

--- ���� ��������� ����� (������� ��� ��������������)
      IF vidd_ IN (2, 3, 12, 13)
      THEN
         if vidd_kl = 0 then
            BEGIN                                           -- �������������� �����
               SELECT gl.p_icurval (a.kv, l.lim2, dat_) +   -- ������������� 9129
                      gl.p_icurval (a.kv, NVL(CCK_APP.TO_NUMBER2(nvl(CCK_APP.GET_ND_TXT(nd_, 'D9129'), 0)),0), dat_),
                      a.wdate
                 INTO sum_lim, p111p_
                 FROM cc_lim l, cc_add a
                WHERE (l.nd, l.fdat) IN (
                         SELECT   l2.nd, MIN (l2.fdat)
                             FROM cc_lim l2
                            WHERE l2.nd = nd_
                              AND l2.fdat <= dat_
                              AND l2.lim2 <> 0
                         GROUP BY l2.nd)
                  AND l.nd = a.nd
                  AND a.kv IS NOT NULL
                  AND a.adds = 0;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  sum_lim := 0;
                  p111p_ := p111_;
               WHEN OTHERS
               THEN
                    if sqlcode = -6502 then
                       SELECT gl.p_icurval (a.kv, l.lim2, dat_) +   -- ������������� 9129
                              gl.p_icurval (a.kv, NVL(nvl(to_number(CCK_APP.GET_ND_TXT(nd_, 'D9129')), 0),0), dat_),
                              a.wdate
                         INTO sum_lim, p111p_
                         FROM cc_lim l, cc_add a
                        WHERE (l.nd, l.fdat) IN (
                                 SELECT   l2.nd, MIN (l2.fdat)
                                     FROM cc_lim l2
                                    WHERE l2.nd = nd_
                                      AND l2.fdat <= dat_
                                      AND l2.lim2 <> 0
                                 GROUP BY l2.nd)
                          AND l.nd = a.nd
                          AND a.kv IS NOT NULL
                          AND a.adds = 0;
                    else
                       raise_application_error (-20012,
                                                'nd=' || nd_ || ' ������ : '
                                                || SQLERRM
                                               );
                    end if;
            END;
         else
            BEGIN                                            -- ������� �����
               SELECT gl.p_icurval (a.kv, l.lim2, dat_), a.wdate
                 INTO sum_lim, p111p_
                 FROM cc_lim l, cc_add a
                WHERE (l.nd, l.fdat) IN (
                         SELECT   l2.nd, MAX (l2.fdat)
                             FROM cc_lim l2
                            WHERE l2.nd = nd_
                              AND l2.fdat <= dat_
                              AND l2.lim2 <> 0
                         GROUP BY l2.nd)
                  AND l.nd = a.nd
                  AND a.kv IS NOT NULL
                  AND a.adds = 0;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  sum_lim := 0;
                  p111p_ := p111_;
            END;
         end if;
      ELSIF vidd_ IN (9, 19, 29, 39)
      THEN                                       -- ���� ��� �������� ��������
         BEGIN
            SELECT ABS (gl.p_icurval (kv_, a.LIMIT * 100, dat_))
              INTO sum_lim
              FROM cc_deal a
             WHERE a.nd = nd_;  -- and a.sos != '15';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               sum_lim := 0;
         END;
      ELSE
         -- 20.12.2013 �_����_��� �� �������� ������� ������������ �����_�����
         --            ������ �������� (������� �.�.) �������� 110 �� ������������� ����
         --            ���� ��������_ �����
         -- ���_��� ��_��� mfo_ ������������� mfou_
         IF --mfo_ NOT IN (300205, 300120, 353575, 305482, 328845, 322669, 380764)  -- ���� �� 17.10.2012 ���������� 05.12.2012
            mfou_ NOT IN (300205, 353575, 300465, 380764)  -- ����� 05.12.2012
         THEN
            BEGIN                                            -- ������� �����
               SELECT gl.p_icurval (a.kv, l.lim2, dat_), a.wdate
                 INTO sum_lim, p111p_
                 FROM cc_lim l, cc_add a
                WHERE (l.nd, l.fdat) IN (
                         SELECT   l2.nd, MAX (l2.fdat)
                             FROM cc_lim l2
                            WHERE l2.nd = nd_
                              AND l2.fdat <= dat_
                              AND l2.lim2 <> 0
                         GROUP BY l2.nd)
                  AND l.nd = a.nd
                  AND a.kv IS NOT NULL
                  AND a.adds = 0;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  sum_lim := 0;
                  p111p_ := p111_;
            END;
         ELSE
            BEGIN                         -- �������������� ����� �� ��������
               SELECT gl.p_icurval (a.kv, l.lim2, dat_), a.wdate
                 INTO sum_lim, p111p_
                 FROM cc_lim l, cc_add a
                WHERE (l.nd, l.fdat) IN (
                         SELECT   l2.nd, MIN (l2.fdat)
                             FROM cc_lim l2
                            WHERE l2.nd = nd_
                              AND l2.fdat <= dat_
                              AND l2.lim2 <> 0
                         GROUP BY l2.nd)
                  AND l.nd = a.nd
                  AND a.kv IS NOT NULL
                  AND a.adds = 0;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  sum_lim := 0;
                  p111p_ := p111_;
            END;

            BEGIN
            -- ����� �� ���. ���������� (���������� 111 = ���� ���������� ������ �� ���. ����������)
               SELECT gl.p_icurval (a.kv, l.lim2, dat_)             --, l.FDAT
                 INTO sum_lim                                       --, p111p_
                 FROM cc_lim l, cc_add a
                WHERE (l.nd, l.fdat) IN (
                         SELECT nd_, MAX (fdat)
                           FROM (SELECT nd, fdat, lim2 lim,
                                        LAG (lim2, 1, 0) OVER (PARTITION BY nd ORDER BY fdat)
                                                                  AS prev_lim
                                   FROM cc_lim
                                  WHERE nd = nd_ AND fdat <= dat_)
                          WHERE prev_lim <> 0 AND lim > prev_lim)
                  AND l.nd = a.nd
                  AND a.kv IS NOT NULL
                  AND a.adds = 0;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  NULL;
            END;

         END IF;

      END IF;

      sum_zd_ := sum_lim;

      --- ����� ����� �� ������ ��������
      BEGIN
         IF nd_ IS NOT NULL
         THEN
            if vidd_ IN (9, 19, 29, 39)
            THEN                              -- ���� ��� �������� ��������
               -- �������� ���� ������������� �������������
               BEGIN
                  SELECT NVL (MAX (fdat), p111_)
                    INTO p111p_
                    FROM saldoa
                   WHERE acc = acc_
                     AND fdat <= dat_
                     AND (   ostf = 0
                          OR (    ostf < 0
                              AND kos >= ABS (ostf)
                              AND ostf - dos + kos < 0
                             )
                         );
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     p111p_ := p111_;
               END;
            end if;

            -- ��� ����� � ���.��� �� ����������� ������ ����� �� ��������
            if vidd_ <> 11 then
               -- � ��������� ������
               SELECT /*+ordered*/
                    ABS (SUM (decode(a.kv, 980, a.ost-a.dos96+a.kos96, a.ostq-a.dosq96+a.kosq96)))
                 INTO sum_71
               FROM nd_acc p, otcn_acc s, kl_f3_29 k, otcn_saldo a
               WHERE p.nd = nd_
                 AND p.acc = s.acc
                 AND s.nbs = k.r020
                 AND k.kf = '71'
                 AND NVL (k.ddd, '121') NOT IN ('122','123','124','125')
                 AND s.acc = a.acc;

                 if mfou_  in (300465) then
                    -- ������� 04.06.2013 (��������� ���������)
                    sum_zd_ := sum_71;
                 end if;
            end if;
         ELSE
            -- �������� ���� ������������� �������������
            BEGIN
               SELECT NVL (MAX (fdat), p111_)
                 INTO p111p_
                 FROM saldoa
                WHERE acc = acc_
                  AND fdat <= dat_
                  AND (   ostf = 0
                       OR (    ostf < 0
                           AND kos >= ABS (ostf)
                           AND ostf - dos + kos < 0
                          )
                      );
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  p111p_ := p111_;
            END;

            IF nls_ LIKE '202%' OR nls_ LIKE '222%'
            THEN
               -- �� �������� ��������
               -- ����� ������������� �� �������� �� ������� �����������
               SELECT ABS (SUM (decode(s.kv, 980, s.ost-s.dos96+s.kos96, s.ostq-s.dosq96+s.kosq96)))
                 INTO sum_71
                 FROM otcn_saldo s, kl_f3_29 k
                WHERE s.nbs = k.r020
                  AND k.kf = '71'
                  AND (s.nbs LIKE '202%' OR s.nbs LIKE '222%')
                  AND NVL (k.ddd, '121') NOT IN ('122','123','124','125')
                  AND s.rnk = rnk_;

               -- ����� �� ������ ��������
                  SELECT ABS (SUM (decode(s.kv, 980, s.ost-s.dos96+s.kos96, s.ostq-s.dosq96+s.kosq96)))
                    INTO sum_zd_
                    FROM otcn_saldo s, kl_f3_29 k, specparam r
                   WHERE s.rnk = rnk_
                     AND k.r020 = s.nbs
                     AND k.kf = '71'
                     AND s.acc = r.acc
                     AND (s.nbs LIKE '202%' OR s.nbs LIKE '222%')
                     AND NVL (k.ddd, '121') NOT IN ('122','123','124','125')
                     AND r.nkd = nkd_;

               if NVL(sum_zd_,0) = 0 then
                  sum_zd_ := ABS (p120_);
               end if;

            ELSE
               -- �� ������� �?���� �����?�
               IF SUBSTR (nls_, 1, 3) NOT IN
                                         ('140','141','142','300', '301', '310', '311', '321')
               THEN
                  -- �� � ��������� ������, �� ��������� ���������
                  SELECT ABS (SUM (decode(s.kv, 980, s.ost - s.dos96 + s.kos96,
                                                     s.ostq - s.dosq96 + s.kosq96)))
                         --ABS(SUM(gl.p_icurval (s.kv, s.ost, dat_)))
                    INTO sum_zd_                                      --sum_71
                    FROM otcn_saldo s, specparam r, kl_f3_29 k
                   WHERE s.ost - s.dos96 + s.kos96 < 0
                     AND k.r020 = s.nbs
                     AND k.kf = '71'
                     AND NVL (k.ddd, '121') NOT IN ('122','123','124','125')
                     AND s.rnk = rnk_
                     AND s.acc = r.acc
                     AND r.nkd = nkd_;

                  if NVL(sum_zd_,0) = 0 then
                     sum_zd_ := ABS (p120_);
                  end if;
               END IF;

               -- ������� �?���� �����?� (������_ �_��_ ������)
               IF SUBSTR (nls_, 1, 3) IN ('140','141','142','300', '301', '310', '311', '321')
               THEN

                  -- ����� �� ������ ��������
                  SELECT ABS (SUM (decode(s.kv, 980, s.ost-s.dos96+s.kos96, s.ostq-s.dosq96+s.kosq96)))
                     INTO sum_zd_
                  FROM otcn_saldo s, specparam r, kl_f3_29 k
                  WHERE k.r020 = substr(s.nls,1,4)
                    AND k.kf = '71'
                    AND substr(s.nls,1,3) in ('140','141','142','300','301','310','311','321')
                    AND NVL (k.ddd, '121') NOT IN ('122','123','124','125')
                    AND s.rnk = rnk_
                    AND s.acc = r.acc(+)
                    AND NVL (r.nkd, 'N ���.') = NVL(nkd_, 'N ���.');


                  if NVL(sum_zd_,0) = 0 then
                     sum_zd_ := ABS (p120_);
                  end if;
               END IF;
            END IF;
         END IF;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            sum_71 := ABS (p120_);
      END;

      sum_71 := NVL (sum_71, 0);

      if mfou_ = 300465 then
         kol_ := 0;

         FOR k in ( select * from
                    (
                     select a.acc, a.nls, a.kv, a.daos
                     from  nd_acc n, accounts a
                     where n.nd = nd_
                       and a.acc = n.acc
                       and a.tip LIKE 'SS%'
                      UNION
                      select a.acc, a.nls, a.kv, a.daos
                      from nd_acc n, accounts a, specparam s
                      where n.nd = nd_
                        and a.acc = n.acc
                        and a.acc = s.acc(+)
                        and ( a.nbs || NVL(s.r013,'0') = '91291' or
                              a.nbs in ('9000','9001','9002','9003',
                                        '9020','9023','9100','9122')
                            )
                        and not exists ( select 1
                                         from accounts a1, nd_acc n1
                                         where a1.acc = n1.acc
                                           and n1.nd  = nd_
                                           and a1.tip like 'SS%'
                                       )
                    )
                    order by 2, 4
                  )
         loop

             kol_ := kol_ +1;
             -- �������� ���� ������������� �������������
             BEGIN
                SELECT NVL (MIN (fdat), p111p_)  --dat_)
                   INTO p111p_saldoa
                FROM saldoa
                WHERE acc = k.acc
                  AND fdat <= dat_
                  AND dos <> 0;
             EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                   p111p_saldoa := p111p_;  --null;
             END;

             if kol_ = 1 then
                p111_1 := p111p_saldoa;
             end if;
             if kol_ > 1 and p111p_saldoa < p111_1
             then
                p111_1 := p111p_saldoa;
             end if;

             p111p_ := p111_1;
         end loop;
      end if;

      BEGIN
         SELECT NVL(to_date(trim(t.txt),'dd/mm/yyyy'),p111p_) 
            INTO p111p_
         FROM nd_acc n, nd_txt t
         WHERE n.acc = acc_
           AND n.nd = t.nd(+)
           AND t.tag like 'DB_SS%';
      EXCEPTION WHEN NO_DATA_FOUND THEN
         null;
      END;          
   END;

------------------------------------------------------------------
   PROCEDURE p_obrab_pkd (ptype_ IN NUMBER)
   IS
   BEGIN
      IF     pog_
         AND ((nd_ IS NOT NULL AND nd_ <> nvl(p_nd_, 0) and 
               (nvl(p_nd_, 0) <> 0 or  
                nvl(p_nd_, 0) = 0 and nvl(p090_,'N ���.') <> nvl(p_p090_,'N ���.')))
                OR 
               (nd_ IS NULL AND nvl(p090_,'N ���.') <> nvl(p_p090_,'N ���.'))
             )
      THEN
         p080_ := p_p080_;
         p081_ := p_p081_;
         p090_ := p_p090_;
         sum_zd_ := p_sum_zd_;
         p111p_ := p_p111_;
         dat_nkd_ := p_p111_;
         p112p_ := p_p112_;
         p120_ := 0;
         p130_ := p_p130_;
         nd_ := p_nd_;

         SELECT MIN (c.fdat)
           INTO data_
           FROM saldoa c
          WHERE c.acc = acc_
            AND c.fdat > dat2_
            AND (   c.ostf - c.dos + c.kos = 0
                 OR (c.ostf < 0 AND c.kos >= ABS (c.ostf))
                );

         if data_ is not null
         then
            p_ins_kredit (ptype_);
         end if;
      END IF;
   END;

   PROCEDURE p_ins_log (p_kod_ VARCHAR2, p_val_ NUMBER)
   IS
   BEGIN
      IF kodf_ IS NOT NULL AND userid_ IS NOT NULL
      THEN
         INSERT INTO otcn_log
                     (kodf, userid,
                      txt
                     )
              VALUES (kodf_, userid_,
                      p_kod_ || TO_CHAR (p_val_ / 100, fmtkap_)
                     );
      END IF;
   END;
-------------------------------------------------------------------
BEGIN
   commit;

   EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
-------------------------------------------------------------------
   logger.info ('P_FD8_NN: Begin for datf = '||to_char(dat_, 'dd/mm/yyyy'));

   userid_ := user_id;
-------------------------------------------------------------------
   EXECUTE IMMEDIATE 'truncate table otcn_f71_rnk';

   EXECUTE IMMEDIATE 'truncate table TMP_LINK_GROUP';
   
   EXECUTE IMMEDIATE 'truncate table rnbu_trace';

-------------------------------------------------------------------
   DELETE FROM otcn_f71_history
         WHERE datf = dat_;

   EXECUTE IMMEDIATE 'truncate table OTCN_F71_TEMP';

   EXECUTE IMMEDIATE 'truncate table OTCN_F71_CUST';

-------------------------------------------------------------------
   EXECUTE IMMEDIATE 'alter session set NLS_NUMERIC_CHARACTERS=''.,''';

   mfo_ := f_ourmfo ();

-- ��� "��������"
   BEGIN
      SELECT mfou
        INTO mfou_
        FROM banks
       WHERE mfo = mfo_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         mfou_ := mfo_;
   END;

   BEGIN
      SELECT SUBSTR (sab, 2, 3)
        INTO sab_
        FROM banks
       WHERE mfo = mfo_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         raise_application_error
                         (-20009,
                             '� ���_����� ����_� ���� ������ � ����� MFO='''
                          || mfo_
                          || ''''
                         );
   END;
   
-- ��� �������, ��� ���������� ����
   BEGIN
      b040_ := SUBSTR (LPAD (f_get_params ('OUR_TOBO', NULL), 12, '0'), -12);

      IF SUBSTR (b040_, 1, 1) IN ('0', '1')
      THEN
         our_reg_ := TO_NUMBER (SUBSTR (b040_, 2, 2));
      ELSE
         our_reg_ := TO_NUMBER (SUBSTR (b040_, 7, 2));
      END IF;

      our_reg_ := NVL (our_reg_, '00');
   END;

   our_rnk_ := F_Get_Params ('OUR_RNK', -1);
   our_okpo_ := NVL(LPAD (to_char(F_Get_Params ('OKPO', 0)), 8,'0'),'0');

-- ���� ��� �������� VIEW CC_TRANS_DAT �� �������� ����
   pul.Set_Mas_Ini('sFdat1',to_char(Dat_,'dd.mm.yyyy'),'date');

-- ��� ������������� ���������� �� PARAMS PAR='OUR_TOBO' (���������� ���� b040_)
-- ���������� ��� ������� ��� ��� �� ���� ����� #D8 � ��� ������������
   p_proc_set (kodf_, sheme_, nbuc1_, typ_);
   nnnn_ := 0;

-- ���������� ���� �� ��� ����������� ������
    Dat23_  := TRUNC(add_months(Dat_,1),'MM');

-- ����������� ����� ������������� ��������
   sum_k_ := rkapital (dat_, kodf_, userid_, 1);

   IF dat_ >= TO_DATE ('01072006', 'ddmmyyyy')
   THEN
      -- ��������� ���i���
      sum_sk_ := NVL (TRIM (f_get_params ('NORM_SK', 0)), 0);

      IF dat_ <= to_date('30062012','ddmmyyyy') and NVL (sum_sk_, 0) <> 0 AND sum_sk_ * 0.05 < smax_
      THEN
         smax_ := sum_sk_ * 0.05;
      END IF;

      -- � 01.07.2012 ���.���� �� ����������� 1% �i� �� i ���� �������� 200000000 �� 200000000
      IF dat_ >= to_date('01072012','ddmmyyyy') and NVL (sum_sk_, 0) <> 0 AND sum_sk_ * 0.01 < smax_
      THEN
         smax_ := sum_sk_ * 0.01;
      END IF;
   ELSE
      sum_sk_ := sum_k_;
   END IF;

   -- ����� ������� ������� ���������� � 20% �� 10%
   if Dat_ >= to_date('29082008','ddmmyyyy') then
      sum_proc := 10;
   end if;

   p_ins_log
      (' -------------------------------- ���������� #D8 �����  --------------------------------- ',
       NULL
      );
   p_ins_log ('������������ ���i��� (��1): ', sum_k_);
   p_ins_log ('��������� ���i���: ', sum_sk_);
   p_ins_log ('smax_  : ', smax_);

                                                  -- �������� ����
   dat1_ := TO_DATE ('01' || TO_CHAR (dat_, 'mmyyyy'), 'ddmmyyyy');

   -- �_���� ���������� �_����
   SELECT MAX (fdat)
    INTO dat2_
    FROM fdat
   WHERE fdat < dat1_;

   -- ��� ��������?
   SELECT COUNT (*)
     INTO kolvo_
     FROM holiday
    WHERE holiday = dat2_ AND kv = 980;

   -- ���� ��, �� ���� �� ��������
   IF kolvo_ <> 0
   THEN
      dbuf_ := calc_pdat (dat2_);
      dat2_ := dbuf_ - 1;
   END IF;

   SELECT MAX (fdat)
     INTO pdat_
     FROM fdat
    WHERE fdat <= dat_;

   ndk_ := 0;

   -- ��� ������������, ������ �� ������� ������� �������� ��������������
   -- ��� ������������ �����
   -- ���� ���� �� ������������ = ��� �������� ������������
   BEGIN
      SELECT userid
        INTO rezid_
        FROM rez_protocol
       WHERE dat = dat_
         and rownum = 1;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         rezid_ := NULL;
   END;

   if prnk_ is null then
       sql_acc_ := 'select * from accounts a where nvl(a.nbs, substr(a.nls,1,4)) in ';
       sql_acc_ := sql_acc_ || '(select r020 from kl_f3_29 where kf=''71'') ';

       ret_ := F_Pop_Otcn(Dat_, 2, sql_acc_, null, 0, 1);
   else
       sql_acc_ := 'select * from accounts where rnk = '||to_char(prnk_)||' and nbs in ';
       sql_acc_ := sql_acc_ || '(select r020 from kl_f3_29 where kf=''71'') ';

       ret_ := F_Pop_Otcn(Dat_, 2, sql_acc_, null, 0, 1);
   end if;

   INSERT INTO OTCN_SALDO (ODATE, FDAT, ACC, NLS, KV, NBS, RNK,
               VOST, VOSTQ, OST, OSTQ,
               DOS, DOSQ, KOS, KOSQ,
               DOS96, DOSQ96, KOS96, KOSQ96,
               DOS96P, DOSQ96P, KOS96P, KOSQ96P,
               DOS99, DOSQ99, KOS99, KOSQ99, DOSZG, KOSZG, DOS96ZG, KOS96ZG, DOS99ZG, KOS99ZG)
    select dat_, dat_, a.acc, a.NLS,  a.KV, a.NBS, A.RNK,
           0 vost,
           0 vostq,
           0 ost,
           0 ostq,
           0 dos,
           0 dosq,
           0 Kos,
           0 Kosq,
           0 CRdos,
           0 CRdosq,
           0 CRKos,
           0 CRKosq,
           0 CUdos,
           0 CUdosq,
           0 CUKos,
           0 CUKosq,
           0,0,0,0,0,0,0,0,0,0
    from OTCN_ACC a
    where not exists (select 1 from otcn_saldo s1
                      where s1.acc = a.acc);

   -- ����� ���� ��� ������ ������ �� �� ������ �������� � �� ������������
   delete from otcn_acc
   where substr(nls,1,4) in (select r020 from kl_f3_29 where kf='1B' and trim(ddd) in ('211','212'))
     and acc in (select accc
                 from accounts
                 where accc is not null
                   and substr(nls,1,3) in ('140','141','142','300','301','310','311','321'));

   -- �� 01.04.2016 
   -- ���� ��� ������ ������ 3541 ������ �������� � �� ������������ OTCN_ACC
   delete from otcn_acc
   where acc in ( select accc
                  from accounts
                  where accc is not null
                    and substr(nls,1,4) in ('3541')
                );

   -- ���� ��� ������ ������ 3541 ������ �������� � �� ������������ OTCN_SALDO
   delete from otcn_saldo
   where acc in ( select accc
                  from accounts
                  where accc is not null
                    and substr(nls,1,4) in ('3541')
                );

   delete from otcn_saldo s
   where s.ost + s.ostq = 0
     and s.dos + s.kos + s.dosq + s.kosq = 0
     and s.dos96 + s.kos96 + s.dosq96 + s.kosq96 = 0
     and substr(s.nls,1,4) in ( select r020 from kl_f3_29
                                where kf = '71'
                                  and (ddd in ('122','123','124') or
                                       r020  like '28%' or r020 like '351%' or
                                       r020 like '354%' or r020 like '355%' or 
                                       r020 like '357%' or r020 like '9129%')
                              );

   -- �� 01.04.2017 ������� ���.���� 3040 ������������ ��������
   delete from otcn_saldo 
   where rnk in ( select rnk 
                  from customer 
                  where trim (okpo) = '00013480'  --rnk = 90092301
                ) 
     and nls like '3040%';

   -- ������� �������� ���.����� '1415','1416','1417','1418','1426','1428'
   -- ��� ������� �������� ����� '1400','1401','1402','1410','1411','1412'
   --                            '1420','1421','1422'
   if mfo_ = 300465 then
       delete from otcn_saldo
       where acc in ( select cp1.cp_acc 
                      from accounts a, cp_accounts cp, cp_accounts cp1
                      where substr(a.nls,1,4) in ('1400','1401','1402',
                                                  '1410','1411','1412',
                                                  '1420','1421','1422'                     
                                                 )
                        and (a.dazs is null or (a.dazs is not null and a.dazs > Dat_)) 
                        and a.acc = cp.cp_acc
                        and cp.cp_ref = cp1.cp_ref
                    );
   end if;
   
   if mfo_ <> 300465 
   then
      -- ������� ������� ����� � RNK ��� ������� ���� ����� ���� �����
      delete from otcn_saldo 
      where rnk  in (select rnk from customer where okpo = our_okpo_) ;
   end if;

   select count(*)
   into cnt_
   from otcn_cust_prins
   where datf = dat_;
         
   if cnt_ = 0 then
       INSERT/*+ APPEND  */
          INTO  otcn_cust_prins (DATF, RNK, PRINS)
       SELECT dat_, U.RNK, DECODE (U.PRINSIDER, 99, 99, 1) PRINS
         FROM CUSTOMER_UPDATE U
             WHERE     U.RNK = any (SELECT UNIQUE RNK FROM OTCN_SALDO)
                   AND U.IDUPD = (SELECT MAX (IDUPD)
                                  FROM CUSTOMER_UPDATE
                                  WHERE RNK = U.RNK AND EFFECTDATE <= dat_);            
        commit;
   end if;

   insert /*+ APPEND  */
   into tmp_link_group (RNK, LINK_GROUP, LINK_CODE, LINK_NAME)
   select c.rnk,
          NVL(max(g.link_group), c.rnk) link_group,
          NVL(max(g.link_code), '000') link_code,
          NVL(max(g.link_code), c.nmk) link_name
   from customer c
   left outer join d8_cust_link_groups g
   on (C.OKPO = g.okpo)
   where (c.codcagent < 7 and c.codcagent not in (2, 4, 6) and
          ((our_okpo_ = '0' or NVL(ltrim(c.okpo, '0'),'X') <> our_okpo_) and mfo_ <> 300465 or
          NVL(ltrim(c.okpo, '0'),'X') <> 'XXXXX' and mfo_ = 300465) or
          g.link_group in (27, 58, 655, 306, 1358, 32, 34, 35, 39, 56, 290, 324, 304, 1169))
   group by c.rnk, c.nmk;
   commit;

   insert /*+ APPEND  */
   into tmp_link_group (RNK, LINK_GROUP, LINK_CODE, LINK_NAME)
   select c.rnk,
          NVL(max(g.link_group), c.rnk) link_group,
          NVL(max(g.link_code), '000') link_code,
          NVL(max(g.link_code), c.nmk) link_name
   from customer c
   left outer join d8_cust_link_groups g
   on (c.rnk = to_number(g.okpo))
   where (c.codcagent in (2, 4, 6)  or
          g.link_group in (27, 58, 655, 306, 1358, 32, 34, 35, 39, 56, 290, 324, 304, 1169)) and
         c.rnk not in (select rnk from tmp_link_group)
   group by c.rnk, c.nmk;
   commit;

   -- ������� ������� ����� � RNK ��� ������� LINK_GROUP ����� RNK �������
   delete from tmp_link_group  
   where rnk = link_group
     and link_group in (27, 58, 655, 306, 1358, 32, 34, 35, 39, 56, 290, 324, 304, 1169)
     and link_code = '000';

   commit;
             
   logger.info ('P_FD8_NN: End etap 1 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

   -- �� ����������� ��� ����� �����������
   INSERT /*+ APPEND*/ 
   INTO otcn_f71_rnk (rnk, nmk, prins, ostf)
      SELECT link_group, link_name, prins, ost
        FROM (SELECT   /*+ ordered  */  --/*+ leading(s) */
                       d.link_group, 
                       d.link_name,
                       u.prins, 
                       SUM (decode(s.kv, 980, s.ost - s.dos96 + s.kos96, 
                                              s.ostq -s.dosq96 + s.kosq96)
                           ) ost
                  FROM kl_f3_29 k,
                       otcn_saldo s,
                       specparam sp,
                       tmp_link_group d,
                       otcn_cust_prins u
                 WHERE s.rnk = d.rnk
                   AND s.rnk = u.rnk 
                   AND u.datf = dat_
                   AND s.nls LIKE k.r020 || '%'
                   AND k.kf = '71'
                   AND NVL(trim(k.ddd),'121') not in ('122','124','125')
                   AND s.acc = sp.acc(+)
	                   AND (k.r020 IN ('1408','1418','1419','1428','1429',
                                    '1500','1508','1509','1518','1519',
                                    '1528','1529','1600','1607','2018',
                                    '2028','2029','2038','2039',
                                    '2068','2069','2078','2079',
                                    '2088','2089','2108','2109',
                                    '2118','2119','2128','2129',
                                    '2138','2139','2208','2209',
                                    '2218','2219','2228','2229',
                                    '2238','2239','2600','2605','2607',
                                    '2620','2625','2627','2650','2655','2527',
                                    '3008','3018','3108','3118','3119','3218','3219'  	
                                   )
                        AND s.ost - s.dos96 + s.kos96 < 0
                            OR  
                        k.r020 not IN
                                   ('1408','1418','1419','1428','1429',
                                    '1500','1508','1509','1518','1519',
                                    '1528','1529','1600','1607','2018',
                                    '2028','2029','2038','2039',
                                    '2068','2069','2078','2079',
                                    '2088','2089','2108','2109',
                                    '2118','2119','2128','2129',
                                    '2138','2139','2208','2209',
                                    '2218','2219','2228','2229',
                                    '2238','2239','2600','2605','2607',
                                    '2620','2625','2627','2650','2655','2527',
                                    '3008','3018','3108','3118','3119','3218','3219',
                                    '9129','9610','9611','9613','9615','9617',
                                    '9618','9600','9601'
                                   ) 
                        AND s.ost - s.dos96 + s.kos96 <> 0
                             OR 
                        k.r020 = '9129'
                        and NVL(sp.r013,'0') = '1' 
                        and s.ost - s.dos96 + s.kos96 < 0
                       )
                   AND (prnk_ IS NULL OR s.rnk = prnk_)
                   AND ( ((our_rnk_ = -1 or s.rnk <> our_rnk_) and mfo_ <> 300465) or
                         (s.rnk <> 0 and mfo_ = 300465) )
              GROUP BY d.link_group, d.link_name, u.prins
              having  SUM (decode(s.kv, 980, s.ost - s.dos96 + s.kos96, 
                                             s.ostq -s.dosq96 + s.kosq96)
                           ) < 0
                       )
       WHERE prins <> 99 OR 
             link_group in (27, 58, 655, 306, 1358, 32, 34, 35, 39, 56, 290, 324, 304, 1169) or  
             ABS (ost) >= smax_;
   commit;

   -- 14/04/2017 �� ����������� ��� ����� ����� - ��� ����� 27 (LINK_GROUP = 27)
   -- �� ����������� ��� ����� ����� - ��� ����� 655 (LINK_GROUP = 655 )
   -- �� ����������� ��� ����� 58 (LINK_GROUP = 58 )
   -- c 30.12.2016 �� ����������� ��� ����� 306 (LINK_GROUP = 306 ) ������������� 

   -- ������� ������� ����� � RNK ��� ������� LINK_GROUP ����� RNK �������
   delete from otcn_saldo 
   where rnk in ( select /*+ leading(o) */
                  c.rnk 
                  from otcn_f71_rnk o, d8_cust_link_groups d, customer c
                  where o.rnk = d.link_group
                    and c.rnk = o.rnk 
                    and o.nmk <> c.nmk  
                    and c.codcagent not in (2, 4, 6)
                    and c.prinsider = 99
                ) ;

   txt_sql :=
         'SELECT ' 
      || 'a.acc, a.nls, c.nmk, c.rnk, trim(f.k074), c.okpo, c.codcagent, '
      || 'c.country, c.c_reg, c.ved, c.prinsider, a.nbs, a.daos, a.mdate, '
      || 'a.ost, '  
      || 'acrn_otc.fproc (a.acc, :dat_), a.kv, a.fdat, a.tip, a.txt, DECODE (c.custtype, 3, 2, 1) custtype, '
      || 'a.isp, a.ddd, a.s081, NVL(c.crisk,0), a.stp_dat, g1.link_code  '
      || 'FROM (SELECT /*+ leading(aa) */ ' 
      || 's.rnk, s.acc, substr(s.nls,1,4) nbs, s.nls, s.kv, s.daos, s.mdate, aa.fdat, ' 
      || 'decode(aa.kv, 980, aa.ost - aa.dos96 + aa.kos96, aa.ostq - aa.dosq96 + aa.kosq96) ost, '
      || 'aa.dos, aa.kos, s.tip, s.isp, k.txt, NVL (TRIM (k.ddd), ''121'') ddd, '
      || 'NVL (TRIM (k.s240), ''1'') s081, '
      || 'NVL(i.stp_dat, to_date(''01011990'',''ddmmyyyy'')) stp_dat '
      || 'FROM  otcn_saldo aa, otcn_acc s, kl_f3_29 k, specparam sp, int_accn i '
      || 'WHERE aa.rnk in (select g.rnk from tmp_link_group g, otcn_f71_rnk o where g.link_group = o.rnk) '
      || 'AND aa.acc = s.acc '
      || 'AND (:prnk_ IS NULL OR s.rnk = :prnk_) '
      || 'and k.kf = ''71'' '
      || 'AND s.nls like k.r020 || ''%'' '
      || 'AND aa.acc = i.acc(+) '
      || 'AND i.id(+) = 0 '
      || 'AND aa.acc = sp.acc(+) '
      || 'AND (   (    substr(s.nls,1,4) NOT IN '
      || '(''1600'', '
      || ' ''2600'', '
      || ' ''2605'', '
      || ' ''2620'', '
      || ' ''2625'', '
      || ' ''2650'', '
      || ' ''2655'', '
      || ' ''9129'', '
      || ' ''3578'', '
      || ' ''3579'') '
      || 'AND aa.ost - aa.dos96 + aa.kos96 <> 0) '
      || 'OR (    substr(s.nls,1,4) IN '
      || '(''1600'', '
      || ' ''2600'', '
      || ' ''2605'', '
      || ' ''2620'', '
      || ' ''2625'', '
      || ' ''2650'', '
      || ' ''2655'') '
      || 'AND aa.ost - aa.dos96 + aa.kos96 < 0) '
      || 'OR (    s.nls like ''9129%'' '
      || '    and NVL(sp.r013,''0'') in (''0'',''1'',''9'') '
      || '   ) '
      || 'OR ( (s.nls like ''3578%'' or s.nls like ''3579%'') '
      || '      and aa.ost - aa.dos96 + aa.kos96 <> 0 '
      || '      and NVL(trim(sp.r114),''0'') in (''1'',''6'',''7'') '
      || '      and :mfo_ not in (353575)  '
      || '    ) '
      || 'OR ( (s.nls like ''3578%'' or s.nls like ''3579%'') '
      || '      and aa.ost - aa.dos96 + aa.kos96 <> 0 '
      || '      and NVL(trim(sp.r114),''0'') in (''0'',''1'',''6'',''7'') '
      || '      and :mfo_ in (344443)  '
      || '    ) '
      || 'OR ( s.nls like ''3578%''  '
      || '      and aa.ost - aa.dos96 + aa.kos96 <> 0 '
      || '      and :mfou_  in (300465)  '
      || '    ) '
      || 'OR ( s.nls like ''3579%''  '
      || '      and aa.ost - aa.dos96 + aa.kos96 <> 0 '
      || '      and :mfou_  in (300465)  '
      || '    ) '
      || 'OR (  aa.ost = 0 '
      || '      and aa.fdat BETWEEN :dat1_ AND :dat_ '
      || '      and (s.nls like ''3578%'' or s.nls like ''3579%'') '
      || '      and NVL(trim(sp.r114),''0'') in (''1'',''6'',''7'') '
      || '    ) '
      || 'OR (    aa.ost = 0 '
      || '     AND (s.nls not like ''3578%'' and s.nls not like ''3579%'') '
      || '     AND aa.fdat BETWEEN :dat1_ AND :dat_))) a, '
      || 'customer c, '
      || 'tmp_link_group g1, '
      || 'kl_k070 f '
      || ' WHERE a.rnk = g1.rnk '  
      || '   AND a.rnk = c.rnk '  
      || '   AND c.ise = f.k070(+) '
      || '   AND f.d_close(+) is null '
      || ' ORDER BY c.okpo, c.rnk, a.nbs ';

--------------------------------------------------------------------------
   OPEN saldo FOR txt_sql USING dat_, prnk_, prnk_, mfo_, mfo_, mfou_, mfou_,  
                                   dat1_, dat_, dat1_, dat_;

   LOOP
      FETCH saldo
       INTO acc_, nls_, p010_, rnk_, p021_, p030_, rez_, p050_, reg_, ved_,
            p060_, p070_, p111_, p112_, p120_, p130_, kv_, data_, tip_,
            doda_, custtype_, isp_, ddd_, s081_, s085_, stp_dat1_, p041_;

      EXIT WHEN saldo%NOTFOUND;
      nd_ := NULL;
      acco_ := NULL;
      accn_ := NULL;
      sum_zd_ := 0;

      if substr(p070_,1,3) not in ('140','141','142','300','301','310','311','320','321') and 
         Dat_ >= to_date('29122012','ddmmyyyy') 
      then
         BEGIN
            select max(fin)  
               into s085_
            from nbu23_rez
            where fdat = dat23_
              and rnk = rnk_
              and fin is not null;
         EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            s085_ := null;   
         END;
      end if;

      BEGIN                                                       -- �� �����
         SELECT NVL (nd, 0), p090, gl.p_icurval(kv_, (gl.p_ncurval(kv_, p110, datf)), dat_),
                p111, p112, p080, p081, p130
           INTO p_nd_, p_p090_, p_sum_zd_,
                p_p111_, p_p112_, p_p080_, p_p081_, p_p130_
           FROM otcn_f71_history
          WHERE acc = acc_ AND datf = dat2_ AND ostf <> 0 and rnk = rnk_ AND ROWNUM = 1;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            BEGIN                                       -- �� ������ ��������
               SELECT MAX (NVL (nd, -1))
                 INTO p_nd_
                 FROM nd_acc
                WHERE acc = acc_;

               SELECT NVL (nd, 0), p090, gl.p_icurval(kv_, (gl.p_ncurval(kv_, p110, datf)), dat_),
                      p111, p112, p080, p081, p130
                 INTO p_nd_, p_p090_, p_sum_zd_,
                      p_p111_, p_p112_, p_p080_, p_p081_, p_p130_
                 FROM otcn_f71_history
                WHERE NVL (nd, 0) = p_nd_
                  AND datf = dat2_
                  AND ostf <> 0
                  AND ROWNUM = 1;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
               BEGIN                           -- �� ������ ��������
                  SELECT MAX (NVL (nd, -1))    -- ���� ������� �� ������
                     INTO p_nd_
                  FROM nd_acc
                  WHERE acc = acc_;

                  SELECT NVL (o.nd, 0), o.p090, gl.p_icurval(kv_, (gl.p_ncurval(kv_, o.p110, o.datf)), dat_),
                         o.p111, o.p112, o.p080, o.p081, o.p130
                     INTO p_nd_, p_p090_, p_sum_zd_,
                          p_p111_, p_p112_, p_p080_, p_p081_, p_p130_
                  FROM otcn_f71_history o, cc_deal c
                  WHERE NVL (o.nd, 0) = p_nd_
                    AND o.datf = dat2_
                    AND o.ostf = 0  
                    AND o. nd = c.nd
                    AND c.sos not in (14,15)
                    AND ROWNUM = 1;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                  p_nd_ := NULL;
                  p_p090_ := NULL;
                  p_p112_ := NULL;
               END;
            END;
      END;

      -- ������ ������� � ������� ��������� ������
      -- ��� ������� ����� �� �� ������
      IF p_nd_ IS NOT NULL
      THEN
         pog_ := TRUE;
      ELSE
         pog_ := FALSE;
      END IF;

      --- ��� �����������
      kod_okpo := TRIM (p030_);

      IF p070_ IN ('2607', '2627')
      THEN
         BEGIN
            SELECT max(i.acc)
              INTO acco_
              FROM int_accn i, accounts a
             WHERE i.acra = acc_
               AND ID = 0
               AND i.acc = a.acc
               AND a.nbs LIKE SUBSTR (p070_, 1, 3) || '%'
               AND a.nbs <> p070_;

            IF acco_ IS NOT NULL
            THEN
               accn_ := acc_;
               acc_  := acco_;
            END IF;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               NULL;
         END;
      END IF;

      --- ���������� ��������� ����� ��� ��� � ��������� �����
      BEGIN
         SELECT NVL (s181, '0'), NVL (s080, '1'), NVL (s031, '90'),
                NVL (nkd, 'N ���.'), NVL (r013, '0')
           INTO s181_, s080_, s031_,
                nkd_, r013_
           FROM specparam
          WHERE acc = acc_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            s181_ := '0';
            s080_ := '1';
            s031_ := '90';
            nkd_ := 'N ���.';
            r013_ := '0';
      END;

      if Dat_ = to_date('30122016','ddmmyyyy') and p070_ like '9129%' and r013_ = '9'
      then
         -- �������� �� ������� ������� �� ������ ������ �� NBU23_REZ
         SELECT NVL(sum(t.rezq*100), 0) 
            INTO sum_rez_
         FROM nbu23_rez t                         
         WHERE t.acc = acc_
           and t.fdat = dat23_;

         iF sum_rez_ <> 0
         then
            r013_ := '1';
         end if;
      end if;

      if Dat_ > to_date('30112012','ddmmyyyy') then
         BEGIN
            select NVL(s080_351,'0')
               into s080_
            from v_tmp_rez_risk
            where dat = dat23_
              and acc = acc_
              and nd = p_nd_
              and rownum = 1;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            BEGIN
               select NVL(s080_351,'0')
                  into s080_
               from v_tmp_rez_risk
               where dat = dat23_
                 and acc = acc_
                 and rownum = 1;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               BEGIN
                  select NVL(max(s080_351),'0')
                     into s080_
                  from v_tmp_rez_risk
                  where dat = dat23_
                    and rnk = rnk_  
                  group by rnk;  
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  s080_ := 0;  
               END;
            END;
         END;
      end if;

      IF 300465 IN (mfo_, mfou_) AND substr(nls_,1,3) in ('311', '321') THEN
         nkd_ := to_char(rnk_);
      END IF;

      p080f_  := s031_;
      s031_1 := f_get_s031(acc_, dat_, s031_, p_nd_);

      if s031_1 = '90' then
         s031_1 := f_get_s031(acc_, dat_, s031_, null);
      end if;

      p080_ := NVL(s031_1, p080f_);

      sum_71 := 0;

      -- ��������� ����� ����������� ��������� ��� ���������
      IF p070_ = '1508'
      THEN
         SELECT COUNT (*)
           INTO f1502_
           FROM accounts
          WHERE nls LIKE '1502_' || SUBSTR (nls_, 6) || '%';

         IF f1502_ <> 0
         THEN
            p120_ := 0;
            pog_ := FALSE;
         END IF;
      END IF;

      BEGIN                                       -- �� ������ ��������
         SELECT MAX (NVL (nd, -1))
            INTO nd_
         FROM nd_acc
         WHERE acc = acc_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
         nd_ := NULL;
      END;

      -- � ��������� ������
      SELECT /*+ordered*/
           ABS (SUM (decode (a.kv, 980, a.ost - a.dos96 + a.kos96, a.ostq - a.dosq96 + a.kosq96)))
        INTO sum_zd_
        FROM nd_acc p, otcn_saldo a, kl_f3_29 k
       WHERE p.nd = nd_
         AND p.acc = a.acc
         AND a.nbs = k.r020
         AND k.kf = '71'
         AND NVL (k.ddd, '121') NOT IN ('122','123','124','125');

      -- ��������� ������ 1 ������ (������������� �������)
      IF     SUBSTR (nls_, 1, 1) = '1'
         AND SUBSTR (nls_, 1, 4) NOT IN ('1600', '1607')
         AND p060_ = 99
         AND (ABS (p120_) <> 0) 
      THEN
         BEGIN
            IF pog_ AND p120_ = 0  
            THEN
               SELECT NVL (d.cc_id, nkd_), d.sdate, 
                      c.wdate, 
                      d.wdate, d.nd,
                      gl.p_icurval (a.kv, d.LIMIT*100, dat_)
                 INTO p090_, dat_nkd_, p111p_, p112p_, nd_,
                      sum_zd_
                 FROM nd_acc n, cc_deal d, cc_add c, otcn_acc a
                WHERE n.nd = d.nd
                  AND d.nd = c.nd
                  AND c.adds = 0
                  AND n.acc = a.acc
                  AND n.acc = acc_
                  AND d.nd = p_nd_;

               SELECT   MIN (c.fdat)
                   INTO data_
                   FROM saldoa c
                  WHERE c.acc = acc_
                    AND c.fdat > dat2_
                    AND c.ostf - c.dos + c.kos = 0
               GROUP BY c.acc;

               p130_ := acrn_otc.fproc (acc_, data_);
            ELSE
               SELECT NVL (d.cc_id, nkd_), d.sdate, 
                      c.wdate, 
                      d.wdate, d.nd,
                      gl.p_icurval (a.kv, d.LIMIT*100, dat_)
                 INTO p090_, dat_nkd_, p111p_, p112p_, nd_,
                      sum_zd_
                 FROM nd_acc n, cc_deal d, cc_add c, otcn_acc a
                WHERE n.nd = d.nd
                  AND d.nd = c.nd
                  AND c.adds = 0
                  AND n.acc = a.acc
                  AND n.acc = acc_
                  AND (c.wdate, c.nd) =
                         (SELECT MAX (c1.wdate), MAX (c1.nd)
                            FROM nd_acc n1, cc_add c1
                           WHERE n1.nd = c1.nd
                             AND n1.acc = acc_
                             AND c1.wdate <= dat_);
            END IF;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               p090_ := nkd_;
               dat_nkd_ := p111_;
               p111p_ := p111_;
               p112p_ := p112_;
               nd_ := NULL;
               sum_zd_ := 0;
            WHEN OTHERS
            THEN
               raise_application_error (-20001,
                                        'acc=' || acc_ || ' ������ : '
                                        || SQLERRM
                                       );
         END;

         -- ����� ������������� �� ���������
         IF nd_ IS NULL
         THEN
           -- �� � ��������� ������, �� ��������� ���������
           SELECT ABS (SUM (decode(s.kv, 980, s.ost - s.dos96 + s.kos96,
                                              s.ostq - s.dosq96 + s.kosq96)))
             INTO sum_71
             FROM kl_f3_29 k, otcn_saldo s, otcn_acc c, specparam r
            WHERE k.kf = '71'
              AND NVL (k.ddd, '121') NOT IN ('122','123','124','125')
              AND k.r020 = s.nbs
              AND decode(s.kv, 980, s.ost-s.dos96+s.kos96, s.ostq-s.dosq96+s.kosq96) < 0
              AND s.acc = c.acc
              AND c.rnk = rnk_
              AND s.acc = r.acc
              AND r.nkd = nkd_;

           if NVL(sum_71,0) = 0 then
              sum_71 := ABS (p120_);
           end if;

            --- ���� ����� ����� �� �������� ������ ����� �� �����
            IF sum_71 < ABS (p120_)
            THEN
               sum_71 := ABS (p120_);
            END IF;
         ELSE
            sum_71 := sum_zd_;
         END IF;

         -- ���� ������� �������� � �������� ����� ��������� ������, �� ��� �� ���������
         IF p120_ = 0 AND (p111p_ >= dat1_ OR p_nd_ IS NULL)
         THEN
            pog_ := FALSE;
            sum_71 := 0;
         END IF;

         IF NVL (sum_zd_, 0) = 0
         THEN
            sum_zd_ := sum_71;
         END IF;

         -- �������� %% ������ ���� ��������� ���� ����
         if stp_dat1_ <> to_date('01011990','ddmmyyyy') and 
            stp_dat1_ <= Dat_
         then
            p130_ := 0;
         end if;

         -- ������ ���������� ���������� ��������
         p_ins_kredit (1);
         -- ���� � ������� ������ ��������� ������� �� ������ ����� ��� ������� ������ � ����� �����
         p_obrab_pkd (1);
      END IF;

      --- ��������� ������ 2 � 9 ������� (������� ���������)
      --- ��������� ����� ����� �� 1 ��������
      IF     (   SUBSTR (nls_, 1, 1) IN ('2', '3', '9')
              OR SUBSTR (nls_, 1, 4) IN ('1600', '1607')
             )
         AND p060_ = 99
         AND (   (p070_ IN ('3103', '3105') AND r013_ <> 'X')
              OR p070_ NOT IN ('3103', '3105')
             )
         AND (ABS (p120_) <> 0)  
      THEN
         kol_dz := 0;

         -- �������� %% ������ ���� ��������� ���� ����
         if stp_dat1_ <> to_date('01011990','ddmmyyyy') and 
            stp_dat1_ <= Dat_
         then
            p130_ := 0;
         end if;

         -- ��������� �� �������� �� ��� �����, ������� ����������
         IF SUBSTR (nls_, 1, 4) IN ('2067', '2069', '2096')
         THEN
            SELECT COUNT (*)
              INTO kol_dz
              FROM acc_over o
             WHERE acc_ IN (o.acc_2067, o.acc_2069, o.acc_2096);

            IF kol_dz > 0
            THEN
               flag_over_ := TRUE;
               kol_dz := 0;
            ELSE
               flag_over_ := FALSE;
            END IF;
         ELSE
            flag_over_ := FALSE;
         END IF;

         --- ��� ������ ���������� ���������� ������� � ������� ACC_OVER
         IF    p070_ IN
                  ('3578','9129','9100','1600','1607','2000','2600','2605',
                   '2620','2625','2607','2627','2650','2655','2657'
                  )
            OR p070_ IN ('2067', '2069', '2096') AND flag_over_
         THEN
            p_over_1 (acc_);
         END IF;

         IF (   p070_ NOT IN
                   ('2067','2069','2096','3578','9129','2000','2600','2605',
                    '2620','2625','2607','2627','2650','2655','2657'
                   )
             OR p070_ IN ('2067', '2069', '2096') AND NOT flag_over_
             OR (    p070_ IN
                        ('3578','9129','9100','1600','1607','2000','2600',
                         '2605','2620','2625','2607','2627','2650','2655','2657'
                        )
                 AND kol_dz = 0
                )
            )
         THEN
            -- ����������� ���������� ��
            p_obrab_kd;
         END IF;

         IF p070_ <> '9129' OR
            (p070_ = '9129' AND r013_ in ('0','1','9')) 
         THEN
            IF NVL (sum_zd_, 0) = 0
            THEN
               sum_zd_ := sum_71;
            END IF;

            -- �������� ����������
            IF    (    p070_ IN
                          ('3578','9129','9100','1600','1607','2000','2600',
                         '2605','2620','2625','2607','2627','2650','2655','2657'
                        )
                   AND kol_dz <> 0
                  )
               OR p070_ IN ('2067', '2069', '2096') AND flag_over_
            THEN
               p112p_ := p112_;
               p_over_2 (acc_);
               sum_zd_ := sum_71;
            END IF;

            -- ������ ���������� ���������� ��������
            p_ins_kredit (2);
         end if;
      END IF;

      --- ��������� ������ ���������� ����� - �������� ��� �������
      IF p060_ <> 99 AND (ABS (p120_) <> 0)  
      THEN
         kol_dz := 0;
         -- ��������� �� �������� �� ��� �����, ������� ����������
         IF SUBSTR (nls_, 1, 4) IN ('2067', '2069', '2096')
         THEN
            SELECT COUNT (*)
              INTO kol_dz
              FROM acc_over o
             WHERE acc_ IN (o.acc_2067, o.acc_2069, o.acc_2096);

            IF kol_dz > 0
            THEN
               flag_over_ := TRUE;
               kol_dz := 0;
            ELSE
               flag_over_ := FALSE;
            END IF;
         ELSE
            flag_over_ := FALSE;
         END IF;

         --- ��� ����� ��� �� �������� ����� ����������� ��������
         IF     (   (p070_ IN ('3103', '3105') AND r013_ <> 'X')
                 OR p070_ NOT IN ('3103', '3105')
                )
            AND (   SUBSTR (p070_, 1, 1) <> '8'
                 OR p070_ IN ('2067', '2069', '2096') AND flag_over_
                )
            AND (ABS (p120_) <> 0)  
         THEN
            --- ��� ������ ���������� ���������� ������� � ������� ACC_OVER
            IF    p070_ IN
                     ('3578','9129','9100','1600','1607','2000','2600',
                      '2605','2620','2625','2607','2627','2650','2655','2657'
                     )
               OR p070_ IN ('2067', '2069', '2096') AND flag_over_
            THEN
               p_over_1 (acc_);
            END IF;

            IF (   p070_ NOT IN
                      ('3578','9129','9100','1600','1607','2000','2600',
                       '2605','2620','2625','2607','2627','2650','2655','2657'
                      )
                   OR p070_ IN ('2067', '2069', '2096') AND NOT flag_over_
                   OR (    p070_ IN
                              ('3578','9129','9100','1600','1607','2000','2600',
                         '2605','2620','2625','2607','2627','2650','2655','2657'
                        )
                    AND kol_dz = 0
                      )
                )
            THEN
               -- �� ����������
               -- ����������� ���������� ��
               p_obrab_kd;

               IF NVL (sum_zd_, 0) = 0
               THEN
                  sum_zd_ := sum_71;
               END IF;
            ELSE                                               --����������
               p112p_ := p112_;
               p_over_2 (acc_);
               sum_zd_ := sum_71;
            END IF;

            IF p070_ <> '9129' OR (p070_ = '9129' AND r013_ in ('0','1','9')) 
            THEN
               -- ������ ���������� ���������� ��������
               p_ins_kredit (3);
               -- �������� �� ���� �� �� ����� ����� ������� �������� �� ����. �������� ����
               p_obrab_pkd (3);
            END IF;
         END IF;
      END IF;
   END LOOP;

   CLOSE saldo;

   logger.info ('P_FD8_NN: End etap 2 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

   nnnn_ := 1;
   p_rnk_ := NULL;
   p_nd_ := NULL;
   p_p090_ := '------';

   -- �������� ���� P040 � ������� OTCN_F71_HISTORY (���� OTCN_F71_CUST)
   FOR k IN (SELECT DISTINCT rnk, custtype, p060
                        FROM otcn_f71_cust
                       WHERE TRIM (p040) = '0')
   LOOP
      SELECT COUNT (*)
        INTO kol_
        FROM otcn_f71_temp
       WHERE rnk = k.rnk
         AND (   (TRIM (k.p060) <> '99' AND p120 <> 0 ) 
              OR (TRIM (k.p060) = '99' AND ABS(p120) + ABS(p125) >= 0)
             );

      IF kol_ <> 0
      THEN
         BEGIN
            IF k.custtype = 2
            THEN                                         -- ��� �_������ ��_�
               SELECT COUNT (*)
                 INTO p040_
                 FROM ( SELECT distinct a.rnk
                        FROM ( SELECT rnkb rnk
                               FROM cust_bun
                               WHERE rnka = k.rnk AND id_rel in (5, 12)
                                 AND nvl(edate, Dat_)>=Dat_            
                                 AND nvl(bdate, Dat_)<=Dat_
                             ) a
                      );
            ELSE
               SELECT COUNT (*)
                 INTO p040_
               FROM (SELECT rnka, rnkb, okpo_u, doc_number, min(id_rel)
                     FROM cust_bun
                     WHERE rnka = k.rnk
                       AND id_rel IN (1, 4)
                       AND NVL (vaga1, 0) + NVL (vaga2, 0) >= sum_proc  --20;
                       AND nvl(edate, Dat_)>=Dat_            --(c 29.08.08 - 10%)
                       AND nvl(bdate, Dat_)<=Dat_
                     GROUP BY rnka, rnkb, okpo_u, doc_number);
            END IF;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               p040_ := 0;
         END;

         -- �������� ���� P040 �� � ����. OTCN_F71_CUST � � ����. OTCN_F71_HISTORY
         -- �.�. ������������ ���������� 040 � ����� #D8 ����������� �� ����. OTCN_F71_CUST
         -- � ����������� ���������� 040 � ����� #D9 ����������� �� ����. OTCN_F71_HISTORY

         if p040_ <> 0 then
            update otcn_f71_history
               set p040=p040_
            where rnk=k.rnk
              and p040 = 0
              and datf=Dat_;
            UPDATE otcn_f71_cust
               SET p040 = p040_
             WHERE rnk = k.rnk AND TRIM (p040) = '0';
         end if;

      END IF;
   END LOOP;

   -- �������� ���� P020 � P025 ��� �� ���������������� � ������� OTCN_F71_CUST
   -- ���� ���� ���������� ����� �� 
   FOR k IN ( SELECT okpo, custtype, p020, p025
              FROM otcn_f71_cust
              WHERE p025 <> '00000' 
                and custtype = 2)

   LOOP

      BEGIN
         SELECT p010, p020, p025 
            INTO p010_, p021_, k110_
         FROM otcn_f71_cust
         WHERE okpo = k.okpo
           and custtype = k.custtype
           and p025 = '00000';

         update OTCN_F71_CUST c 
            set c.p010 = p010_, c.p020 = p021_, c.p025 = k110_
         where c.okpo = k.okpo and c.p020 = k.p020 and c.p025 = k.p025;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         null;
      END;
      
   END LOOP;

   -- ���� ��� ������������� ��������� 042 ���������� ����� ����������� � ����
   for z in ( select znap, count(*) 
              from rnbu_trace
              where kodp like '041%'
              group by znap
              having count(*) > 1
              order by 1
            )
      loop

         kod_okpo := 'XXXXXXXXXX';
         nnnn_ := 0;

         for k in ( select substr(r1.kodp,4,10) okpo, sum(r1.znap) p120 
                    from rnbu_trace r1,
                         ( select substr(kodp,4,10) okpo1
                           from rnbu_trace 
                           where kodp like '041%' 
                             and znap = z.znap) r2
                    where substr(r1.kodp, 4,10) = r2.okpo1 
                      and substr(r1.kodp,1,3) in ('118','121','123','122','124')
                    group by substr(r1.kodp,4,10)
                    order by 2
                  )
 
            loop

               nnnn_ := nnnn_ + 1;
   
               update rnbu_trace set znap = to_char(nnnn_) 
               where kodp like '042' || k.okpo || '%';
         end loop;

   end loop;

   for k in ( select oc.rnk, oc.p060, op.prins 
              from otcn_f71_cust oc, otcn_cust_prins op
              where oc.rnk = op.rnk 
                and op.datf = dat_ 
                and oc.p060 <> op.prins 
            )

      loop

         SELECT U.PRINSIDER
            INTO p060_
         FROM CUSTOMER_UPDATE U
         WHERE U.RNK = k.RNK
           AND U.IDUPD = (SELECT MAX (IDUPD)
                          FROM CUSTOMER_UPDATE
                          WHERE RNK = U.RNK AND EFFECTDATE <= dat_);            

         update otcn_f71_cust set p060 = p060_ 
         where  rnk = k.rnk;
   end loop;

   logger.info ('P_FD8_NN: End etap 3 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

   OPEN c_cust;

   LOOP
      FETCH c_cust
       INTO rnk_, kod_okpo, rez_, k021_, p010_, p021_, k110_, p040_,
            p050_, reg_, p060_, p085_, p041_;

      EXIT WHEN c_cust%NOTFOUND;
      p140_ := NULL;
      p_p140_ := 0;
      data_ := NULL;
      isp_ := NULL;
      sum_d_ := 0;
      nd_ := null;
      p_nd_ := null;
      p_p090_ := 'N ���.'; 

      if dat_ >= dat_izm6 
      then
         begin
            select NVL(substr(trim(value),1,1), '9')
                into k140_
            from customerw
            where rnk = rnk_
              and tag like 'K140%';
         exception when no_data_found then
            k140_ := '9';
         end;
      end if;         
         
      if rez_ in (4,6) and substr(kod_okpo,1,1) != 'I' then
         okpo_nerez := trim(kod_okpo);
         kod_okpo := 'I'||LPAD (to_char(rnk_), 9, '0');

         if length(okpo_nerez) > 8 then
            kodp_ := kod_okpo || '0000' || '0000' || '000';
            -- ��� ���� �����������
            p_ins ('019' || kodp_, okpo_nerez, null, '00', k021_, '0', '00', '0', '0');
         end if;
      end if;

      kodp_ := kod_okpo || '0000' || '0000' || '000';
      -- �������� �����������
      p_ins ('010' || kodp_, p010_, null, '00', k021_, '0', '00', '0', '0');

      if rez_ in (2, 4, 6) then
         p021_ := '2';
         k110_ := '00000';
      end if;
      -- ����������� �� 01.10.2013
      -- �� 01.10.2014 ����� ����� �������������
      if dat_ <= dat_izm1 OR dat_ > to_date('29092014','ddmmyyyy')
      then
         --�������� ������� � 01.09.2007
         p_ins ('021' || kodp_, p021_, null, '00', k021_, '0', '00', '0', '0');         
      end if;
      -- ��� ������������� ������������
      p_ins ('025' || kodp_, k110_, null, '00', k021_, '0', '00', '0', '0');

      -- ���������� ����������, ������� ������� 20 � ������ %% ���������� �����
      If dat_ < dat_izm4 
      then
         p_ins ('040' || kodp_, lpad(p040_,3,'0'), null, '00', k021_, '0', '00', '0', '0');
      end if;

      -- �� 01.04.2016 ��� ����� ���� 041, 042
      -- ���������� ����� ������ ��������� �����������
      If dat_ >= dat_izm3
      then
         p_ins ('041' || kodp_, p041_, null, '00', k021_, '0', '00', '0', '0');
      end if;

      -- ���������� ����� ����������� � ���� ��������� ���
      If dat_ >= dat_izm3 and dat_ < dat_izm4 
      then
         p_ins ('042' || kodp_, '1', null, '00', k021_, '0', '00', '0', '0');
      end if;

      -- ��� ������
      p_ins ('050' || kodp_, lpad(TO_CHAR (p050_),3,'0'), null, '00', k021_, '0', '00', '0', '0');

      -- ����������� �� 01.03.2014
      -- ����� ����������� �� 01.02.2017 
      if dat_ < dat_izm2 OR dat_ >= dat_izm5 
      then
         if rez_ not in (2, 4, 6) then
            -- ��� �������
            p_ins ('055' || kodp_, lpad(TO_CHAR (NVL (reg_, our_reg_)), 3, '0'), null, '00', k021_, '0', '00', '0', '0');
         end if;
      end if;

      -- �������� ��� ��������� �� ������� 
      -- ���� � CUSTOMER ������ ��� ��� CUSTOMER_UPDATE
      p060_1 := p060_;

      -- ������� ���������
      p_ins ('060' || kodp_, LPAD(TO_CHAR (p060_1),2,'0'), null, '00', k021_, '0', '00', '0', '0');

      -- ����� ��� 085 ��� ��������� �� SPE (�������� 0 ��� B ��� A)
      if Dat_ >= dat_izm6
      then
         if rez_ = 3 
         then
            begin
               select substr(trim(value),1,1)
                  into isspe_
               from customerw
               where rnk = rnk_
                 and tag like 'ISSPE%';
            exception when no_data_found then
               isspe_ := '0';
            end;
         end if;

         p085_ := 'B';

         if rez_ = 5 or p060_1 <> 99
         then
            p085_ := '0';
         elsif rez_ = 3 and isspe_ = '1' then
            p085_ := 'A';
         else
            null;
         end if;

         p_ins ('085' || kodp_, p085_, null, '00', k021_, '0', '00', '0', '0');
      end if;


      OPEN c_cust_dg;

      LOOP
         FETCH c_cust_dg
          INTO acc_, nd_, p090_, p080_, p081_, sum_zd_, p111_, p112_, p113_,
               s080_, p070_, kv_, ddd_, p120_, p125_, p130_, p150_, nls_,
               data_, isp_, cur_sum_, p081_d, rnum_;

         EXIT WHEN c_cust_dg%NOTFOUND;

          comm_ := '';

          p140_ := LPAD (TO_CHAR (kv_), 3, '0');

          if mfo_ <> 300465 OR
            ((mfo_ = 300465 and substr(p070_,1,3) in ('311','321') and
              ABS(p120_)+ABS(p125_)<>0 ) OR
              (mfo_=300465 and substr(p070_,1,3) not in ('311','321')) )
          then

             IF    (p_nd_ IS NULL AND p_p090_ = '------')
                OR                                                   -- ������ ���
                   (    p_nd_ IS NULL
                    AND nd_ IS NULL
                    AND (   (p090_ <> p_p090_)
                         OR (p090_ = p_p090_ AND p_rnk_ <> rnk_)
                        )
                   )
                OR (    p_nd_ IS NULL
                    AND nd_ IS NULL
                    AND p090_ = p_p090_
                    AND p090_ = 'N ���.'
                   )
                OR (p_nd_ IS NOT NULL AND nd_ IS NOT NULL AND p_nd_ <> nd_)
                OR (p_nd_ IS NULL AND nd_ IS NOT NULL)
                OR (p_nd_ IS NOT NULL AND nd_ IS NULL)
             THEN

                kod_nnnn := LPAD (TO_CHAR (nnnn_), 4, '0');
                n_trans := 0;

                -- 12 ������� ��� �������������
                nbuc_ := SUBSTR(NVL(LPAD(f_codobl_tobo(acc_,5), 14, '0'), b040_),-12);

                -- ��� ������������ ������_�
                if p081_d = 0 and p080_ <> '33' then
                   BEGIN
                      select o.p080
                         into p080_
                      from otcn_f71_history o
                      where o.acc = acc_
                        and o.datf = ( select max(datf)
                                       from otcn_f71_history
                                       where acc = o.acc
                                         and p081 <> 0
                                         and datf < dat_
                                     )
                        and rownum = 1;
                   EXCEPTION WHEN NO_DATA_FOUND THEN
                      p080_ := '90';  --null;
                   END;
                end if;

                p085_p := p085_;

                if Dat_ >= to_date('29122012','ddmmyyyy') then
                   BEGIN
                      select NVL(to_char(max(fin)), p085_p), 
                             NVL(to_char(max(ccf)), 0)
                        into p085_p, ccf_
                   from nbu23_rez
                   where fdat = dat23_
                     and rnk = rnk_
                     and nd = nd_
                     and rownum =1;
                   EXCEPTION WHEN NO_DATA_FOUND THEN
                      BEGIN
                         select NVL(to_char(max(fin)), p085_p)
                            into p085_p
                         from nbu23_rez
                         where fdat = dat23_
                           and rnk = rnk_;
                      EXCEPTION WHEN NO_DATA_FOUND THEN
                         null;
                      END;
                   END;
                end if;

                -- ��� �� ��� ����������� "00" � ����� ����������� ����� ����
                -- 06.03.2013 ������� ������ 354
                -- 18.03.2014 ������� ������ 280,351,357
                if substr(p070_,1,3) in ('140','141','142','150',
                                         '181','280','300','301',
                                         '304','310','311','320',
                                         '321','351','354','355',
                                         '357','920','930','935'
                                        ) 
                then
                   p080_ := '00';
                   p081_ := '0';
                   --p085_p := p085_;
                end if;

                -- �� 01.04.2016 ���������� �� �����������
                if dat_ < dat_izm3 
                then
                   -- �� 01.03.2014 ������ ������������ ���� S031
                   if dat_ < dat_izm2 then
                      -- ��� ������������ ������_�
                      p_ins ('080' || kod_okpo || kod_nnnn || '0000' || '000', p080_);
                   else
                      if p080_ not in ('40','41','42','43','44','45')
                      then
                         if p080_ in ('30','31','32')
                         then
                            p080_ := '33';
                         end if;
                         -- ��� ������������ ������_�
                         p_ins ('080' || kod_okpo || kod_nnnn || '0000' || '000', p080_);
                      else
                         -- ��� ������������ ������_�
                         p_ins ('080' || kod_okpo || kod_nnnn || '0000' || '000', '00');
                      end if;
                   end if;
                end if;

                -- �� 01.04.2016 ���������� �� �����������
                if dat_ < dat_izm3 
                then
                   -- �� 01.03.2014 ����� ��� �������� ����� ����������� S031
                   if dat_ >= dat_izm2 and p080_ in ('40','41','42','43','44','45')
                   then
                      begin
                         select nd, substr(max(sys_connect_by_path(s031, ';')), 2) s031
                            into nd_p082, p080_list
                         from (select nd, s031, row_number() over(partition by nd order by s031) rn
                               from (select distinct z.nd, DECODE(c.s031,'30','33','31','33','32','33',c.s031) s031
                                     from tmp_rez_zalog23 z, cc_pawn c
                                     where dat = Dat23_
                                       and z.pawn = c.pawn
                                       and nd = nd_))
                         start with rn = 1
                         connect by prior rn = rn - 1
                          and prior nd = nd
                         group by nd;
                      exception when no_data_found then
                         p080_list := p080_ || ';';
                      end;
   
                      -- ������ ���� ������������ ������_�
                      p_ins ('082' || kod_okpo || kod_nnnn || '0000' || '000', p080_list);
                   end if;

                   -- �� 01.03.2014 ����� ��� �������� ����� ����������� S031
                   if substr(p070_,1,3) in ('140','141','142','150','181','280','300','301','304','310','311','320','321','351','354','357') then
                      -- ������ ���� ������������ ��� �� ������_� ������ '00'
                      p_ins ('082' || kod_okpo || kod_nnnn || '0000' || '000', '00');
                   end if;
                end if;

                -- _������_����� ��������
                p_ins ('090' || kod_okpo || kod_nnnn || '0000' || '000', p090_, null, '00', k021_, '0', '00', '0', '0');
   
                IF dat_ > TO_DATE ('01012008', 'ddmmyyyy')
                THEN
                   if mfo_ = 324805 and
                      ( (substr(nbuc_,1,1)='1' and substr(nbuc_,2,2)='11') or
                        (substr(nbuc_,1,1)='2' and substr(nbuc_,7,2)='11')
                      )
                   then
                      nbuc_ := '726614110000';
                   end if;

                   if mfo_ = 324805 and
                      ( (substr(nbuc_,1,1)='1' and substr(nbuc_,2,2)='29') or
                        (substr(nbuc_,1,1)='2' and substr(nbuc_,7,2)='29')
                      )
                   then
                      nbuc_ := '726614290000';
                   end if;

                   -- 12 ������� ��� �_�����_��
                   p_ins ('091' || kod_okpo || kod_nnnn || '0000' || '000',
                          nbuc_, null, '00', k021_, '0', '00', '0', '0');
                END IF;

                IF dat_ > TO_DATE ('01012010', 'ddmmyyyy')
                THEN
                   -- ���� ��������
                   p_ins ('092' || kod_okpo || kod_nnnn || '0000' || '000',
                          TO_CHAR (p113_, dfmt_), null, '00', k021_, '0', '00', '0', '0'
                         );
                END IF;

                -- ����������� �� 01.03.2014
                if dat_ < dat_izm2 then
                   -- ���� �������������_ ��_��� ��������
                   p_ins ('110' || kod_okpo || kod_nnnn || '0000' || p140_,
                          TO_CHAR (ABS (sum_zd_))
                         );
                end if;

                nnnn_ := nnnn_ + 1;
             END IF;

             if rnum_ >= 1 then

                if dat_ >= dat_izm6 and p070_ in ('1510','1513','1520','1521','1524', 
                                                  '2020','2030','2063','2071','2083', 
                                                  '2103','2113','2123','2133','2203', 
                                                  '2211','2220','2233','3570','3578' ) 
                then
               
                   begin
                      select a.tip 
                         into tip_ 
                      from accounts a  
                      where a.acc = acc_;
                   exception when no_data_found then
                      tip_  := 'SN';
                   end;
                end if;

                -- �� 01.04.2016 ����������� ���������� ���� ����������� �� �����
                -- �� 01.02.2017 ���������� 081, 083, 084, 086 ����� ������������� 
                -- �� ������ ������ (����. REZ_CR) 
                if dat_ >= dat_izm3  --and Dat_ < dat_izm5
                then
                   if dat_ < dat_izm5 
                   then
                      select count(*) 
                         into kol_dz 
                      from tmp_rez_zalog23 z
                      where z.dat = Dat23_
                        and z.nd = nd_;

                      if kol_dz = 0 
                      then
                         select count(*) 
                            into kol_dz
                         from cc_accp p, accounts s,accounts z 
                         where p.nd = nd_ 
                           and p.acc = Z.ACC 
                           and p.accs = s.acc;
                      end if;

                      -- �� ���� ������������ ����������� �� ������������ 
                      if rnk_ in ( 300006, 300047, 300079, 977897, 
                                   978159, 978162, 978261)
                      then
                         kol_dz := 1;
                      end if;
  
                      if kol_dz <> 0  
                      then

                         for k in ( select NVL(DECODE(c.s031,'26','33','29','33','30','33','31','33','32','33','56','33',c.s031),'00') s031, 
                                           NVL( sum (z.sallq),0) sum_ob
                                    from tmp_rez_zalog23 z, cc_pawn c
                                    where z.dat = Dat23_
                                      and z.pawn = c.pawn
                                      and z.accs = acc_
                                    group by DECODE(c.s031,'26','33','29','33','30','33','31','33','32','33','56','33',c.s031) 
                                  )
                            loop
   
                               if k.sum_ob > 0 and k.s031 not in ('29','30','31','32','33','34','40','41','42','43','44','45','90')
                               then
                                  p080_ := k.s031;
                                  p_p081_ := to_char (k.sum_ob);

                                  -- �� 01.03.2014 ����� ��� �������� ����� ����������� S031
                                  if substr(p070_,1,3) in ('140','141','142','150',
                                                           '181','280','300','301',
                                                           '304','310','311','320',
                                                           '321','351','354','357',
                                                           '920','930','935') 
                                        and p_p081_ = 0 
                                  then
                                     p080_ := '00';
                                     --p_p081_ := '0'; 
                                  end if;
                                  -- ���� ������������
                                  p_ins ('081' || kod_okpo || kod_nnnn || '0000' || '000', p_p081_, nls_, '00', k021_, '0', p080_, '0', '0');
                               end if;
   
                         end loop;
                      else
                         p080_ := '90';  
                         -- �� 01.03.2014 ����� ��� �������� ����� ����������� S031
                         if substr(p070_,1,3) in ('140','141','142','150',
                                                  '181','280','300','301',
                                                  '304','310','311','320',
                                                  '321','351','354','355',
                                                  '357','920','930','935') 
                         then
                            p080_ := '00';
                         end if;
                         -- ���� ������������
                         p_ins ('081' || kod_okpo || kod_nnnn || '0000' || '000', '0', nls_, '00', k021_, '0', p080_, '0', '0');
                      end if;
                   end if;
                end if;

                -- �� 01.02.2017 ����� ���������� 081, 083, 084, 086 
                -- ����� ������������� �� ������� REZ_CR 
                if dat_ >= dat_izm5 
                then

                   select count(*), NVL( sum (z.zal_bvq * 100),0) 
                      into kol_dz, sum_ob_ 
                   from rez_cr z
                   where z.fdat = Dat23_
                     and z.nd = nd_;

                   if kol_dz = 0 
                   then
                      select count(*) 
                         into kol_dz
                      from cc_accp p, accounts s,accounts z 
                      where p.nd = nd_ 
                        and p.acc = Z.ACC 
                        and p.accs = s.acc;
                   end if;

                   -- �� ���� ������������ ����������� �� ������������ 
                   if (mfo_ = 300465 and rnk_ in (30000601, 30004701, 30007901, 
                                                  97789701, 97815901, 97816201, 
                                                  97826101)) OR
                      (mfo_ = 322669 and rnk_ in (246599, 587674))
                   then
                      kol_dz := 1;
                   end if;
  
                   if kol_dz >= 0   --<> 0 
                   then

                      for k in ( select NVL(DECODE(c.s031,'26','33','29','33','30','33','31','33','32','33','56','33',c.s031),'00') s031, 
                                        NVL( sum (z.zal_bvq * 100),0) sum_ob,
                                        NVL( sum (z.zalq * 100),0) sum_obp,
                                        NVL( sum (z.rcq * 100),0) sum_obi, 
                                        sum (NVL(z.kl_351, 0)) kl_351,
                                        sum (NVL(t.accs, 0)) accs 
                                 from rez_cr z, cc_pawn c, 
                                      ( select distinct accs 
                                        from cc_accp   ---tmp_rez_obesp23
                                        -- where dat = Dat23_
                                      ) t
                                 where z.fdat = Dat23_
                                   and z.pawn = c.pawn(+)
                                   and z.acc = acc_
                                   and z.acc = t.accs(+)
                                 group by DECODE(c.s031,'26','33','29','33','30','33','31','33','32','33','56','33',c.s031) 
                               )
                         loop
   
                            if (k.sum_ob >= 0 OR k.sum_obp >= 0 OR k.sum_obi >= 0) 
                               and k.s031 not in ('29','30','31','32','33','34','40','41','42','43','44','45','90')
                            then
                               p080_ := k.s031;

                               -- �� 01.03.2014 ����� ��� �������� ����� ����������� S031
                               if substr(p070_,1,3) in ('140','141','142','150',
                                                        '181','280','300','301',
                                                        '304','310','311','320',
                                                        '321','351','354','357',
                                                        '920','930','935') 
                                     and k.sum_ob = 0    
                               then
                                  p080_ := '00';
                               end if;
                               if substr(p070_,1,3) not in ('140','141','142','150',
                                                            '181','280','300','301',
                                                            '304','310','311','320',
                                                            '321','351','354','357',
                                                            '920','930','935') 
                                     and k.sum_ob = 0 and k.accs = 0
                               then
                                  p080_ := '90';
                               end if;

                               if k.sum_ob > 0 and k.kl_351 <> 0 
                               then 
                                  p_p081_ := to_char (k.sum_ob);
                                  -- ���� ������������
                                  p_ins ('081' || kod_okpo || kod_nnnn || '0000' || '000', p_p081_, nls_, '00', k021_, '0', p080_, '0', '0');
                               end if;

                               if k.sum_ob = 0 and k.accs = 0 and sum_ob_ = 0     --k.kl_351 >= 0 
                               then 
                                  if not (mfo_ = 300465 and rnk_ in (30000601, 30004701, 30007901, 
                                                                     97789701, 97815901, 97816201, 
                                                                     97826101)) OR
                                         (mfo_ = 322669 and rnk_ in (246599, 587674))
                                  then
                                     p_p081_ := to_char (k.sum_ob);
                                     -- ���� ������������
                                     p_ins ('081' || kod_okpo || kod_nnnn || '0000' || '000', p_p081_, nls_, '00', k021_, '0', p080_, '0', '0');
                                  end if;
                               end if;
                              
                               if k.sum_obp > 0 then 
                                  p_p081_ := to_char (k.sum_obp);
                                  -- ���� ������������
                                  p_ins ('084' || kod_okpo || kod_nnnn || '0000' || '000', p_p081_, nls_, '00', k021_, '0', p080_, '0', '0');
                               end if;

                               if k.sum_obi > 0 then 
                                  p_p081_ := to_char (k.sum_obi);
                                  -- ���� ������������
                                  p_ins ('086' || kod_okpo || kod_nnnn || '0000' || '000', p_p081_, nls_, '00', k021_, '0', '00', '0', '0');
                               end if;

                            end if;
   
                      end loop;
                   end if;

                   -- ����������� ���� 083 
                   -- ���� ������������ �� ��� ���������� ��������� �����
                   if p081_ >= 0 then
                      for k in ( select NVL(DECODE(c.s031,'26','33','29','33','30','33','31','33','32','33','56','33',c.s031),'00') s031, 
                                        NVL( sum (z.pvzq),0) sum_ob
                                 from tmp_rez_obesp23 z, cc_pawn c, accounts a, specparam sp
                                 where z.dat = Dat23_
                                   and z.pawn = c.pawn
                                   and z.accs = acc_
                                   and z.accz = a.acc
                                   and a.acc = sp.acc(+) 
                                   and substr(a.nls,1,4) || NVL(sp.r013,'0') in ('16021', '26021', '26221',  
                                                                                 '90301', '90311', '90361',
                                                                                 '95001', '95003'
                                                                                )                       
                                 group by DECODE(c.s031,'26','33','29','33','30','33','31','33','32','33','56','33',c.s031) 
                               )
                         loop
   
                            if k.sum_ob >= 0 and k.s031 not in ('29','30','31','32','33','34','40','41','42','43','44','45')
                            then
                               p080_ := k.s031;
                               p083_ := to_char(k.sum_ob);
   
                               -- �� 01.03.2014 ����� ��� �������� ����� ����������� S031
                               if substr(p070_,1,3) in ('150','181','280','300','301',
                                                        '304','310','311','320',
                                                        '321','351','354','357',
                                                        '920','930','935')   
                                     and p083_ = 0
                               then
                                  p080_ := '00';
                               end if;
                   
                               -- ���� ������������
                               p_ins ('083' || kod_okpo || kod_nnnn || '0000' || '000', p083_, null, '00', k021_, '0', p080_, '0', '0');
                            end if;
   
                      end loop;
                   else
                      p080_ := '90';
                      -- ���� ������������
                      --p_ins ('083' || kod_okpo || kod_nnnn || '0000' || '000', '0', null, '00', k021_, '0', p080_);
                   end if;
                end if;
-----------------------------------------------------------------------
                if p085_p is null and substr(p070_,1,3) in ('181','280','300','301','304','310','311','320','321','351','354','355','357') 
                then
                   p085_p := '0';
                end if;

                if Dat_ < dat_izm5
                then
                   -- ��� ������ �����������/���������
                   p_ins ('085' || kod_okpo || kod_nnnn || '0000' || p140_, p085_p,
                           nls_, '00', k021_, '0', '00', '0', '0'
                          );
                end if;
                
                -- ���� ���������� �������������_
                p_ins ('111' || kod_okpo || kod_nnnn || '0000' || p140_,
                       TO_CHAR (p111_, dfmt_),
                       nls_, '00', k021_, '0', '00', '0', '0'
                      );

                -- ���� ��������� �������������_ ��_��� � ���������
                if (mfo_ = 300465 and p070_ in ('1500','1502') and trim(p112_) is not null) or
                   (mfo_ = 300465 and p070_ not in ('1500','1502') ) or
                   (mfo_ = 300120 and p070_ not in ('2030','2037','2038','2039') ) or
                    mfo_ not in (300120, 300465) then
                   p_ins ('112' || kod_okpo || kod_nnnn || '0000' || p140_,
                          TO_CHAR (p112_, dfmt_),
                          nls_, '00', k021_, '0', '00', '0', '0'
                         );
                end if;

                -- ����� �������� ����������� 160, 162, 163, 164
                if Dat_ >= dat_izm5
                then
                   begin
                      select NVL(round(lgd, 2), 0), NVL(round(pd, 3), 0),  
                             substr(kol29,1,70), substr(NVL(kol24,'000'),1,70), substr(NVL(kol25,'0000'),1,70), 
                             substr(NVL(kol26,'000000000'),1,70), substr(NVL(kol27,'000'),1,70), 
                             substr(NVL(trim(kol28),'00000'),1,70), substr(kol30,1,70)
                         into lgd_, pd_,  
                              p170_, p171_, p172_, 
                              p173_, p174_, 
                              p175_, p179_ 
                      from rez_cr 
                      where fdat = dat23_
                        and acc = acc_
                        and rownum = 1;
                   exception when no_data_found then
                      lgd_ := 0;
                      pd_ := 0;
                      p170_ := '';
                      p171_ := '000';
                      p172_ := '0000';
                      p173_ := '000000000';
                      p174_ := '000';
                      p175_ := '00000';
                      p179_ := '';
                   end;
                end if;

                if Dat_ >= to_date('29122012','ddmmyyyy') then
                   BEGIN
                      select pd_0, NVL(s080_z, s080), 
                      --decode(NVL(s250_23,'0'), '8', '0', s080),
                      s080, 
                      NVL(s250_23,'0')   
                        into pd_0_, s080_, fin_, s250_23_ 
                   from nbu23_rez
                   where fdat = dat23_
                     and rnk = rnk_
                     and nd = nd_
                     and kv = kv_
                     and id not like 'DEB%'
                     and nls not like '9129%'
                     and rownum =1;
                   EXCEPTION WHEN NO_DATA_FOUND THEN
                      BEGIN
                         select pd_0, NVL(s080_z, s080), 
                                --decode(NVL(s250_23,'0'), '8', '0', s080), 
                                s080,
                                NVL(s250_23,'0')
                            into pd_0_, s080_, fin_, s250_23_ 
                         from nbu23_rez
                         where fdat = dat23_
                           and rnk = rnk_
                           and nd = nd_ 
                           and kv = kv_
                           and id like 'DEB%'
                           and rownum = 1;
                      EXCEPTION WHEN NO_DATA_FOUND THEN
                         BEGIN
                            select pd_0, NVL(s080_z, s080), 
                                   --decode(NVL(s250_23,'0'), '8', '0', s080), 
                                   s080, 
                                   NVL(s250_23,'0')
                               into pd_0_, s080_, fin_, s250_23_ 
                            from nbu23_rez
                            where fdat = dat23_
                              and rnk = rnk_
                              and nd = nd_ 
                              and kv = kv_
                              and nls like '9129%'
                              and rownum = 1;
                         EXCEPTION WHEN NO_DATA_FOUND THEN
                            pd_0_ := 0;
                            s080_ := '0';
                            fin_ := '0';
                            s250_23_ := '0';
                         END;
                      END;
                   END;
                end if;

                if fin_ = '0' 
                then
                   BEGIN
                      select pd_0, NVL(s080_z, s080), 
                             --decode(NVL(s250_23,'0'), '8', '0', s080)   
                             s080 
                         into pd_0_, s080_, fin_  
                      from nbu23_rez
                      where fdat = dat23_
                        and acc = acc_
                        and rownum =1;
                   EXCEPTION WHEN NO_DATA_FOUND THEN
                      null;
                   END;
                end if;

                --if p070_ like '351%' 
                --OR p070_ like '355%' 
                --then
                --   pd_0_ := 0;
                --   fin_ := '0';
                --   s250_23_ := '0';
                --end if;
                
                H_ := '0';

                if pd_0_ != 1 and s250_23_ = '8' then
                   H_ := '2';
                elsif pd_0_ != 1  then
                   H_ := '1';
                else
                   H_ := '0';
                end if;
                
                if nls_ like '3105%'
                then
                    select NVL(trim(r013),'0')
                       into r013_
                    from specparam
                    where acc=acc_;
                end if;
                             
                -- ������ 15/06/2017 ����� �������� ���������� �������� � ���
                if nls_ like '3102%' and rnk_ in (90931101, 10020901) 
                OR nls_ like '3105%' and r013_ = '2'            
                OR nls_ like '96%'
                then
                   fin_ := '0';
                   s080_ := '0';
                   pd_ := '';
                end if;
                
                if pd_0_ = 1  and substr(p070_,1,3) in ('140','141','142',
                                                        '300','301','310',
                                                        '311','312')
                then
                   H_ := '0';
                end if;

                -- ���������� CCF
                if dat_ >= dat_izm6 then
                   p_ins ('150' || kod_okpo || kod_nnnn || '0000' || p140_, 
                          TO_CHAR (ccf_ / 100, fmtkap_), 
                          nls_, '00', k021_, '0', '00', '0', '0'
                         );
                end if;

                -- ���� �������������_
                if dat_ <= to_date('30112012','ddmmyyyy') then
                   p_ins ('160' || kod_okpo || kod_nnnn || '0000' || '000', s080_, '0', '0');
                else 
                   p_ins ('160' || kod_okpo || kod_nnnn || '0000' || p140_, to_char(s080_), 
                          nls_, '00', k021_, '0', '00', '0', '0'
                         );
                end if;

                -- �� 01.04.2016 ��� ���������������� "2" ������� 
                if dat_ >= to_date('01072011','ddmmyyyy') then
                   if p070_ like '1%' or p070_ like '2%' or p070_ like '3%' or
                      p070_ = '9129' 
                   then -- ?�������_ ������_�??? ?
                      if nd_ is not null and 
                         substr(p070_,1,3) not in ('140','141','142',
                                                   '300','301','310',
                                                   '311','312')
                      then -- ??? � ��������� �����_�
                         begin 
                           select c.vid_restr, NVL(substr(trim(n.txt),1,1), null)
                              into vid_, zamina_a
                           from cck_restr c, nd_txt n
                           where c.nd = nd_
                             and dat_ between c.fdat and nvl(c.fdat_end, dat_)
                             and c.pr_no = 1
                             and c.nd = n.nd(+) 
                             and nvl(n.tag(+), 'ASSET') like 'ASSET%'
                             and rownum = 1;
                         exception when no_data_found then
                            vid_ := 0;
                         end;
                         
                         IF dat_ >= to_date('31102017','ddmmyyyy')
                         THEN
                            if vid_ in (1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 13, 15, 17)
                               and NVL(zamina_a, '0') not in ('0','5','6')
                            then  
                               vid_ := 4; -- ����������������� ��� ����� ������
                            elsif vid_ in (1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 13, 15, 17)
                                  and zamina_a = '5'
                            then
                               vid_ := 5; -- ����� ������ �������� ����������������
                            elsif zamina_a = '6'
                            then
                               vid_ := 6; -- ����� ������ �� �������� � �����������������
                            else 
                               vid_ := 0;
                            end if;
                         END IF;
                      else
                         begin 
                            select vid_restr
                              into vid_
                           from cck_restr_acc
                           where acc = acc_
                             and dat_ between fdat and nvl(fdat_end, dat_)
                             and pr_no = 1
                             and rownum = 1;
                         exception when no_data_found then
                            vid_ := 0;
                         end;
                         
                         IF dat_ >= to_date('31102017','ddmmyyyy')
                         THEN
                            if vid_ in (1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 13, 15, 17)
                            then  
                               vid_ := 4; -- ����������������� ��� ����� ������
                            elsif vid_ in (18)
                            then
                               vid_ := 5; -- ����� ������ (��) �������� ����������������
                            elsif vid_ in (19)
                            then
                               vid_ := 6; -- ����� ������ (��), �� �������� � �����������������
                            else 
                               vid_ := 0;
                            end if;
                         END IF;
                      end if;

                      IF dat_ < to_date('31102017','ddmmyyyy')
                      THEN
                         if vid_ in (1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 13, 15)
                         then  
                            vid_ := 1; -- ���� ��������������_�
                         elsif vid_ in (10, 14, 16)
                         then
                            vid_ := 2; -- �� ���� ��������������_�
                         elsif vid_ in (17)
                         then
                            vid_ := 3; -- ����������������� �� �������������
                         else 
                            null;
                         end if;
                      END IF;  
                   else
                       vid_ := 0; -- _��_ ������_ ������_�
                   end if;

                   -- ���� �������������_ ���� ��������������?�
                   p_ins ('161' || kod_okpo || kod_nnnn || '0000' || p140_, to_char(vid_),
                          nls_, '00', k021_, '0', '00', '0', '0'
                         );

                   if Dat_ < dat_izm5
                   then
                      -- ����� ����������� ���� ���������� ����� ������
                      p_ins ('162' || kod_okpo || kod_nnnn || '0000' || p140_, LTRIM (TO_CHAR (TO_NUMBER(p150_), fmt1_)),
                            nls_, '00', k021_, '0', '00', '0', '0'
                           );
                   end if;
                end if;

             end if;

             if Dat_ >= dat_izm5
             then
                -- ���������� LGD
                p_ins ('162' || kod_okpo || kod_nnnn || '0000' || p140_, LTRIM (TO_CHAR (lgd_)), --fmt1_),
                       nls_, '00', k021_, '0', '00', '0', '0'
                      );

                -- ���������� PD
                p_ins ('163' || kod_okpo || kod_nnnn || '0000' || p140_, LTRIM (TO_CHAR (pd_)), -- fmt2_),
                       nls_, '00', k021_, '0', '00', '0', '0'
                      );

                -- ��� ������������� �����
                p_ins ('164' || kod_okpo || kod_nnnn || '0000' || p140_, TO_CHAR (fin_),
                       nls_, '00', k021_, '0', '00', '0', '0'
                      );

                -- ��� ������� �� ������ ����� ������������� ���� �����������
                p_ins ('170' || kod_okpo || kod_nnnn || '0000' || p140_, p170_,
                       nls_, '00', k021_, '0', '00', '0', '0'
                      );

                -- ��� ������� ���� ��������� �� ����� �����
                p_ins ('171' || kod_okpo || kod_nnnn || '0000' || p140_, p171_,
                       nls_, '00', k021_, '0', '00', '0', '0'
                      );
                -- ��� ������� ���� �������� ������ �� ������� ��� ������� ��������� �����
                p_ins ('172' || kod_okpo || kod_nnnn || '0000' || p140_, p172_,
                       nls_, '00', k021_, '0', '00', '0', '0'
                      );
                -- ��� ������� ���� ��䳿 �������
                p_ins ('173' || kod_okpo || kod_nnnn || '0000' || p140_, p173_,
                       nls_, '00', k021_, '0', '00', '0', '0'
                      );

                if s080_ not in ('K','L')
                then
                   -- ��� ������� ���� �������� ������ �����
                   p_ins ('174' || kod_okpo || kod_nnnn || '0000' || p140_, p174_,
                          nls_, '00', k021_, '0', '00', '0', '0'
                         );
                end if;

                if p175_ <> '00000'
                then
                   -- ��� ������� ���� ���������� �������������
                   p_ins ('175' || kod_okpo || kod_nnnn || '0000' || p140_, p175_,
                          nls_, '00', k021_, '0', '00', '0', '0'
                         );
                end if;

                -- ��� ������ ������� �����������
                p_ins ('179' || kod_okpo || kod_nnnn || '0000' || p140_, p179_,
                       nls_, '00', k021_, '0', '00', '0', '0'
                      );

             end if;

             if p080_ = '90' then
                p081_ := '0';
             end if;

             if p070_ in ('1502','1524','3003','3005','3006','3007',
                          '3010','3011','3012','3013','3014','3015',
                          '3103','3105','3106','3107','3115','3212',
                          '3540','3578','9129'
                         ) 
             then
                select NVL(trim(r013),'0')
                   into r013_
                from specparam
                where acc=acc_;
             end if;

             if Dat_ = to_date('30122016','ddmmyyyy') and p070_ like '9129%' and r013_ = '9'
             then
                -- �������� �� ������� ������� �� ������ ������ �� NBU23_REZ
                SELECT NVL(sum(t.rezq*100), 0) 
                   INTO sum_rez_
                FROM nbu23_rez t                         
                WHERE t.acc = acc_
                  and t.fdat = dat23_;

                iF sum_rez_ <> 0
                then
                   r013_ := '1';
                end if;
             end if;

             -- ��������� ������ �� ��������
             if substr(p070_,4,1) not in ('5','6','8','9') and
                p070_ not in ('1490','1491','1590','1592','2400','2401','2890','3190','3590','3690','2607','2627','2657') or
                p070_ = '9100' or (p070_ = '9129' and r013_ = '1')
             then
                if dat_ <= to_date('31012012','ddmmyyyy') then
                   p_ins ('130' || kod_okpo || kod_nnnn || '0000' || p140_,
                          LTRIM (TO_CHAR (p130_, fmt_)),
                          nls_
                         );
                else
                   p_ins ('130' || kod_okpo || kod_nnnn || '0000' || p140_,
                          LTRIM (TO_CHAR (p130_, fmt_)),
                          nls_, '00', k021_, '0', '00', '0', '0'
                         );
                end if;
             end if;

             kol_trans := 0;

             -- ���� �������� �������������_ �����������
             IF ddd_ = '119'
             THEN
                if Dat_ >= dat_izm3
                then
                   if p070_ = '9129' and r013_ ='9'
                   then 
                      w_ := '2';
                   else 
                      w_ := '1';
                   end if;

                   comm_ := substr(comm_ || nls_ || ' ' || to_char(kv_) || 
                            ' R013=' || r013_ || ' W=' || w_, 1, 200);

                   p_ins ('118' || kod_okpo || kod_nnnn || p070_ || p140_,
                                TO_CHAR (ABS (p120_)),
                                nls_, '00', k021_, w_, '00', H_, K140_
                         );
                end if;
 
                if (p070_ = '9129' and r013_ = '1') or p070_ <> '9129'
                then

                   IF dat_ <= to_date('31012012','ddmmyyyy') then
                      p_ins (ddd_ || kod_okpo || kod_nnnn || '0000' || p140_,
                             TO_CHAR (ABS (p120_)),
                             nls_
                            );
                   else
                      comm_ := substr(comm_ || nls_ || ' ' || to_char(kv_) || 
                               ' R013=' || r013_ || ' W=' || w_, 1, 200);

                      p_ins (ddd_ || kod_okpo || kod_nnnn || p070_ || p140_,
                             TO_CHAR (ABS (p120_)),
                             nls_, '00', k021_, w_, '00', H_, K140_
                            );
                      sum_d_ := sum_d_ + ABS(p120_);
                   end if;
                end if;
             ELSE
                IF ddd_ IN ('122', '124')
                THEN
                   w_ := '2';

                   if (p070_ = '3007' and r013_ ='9') or
                      (p070_ = '3015' and r013_ ='9') or 
                      (p070_ = '3107' and r013_ in ('1','9')) or
                      (p070_ = '3115')
                      
                   then 
                      w_ := '1';
                   end if;

                   comm_ := substr(comm_ || nls_ || ' ' || to_char(kv_) || 
                            ' R013=' || r013_ || ' W=' || w_, 1, 200);

                   -- ������� �� ����_� �������� �_ ������
                   p_ins (ddd_ || kod_okpo || kod_nnnn || p070_ || p140_,
                          TO_CHAR (0 - p120_),
                          nls_, '00', k021_, w_, '00', H_, K140_
                         );
                ELSE
                   if (ddd_ = '123' and p120_ != 0) or ddd_ not in ('119','123') then

                      if ddd_ = '121' and ( p070_ in ('1500','1514','3002','3102','3579') or 
                                            (p070_ = '1502' and r013_ not in ('1','2','9')) or  
                                            (p070_ = '1524' and r013_ not in ('1','3')) or  
                                            (p070_ in ('3003','3005','3010','3011') and r013_ not in ('9')) or  
                                            (p070_ in ('3006','3106') and r013_ not in ('1')) or  
                                            (p070_ in ('3012','3014') and r013_ not in ('7','9')) or 
                                            (p070_ = '3013' and r013_ not in ('5','6','9','A','B','C')) or   
                                            (p070_ in ('3103','3105') and r013_ not in ('1','9')) or 
                                            (p070_ = '3540' and r013_ not in ('4','5','6','7')) or 
                                            (p070_ = '3578' and r013_ not in ('3','5')) or 
                                            (p070_ in ('3550','3551','3552','3570')) or 
                                            (substr(p070_,1,3) in ('140','141','142')) or 
                                            (p070_ like '92%' or p070_ like '93%' or p070_ like '96%')     
                                          )
                      then 
                         w_ := '2';
                      else 
                         w_ := '1';
                      end if;

                      comm_ := substr(comm_ || nls_ || ' ' || to_char(kv_) || 
                               ' R013=' || r013_ || ' W=' || w_, 1, 200);
 
                      -- ��� �������
                      if dat_ >= dat_izm2 then
                         if ddd_ = '121' and p070_ in ('2062','2063','2067')
                         then
                            select count(*)
                               into kol_trans
                            from cc_trans_dat
                            where acc = acc_ and
                                exists ( select 1
                                           from nd_txt n1
                                           where n1.nd = nd_
                                             and n1.tag like 'PR_TR%'
                                             and n1.txt = '1'
                                          )
                              and sv <> 0
                              and fdat <= dat_;

                            if kol_trans <> 0 then
                               delete from rnbu_trace
                               where substr(kodp,1,3) in ('085','111','112','130','150','160','161','162','163','164')
                                 and acc = acc_ and nd = nd_;

                               -- �� 01.11.2016 ����� ���������� 131 
                               -- (��� ���� OBS=4,5 � NBU23_REZ)
                               -- �� 01.02.2017 ����� ���������� 131 
                               -- (��� ���� KOL_351 � NBU23_REZ)

                               if Dat_ >= dat_izm5 
                               then
                                  BEGIN
                                     select NVL(kol_351, 1)
                                        into s190_
                                     from nbu23_rez
                                     where fdat = dat23_
                                       and acc = acc_
                                       and nd = nd_
                                       and kol_351 <> 0
                                       and rownum = 1;
                                  EXCEPTION WHEN NO_DATA_FOUND THEN
                                     BEGIN
                                        select NVL(kol_351, 1)
                                           into s190_
                                        from nbu23_rez
                                        where fdat = dat23_
                                          and acc = acc_
                                          and kol_351 <> 0
                                          and rownum = 1;
                                     EXCEPTION WHEN NO_DATA_FOUND THEN
                                        BEGIN
                                           select NVL(kol_351, 1)
                                              into s190_
                                           from nbu23_rez
                                           where fdat = dat23_
                                             and nd = nd_
                                             and kol_351 <> 0 
                                             and rownum = 1;
                                        EXCEPTION WHEN NO_DATA_FOUND THEN
                                           s190_ := 1;
                                        END;
                                     END;
                                  END;
                                  -- ��  ������� ������� �������� OBS � "3" �� "4"
                                  if mfo_ = 300465 and rnk_ in (940143, 946362) 
                                  then
                                     s190_ := 91;
                                  end if;
                               end if;

                               sum_tr_ := 0;
                               tr_end := 0;
                               
                               if dat_ = to_date('31052017','ddmmyyyy') and acc_ = 587865511 then
                                  pul.Set_Mas_Ini('sFdat1',to_char(Dat_+1,'dd.mm.yyyy'),'date');
                               else
                                  pul.Set_Mas_Ini('sFdat1',to_char(Dat_,'dd.mm.yyyy'),'date');
                               end if;

                               if p070_ = '2063' and TRIM (tip_) = 'SP'  
                               then
                                  BEGIN
                                     SELECT to_date(trim(t.txt),'dd/mm/yyyy')
                                        INTO p111_dop
                                     FROM nd_acc n, nd_txt t
                                     WHERE n.acc = acc_
                                       AND n.nd = t.nd(+)
                                       AND t.tag like 'DB_SS%';
                                  EXCEPTION WHEN NO_DATA_FOUND THEN
                                     p111_dop := null;
                                  END;          
                               end if;

                               for k in ( select p111, p112, st, ref
                                          from
                                             (select (case when p070_ = '2063' and TRIM (tip_) = 'SP'  
                                                           then t.d_plan - 365 
                                                           else t.fdat
                                                      end) p111,
                                                      (case when t.d_fakt is not null and t.d_fakt > Dat_ 
                                                            then t.d_plan 
                                                            else NVL(t.d_fakt,t.d_plan) 
                                                      end) p112,
                                                      gl.p_icurval(kv_, NVL(t.sv*100,0) - NVL(t.sz*100,0), Dat_) st,
                                                      t.ref
                                               from cc_trans_dat t
                                               where t.acc = acc_
                                                 and NVL(t.sv*100,0) -  NVL(t.sz*100,0) <> 0
                                             )
                                             order by 1,4
                                        )
                                    loop
                                       n_trans := n_trans + 1;
                                       s_tr_ := k.st;
                                       sum_tr_ := sum_tr_ + k.st;
                                       p111_ := k.p111;

                                       if p070_ = '2063' and TRIM (tip_) = 'SP' and n_trans = 1
                                       then
                                          if p111_dop is null then
                                             begin
                                                select min(t.fdat)
                                                   into p111_
                                                from cc_trans_dat t, nd_acc n
                                                where t.acc = n.acc
                                                  and n.nd = nd_;
                                             exception when no_data_found then
                                                p111_ := k.p111;
                                             end;
                                          else
                                              p111_ := p111_dop;
                                          end if;
                                       end if;

                                       if tr_end = 0 then

                                          kod_mm := substr(sep.h2_rrp(trunc(mod(n_trans,36*36)/36)),1,1)
                                                 || substr(sep.h2_rrp(mod(n_trans,36)),1,1);

                                          -- ���� ���������� �������������_
                                          p_ins ('111' || kod_okpo || kod_nnnn || '0000' || p140_,
                                                  TO_CHAR (p111_, dfmt_),
                                                  nls_,
                                                  kod_mm, k021_, '0', '00', '0', '0'
                                                );

                                          -- ������ ���� ��� ������ ������� ����� ������������� � ��� 111
                                          -- ��� ����������� 123,122,119
                                          if n_trans = 1 then
                                             p111_1 := p111_;
                                             -- ��������� ���� ��� ������ ������� ����� ������������� � ��� 112
                                             -- ��� ����������� 123,122,119
                                             p112_2 := k.p112;
                                          end if;

                                          -- ���� ��������� �������������_ ��_��� � ���������
                                          p_ins ('112' || kod_okpo || kod_nnnn || '0000' || p140_,
                                                  TO_CHAR (k.p112, dfmt_),
                                                  nls_,
                                                  kod_mm, k021_, '0', '00', '0', '0', 
                                                  'ntr='||to_char(n_trans)||' '||to_char(p120_)||' '||to_char(sum_tr_)||' '||to_char(s_tr_)||' '||tr_end
                                                );

                                          if ABS(sum_tr_) > ABS(p120_) then
                                             s_tr_ := ABS(p120_) - (ABS(sum_tr_) - s_tr_);
                                             tr_end := 1;
                                          end if;

                                          -- ���� ������
                                          p_ins (ddd_ || kod_okpo || kod_nnnn || p070_ || p140_,
                                                 TO_CHAR (ABS (s_tr_)),
                                                 nls_,
                                                 kod_mm, k021_, w_, '00', H_, K140_
                                                );

                                          if p070_ = '2063' and TRIM (tip_) = 'SP' 
                                          then
                                             -- ���� ������ ��� ������ ��������� (���� 126) 
                                             p_ins ('126' || kod_okpo || kod_nnnn || p070_ || p140_,
                                                    TO_CHAR (ABS (s_tr_)),
                                                    nls_,
                                                    kod_mm, k021_, w_, '00', H_, K140_
                                                   );

                                             if s190_ > 90     
                                             then
                                                p_ins ('131' || kod_okpo || kod_nnnn || p070_ || p140_,
                                                       TO_CHAR (ABS (s_tr_)),
                                                       nls_,
                                                       kod_mm, k021_, w_, '00', H_, K140_
                                                      );                                            
                                             end if;
                                          end if; 

                                          -- ��������� ������ �� ��������
                                          p_ins ('130' || kod_okpo || kod_nnnn || '0000' || p140_,
                                                 LTRIM (TO_CHAR (p130_, fmt_)),
                                                 nls_,
                                                 kod_mm, k021_, '0', '00', '0', '0' 
                                                );

                                          -- ���������� CCF
                                          if dat_ >= dat_izm6 then
                                             p_ins ('150' || kod_okpo || kod_nnnn || '0000' || p140_, 
                                                    TO_CHAR (ccf_ / 100, fmtkap_), 
                                                    nls_, kod_mm, k021_, '0', '00', '0', '0'
                                                   );
                                          end if;

                                          -- ���� �������������_
                                          p_ins ('160' || kod_okpo || kod_nnnn || '0000' || p140_ , to_char (s080_),
                                                 nls_,
                                                 kod_mm, k021_, '0', '00', '0', '0'
                                                );

                                          -- ���� �������������_ ���� ��������������?�
                                          p_ins ('161' || kod_okpo || kod_nnnn || '0000' || p140_, to_char (vid_),
                                                 nls_,
                                                 kod_mm, k021_, '0', '00', '0', '0'
                                                );

                                          -- ���������� (LGD)
                                          p_ins ('162' || kod_okpo || kod_nnnn || '0000' || p140_, LTRIM (TO_CHAR (lgd_)), --fmt1_),
                                                 nls_,
                                                 kod_mm, k021_, '0', '00', '0', '0'
                                                );

                                          -- ���������� (PD)
                                          p_ins ('163' || kod_okpo || kod_nnnn || '0000' || p140_, LTRIM (TO_CHAR (pd_)), --fmt2_),
                                                 nls_,
                                                 kod_mm, k021_, '0', '00', '0', '0'
                                                );

                                          -- ��� ������������� ����� �����������
                                          p_ins ('164' || kod_okpo || kod_nnnn || '0000' || p140_, TO_CHAR (fin_),
                                                 nls_,
                                                 kod_mm, k021_, '0', '00', '0', '0'
                                                );

                                       else
                                          exit;
                                       end if;
                                 end loop;
                            else
                               p_ins (ddd_ || kod_okpo || kod_nnnn || p070_ || p140_,
                                      TO_CHAR (ABS (p120_)),
                                      nls_,
                                      null, k021_, w_, '00', H_, K140_ 
                                     );

                               -- ����� ��� �� 01.04.2016
                               if dat_ >= dat_izm3 and 
                                  p070_ in ('1510','1513','1520','1521','1524',  
                                            '2020','2030','2063','2071','2083', 
                                            '2103','2113','2123','2133','2203', 
                                            '2211','2220','2233','3578' ) and 
                                  tip_ in ('SP','SK9','OFR')
                               then   
                                  p_ins ('126' || kod_okpo || kod_nnnn || p070_ || p140_,
                                         TO_CHAR (ABS (p120_)),
                                         nls_,
                                         null, k021_, w_, '00', H_, K140_
                                        );
   
                                  -- �� 01.11.2016 ����� ���������� 131 
                                  -- (��� ���� OBS=4,5 � NBU23_REZ)
                                  if Dat_ >= dat_izm5 
                                  then
                                     BEGIN
                                        select NVL(kol_351, 1)
                                           into s190_
                                        from nbu23_rez
                                        where fdat = dat23_
                                          and acc = acc_
                                          and nd = nd_
                                          and kol_351 <> 0
                                          and rownum = 1;
                                     EXCEPTION WHEN NO_DATA_FOUND THEN
                                        BEGIN
                                           select NVL(kol_351, 1)
                                              into s190_
                                           from nbu23_rez
                                           where fdat = dat23_
                                             and acc = acc_
                                             and kol_351 <> 0 
                                             and rownum = 1;
                                        EXCEPTION WHEN NO_DATA_FOUND THEN
                                           BEGIN
                                              select NVL(kol_351, 1)
                                                 into s190_
                                              from nbu23_rez
                                              where fdat = dat23_
                                                and nd = nd_
                                                and kol_351 <> 0
                                                and rownum = 1;
                                           EXCEPTION WHEN NO_DATA_FOUND THEN
                                              s190_ := 1;
                                           END;
                                        END;
                                     END;
                                     -- ��  ������� ������� �������� OBS � "3" �� "4"
                                     if mfo_ = 300465 and rnk_ in (940143, 946362) 
                                     then
                                        s190_ := 91;
                                     end if;
                                     if s190_ > 90   
                                     then
                                        p_ins ('131' || kod_okpo || kod_nnnn || p070_ || p140_,
                                               TO_CHAR (ABS (p120_)),
                                               nls_,
                                               null, k021_, w_, '00', H_, K140_
                                              );                                            
                                     end if;
                                  end if;
                               end if;
                            end if;
                         else
                            if ddd_ = '123' then
                               if (p070_ in ('1408', '1418', '1428', '1508',
                                             '1518', '1528', '1538', '1548', 
                                             '1607', '2018', '2028', '2038', 
                                             '2048', '2068', '2078', '2088',  
                                             '2108', '2118', '2128', '2138',  
                                             '2148', '2208', '2218', '2228', 
                                             '2238', '2248', '2308', '2318',  
                                             '2328', '2338', '2348', '2358',  
                                             '2368', '2378', '2388', '2398', 
                                             '2408', '2418', '2428', '2438', 
                                             '2458', '2607', '2627', '2657',
                                             '3008', '3018', '3108', '3118', 
                                             '3218', '3418', '3428', '3568'
                                            ) and p120_ > 0 ) 
                               then
                                  w_ := '2';
                                  p_ins (ddd_ || kod_okpo || kod_nnnn || p070_ || p140_,
                                         TO_CHAR (-1*p120_),
                                         nls_,
                                         null, k021_, w_, '00', H_, K140_
                                        );
                               end if;

                               if dat_ >= dat_izm5 and 
                                  (p070_ in ('1408', '1418', '1428', '1508',   
                                             '1518', '1528', '1538', '1548',   
                                             '1607', '2018', '2028', '2038',   
                                             '2048', '2068', '2078', '2088',   
                                             '2108', '2118', '2128', '2138',   
                                             '2148', '2208', '2218', '2228',   
                                             '2238', '2248', '2308', '2318',   
                                             '2328', '2338', '2348', '2358',   
                                             '2368', '2378', '2388', '2398',   
                                             '2408', '2418', '2428', '2438',   
                                             '2458', '2607', '2627', '2657',   
                                             '3008', '3018', '3108', '3118',   
                                             '3218', '3418', '3428', '3568'    
                                            ) and p120_ < 0 ) 
                               then

                                  -- �� 01.11.2016 ����� ���������� 132 
                                  -- (��� ���� OBS=4,5 � NBU23_REZ)
                                  -- �� 01.02.2017 ����� ���������� 132 
                                  -- (��� ���� KOL_351 � NBU23_REZ)
                                  if Dat_ >= dat_izm5 
                                  then
                                     BEGIN
                                        select NVL(kol_351, 1)
                                           into s190_
                                        from nbu23_rez
                                        where fdat = dat23_
                                          and acc = acc_
                                          and nd = nd_
                                          and kol_351 <> 0
                                          and rownum = 1;
                                     EXCEPTION WHEN NO_DATA_FOUND THEN
                                        BEGIN
                                           select NVL(kol_351, 1)
                                              into s190_
                                           from nbu23_rez
                                           where fdat = dat23_
                                             and acc = acc_
                                             and kol_351 <> 0 
                                             and rownum = 1;
                                        EXCEPTION WHEN NO_DATA_FOUND THEN
                                           BEGIN
                                              select NVL(kol_351, 1)
                                                 into s190_
                                              from nbu23_rez
                                              where fdat = dat23_
                                                and nd = nd_
                                                and kol_351 <> 0  
                                                and rownum = 1;
                                           EXCEPTION WHEN NO_DATA_FOUND THEN
                                              s190_ := 1;
                                           END;
                                        END;
                                     END;
                                     --if p070_ = '3119' 
                                     --then
                                     --   begin
                                     --      select NVL(s190, '1')
                                     --         into s190s_ 
                                     --      from specparam 
                                     --      where acc = acc_;
                                     --   exception when no_data_found then 
                                     --      s190s_ := '1';
                                     --   end;
                                     --   if s190s_ in ('4', '5', 'E', 'F', 'G') 
                                     --   then
                                     --      s190_ := 91;
                                     --   end if;
                                     --end if; 
                                     -- ��  ������� ������� �������� OBS � "3" �� "4"
                                     if mfo_ = 300465 and rnk_ in (940143, 946362) 
                                     then
                                        s190_ := 91;
                                     end if;
                                     if s190_ > 90 
                                     then
                                        p_ins ('132' || kod_okpo || kod_nnnn || p070_ || p140_,
                                               TO_CHAR (ABS (p120_)),
                                               nls_,
                                               null, k021_, w_, '00', H_, K140_
                                              );                                            
                                     end if;

                                  end if;         
                               end if;
                            else
                               p_ins (ddd_ || kod_okpo || kod_nnnn || p070_ || p140_,
                                      TO_CHAR (ABS (p120_)),
                                      nls_,
                                      null, k021_, w_, '00', H_, K140_ 
                                     );

                               -- ����� ��� �� 01.04.2016
                               if dat_ >= dat_izm3 and 
                                  p070_ in ('1510','1513','1520','1521','1524',  
                                            '2020','2030','2063','2071','2083', 
                                            '2103','2113','2123','2133','2203', 
                                            '2211','2220','2233','3578' ) and 
                                  tip_ in ('SP','SK9','OFR')
                               then 
                                  p_ins ('126' || kod_okpo || kod_nnnn || p070_ || p140_,
                                            TO_CHAR (ABS (p120_)),
                                            nls_,
                                            null, k021_, w_, '00', H_, K140_
                                           );

                                  -- �� 01.11.2016 ����� ���������� 131 
                                  -- (��� ���� OBS=4,5 � NBU23_REZ)
                                  -- �� 01.02.2017 ����� ���������� 131 
                                  -- (��� ���� KOL_351 � NBU23_REZ)
                                  if Dat_ >= dat_izm5 
                                  then
                                     BEGIN
                                        select NVL(kol_351, 1)
                                           into s190_
                                        from nbu23_rez
                                        where fdat = dat23_
                                          and acc = acc_
                                          and nd = nd_
                                          and kol_351 <> 0
                                          and rownum = 1;
                                     EXCEPTION WHEN NO_DATA_FOUND THEN
                                        BEGIN
                                           select NVL(kol_351, 1)
                                              into s190_ 
                                           from nbu23_rez
                                           where fdat = dat23_
                                             and acc = acc_
                                             and kol_351 <> 0 
                                             and rownum = 1;
                                        EXCEPTION WHEN NO_DATA_FOUND THEN
                                           BEGIN
                                              select NVL(kol_351, 1)
                                                 into s190_
                                              from nbu23_rez
                                              where fdat = dat23_
                                                and nd = nd_
                                                and kol_351 <> 0 
                                                and rownum = 1;
                                           EXCEPTION WHEN NO_DATA_FOUND THEN
                                              s190_ := 1;
                                           END;
                                        END;
                                     END;
                                     -- ��  ������� ������� �������� OBS � "3" �� "4"
                                     if mfo_ = 300465 and rnk_ in (940143, 946362) 
                                     then
                                        s190_ := 91;
                                     end if;
                                     if s190_ > 90 
                                     then
                                        p_ins ('131' || kod_okpo || kod_nnnn || p070_ || p140_,
                                               TO_CHAR (ABS (p120_)),
                                               nls_,
                                               null, k021_, w_, '00', H_, K140_
                                              );                                            
                                     end if;
                                  end if;         
                               end if;

                               -- �� 01.11.2016 ��� 126 � 131 � ������ ���.������� � S240='Z'
                               if dat_ >= dat_izm4 and p070_ in ('1403', '1404', '1413', '1414', '1423', '1424', 
                                                                 '1811', '1812', '1819', '2800', '2801', '2802',
                                                                 '2805', '2806', '2809', '3002', '3003', '3005',
                                                                 '3006', '3010', '3011', '3012', '3013', '3014',
                                                                 '3102', '3103', '3105', '3106', '3110', '3111',
                                                                 '3112', '3113', '3114', '3122', '3123', '3125', 
                                                                 '3132', '3133', '3135', '3210', '3211', '3212', 
                                                                 '3213', '3214', '3510', '3519', '3540', '3541', 
                                                                 '3548', '3550', '3551', '3552', '3559', '3570'
                                                                )
                               then
                                  --for c0 in ( select nls, kv, znap
                                  --            from rnbu_trace_arch
                                  --            where kodf = 'A7'
                                  --              and datf = dat_
                                  --              and acc = acc_
                                  --              and p070_ = substr(kodp,2,4)
                                  --              and substr(kodp,8,1) = 'Z'
                                  --           )
                                  --loop   
                                  --     p_ins ('126' || kod_okpo || kod_nnnn || p070_ || p140_,
                                  --            TO_CHAR (ABS (p120_)),
                                  --            nls_,
                                  --            null, k021_, w_, '00', H_, K140_
                                  --           );

                                  --end loop; 

                                  -- �� 01.11.2016 ����� ���������� 131 
                                  -- (��� ���� OBS=4,5 � NBU23_REZ)
                                  -- �� 01.02.2017 ����� ���������� 131 
                                  -- (��� ���� KOL_351 � NBU23_REZ)
                                  if p070_ not in ('1811', '1812', '1819',
                                                   '2800', '2801', '2802', '2805', '2806', '2809', 
                                                   '3510', '3519', '3540', '3541', '3548', 
                                                   '3550', '3551', '3552', '3570' 
                                                  )
                                  then
                                     BEGIN
                                        select NVL(kol_351, 1)
                                           into s190_
                                        from nbu23_rez
                                        where fdat = dat23_
                                          and acc = acc_
                                          and nd = nd_
                                          and kol_351 <> 0 
                                          and rownum = 1;
                                     EXCEPTION WHEN NO_DATA_FOUND THEN
                                        BEGIN
                                           select NVL(kol_351, 1)
                                              into s190_
                                           from nbu23_rez
                                           where fdat = dat23_
                                             and acc = acc_
                                             and kol_351 <> 0 
                                             and rownum = 1;
                                        EXCEPTION WHEN NO_DATA_FOUND THEN
                                           BEGIN
                                              select NVL(kol_351, 1)
                                                 into s190_
                                              from nbu23_rez
                                              where fdat = dat23_
                                                and nd = nd_
                                                and kol_351 <> 0 
                                                and rownum = 1;
                                           EXCEPTION WHEN NO_DATA_FOUND THEN
                                              s190_ := 1;
                                           END;
                                        END;
                                     END;
                                     -- �� ������� ������� �������� OBS � "3" �� "4"
                                     -- �� 01.02.2017 ������ OBS �������� �������� �� KOL_351 (������ 90 ����)
                                     if mfo_ = 300465 and rnk_ in (940143, 946362) 
                                     then
                                        s190_ := 91;
                                     end if;
                                  end if;

                                  if p070_ in ('1811', '1812', '1819',
                                               '2800', '2801', '2802', '2805', '2806', '2809', 
                                               '3510', '3519', '3540', '3541', '3548', 
                                               '3550', '3551', '3552', '3570' 
                                              )
                                  then
                                     begin
                                        select NVL(kol_351, 1)
                                           into s080_131 
                                        from nbu23_rez 
                                        where fdat = dat23_
                                          and acc = acc_
                                          and rownum = 1;
                                     exception when no_data_found then 
                                        s080_131 := 1;
                                     end;

                                     if s080_131 > 0 
                                     then 
                                        p_ins ('126' || kod_okpo || kod_nnnn || p070_ || p140_,
                                               TO_CHAR (ABS (p120_)),
                                               nls_,
                                               null, k021_, w_, '00', H_, K140_
                                              );
                                     end if; 
                           
                                     if s080_131 > 90 
                                     then
                                        p_ins ('131' || kod_okpo || kod_nnnn || p070_ || p140_,
                                               TO_CHAR (ABS (p120_)),
                                               nls_,
                                               null, k021_, w_, '00', H_, K140_
                                              );                                            
                                     end if;
                                  end if; 

                                  if p070_ = '3114' 
                                  then
                                     begin
                                        select NVL(s190, '1')
                                           into s190s_ 
                                        from specparam 
                                        where acc = acc_;
                                     exception when no_data_found then 
                                        s190s_ := '1';
                                     end;
                                     if s190s_ in ('4', '5', 'E', 'F', 'G')
                                     then
                                        s190_ := 91;
                                     end if; 
                                  end if; 
                                  -- ��  ������� ������� �������� OBS � "3" �� "4"
                                  if mfo_ = 300465 and rnk_ in (940143, 946362) 
                                  then
                                     s190_ := 91;
                                  end if;

                                  if p070_ not in ('1811', '1812', '1819',
                                                   '2800', '2801', '2802', '2805', '2806', '2809', 
                                                   '3510', '3519', '3540', '3541', '3548', 
                                                   '3550', '3551', '3552', '3570' 
                                                  ) and 
                                     s190_ > 0
                                  then
                                     p_ins ('126' || kod_okpo || kod_nnnn || p070_ || p140_,
                                            TO_CHAR (ABS (p120_)),
                                            nls_,
                                            null, k021_, w_, '00', H_, K140_
                                           );                                            
                                  end if;

                                  if p070_ not in ('1811', '1812', '1819',
                                                   '2800', '2801', '2802', '2805', '2806', '2809', 
                                                   '3510', '3519', '3540', '3541', '3548', 
                                                   '3550', '3551', '3552', '3570' 
                                                  ) and 
                                     s190_ > 90
                                  then
                                     p_ins ('131' || kod_okpo || kod_nnnn || p070_ || p140_,
                                            TO_CHAR (ABS (p120_)),
                                            nls_,
                                            null, k021_, w_, '00', H_, K140_
                                           );                                            
                                  end if;
 
                               end if;
                            end if;
                         end if;
                      else
                         p_ins (ddd_ || kod_okpo || kod_nnnn || p070_ || p140_,
                                TO_CHAR (ABS (p120_)),
                                nls_,
                                null, k021_, w_, '00', H_, K140_
                               );
                      end if;

                   end if;
                   if ddd_ ='123' then
                      sum_d_ := sum_d_ + (-1*p120_);
                   else
                      sum_d_ := sum_d_ + ABS(p120_);
                   end if;
                END IF;
             END IF;

             for k in ( select t.nls, t.r013, t.s080, t.id, t.kv, 
                               NVL(s.ob22, '00') OB22, c.custtype, t.accr
                        from v_tmp_rez_risk_c5 t, customer c, specparam_int s 
                        where t.dat = dat23_ 
                          and t.id not like 'NLO%' 
                          and t.rnk = c.rnk 
                          and t.acc = s.acc(+) 
                          and t.acc = acc_  
                      )
 
                loop
 
                   nbs_r013_ := f_ret_nbsr_rez(k.nls, k.r013, k.s080, k.id, k.kv, k.ob22, k.custtype, k.accr);
             end loop;

             p070_rez_ := substr(nbs_r013_, 1, 4);

             -- ���� ������_�
             IF p125_ <> 0
             THEN
                if (( p070_rez_ like '14_9%' OR
                      p070_rez_ like '15_9%' OR 
                      p070_rez_ like '20_9%' OR
                      p070_rez_ like '21_9%' OR
                      p070_rez_ like '22_9%' OR
                      p070_rez_ like '23_9%' OR
                      p070_rez_ like '24_9%' OR
                      p070_rez_ like '26_9%' 
                    ) and substr(nbs_r013_, 5, 1)  in ('2','4')
                   ) OR
                   ((p070_rez_ = '3119' or p070_rez_ = '3219') and 
                    substr(nbs_r013_, 5, 1)  in ('2','4')
                   ) OR
                   (p070_rez_ = '3599' and 
                    substr(nbs_r013_, 5, 1) in ('2','9')
                   ) OR 
                   p070_rez_ in ('1890','2890','3590','3690','3692')
                then
                   w_ := '1';
                else 
                   w_ := '2';
                end if;

                comm_ := substr(comm_ || nls_ || ' ' || to_char(kv_) || 
                         ' R013=' || r013_ || ' W=' || w_, 1, 200);

                p_ins ('125' || kod_okpo || kod_nnnn || p070_rez_ || p140_,
                       p125_,
                       nls_,
                       null, k021_, w_, '00', H_, K140_ 
                      );
             END IF;

             if  p070_ in ('1408', '1418', '1428', '1508',
                           '1518', '1528', '1538', '1548', 
                           '1607', '2018', '2028', '2038', 
                           '2048', '2068', '2078', '2088',  
                           '2108', '2118', '2128', '2138',  
                           '2148', '2208', '2218', '2228', 
                           '2238', '2248', '2308', '2318',  
                           '2328', '2338', '2348', '2358',  
                           '2368', '2378', '2388', '2398', 
                           '2408', '2418', '2428', '2438', 
                           '2458', '2607', '2627', '2657',
                           '3008', '3018', '3108', '3118', 
                           '3218', '3418', '3428', '3568'
                          )  
             then   
                begin
                   select a.tip, NVL(sp.r013,'3') 
                      into tip_, r013_ 
                   from accounts a, specparam sp  
                   where a.acc = acc_
                     and a.acc = sp.acc(+);
                exception when no_data_found then
                   tip_  := 'SN';
                   r013_ := '3';
                end;
             end if;

             -- ����� ��� �� 01.04.2016 ���.���. 3578 ��������� �� ����� 
             -- ��� �� 12.04.2016
             if dat_ >= dat_izm3 and 
                   p070_ in ('1408', '1418', '1428', '1508',
                             '1518', '1528', '1538', '1548', 
                             '1607', '2018', '2028', '2038', 
                             '2048', '2068', '2078', '2088',  
                             '2108', '2118', '2128', '2138',  
                             '2148', '2208', '2218', '2228', 
                             '2238', '2248', '2308', '2318',  
                             '2328', '2338', '2348', '2358',  
                             '2368', '2378', '2388', '2398', 
                             '2408', '2418', '2428', '2438', 
                             '2458', '2607', '2627', '2657',
                             '3008', '3018', '3108', '3118', 
                             '3218', '3418', '3428', '3568'
                           ) and p120_ < 0 and tip_ <> 'SNP'
             then   

                BEGIN 
                   SELECT i.freq 
                      INTO freq_
                   FROM accounts a8, nd_acc n8, int_accn i
                   WHERE n8.nd = nd_  
                   AND a8.nls like '8999%'
                   AND n8.acc = a8.acc
                   AND a8.acc = i.acc
                   AND i.ID = 0
                   AND ROWNUM = 1; 
                exception when no_data_found then
                   freq_ := null;
                end;

                p_analiz_r013_new (mfo_,
                                   mfou_,
                                   dat_,
                                   acc_,
                                   tip_,
                                   p070_,
                                   kv_,
                                   r013_,
                                   p120_,
                                   nd_,
                                   freq_,
                                   --------
                                   o_r013_1,
                                   o_se_1,
                                   o_comm_1,
                                   --------
                                   o_r013_2,
                                   o_se_2,
                                   o_comm_2
                                  );

                IF o_se_1 <> 0
                THEN
                   if p070_ in ('1408', '1418', '1428', '3128', '3138')
                   then
                      w_ := '2';
                   else
                      w_ := '1';
                   end if;

                   comm_ := substr(comm_ || nls_ || ' ' || to_char(kv_) || ' freq='||to_char(freq_)||
                            ' R013=' || o_r013_1 || ' W=' || w_, 1, 200);

                   p_ins ('123' || kod_okpo || kod_nnnn || p070_ || LPAD (to_char(kv_), 3, '0'),
                       TO_CHAR (ABS (o_se_1)),
                       nls_,
                       null, k021_, w_, '00', H_, K140_
                      );

                   p_ins ('127' || kod_okpo || kod_nnnn || p070_ || LPAD (to_char(kv_), 3, '0'),
                       TO_CHAR (ABS (o_se_1)),
                       nls_,
                       null, k021_, w_, '00', H_, K140_ 
                      );
                end if;

                IF o_se_2 <> 0
                THEN
                   w_ := '2';

                   comm_ := substr(comm_ || nls_ || ' ' || to_char(kv_) || ' freq='||to_char(freq_)||
                            ' R013=' || o_r013_2 || ' W=' || w_, 1, 200);

                   p_ins ('123' || kod_okpo || kod_nnnn || p070_ || LPAD (to_char(kv_), 3, '0'),
                       TO_CHAR (ABS (o_se_2)),
                       nls_,
                       null, k021_, w_, '00', H_, K140_
                      );
                end if;
             end if;

          -- �� 01.04.2016 ����� �������� ����� ���������� ������
          -- �� ������������ ���� �������
          if Dat_ >= dat_Izm3 and Dat_ < dat_izm5
          then
              -- �������� �� ������� ������� �� ������ ������ �� NBU23_REZ
              SELECT NVL(sum(t.rezq23*100), 0) 
                 INTO sum_rez_
              FROM nbu23_rez t                         
              WHERE t.acc = acc_
                and t.fdat = dat23_;

                IF sum_rez_ <> 0
                THEN
                   p_ins ('128' || kod_okpo || kod_nnnn || '0000' || p140_,
                       TO_CHAR (ABS (round(sum_rez_, 0))),
                       nls_,
                       null, k021_, '0', '00', '0', '0'
                      );
                end if;

          end if;

          -- �� ����� ���������� ������ (���� CRQ � REZ_CR)
          if Dat_ >= dat_izm5 
          then
              -- �������� �� ������� ������� �� ������ ������ �� NBU23_REZ
              SELECT NVL(sum(t.crq*100), 0) 
                 INTO sum_rez_
              FROM nbu23_rez t                         
              WHERE t.acc = acc_
                and t.fdat = dat23_;

                IF sum_rez_ <> 0
                THEN
                   p_ins ('128' || kod_okpo || kod_nnnn || '0000' || p140_,
                       TO_CHAR (ABS (round(sum_rez_, 0))),
                       nls_,
                       null, k021_, '0', '00', '0', '0'
                      );
                end if;

          end if;
             
             -- ���� ������_� ���� ������ �����������
             --IF p070_ = '3119' and p120_ <> 0 and p125_ = 0 THEN
             --   p_ins ('125' || kod_okpo || kod_nnnn || '3190' || p140_,
             --          p125_,
             --          nls_,
             --          null, k021_, w_, '00', H_, K140_
             --         );

             --END IF;

             IF p070_ = '3548' and p120_ <> 0 and p125_ = 0 THEN
                p_ins ('125' || kod_okpo || kod_nnnn || '3590' || p140_,
                       p125_,
                       nls_,
                       null, k021_, w_, '00', H_, K140_
                      );

             END IF;

             p_nd_ := nd_;
             p_sum_zd_ := sum_zd_;
             p_p111_ := p111_;
             p_p112_ := p112_;
             p_p090_ := p090_;
             p_rnk_ := rnk_;
          end if;

          if Dat_ < dat_Izm3
          then
             begin
               select aa.nls, NVL(sum(DECODE(aa.kv, 980, aa.ost-aa.dos96+aa.kos96, aa.ostq-aa.dosq96+aa.kosq96)),0)
               into nls_9129_9, s9129_9
               from otcn_saldo aa, nd_acc n, specparam sp
               where aa.rnk = rnk_
                   and aa.acc = n.acc
                   and n.nd = nd_
                   and aa.nls like '9129%'
                   and aa.acc = sp.acc
                   and NVL(sp.r013,'0')='9'
                   and rownum = 1
               group by aa.nls;
             exception when no_data_found then
                begin
                   select aa.nls, NVL(sum(DECODE(aa.kv, 980, aa.ost-aa.dos96+aa.kos96, aa.ostq-aa.dosq96+aa.kosq96)),0)
                      into nls_9129_9, s9129_9
                   from otcn_saldo aa, specparam sp
                   where aa.rnk = rnk_
                     and aa.acc = sp.acc
                     and sp.nkd = p090_
                     and aa.nls like '9129%'
                     and NVL(sp.r013,'0')='9'
                     and rownum = 1
                 group by aa.nls;
                exception when no_data_found then
                   s9129_9 := 0;
                end;
             end;
   
             if s9129_9 <> 0
             then
                select count(*)
                   into kol_9129_9
                from rnbu_trace
                where nls = nls_9129_9;
   
                if kol_9129_9 = 0
                then
                   p_ins ('118' || kod_okpo || kod_nnnn || '9129' || p140_,
                          TO_CHAR (ABS (s9129_9)),
                          nls_9129_9
                         );
                end if;
             end if;
          end if;

          if n_trans <> 0 then
             -- ��� ������ �����������/��������� ��� 085
             update rnbu_trace set kodp = substr(kodp,1,24)||'01'||substr(kodp,27)
             where substr(kodp,1,3) = '085' and substr(kodp,25,2)='00' and nd = nd_;

             -- ���� ������� ������ ��� 111
             update rnbu_trace set kodp = substr(kodp,1,24)||'01'||substr(kodp,27),
                                   znap = TO_CHAR (p111_1, dfmt_)
             where substr(kodp,1,3) = '111' and substr(kodp,25,2)='00' and nd = nd_ ;

             -- ���� ���������� ������ ��� 112
             update rnbu_trace set kodp = substr(kodp,1,24)||'01'||substr(kodp,27),
                                   znap = TO_CHAR (p112_2, dfmt_)
             where substr(kodp,1,3) = '112' and substr(kodp,25,2)='00' and nd = nd_ ;

             -- ���������� CCF ��� 150
             update rnbu_trace set kodp = substr(kodp,1,24)||'01'||substr(kodp,27)
             where substr(kodp,1,3) = '150' and substr(kodp,25,2)='00' and nd = nd_ ;

             -- ���� ������������� ��� 160
             update rnbu_trace set kodp = substr(kodp,1,24)||'01'||substr(kodp,27)
             where substr(kodp,1,3) = '160' and substr(kodp,25,2)='00' and nd = nd_ ;

             -- ���� �������������_ ���� ��������������?� ��� 161
             update rnbu_trace set kodp = substr(kodp,1,24)||'01'||substr(kodp,27)
             where substr(kodp,1,3) = '161' and substr(kodp,25,2)='00' and nd = nd_ ;

             -- ����� ����������� ���� ���������� ����� ������
             update rnbu_trace set kodp = substr(kodp,1,24)||'01'||substr(kodp,27)
             where substr(kodp,1,3) = '162' and substr(kodp,25,2)='00' and nd = nd_ ;

             -- ���� ��������� ���������� ����� ��� 118
             update rnbu_trace set kodp = substr(kodp,1,24)||'01'||substr(kodp,27)
             where substr(kodp,1,3)='118' and nd = nd_;

             -- ���� �������� �������������_ ����������� ��� 119
             update rnbu_trace set kodp = substr(kodp,1,24)||'01'||substr(kodp,27)
             where substr(kodp,1,3)='119' and nd = nd_;

             -- ������� �� ����_� �������� �_ ������ ���� 122, 124
             update rnbu_trace set kodp = substr(kodp,1,24)||'01'||substr(kodp,27)
             where substr(kodp,1,3) in ('122','124') and nd = nd_;

             -- ������� ���� ��� 121 ���.������� 3578,3579
             update rnbu_trace set kodp = substr(kodp,1,24)||'01'||substr(kodp,27)
             where substr(nls,1,4) in ('3578','3579') and substr(kodp,1,3) = '121' and nd = nd_;

             -- ����������� ���� ��� 126 ���.������� 3578
             update rnbu_trace set kodp = substr(kodp,1,24)||'01'||substr(kodp,27)
             where substr(nls,1,4) = '3578' and substr(kodp,1,3) = '126' and nd = nd_;

             -- ����������� ���� ��� 131 ���.������� 3578
             update rnbu_trace set kodp = substr(kodp,1,24)||'01'||substr(kodp,27)
             where substr(nls,1,4) = '3578' and substr(kodp,1,3) = '131' and nd = nd_;

             -- ���������� ������ ��� 123
             update rnbu_trace set kodp = substr(kodp,1,24)||'01'||substr(kodp,27)
             where substr(kodp,1,3) = '123' and nd = nd_;

             -- ���������� ������ ��� 132
             update rnbu_trace set kodp = substr(kodp,1,24)||'01'||substr(kodp,27)
             where substr(kodp,1,3) = '132' and nd = nd_;

             if Dat_ >= dat_izm5 
             then 
                -- ���������� PD
                update rnbu_trace set kodp = substr(kodp,1,24)||'01'||substr(kodp,27)
                where substr(kodp,1,3) = '163' and substr(kodp,25,2)='00' and nd = nd_ ;

                -- ��� ������������� ����� �����������
                update rnbu_trace set kodp = substr(kodp,1,24)||'01'||substr(kodp,27)
                where substr(kodp,1,3) = '164' and substr(kodp,25,2)='00' and nd = nd_ ;

                -- ��� �������
                update rnbu_trace set kodp = substr(kodp,1,24)||'01'||substr(kodp,27)
                where substr(kodp,1,3) = '170' and substr(kodp,25,2)='00' and nd = nd_ ;

                -- ��� ������� ���� ��������� �� �����
                update rnbu_trace set kodp = substr(kodp,1,24)||'01'||substr(kodp,27)
                where substr(kodp,1,3) = '171' and substr(kodp,25,2)='00' and nd = nd_ ;

                -- ��� ������� ���� �������� ������
                update rnbu_trace set kodp = substr(kodp,1,24)||'01'||substr(kodp,27)
                where substr(kodp,1,3) = '172' and substr(kodp,25,2)='00' and nd = nd_ ;

                -- ��� ������� ���� ���� �������
                update rnbu_trace set kodp = substr(kodp,1,24)||'01'||substr(kodp,27)
                where substr(kodp,1,3) = '173' and substr(kodp,25,2)='00' and nd = nd_ ;

                -- ��� ������� ���� �������� ������ �����
                update rnbu_trace set kodp = substr(kodp,1,24)||'01'||substr(kodp,27)
                where substr(kodp,1,3) = '174' and substr(kodp,25,2)='00' and nd = nd_ ;

                -- ��� ������� ���� ���������� �������������
                update rnbu_trace set kodp = substr(kodp,1,24)||'01'||substr(kodp,27)
                where substr(kodp,1,3) = '175' and substr(kodp,25,2)='00' and nd = nd_ ;

                -- ��� ������� ���� �������� �����
                update rnbu_trace set kodp = substr(kodp,1,24)||'01'||substr(kodp,27)
                where substr(kodp,1,3) = '176' and substr(kodp,25,2)='00' and nd = nd_ ;

                -- ��� ������ �������
                update rnbu_trace set kodp = substr(kodp,1,24)||'01'||substr(kodp,27)
                where substr(kodp,1,3) = '179' and substr(kodp,25,2)='00' and nd = nd_ ;

             end if;

             if Dat_ >= dat_Izm3 
             then 
                -- ���� ����������� ������ ����������� �� 30 ���� ��� 127
                update rnbu_trace set kodp = substr(kodp,1,24)||'01'||substr(kodp,27)
                where substr(kodp,1,3) = '127' and nd = nd_;

                -- ����� ���������� ������ ��� 128
                update rnbu_trace set kodp = substr(kodp,1,24)||'01'||substr(kodp,27)
                where substr(kodp,1,3) = '128' and nd = nd_;

             end if;

             -- ���� ������_� ��� 125
             update rnbu_trace set kodp = substr(kodp,1,24)||'01'||substr(kodp,27)
             where substr(kodp,1,3) = '125' and nd = nd_;
          end if;

      END LOOP;

      CLOSE c_cust_dg;

         if Dat_ < dat_izm3
         then
            if p060_ <> 99 then
               if sum_sk_ > 0 then
                  p150_ :=
                       LTRIM (TO_CHAR (ROUND ((ABS (sum_d_) / sum_sk_) * 100, 4), fmt_));
               end if;
            else
               if sum_k_ > 0 then
                  p150_ :=
                       LTRIM (TO_CHAR (ROUND ((ABS (sum_d_) / sum_k_) * 100, 4), fmt_));
               end if;
            end if;
   
            if sum_k_ < 0 then
               p150_ := 0;
            end if;

               p_ins ('150' || kod_okpo || '0000' || '0000' || '000',
                            LTRIM (TO_CHAR (TO_NUMBER(p150_), fmt_)), nls_);
         end if; 

   END LOOP;

   CLOSE c_cust;

   logger.info ('P_FD8_NN: End etap 4 for datf = '||to_char(dat_, 'dd/mm/yyyy'));
----------------------------------------------------
-- ������ ���� ��� ������ ����� ��������� ���� (2062,2063)
-- � �������� ������ ��������

for z in ( select r.acc, r.nls, r.kv, r.nd, r.kodp
           from rnbu_trace r
           where substr(kodp,1,3) = '121'
             and substr(kodp, 25, 2) = '00'
             and (r.nls like '2062%' or r.nls like '2063%')
             and r.acc not in (select acc from cc_trans)
           order by 2,3,1
         )

     loop

        select count(*)
           into kol_trans
        from cc_deal c, accounts a, nd_acc n, nd_txt n1
        where c.nd = z.nd
          and c.vidd in (2,3)
          and c.nd = n.nd
          and c.sos<>15
          and c.rnk=a.rnk
          and a.acc =n.acc
          and a.nbs in ('2062','2063')
          and a.dazs is null
          and fost(a.acc, dat_) <> 0
          and n1.nd=n.nd
          and n1.tag like 'PR_TR%'
          and trim(n1.txt)='1';

          n_trans := 0;

          if kol_trans >= 1 then
             for k in ( select a.acc, a.nls, a.kv, a.daos p111, a.mdate p112, decode(a.kv, 980, fost(a.acc, dat_), fostq(a.acc, dat_) ) st
                        from cc_deal c, accounts a, nd_acc n
                        where c.nd = z.nd
                          and c.vidd in (2,3)
                          and c.nd = n.nd
                          and c.sos<>15
                          and c.rnk=a.rnk
                          and a.acc =n.acc
                          and a.nbs in ('2062','2063')
                          and a.dazs is null
                          and fost(a.acc, dat_) <> 0
                        order by 2,3,1
                      )

                loop
                   n_trans := n_trans + 1;

                   kod_mm := substr(sep.h2_rrp(trunc(mod(n_trans,36*36)/36)),1,1)
                          || substr(sep.h2_rrp(mod(n_trans,36)),1,1);

                  nls_ := null;
                  kv_  := null;

                  -- ��� ���� ���������� 123 ���������� ���� ����������� ���������
                  begin
                     select a.nls, a.kv
                        into nls_, kv_
                     from accounts a, int_accn n
                     where n.acc = k.acc
                       and n.acra = a.acc;
                  exception when no_data_found then
                     null;
                  end;

                  -- ��� ������ �����������/���������
                  update rnbu_trace set kodp = substr(kodp,1,24)||kod_mm||substr(kodp,27)
                  where substr(kodp,1,3)='085' and nls = k.nls and kv = k.kv and nd = z.nd;

                  -- ���� ���������� �������������_
                  update rnbu_trace set kodp = substr(kodp,1,24)||kod_mm||substr(kodp,27),
                         znap = TO_CHAR (k.p111, dfmt_)
                  where substr(kodp,1,3)='111' and nls = k.nls and kv = k.kv and nd = z.nd;

                  -- ���� ��������� �������������_ ��_��� � ���������
                  update rnbu_trace set kodp = substr(kodp,1,24)||kod_mm||substr(kodp,27),
                         znap = TO_CHAR (k.p112, dfmt_)
                  where substr(kodp,1,3)='112' and nls = k.nls and kv = k.kv and nd = z.nd;

                  -- ���� ������
                  update rnbu_trace set kodp = substr(kodp,1,24)||kod_mm||substr(kodp,27)
                  where substr(kodp,1,3)='121' and nls = k.nls and kv = k.kv and nd = z.nd;

                  -- ���������� ������ ��� 123
                  if nls_ is not null
                  then
                     update rnbu_trace set kodp = substr(kodp,1,24)||kod_mm||substr(kodp,27)
                     where substr(kodp,1,3)='123' and nls = nls_ and kv = kv_ and nd = z.nd;
                     -- ���� ������_� ��� 125
                     update rnbu_trace set kodp = substr(kodp,1,24)||kod_mm||substr(kodp,27)
                     where substr(kodp,1,3)='125' and nls = nls_ and kv = kv_ and nd = z.nd;
                  end if;

                  -- ���� ������_� ��� 125
                  update rnbu_trace set kodp = substr(kodp,1,24)||kod_mm||substr(kodp,27)
                  where substr(kodp,1,3)='125' and nls = k.nls and kv = k.kv and nd = z.nd;

                  -- ��������� ������ �� �������� ��� 130
                  update rnbu_trace set kodp = substr(kodp,1,24)||kod_mm||substr(kodp,27)
                  where substr(kodp,1,3)='130' and nls = k.nls and kv = k.kv and nd = z.nd;

                  -- ���� �������������_
                  update rnbu_trace set kodp = substr(kodp,1,24)||kod_mm||substr(kodp,27)
                  where substr(kodp,1,3)='160' and nls = k.nls and kv = k.kv and nd = z.nd;

                  -- ��� ������� ��������� ��������
                  update rnbu_trace set kodp = substr(kodp,1,24)||kod_mm||substr(kodp,27)
                  where substr(kodp,1,3)='161' and nls = k.nls and kv = k.kv and nd = z.nd;

                  -- ���������� LGD
                  update rnbu_trace set kodp = substr(kodp,1,24)||kod_mm||substr(kodp,27)
                  where substr(kodp,1,3)='162' and nls = k.nls and kv = k.kv and nd = z.nd;

                  -- ���������� PD
                  update rnbu_trace set kodp = substr(kodp,1,24)||kod_mm||substr(kodp,27)
                  where substr(kodp,1,3)='163' and nls = k.nls and kv = k.kv and nd = z.nd;

                  -- ��� ������������� �����
                  update rnbu_trace set kodp = substr(kodp,1,24)||kod_mm||substr(kodp,27)
                  where substr(kodp,1,3)='164' and nls = k.nls and kv = k.kv and nd = z.nd;
             end loop;

          end if;
  end loop;

   logger.info ('P_FD8_NN: End etap 5 for datf = '||to_char(dat_, 'dd/mm/yyyy'));
----------------------------------------------------------------------------
-- ������ ���� DDD �� �������� 121 ��� 123 �� 133
update rnbu_trace set kodp = '133' || substr(kodp,4)
where substr(kodp,1,3) in ('121','123')
  and substr(kodp,18,4) in ('9610','9611','9613','9615',
                       '9617','9618','9600','9601'
                      );

update rnbu_trace set kodp = '124' || substr(kodp,4)
where substr(kodp,1,3) in ('125')
  and substr(kodp,18,4) in ('3107');

update rnbu_trace set kodp = '125' || substr(kodp,4)
where substr(kodp,1,3) in ('123')
  and substr(kodp,18,4) in ('3119');
----------------------------------------------------------------------------
delete from rnbu_trace r
where substr(r.kodp,1,3) = '081' 
  and substr(r.kodp,29,2) in ('00','90') 
  and r.znap = '0' 
  and exists ( select 1 from rnbu_trace r1
               where substr(r1.kodp,1,3) = '081'
                 and substr(r1.kodp,1,28) = substr(r.kodp,1,28)
                 and substr(r1.kodp,29,2) not in ('00','90')
                 and r1.znap <> '0'
             );

delete from rnbu_trace r
where substr(r.kodp,1,3) = '083' 
  and substr(r.kodp,29,2) in ('00','90') 
  and r.znap = '0' 
  and exists ( select 1 from rnbu_trace r1
               where substr(r1.kodp,1,3) = '083'
                 and substr(r1.kodp,1,28) = substr(r.kodp,1,28)
                 and substr(r1.kodp,29,2) not in ('00','90')
                 and r1.znap <> '0'
             );
   
-- ������ ����������� 080,082 �� �������� �������������� 28.11.2014
if mfo_ = 324805 and dat_ >= to_date('31122014','ddmmyyyy') then
   for k in ( select kodp, substr(kodp,1,3) ddd, substr(kodp,4,10) okpo,
                     substr(kodp,14,4) nnnn, substr(kodp,27) rnk
              from rnbu_trace
              where (kodp like '080%' or kodp like '082%')
              order by substr(kodp,4,10), substr(kodp,14,4),
                       substr(kodp,1,3), substr(kodp,33)
            )

   loop
      begin
         select znap
            into znap_
         from tmp_nbu
         where kodf='D8' and datf=to_date('28112014','ddmmyyyy')
           and kodp = k.kodp;

         update rnbu_trace set znap = znap_
         where kodp = k.kodp;
      exception when no_data_found then
         begin
            select znap
               into znap_
            from tmp_nbu
            where kodf='D8' and datf=to_date('28112014','ddmmyyyy')
              and substr(kodp,4,10) = k.okpo
              and substr(kodp,1,3) = k.ddd
              and substr(kodp,33) = k.rnk
              and rownum = 1;

            update rnbu_trace set znap = znap_
            where substr(kodp,4,10) = k.okpo
              and substr(kodp,14,4) = k.nnnn
              and substr(kodp,33) = k.rnk
              and substr(kodp,1,3) = k.ddd;
         exception when no_data_found then
            null;
         end ;
      end;

   end loop;

end if;
----------------------------------------------------
   DELETE FROM tmp_nbu
         WHERE kodf = kodf_ AND datf = dat_;

----------------------------------------------------
   OPEN basel;

   LOOP
      FETCH basel
       INTO kodp_, znap_;

      EXIT WHEN basel%NOTFOUND;

      BEGIN
         if trim(znap_) is not null
         then

            select count(*)
               into kol_
            from tmp_nbu
            WHERE kodf = kodf_ AND datf = dat_ AND kodp like substr(kodp_,1,32)||'%';

            if kol_ = 0
            then

               if dat_ >= dat_izm5
               then
                  IF SUBSTR (kodp_, 1, 3) = '162'
                  THEN
                     znap_ := LTRIM (TO_CHAR (TO_NUMBER (znap_), fmt1_));
                  END IF;
                  IF SUBSTR (kodp_, 1, 3) = '163'
                  THEN
                     znap_ := LTRIM (TO_CHAR (TO_NUMBER (znap_), fmt2_));
                  END IF;
               end if;

               INSERT INTO tmp_nbu
                           (kodf, datf, kodp, znap
                           )
                    VALUES (kodf_, dat_, kodp_, znap_
                           );
            end if;
         end if;
      EXCEPTION
         WHEN OTHERS
         THEN
            raise_application_error (-20004,
                                     '������: ' || SQLERRM || ' kodp:'
                                     || kodp_
                                    );
      END;
   END LOOP;

   CLOSE basel;

----------------------------------------
   OPEN basel1;

   LOOP
      FETCH basel1
       INTO kodp_, sum_zd_, znap_;

      EXIT WHEN basel1%NOTFOUND;

      if substr(kodp_,18,4) = '9129' then
         BEGIN
            select a.nbs
               into p070_
            from acc_over o, otcn_acc a, rnbu_trace r
            where r.kodp = kodp_
              and o.acc_9129 = r.acc
              and a.acc = o.acco
              and NVL (o.sos, 0) <> 1
              and not exists ( select 1 from rnbu_trace r1
                               where substr(r1.kodp,1,17) = substr(kodp_,1,17)
                                 and substr(r1.kodp,18) <> substr(kodp_,18,4)
                             )
              and rownum = 1;
              kodp_ := substr(kodp_,1,17) || p070_ || substr(kodp_,22);
         EXCEPTION WHEN NO_DATA_FOUND THEN
            BEGIN
               select a.nbs
                  into p070_
               from bpk_acc o, otcn_acc a, rnbu_trace r
               where r.kodp = kodp_
                 and o.acc_9129 = r.acc
                 and a.acc = DECODE(o.acc_ovr, null, o.acc_2207, o.acc_ovr)
                 and not exists ( select 1 from rnbu_trace r1
                                  where substr(r1.kodp,1,17) = substr(kodp_,1,17)
                                    and substr(r1.kodp,18) <> substr(kodp_,18,4)
                                )
                 and rownum = 1;
                 kodp_ := substr(kodp_,1,17) || p070_ || substr(kodp_,22);
            EXCEPTION WHEN NO_DATA_FOUND THEN
               BEGIN
                  select a.nbs
                     into p070_
                  from w4_acc o, otcn_acc a, rnbu_trace r
                  where r.kodp = kodp_
                    and o.acc_9129 = r.acc
                    and a.acc = DECODE(o.acc_ovr, null, o.acc_2203, o.acc_ovr)
                    and not exists ( select 1 from rnbu_trace r1
                                     where substr(r1.kodp,1,17) = substr(kodp_,1,17)
                                       and substr(r1.kodp,18) <> substr(kodp_,18,4)
                                   )
                    and rownum = 1;
                    kodp_ := substr(kodp_,1,17) || p070_ || substr(kodp_,22);
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  null;
               END;
            END;
         END;
      end if;

      if sum_zd_ <> 0 THEN
         znap_ := LTRIM (TO_CHAR ((TO_NUMBER (znap_) /sum_zd_) / 10000, fmt_));

          INSERT INTO tmp_nbu
                      (kodf, datf, kodp, znap
                      )
               VALUES (kodf_, dat_, kodp_, znap_
                      );
      END IF;
   END LOOP;

   CLOSE basel1;

-----------------------------------------
   OPEN basel2;

   LOOP
      FETCH basel2
       INTO kodp_, znap_;

      EXIT WHEN basel2%NOTFOUND;

      if dat_ < dat_izm3
      then
         IF SUBSTR (kodp_, 1, 3) = '150'
         THEN
            if sum_k_ < 0 then
               znap_ := '0';
            else
               znap_ := LTRIM (TO_CHAR (TO_NUMBER (znap_), fmt_));
            end if;
         END IF;
      end if;

      if dat_ >= dat_izm3  
      then
         IF SUBSTR (kodp_, 1, 3) = '162'
         THEN
            znap_ := LTRIM (TO_CHAR (TO_NUMBER (znap_), fmtkap_));
         END IF;
      end if;

      INSERT INTO tmp_nbu
                  (kodf, datf, kodp, znap
                  )
           VALUES (kodf_, dat_, kodp_, znap_
                  );
   END LOOP;

   CLOSE basel2;

   logger.info ('P_FD8_NN: End for datf = '||to_char(dat_, 'dd/mm/yyyy'));

END p_fd8_nn;
/