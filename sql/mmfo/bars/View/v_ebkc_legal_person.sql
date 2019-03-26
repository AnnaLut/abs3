

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_EBKC_LEGAL_PERSON.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_EBKC_LEGAL_PERSON ***

  CREATE OR REPLACE FORCE VIEW BARS.V_EBKC_LEGAL_PERSON ("KF", "RNK", "LASTCHANGEDT", "DATE_OFF", "DATE_ON", "FULL_NAME", "FULL_NAME_INTERNATIONAL", "FULL_NAME_ABBREVIATED", "K014", "K040", "BUILD_STATE_REGISTER", "OKPO", "IS_OKPO_EXCLUSION", "K060", "K030", "OFF_BALANCE_DEP_CODE", "OFF_BALANCE_DEP_NAME", "K070", "K080", "K110", "K050", "K051", "AU_ZIP", "AU_TERID", "AU_REGION", "AU_AREA", "AU_LOCALITY", "AU_CONTRY", "AU_ADRESS", "AF_ZIP", "AF_TERID", "AF_REGION", "AF_AREA", "AF_LOCALITY", "AF_CONTRY", "AF_ADRESS", "REGIONAL_PI", "AREA_PI", "ADM_REG_AUTHORITY", "ADM_REG_DATE", "PI_REG_DATE", "DPA_REG_NUMBER", "DPI_REG_DATE", "VAT_DATA", "VAT_CERT_NUMBER", "NAME_BY_STATUS", "BORROWER_CLASS", "REGIONAL_HOLDING_NUMBER", "K013", "GROUP_AFFILIATION", "INCOME_TAX_PAYER_REG_DATE", "SEPARATE_DIV_CORP_CODE", "ECONOMIC_ACTIVITY_TYPE", "FIRST_ACC_DATE", "INITIAL_FORM_FILL_DATE", "EVALUATION_REPUTATION", "AUTHORIZED_CAPITAL_SIZE", "RISK_LEVEL", "REVENUE_SOURCES_CHARACTER", "ESSENCE_CHARACTER", "NATIONAL_PROPERTY", "VIP_SIGN", "NO_TAXPAYER_SIGN") AS 
  select c.kf,                                      -- ��� �� (��� ���)
       c.rnk,                                     -- �����. � (���)
       greatest( ( select max(cu.CHGDATE) from BARS.CUSTOMER_UPDATE  cu where cu.RNK = c.RNK )
               , ( select max(cu.CHGDATE) from BARS.CUSTOMERW_UPDATE cu where cu.RNK = c.RNK )
               , ( select max(cu.CHGDATE) from BARS.CORPS_UPDATE     cu where cu.RNK = c.RNK )
               ) as lastChangeDt,                  -- ���� �������� �����������
       c.date_off,                                               --���� ��������
       c.date_on,                                              --���� ���������
       c.nmk  as full_Name,                        --������������ �볺��� (���.)
       c.nmkv as full_Name_International,                 --������������ (���.)
       c.nmkk as full_Name_Abbreviated,               --������������ (���������)
       1 as k014,                                           --��� �볺��� (�014)
       c.country as k040,                                --����� �볺��� (�040)
       c.tgr     as build_State_Register,               --��� ���������� ������
       c.okpo,                                            --���������������� ���
      (SELECT cw.VALUE
         FROM customerw cw
        WHERE cw.tag = 'EOKPO' AND c.rnk = cw.rnk)
             as is_Okpo_Exclusion,                     --������ ���������� �����
       c.prinsider as k060,                            --������ ��������� (�060)
       (select rezid from bars.codcagent where codcagent=c.codcagent)
             as k030,                                     --������������� (�030)
       c.branch as off_Balance_Dep_Code,         --��� �������������� ��������
       (select name from branch where branch = c.branch)
             as off_Balance_Dep_Name,          --����� �������������� ��������
       c.ise as k070,                            --����. ������ �������� (�070)
       c.fs  as k080,                                   --����� �������� (�080)
       c.ved as k110,                                 --��� ��. ��������(�110)
       c.k050,                                     --����� �������������� (�050)
       trim(c.sed) as k051,                        --����� �������������� (�051)
       -- �������� ������
       au.zip as au_zip,                                                --������
       au.territory_id as au_terid,                              --��� �������
       au.domain as au_region,                                         --�������
       au.region as au_area,                                             --�����
       au.locality as au_locality,                             --��������� �����
       au.country as au_contry,                          --����� �볺��� (�040)
       au.address as au_adress,                                  --���.,���., ��
       --�������� ������
       af.zip as af_zip,                                                --������
       af.territory_id as af_terid,                              --��� �������
       af.domain as af_region,                                         --�������
       af.region as af_area,                                             --�����
       af.locality as af_locality,                             --��������� �����
       af.country as af_contry,                          --����� �볺��� (�040)
       af.address as af_adress,                                  --���.,���., ��
       --�������� �������� �������
       c.c_reg as regional_Pi,                                      --������� ϲ
       c.c_dst as area_Pi,                                          --������� ϲ
       c.adm   as adm_Reg_Authority,         --��������������� ����� ���������
       c.datea as adm_Reg_Date,                            --���� �����. � ���.
       c.datet as pi_Reg_Date,                               --���� �����. � ϲ
       c.rgadm as dpa_Reg_Number,                       --����� ��������� � ���
       to_date (null) as dpi_Reg_Date,                     --?���� �����. � �ϲ
       (select value from bars.CUSTOMERW cw where cw.tag='N_RPP' and c.rnk=cw.rnk)
        as vat_Data,                                     --���� ��� �������� ���
       (select value from bars.CUSTOMERW cw where cw.tag='N_RPN' and c.rnk=cw.rnk)
        as vat_Cert_Number,  --� �������� �������� ���
       (select value from bars.CUSTOMERW cw where cw.tag='FIRMA' and c.rnk=cw.rnk)
        as name_By_Status,                             --������������ �� �������
       C.CRISK as borrower_Class,                            --���� ������������
       '' as regional_Holding_Number,                         --?���. � ��������
       (select value from bars.CUSTOMERW cw where cw.tag='K013 ' and c.rnk=cw.rnk)
        as k013,                                         --��� ���� �볺��� (K013)
       (select value from bars.CUSTOMERW cw where cw.tag='MS_GR' and c.rnk=cw.rnk)
        as group_Affiliation,                                 --��-�.53 ������������� �� �����
       --(select value from bars.CUSTOMERW cw where cw.tag='N_RPD' and c.rnk=cw.rnk)
       to_date (null) as income_Tax_Payer_Reg_Date,      --?���� ��������� �� �������� ������� �� ��������
       (select value from bars.CUSTOMERW cw where cw.tag='KVPKK' and c.rnk=cw.rnk)
        as separate_Div_Corp_Code,                    --��� ������������� �������� ����. �볺���
       (select value from bars.CUSTOMERW cw where cw.tag='CCVED' and c.rnk=cw.rnk)
        as economic_Activity_Type,              --��� (����) ������������ (���������) ��������
       (select value from bars.CUSTOMERW cw where cw.tag='DATVR' and c.rnk=cw.rnk)
        as first_Acc_Date,                          --���� �������� ������� �������
       (select value from bars.CUSTOMERW cw where cw.tag='DATZ ' and c.rnk=cw.rnk)
        as initial_Form_Fill_Date,                        --���� ���������� ���������� ������
       (select value from bars.CUSTOMERW cw where cw.tag='O_REP' and c.rnk=cw.rnk)
        as evaluation_Reputation,                                       --������ ��������� �볺���
       (select value from bars.CUSTOMERW cw where cw.tag='FSRSK' and c.rnk=cw.rnk)
        as authorized_Capital_Size,                   --������ �i�.�����: ����i� ���������� ���i����
       (select value from bars.CUSTOMERW cw where cw.tag='RIZIK' and c.rnk=cw.rnk)
        as risk_Level,                                                  --�i���� ������
       (select value from bars.CUSTOMERW cw where cw.tag='DJER ' and c.rnk=cw.rnk)
        as revenue_Sources_Character,                  --�������������� ������ ���������� ����i�
       (select value from bars.CUSTOMERW cw where cw.tag='SUTD ' and c.rnk=cw.rnk)
        as essence_Character,                           --�������������� ��� ��������
       (select value from bars.CUSTOMERW cw where cw.tag='UUDV' and c.rnk=cw.rnk)
        as national_Property,                                      --������ �������� ��������
       (select value from bars.CUSTOMERW cw where cw.tag='VIP_K' and c.rnk=cw.rnk)
        as vip_Sign,                                             --������ VIP-�볺���
       (select value from bars.CUSTOMERW cw where cw.tag='NOTAX' and c.rnk=cw.rnk)
        as no_Taxpayer_Sign                                      --������ ���������� �������
  from customer c
     , corps p
     , ( select rnk, type_id, country,zip, domain, region, locality_type, locality, address, street_type, street,
                home_type, home, homepart_type, homepart, room_type, room , territory_id
           from bars.customer_address ca
          where type_id ='1'
        ) au
     , ( select rnk, type_id, country,zip, domain, region, locality_type, locality, address, street_type, street,
                home_type, home, homepart_type, homepart, room_type, room , territory_id
           from bars.customer_address ca
          where type_id ='2'
        ) af
 where c.custtype = 2
   and c.rnk = p.rnk
   and c.rnk=au.rnk(+)
   and c.rnk=af.rnk(+);

PROMPT *** Create  grants  V_EBKC_LEGAL_PERSON ***
grant SELECT                                                                 on V_EBKC_LEGAL_PERSON to BARSREADER_ROLE;
grant SELECT                                                                 on V_EBKC_LEGAL_PERSON to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_EBKC_LEGAL_PERSON to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_EBKC_LEGAL_PERSON.sql =========*** En
PROMPT ===================================================================================== 