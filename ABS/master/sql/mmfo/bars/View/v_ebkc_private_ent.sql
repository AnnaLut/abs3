CREATE OR REPLACE FORCE VIEW BARS.V_EBKC_PRIVATE_ENT
as /* ��� �� ����� ��� ���  */
select c.kf,                                                 -- ��� �� (��� ���)
       c.rnk,                                                 -- �����. � (���)
       GREATEST( ( select max(cu.CHGDATE) from BARS.CUSTOMER_UPDATE  cu where cu.RNK = c.RNK )
               , ( select max(cu.CHGDATE) from BARS.CUSTOMERW_UPDATE cu where cu.RNK = c.RNK )
               , ( select max(cu.CHGDATE) from BARS.PERSON_UPDATE    cu where cu.RNK = c.RNK )
               ) AS lastChangeDt,                   --���� �������� �����������
       c.date_off,                                               --���� ��������
       c.date_on,                                              --���� ���������
       c.nmk,                                      --������������ �볺��� (���.)
       c.nmkv,                                            --������������ (���.)
       c.nmkk,                                        --������������ (���������)
       2 AS k014,                                           --��� �볺��� (�014)
       c.country,                                        --����� �볺��� (�040)
       c.tgr,                                           --��� ���������� ������
       c.okpo,                                            --���������������� ���
       ( SELECT cw.VALUE FROM customerw cw 
          WHERE cw.tag = 'EXCLN' AND cw.rnk = c.rnk
       ) as OKPO_EXCLUSION,                           -- ������ ���������� �����
       c.prinsider,                                   -- ������ ��������� (�060)
       c.codcagent as k010,                      --�������������� �볺��� (�010)
       --�������� ���������    
       c.ise,                                    --����. ������ �������� (�070)
       c.fs,                                            --����� �������� (�080)
       c.ved,                                         --��� ��. ��������(�110)
       c.k050,                                     --����� �������������� (�050)
       trim(c.sed) as sed,                         --����� �������������� (�051)
       -- �������� ������
       a.au_zip,                                                        --������
       a.au_terid,                                               --��� �������
       a.au_domain as au_region,                                        --�������
       a.au_region as au_area,                                            --�����
       a.au_locality,                                          --��������� �����
       a.au_adress,                                         --���., �����., �-�.
       a.au_home,                                                  --� ���., �/�
       a.au_homepart,                                           --� ����., ����.
       a.au_room,                                            --� ��., ���., ��.
       '' as au_comm,                                                 --�������
       --�������� ������
       a.af_zip,                                                        --������
       a.af_terid,                                               --��� �������
       a.af_domain as af_region,                                       --�������
       a.af_region as af_area,                                           --�����
       a.af_locality,                                          --��������� �����
       a.af_adress,                                         --���., �����., �-�.
       a.af_home,                                                  --� ���., �/�
       a.af_homepart,                                           --� ����., ����.
       a.af_room,                                            --� ��., ���., ��.
       '' as af_comm,                                                 --�������
       --�������� �������� �������
       c.c_reg,                                                     --������� ϲ
       c.c_dst,                                                     --������� ϲ
       c.adm,                                --�������������� ����� ���������
       c.datea,                                           --���� �����. � ���.
       c.datet,                                             --���� �����. � ϲ
       c.rgadm,                                         --����� ��������� � ���
       c.rgtax,                                             --�����. ����� � ϲ
       '' as pcod_k050,                                 --?���������� ��� (�050)
       --�������� �볺���      
       p.passp,                                                  --��� ���������
       p.ser,                                                  --���� ���������
       p.numdoc,                                               --����� ���������
       p.organ,                                                    --��� �������
       p.pdate,                                                   --���� �������
       p.actual_date,                                               --ĳ����� ��
       p.eddr_id,                                 --��������� ����� ������ ����
       p.bday,                                                 --���� ����������
       p.bplace,                                              --̳��� ����������
       p.sex,                                                            --�����
       p.cellphone,                                                  --���. ���.    
       --��������� ����������
       c.crisk,                                              --���� ������������
       c.mb   ,                                --������������ �� ������ ������
       --�������� ��������
       ( select value from bars.CUSTOMERW cw 
          where cw.tag='K013 ' and c.rnk=cw.rnk
       ) as k013,                                     -- ��� ���� �볺��� (K013)
       ( select value from bars.CUSTOMERW cw
          where cw.tag='MS_GR' and c.rnk=cw.rnk
       ) as ms_gr,                             -- ��-�.53 ������������ �� �����
       ( select value from bars.CUSTOMERW cw
          where cw.tag='EMAIL' and c.rnk=cw.rnk
       ) as email,                                   -- ������ ���������� �����
       ( select value from bars.CUSTOMERW cw
          where cw.tag='CIGPO' and c.rnk=cw.rnk
       ) as cigpo                                     -- ������ ��������� �����
  from CUSTOMER c
     , PERSON   p
     , ( select rnk,
                "'1'_C1"  au_contry,
                "'1'_C2"  au_zip,
                "'1'_C3"  au_domain,
                "'1'_C4"  au_region,
                "'1'_C5"  au_locality_type,
                "'1'_C6"  au_locality,
                "'1'_C7"  au_adress,
                "'1'_C8"  au_street_type,
                "'1'_C9"  au_street,
                "'1'_C10" au_home_type,
                "'1'_C11" au_home,
                "'1'_C12" au_homepart_type,
                "'1'_C13" au_homepart,
                "'1'_C14" au_room_type,
                "'1'_C15" au_room,
                "'1'_C16" au_terid,
                "'2'_C1"  af_contry,
                "'2'_C2"  af_zip,
                "'2'_C3"  af_domain,
                "'2'_C4"  af_region,
                "'2'_C5"  af_locality_type,
                "'2'_C6"  af_locality,
                "'2'_C7"  af_adress,
                "'2'_C8"  af_street_type,
                "'2'_C9"  af_street,
                "'2'_C10" af_home_type,
                "'2'_C11" af_home,
                "'2'_C12" af_homepart_type,
                "'2'_C13" af_homepart,
                "'2'_C14" af_room_type,
                "'2'_C15" af_room,
                "'2'_C16" af_terid
          from ( select rnk, type_id, country,zip, domain, region, locality_type, locality, address, street_type, street, 
                        home_type, home, homepart_type, homepart, room_type, room, territory_id
                   from BARS.CUSTOMER_ADDRESS
               )  pivot ( max(country) c1, max(zip) c2, max(domain) c3, max(region) c4, max(locality_type) c5, max(locality) c6, 
                          max(address) c7, max(street_type) c8, max(street) c9, max(home_type) c10, max(home) c11, 
                          max(homepart_type) c12, max(homepart) c13, max(room_type) c14, max(room) c15, max(territory_id) c16
                      for type_id in ('1', '2') )
       ) a
 where c.custtype = 3
   and c.sed = '91  '
   and c.rnk = p.rnk
   and c.rnk=a.rnk(+);

GRANT SELECT ON BARS.V_EBKC_PRIVATE_ENT TO BARS_ACCESS_DEFROLE;
