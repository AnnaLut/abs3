

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/GET_INFO_UPB.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure GET_INFO_UPB ***

  CREATE OR REPLACE PROCEDURE BARS.GET_INFO_UPB /*  ��� ��������� ��� �� �� */
 ( CC_ID_  IN  varchar2, -- �������������   ��
   DAT1_   IN  date    , -- ���� �����      ��
   nRet_   OUT int     , -- ��� ��������: =1 �� ������, ������ =0
   sRet_   OUT varchar2, -- ����� ������ (?)
   RNK_    OUT int     , -- ��� � ��������
   nS_     OUT number  , -- ����� �������� �������
   nS1_    OUT number  , -- ����� �������������� �������
   NMK_    OUT varchar2, -- ������������ �������
   OKPO_   OUT varchar2, -- OKPO         �������
   ADRES_  OUT varchar2, -- �����        �������
   KV_     IN OUT int  , -- ��� ������   ��
   LCV_    OUT varchar2, -- ISO ������   ��
   NAMEV_  OUT varchar2, -- �����a       ��
   UNIT_   OUT varchar2, -- ���.������   ��
   GENDER_ OUT varchar2, -- ��� ������   ��
   nSS_    OUT number  , -- ���.����� ���.�����
   DAT4_   OUT date    , --\ ���� ���������� ��
   nSS1_   OUT number  , --/ �����.����� ���.�����
   DAT_SN_ OUT date    , --\ �� ����� ���� ��� %
   nSN_    OUT number  , --/ ����� ��� %
   nSN1_   OUT number  ,-- | �����.����� ����.�����
   DAT_SK_ OUT date    , --\ �� ����� ���� ��� ���
   nSK_    OUT number  , --/ ����� ��� ����������� ��������
   nSK1_   OUT number  , --| �����.����� �����.�����
   KV_KOM_ OUT int     , -- ��� ��������
   DAT_SP_ OUT date    , -- �� ����� ���� ��� ����
   nSP_    OUT number  , -- ����� ��� ����������� ����
   SN8_NLS OUT varchar2, --\
   SD8_NLS OUT varchar2, --/ ����� ���������� ����
   MFOK_   OUT varchar2, --\
   NLSK_   out varchar2  --/ ���� �������

--   DAT_och OUT date    ,  -- ��������� ���� �������
--   SUM_och OUT number     -- ��������� ����� �������
) IS


/*
   01-04-2009 ���� ����� ��������� ��������� � ��������� get_info_upb_ext
   23-02-09 ����� ������ SPN
   06-01-09 ������� ����� � ����� ���.
            ������ ��������� cck.GET_INFO,  �� � ������������� ��� - ���������
*/

   nSSP_    number; --\ ����� ������������� ����
   nSSPN_   number; --\ ����� ������������ ���������
   nSSPK_   number; --\ �����  ������������ ��������
   KV_SN8   varchar2(3);
   Mess_    Varchar2(4000);

begin

get_info_upb_ext (CC_ID_,DAT1_,nRet_,sRet_,RNK_,nS_,nS1_,NMK_,OKPO_,ADRES_,
                  KV_,LCV_,NAMEV_,UNIT_,GENDER_,nSS_,DAT4_,nSS1_,DAT_SN_,nSN_,
                  nSN1_,DAT_SK_,nSK_,nSK1_,KV_KOM_,DAT_SP_,nSP_,KV_SN8,SN8_NLS,SD8_NLS,
                  MFOK_,NLSK_,nSSP_,nSSPN_,nSSPK_,Mess_
                  );


END GET_INFO_UPB;
/
show err;

PROMPT *** Create  grants  GET_INFO_UPB ***
grant EXECUTE                                                                on GET_INFO_UPB    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GET_INFO_UPB    to WR_ALL_RIGHTS;
grant EXECUTE                                                                on GET_INFO_UPB    to WR_CREDIT;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/GET_INFO_UPB.sql =========*** End 
PROMPT ===================================================================================== 
