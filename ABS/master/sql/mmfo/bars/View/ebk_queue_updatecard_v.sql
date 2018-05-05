-- ======================================================================================
-- Module : CDM (���)
-- Author : BAA
-- Date   : 12.02.2018
-- ======================================================================================
-- create view EBK_QUEUE_UPDATECARD_V
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500

prompt -- ======================================================
prompt -- create view EBK_QUEUE_UPDATECARD_V
prompt -- ======================================================

create or replace force view EBK_QUEUE_UPDATECARD_V
( KF
, RNK
, DATEON
, DATEOFF
, NMK
, SNLN
, SNFN
, SNMN
, NMKV
, SNGC
, CODCAGENT
, K013
, COUNTRY
, PRINSIDER
, TGR
, OKPO
, PASSP
, SER
, NUMDOC
, ORGAN
, PDATE
, DATEPHOTO
, BDAY
, BPLACE
, SEX
, ACTUALDATE
, EDDRID
, BRANCH
, ADR
, URZIP
, URDOMAIN
, URREGION
, URLOCALITY
, URADDRESS
, URTERRITORYID
, URLOCALITYTYPE
, URSTREETTYPE
, URSTREET
, URHOMETYPE
, URHOME
, URHOMEPARTTYPE
, URHOMEPART
, URROOMTYPE
, URROOM
, FGADR
, FGDST
, FGOBL
, FGTWN
, MPNO
, CELLPHONE
, TELD
, TELW
, EMAIL
, ISE
, FS
, VED
, K050
, PCZ2
, PCZ1
, PCZ5
, PCZ3
, PCZ4
, SAMZ
, VIPK
, WORKPLACE
, PUBLP
, CIGPO
, CHORN
, SPMRK
, WORKB
, OKPOEXCLUSION
, BANKCARD
, CREDIT
, DEPOSIT
, CURRENTACCOUNT
, OTHER
, LASTCHANGEDT
, CUST_ID
, GCIF
, RCIF
) as
select q.KF,                          -- ��� �� (��� ���)
       case
         when ( EBK_PARAMS.IS_CUT_RNK = 1 )
         then trunc(q.RNK/100)
         else q.RNK
       end as RNK,                      -- �����. � (���)
       ecbi.date_ON  as dateON ,        -- ���� ���������
       ecbi.date_OFF as dateOFF,        -- ���� ��������
       ecbi.nmk,                        -- ������������ �볺��� (���.)
       ecbi.sn_Ln as snLn,              -- ������� �볺���
       ecbi.sn_Fn as snFn,              -- ��`� �볺���
       ecbi.sn_Mn snMn,                 -- ��-������� �볺���
       ecbi.nmkv,                       -- ������������ (���.)
       ecbi.sn_Gc as snGc,              -- ϲ� �볺��� � �������� ������
       ecbi.codcagent,                  -- �������������� �볺��� (�010)
       ecbi.k013,                       -- ��� ���� �볺��� (K013)
       ecbi.country,                    -- ����� �볺��� (�040)
       ecbi.prinsider,                  -- ������ ��������� (�060)
       ecbi.tgr,                        -- ��� ����. ������
       ecbi.okpo,                       -- ���������������� ���
       ecbi.passp,                      -- ��� ���������
       ecbi.ser,                        -- ����
       ecbi.numdoc,                     -- �����
       ecbi.organ,                      -- ��� �������
       ecbi.pdate,                      -- ���� ������
       ecbi.date_Photo datePhoto,       -- ���� ���������� ���� � �������
       ecbi.bday,                       -- ���� ����������
       ecbi.bplace,                     -- ̳��� ����������
       ecbi.sex,                        -- �����
       ecbi.actual_date as actualdate,  -- ĳ����� ��
       ecbi.eddr_id as eddrid,          -- ��������� ����� ������ � ����
       ecbi.branch,                     --
       ecbi.adr,                        -- ������ (����� ����)
       ecbi.ur_Zip as urZip,                    -- ��.���:������
       ecbi.ur_Domain as urDomain,              -- ��.���:�������
       ecbi.ur_Region as urRegion,              -- ��.���:������
       ecbi.ur_Locality as urLocality,          -- ��.���:���������� ����
       ecbi.ur_Address as urAddress,            -- ��.���:�����(�����,���,��.)
       ecbi.ur_Territory_Id as urTerritoryId,   -- ��.���:��� ������
       ecbi.ur_Locality_Type as urLocalityType, -- ��.���:��� �����.������
       ecbi.ur_Street_Type as urStreetType,     -- ��.���:��� �����
       ecbi.ur_Street as urStreet,              -- ��.���:�����
       ecbi.ur_Home_Type as urHomeType,         -- ��.���:��� ����
       ecbi.ur_Home as urHome,                  -- ��.���:� ����
       ecbi.ur_Homepart_Type as urHomepartType, -- ��.���:��� ���.����
       ecbi.ur_Home_part as urHomepart,         -- ��.���:� ���� ���.����
       ecbi.ur_Room_Type urRoomType,            -- ��.���:��� ������ ���������
       ecbi.ur_Room urRoom,                     -- ��.���:� ������ ���������
       ecbi.fgadr,                  -- ������: ������,���.,��.
       ecbi.fgdst,                  -- ������: �����
       ecbi.fgobl,                  -- ������: �������
       ecbi.fgtwn,                  -- ������: ��������� �����
       ecbi.mpno,                   -- �������� �������
       ecbi.cellphone,              -- ������� ���.
       ecbi.teld,                   -- ������� ���.
       ecbi.telw,                   -- ������� ���.
       ecbi.email,                  -- ������ ���������� �����
       ecbi.ise,                    -- ����.������.�������� (�070)
       ecbi.fs ,                    -- ����� �������� (�080)
       ecbi.ved ,                   -- ��� ��. �������� (�110)
       ecbi.k050 ,                  -- ����� �������������� (�050)
       ecbi.pc_Z2 as pcZ2,          -- ���. ����������� �������. �����
       ecbi.pc_Z1 as pcZ1,          -- ���. ����������� �������. ����
       ecbi.pc_Z5 as pcZ5,          -- ���. ����������� �������. ���� �������
       ecbi.pc_Z3 as pcZ3,          -- ���. ����������� �������. ��� �������
       ecbi.pc_Z4 as pcZ4,          -- ���. ����������� �������. ĳ����� ��
       ecbi.samz,                   -- �i��i��� ��� ����������i��� �i������
       ecbi.vip_K as vipK,          -- ������ VIP-�볺���
       ecbi.work_Place as workPlace,-- ̳��� ������, ������
       ecbi.publp,                  -- ������i��� �� ����i���� �i��i�
       ecbi.cigpo,                  -- ������ ��������� �����
       ecbi.chorn,                  -- �������i� ��������, ��i ����������� �����i��� ������.����������
       ecbi.spmrk,                  -- ��� �������� �i��i��� �������������� �볺��� ��
       ecbi.workb,                  -- ���������i��� �� ����i����i� �����
       nvl(ecbi.okpo_Exclusion, 0) as okpoExclusion,
       ecbi.bank_card as BankCard,
       ecbi.credit,
       ecbi.deposit,
       ecbi.current_account as CurrentAccount,
       ecbi.other,
       q.INSERT_DATE as lastChangeDt,
       q.RNK as CUST_ID,
       g.GCIF,
       cast( null as number ) as RCIF
  from ( select KF, RNK, INSERT_DATE
           from EBK_QUEUE_UPDATECARD
          where STATUS = 0
          order by ROWID
       ) q
  join EBK_CUST_BD_INFO_V  ecbi
    on ( ecbi.RNK = q.RNK )
  left outer
  join EBKC_GCIF g
    on ( g.RNK = q.RNK )
;

show errors;

grant SELECT on EBK_QUEUE_UPDATECARD_V to BARS_ACCESS_DEFROLE;
grant SELECT on EBK_QUEUE_UPDATECARD_V to BARSREADER_ROLE;