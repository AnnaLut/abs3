

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/EBK_QUEUE_UPDATECARD_V.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view EBK_QUEUE_UPDATECARD_V ***

  CREATE OR REPLACE FORCE VIEW BARS.EBK_QUEUE_UPDATECARD_V ("KF", "RNK", "DATEON", "DATEOFF", "NMK", "SNLN", "SNFN", "SNMN", "NMKV", "SNGC", "CODCAGENT", "K013", "COUNTRY", "PRINSIDER", "TGR", "OKPO", "PASSP", "SER", "NUMDOC", "ORGAN", "PDATE", "DATEPHOTO", "BDAY", "BPLACE", "SEX", "BRANCH", "ADR", "URZIP", "URDOMAIN", "URREGION", "URLOCALITY", "URADDRESS", "URTERRITORYID", "URLOCALITYTYPE", "URSTREETTYPE", "URSTREET", "URHOMETYPE", "URHOME", "URHOMEPARTTYPE", "URHOMEPART", "URROOMTYPE", "URROOM", "FGADR", "FGDST", "FGOBL", "FGTWN", "MPNO", "TELD", "TELW", "EMAIL", "ISE", "FS", "VED", "K050", "PCZ2", "PCZ1", "PCZ5", "PCZ3", "PCZ4", "SAMZ", "VIPK", "WORKPLACE", "PUBLP", "CIGPO", "CHORN", "SPMRK", "WORKB", "OKPOEXCLUSION", "BANKCARD", "CREDIT", "DEPOSIT", "CURRENTACCOUNT", "OTHER", "LASTCHANGEDT") AS 
  select /*View contains data to send to EBK*/
    ecbi.kf , --��� �� (��� ���)
    equ.rnk , --�����. � (���)
    ecbi.date_ON as dateON , --����  ���������
    ecbi.date_OFF as dateOFF, --���� ��������
    ecbi.nmk, --������������ �볺��� (���.)
    ecbi.sn_Ln as snLn, -- ������� �볺���
    ecbi.sn_Fn as snFn, --��'� �볺���
    ecbi.sn_Mn snMn, --��-������� �볺���
    ecbi.nmkv, --������������ (���.)
    ecbi.sn_Gc as snGc, --ϲ� �볺��� � �������� ������
    ecbi.codcagent, --�������������� �볺��� (�010)
    ecbi.k013, --��� ���� �볺��� (K013)
    ecbi.country, --����� �볺��� (�040)
    ecbi.prinsider, --������ ��������� (�060)
    ecbi.tgr, --��� ����. ������
    ecbi.okpo, --���������������� ���
    ecbi.passp, -- ��� ���������
    ecbi.ser, --����
    ecbi.numdoc, --�����
    ecbi.organ, --��� �������
    ecbi.pdate, --���� ������
    ecbi.date_Photo datePhoto, --���� ���������� ���� � �������
    ecbi.bday, --���� ����������
    ecbi.bplace, --���� ����������
    ecbi.sex, --�����
    --equ.branch as branch,--c.branch, --���. �������������� ��������
    ecbi.branch,
    ecbi.adr, --������ (����� ����)
    ecbi.ur_Zip as urZip, -- ��.���:������
    ecbi.ur_Domain as urDomain, --��.���:�������
    ecbi.ur_Region as urRegion, --��.���:������
    ecbi.ur_Locality as urLocality, --��.���:���������� ����
    ecbi.ur_Address as urAddress, --��.���:�����(�����,���,��.)
    ecbi.ur_Territory_Id as urTerritoryId, --��.���:��� ������
    ecbi.ur_Locality_Type as urLocalityType, --��.���:��� �����.������
    ecbi.ur_Street_Type as urStreetType, --��.���:��� �����
    ecbi.ur_Street as urStreet, --��.���:�����
    ecbi.ur_Home_Type as urHomeType, --��.���:��� ����
    ecbi.ur_Home as urHome, --��.���:� ����
    ecbi.ur_Homepart_Type as urHomepartType, --��.���:��� ���.����
    ecbi.ur_Home_part as urHomepart, --��.���:� ���� ���.����
    ecbi.ur_Room_Type urRoomType, --��.���:��� ������ ���������
    ecbi.ur_Room urRoom, -- ��.���:� ������ ���������
    ecbi.fgadr, --���:������,���.,��.
    ecbi.fgdst, --������: �����
    ecbi.fgobl, --������: �������
    ecbi.fgtwn, --������: ��������� �����
    ecbi.mpno, --�������� �������
    --ecbi.cellphone, --������� ���.
    ecbi.teld ,--�������� ���.
    ecbi.telw, --������� ���.
    ecbi.email,--������ ���������� �����
    ecbi.ise  , --����.������.�������� (�070)
    ecbi.fs ,-- ����� �������� (�080)
    ecbi.ved , --��� ��. �������� (�110)
    ecbi.k050 , --����� �������������� (�050)
    ecbi.pc_Z2 as pcZ2,--���. ����������� �������. �����
    ecbi.pc_Z1 as pcZ1,--���. ����������� �������. ����
    ecbi.pc_Z5 as pcZ5,--���. ����������� �������. ���� �������
    ecbi.pc_Z3 as pcZ3,--���. ����������� �������. ��� �������
    ecbi.pc_Z4 as pcZ4,--���. ����������� �������. ĳ����� ��
    ecbi.samz,--�i��i��� ��� ����������i��� �i������
    ecbi.vip_K as vipK,--������ VIP-�볺���
    ecbi.work_Place as workPlace,--̳��� ������, ������
    ecbi.publp,--������i��� �� ����i���� �i��i�
    ecbi.cigpo,--������ ��������� �����
    ecbi.chorn,--�������i� ��������, ��i ����������� �����i��� ������.����������
    ecbi.spmrk,--��� �������� �i��i��� �������������� �볺��� ��
    ecbi.workb, --���������i��� �� ����i����i� �����
    ecbi.okpo_Exclusion as okpoExclusion,
    ecbi.bank_card as BankCard,
    ecbi.credit ,
    ecbi.deposit,
    ecbi.current_account as CurrentAccount,
    ecbi.other,
   /*(select max( chgdate) from
       ( select trunc (cu.chgdate) as chgdate
             from bars.customer_update cu
          where rnk = equ.rnk
           union all
          select trunc (cwu.chgdate) as chgdate
            from bars.customerw_update cwu
            where rnk = equ.rnk
          union all
         select trunc (pu.chgdate) as chgdate
           from bars.person_update pu
             where rnk = equ.rnk))*/
   equ.insert_date as lastChangeDt
from ebk_queue_updatecard equ,
     ebk_cust_bd_info_v ecbi
where equ.status = 0
  and ecbi.rnk=equ.rnk;

PROMPT *** Create  grants  EBK_QUEUE_UPDATECARD_V ***
grant SELECT                                                                 on EBK_QUEUE_UPDATECARD_V to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/EBK_QUEUE_UPDATECARD_V.sql =========***
PROMPT ===================================================================================== 
