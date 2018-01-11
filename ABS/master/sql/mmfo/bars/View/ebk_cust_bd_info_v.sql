

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/EBK_CUST_BD_INFO_V.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view EBK_CUST_BD_INFO_V ***

  CREATE OR REPLACE FORCE VIEW BARS.EBK_CUST_BD_INFO_V ("KF", "RNK", "DATE_ON", "DATE_OFF", "NMK", "SN_LN", "SN_FN", "SN_MN", "NMKV", "SN_GC", "CODCAGENT", "K013", "COUNTRY", "PRINSIDER", "TGR", "OKPO", "PASSP", "SER", "NUMDOC", "ORGAN", "PDATE", "DATE_PHOTO", "BDAY", "BPLACE", "SEX", "ACTUAL_DATE", "EDDR_ID", "BRANCH", "ADR", "UR_ZIP", "UR_DOMAIN", "UR_REGION", "UR_LOCALITY", "UR_ADDRESS", "UR_TERRITORY_ID", "UR_LOCALITY_TYPE", "UR_STREET_TYPE", "UR_STREET", "UR_HOME_TYPE", "UR_HOME", "UR_HOMEPART_TYPE", "UR_HOME_PART", "UR_ROOM_TYPE", "UR_ROOM", "FGADR", "FGDST", "FGOBL", "FGTWN", "MPNO", "CELLPHONE", "TELD", "TELW", "EMAIL", "ISE", "FS", "VED", "K050", "PC_Z2", "PC_Z1", "PC_Z5", "PC_Z3", "PC_Z4", "SAMZ", "VIP_K", "WORK_PLACE", "PUBLP", "CIGPO", "CHORN", "SPMRK", "WORKB", "OKPO_EXCLUSION", "BANK_CARD", "CREDIT", "DEPOSIT", "CURRENT_ACCOUNT", "OTHER") AS 
  with ru as ( select VAL as MFO
               from BARS.PARAMS$GLOBAL
              where PAR = 'GLB-MFO'
           )
select ru.MFO as kf,
       c.rnk as rnk,           -- �����. � (���)
       c.date_on as date_on,   -- ����  ���������
       c.date_off as date_off, -- ���� ��������
       c.nmk as nmk,           -- ������������ �볺��� (���.)
       (select cw.value from customerw cw  where cw.tag='SN_LN' and c.rnk=cw.rnk) as sn_ln, -- ������� �볺���
       (select cw.value from customerw cw  where cw.tag='SN_FN' and c.rnk=cw.rnk) as sn_fn, -- ��'� �볺���
       (select cw.value from customerw cw  where cw.tag='SN_MN' and c.rnk=cw.rnk) as sn_mn, -- ��-������� �볺���
       c.nmkv as nmkv, -- ������������ (���.)
       (select cw.value from customerw cw  where cw.tag='SN_GC' and c.rnk=cw.rnk) as sn_gc, --ϲ� �볺��� � �������� ������
       c.codcagent as codcagent, --�������������� �볺��� (�010)
       (select cw.value from customerw cw  where cw.tag='K013' and c.rnk=cw.rnk) as k013, --��� ���� �볺��� (K013)
       c.country as country, --����� �볺��� (�040)
       c.prinsider as prinsider, --������ ��������� (�060)
       c.tgr as tgr, --��� ����. ������
       c.okpo as okpo, --���������������� ���
       p.passp as passp, -- ��� ���������
       p.ser as ser, --����
       p.numdoc as numdoc, --�����
       p.organ as organ, --��� �������
       p.pdate as pdate, --���� ������
       p.date_photo as date_photo, --���� ���������� ���� � �������
       p.bday as bday, --���� ����������
       p.bplace as bplace, -- ���� ����������
       p.sex as sex,       -- �����
       p.actual_date,      -- ĳ����� ��
       p.eddr_id,          -- ��������� ����� ������ ����
       c.branch as branch, -- ���. �������������� ��������
       c.adr as adr,       -- ������ (����� ����)
       --
       ad.zip           as ur_zip, -- ��.���:������
       ad.domain        as ur_domain, --��.���:�������
       ad.region        as ur_region, --��.���:������
       ad.locality      as ur_locality, --��.���:���������� ����
       ad.address       as ur_address, --��.���:�����(�����,���,��.)
       ad.territory_id  as ur_territory_id, --��.���:��� ������
       ad.locality_type as ur_locality_type, --��.���:��� �����.������
       ad.street_type   as ur_street_type, --��.���:��� �����
       ad.street        as ur_street, --��.���:�����
       ad.home_type     as ur_home_type, --��.���:��� ����
       ad.home          as ur_home, --��.���:� ����
       ad.homepart_type as ur_homepart_type, --��.���:��� ���.����
       ad.homepart      as ur_home_part, --��.���:� ���� ���.����
       ad.room_type     as ur_room_type, --��.���:��� ������ ���������
       ad.room          as ur_room, -- ��.���:� ������ ���������
       (select cw.value from customerw cw  where cw.tag='FGADR' and c.rnk=cw.rnk) as fgadr, --���:������,���.,��.
       (select cw.value from customerw cw  where cw.tag='FGDST' and c.rnk=cw.rnk) as fgdst, --������: �����
       (select cw.value from customerw cw  where cw.tag='FGOBL' and c.rnk=cw.rnk) as fgobl, --������: �������
       (select cw.value from customerw cw  where cw.tag='FGTWN' and c.rnk=cw.rnk) as fgtwn, --������: ��������� �����
       (select cw.value from customerw cw  where cw.tag='MPNO'  and c.rnk=cw.rnk) as mpno,  --�������� �������
       p.cellphone as cellphone, --������� ���.
       p.teld as teld,--������� ���.
       p.telw as telw, --������� ���.
       (select cw.value from customerw cw  where cw.tag='EMAIL' and c.rnk=cw.rnk) as email,--������ ���������� �����
       c.ise as ise , --����.������.�������� (�070)
       c.fs as fs,-- ����� �������� (�080)
       c.ved as ved, --��� ��. �������� (�110)
       c.k050 as k050, --����� �������������� (�050)
       (select cw.value from customerw cw  where cw.tag='PC_Z2' and c.rnk=cw.rnk) as pc_z2,     -- ���. ����������� �������. �����
       (select cw.value from customerw cw  where cw.tag='PC_Z1' and c.rnk=cw.rnk) as pc_z1,     -- ���. ����������� �������. ����
       (select cw.value from customerw cw  where cw.tag='PC_Z5' and c.rnk=cw.rnk) as pc_z5,     -- ���. ����������� �������. ���� �������
       (select cw.value from customerw cw  where cw.tag='PC_Z3' and c.rnk=cw.rnk) as pc_z3,     -- ���. ����������� �������. ��� �������
       (select cw.value from customerw cw  where cw.tag='PC_Z4' and c.rnk=cw.rnk) as pc_z4,     -- ���. ����������� �������. ĳ����� ��
       (select cw.value from customerw cw  where cw.tag='SAMZ'  and c.rnk=cw.rnk) as samz,      -- �i��i��� ��� ����������i��� �i������
       (select cw.value from customerw cw  where cw.tag='VIP_K' and c.rnk=cw.rnk) as vip_k,     -- ������ VIP-�볺���
       (select cw.value from customerw cw  where cw.tag='WORK'  and c.rnk=cw.rnk) as work_place,-- ̳��� ������, ������
       (select cw.value from customerw cw  where cw.tag='PUBLP' and c.rnk=cw.rnk) as publp,     -- ������i��� �� ����i���� �i��i�
       (select cw.value from customerw cw  where cw.tag='CIGPO' and c.rnk=cw.rnk) as cigpo,     -- ������ ��������� �����
       (select cw.value from customerw cw  where cw.tag='CHORN' and c.rnk=cw.rnk) as chorn,     -- �������i� ��������, ��i ����������� �����i��� ������.����������
       (select cw.value from customerw cw  where cw.tag='SPMRK' and c.rnk=cw.rnk) as spmrk,     -- ��� �������� �i��i��� �������������� �볺��� ��
       (select cw.value from customerw cw  where cw.tag='WORKB' and c.rnk=cw.rnk) as workb,     -- ���������i��� �� ����i����i� �����
       (select cw.value from customerw cw  where cw.tag='EXCLN' and c.rnk=cw.rnk) as okpo_exclusion,
       ( case when exists (select * from w4_acc w, bars.accounts a  where w.acc_pk = a.acc and a.dazs is null  and a.rnk = c.rnk ) then 1 else 0 end ) as bank_card,
       ( case when exists (select * from cc_deal cc where cc.rnk = c.rnk and cc.sos not in (0,2,14,15) ) then 1 else 0 end ) as credit ,
       ( case when exists (select * from dpt_deposit dd where dd.rnk = c.rnk) then 1 else 0 end) as deposit,
       ( case when exists (select * from accounts ac where ac.rnk = c.rnk and ac.dazs is null and nbs='2620') then 1 else 0 end) as current_account,
       0 as other
  from bars.customer c
     , bars.person   p
     , bars.customer_address ad
     , bars.ru
 where c.rnk = p.rnk(+)
   and c.rnk = ad.rnk(+)
   and ad.type_id(+) = 1;

PROMPT *** Create  grants  EBK_CUST_BD_INFO_V ***
grant SELECT                                                                 on EBK_CUST_BD_INFO_V to BARSREADER_ROLE;
grant SELECT                                                                 on EBK_CUST_BD_INFO_V to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EBK_CUST_BD_INFO_V to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/EBK_CUST_BD_INFO_V.sql =========*** End
PROMPT ===================================================================================== 
