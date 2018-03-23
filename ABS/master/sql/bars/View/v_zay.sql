

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAY.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAY ("ID", "MFO", "MFO_NAME", "REQ_ID", "DK", "OBZ",
 "ND", "FDAT", "DATT", "RNK", "NMK", "CUSTTYPE", "ND_RNK", "KV_CONV", "LCV_CONV", "KV2",
 "LCV", "DIG", "S2", "S2S", "S3", "KOM", "SKOM", "KURS_Z", "KURS_F", "VDATE", "DATZ", "ACC0", 
"NLS_ACC0", "MFO0", "NLS0", "OKPO0", "OSTC0", "ACC1", "OSTC", "NLS", "SOS", "REF", "VIZA",
 "PRIORITY", "PRIORNAME", "PRIORVERIFY", "IDBACK", "FL_PF", "MFOP", "NLSP", "OKPOP", "RNK_PF",
 "PID", "CONTRACT", "DAT2_VMD", "META", "AIM_NAME", "BASIS", "PRODUCT_GROUP",
 "PRODUCT_GROUP_NAME", "NUM_VMD", "DAT_VMD", "DAT5_VMD", "COUNTRY", "BENEFCOUNTRY",
 "BANK_CODE", "BANK_NAME", "USERID", "BRANCH", "FL_KURSZ", "IDENTKB", "COMM", "CUST_BRANCH", 
"KURS_KL", "CONTACT_FIO", "CONTACT_TEL", "VERIFY_OPT", "CLOSE_TYPE", "CLOSE_TYPE_NAME",
 "AIMS_CODE", "S_PF", "REF_PF", "REF_SPS", "START_TIME", "STATE", "OPERID_NOKK", "REQ_TYPE",
 "VDATE_PLAN", "REASON_COMM","F092") AS 
  select z.id,                                                  -- ��� ������
       substr(f_ourmfo_g,1,6),                                        -- ��
       substr(getglobaloption('GLB-NAME'),1,38),         -- ������������ ��
       null,                                               -- ��� ������ ��
       z.dk,                                         -- 1-�������/2-�������
       z.obz,                                                         -- ??
       z.nd,                                     -- ���������� ����� ������
       z.fdat,                                               -- ���� ������
       z.datt,                                                        -- ??
       z.rnk,                                                        -- ���
       c.nmk,                                                        -- ���
       c.custtype,                                           -- ��� �������
       c.nd,                            -- ����� ���. �� ������� - �� �����
       z.kv_conv,                       -- ������ ������ "�� ���"(����.���)
       t1.lcv,                          -- ������ ������ "�� ���"(����.���)
       z.kv2,                                   -- ������ ������ (����.���)
       t.lcv,                                   -- ������ ������ (����.���)
       t.dig,                                -- ���-�� ������ ����� �������
       z.s2,                                        -- ����� ������ (� ���)
       z.s2 / power (10, t.dig),           -- ����������� ����� (�� � ���.)
       z.s3,                                                         -- ???
       z.kom,                                           -- ������� ��������
       z.skom,                                            -- ����� ��������
       z.kurs_z,                                             -- ���� ������
       z.kurs_f,                             -- ���� ������ �� �����.������
       z.vdate,                                   -- ���� ����������.������
       nvl (z.datz, z.vdate),                                -- ���� ������
       z.acc0,                                             -- ��� ��� �����
       b.nls nls_acc0,                                   -- ����� ��� �����
       nvl (z.mfo0, substr (f_ourmfo, 1, 12)), -- ���� �������, �� ���0 ������, � ��������� mfo0, nls0
       nvl (z.nls0, b.nls),
       c.okpo,                                              -- ���� �������
       b.ostc,                                      -- ������� �� ��� �����
       z.acc1,                                             -- ��� ��� �����
       a.ostc,                                      -- ������� �� ��� �����
       a.nls,                                            -- ����� ��� �����
       z.sos, -- ��������� ������ (0-�������, 1 - ������������� �������, 2 - ��������)
       z.ref,                          -- ������� ��������������� ���������
       z.viza, -- ���� (0 - �������, 0,5 - ������������ ZAY2, 1 - ������������ ���������, -1 - ������)
       z.priority, -- ��������� (0 - �������, 1 - �����������, 2 - ������������, 9 - ���������������)
       p.name,                                       -- �������� ����������
       p.verify,                        -- ������� �� ��������� �����������
       z.idback,                                        -- ������� ��������
       z.fl_pf,                                                   -- �� ���
       z.mfop,                                                    -- �� ���
       z.nlsp,                                                    -- �� ���
       z.okpop,                                                   -- �� ���
       z.rnk_pf,                                                  -- �� ���
       z.pid,                                                         -- ??
       nvl (tc.name, z.contract),                                    -- ���
       nvl (tc.dateopen, z.dat2_vmd),                                -- ���
       z.meta,                                               -- ���� ������
       za.name,                                 -- ������������ ���� ������
       z.basis,                                    -- ��������� ��� �������
       z.product_group,                                       -- ����������
       k.txt,                                     -- �������� product_group
       z.num_vmd,                                                    -- ���
       z.dat_vmd,                                                    -- ���
       z.dat5_vmd,                                                   -- ���
       nvl (z.country, tc.benefcountry),                             -- ���
       z.benefcountry,                                               -- ���
       z.bank_code,                                                  -- ���
       z.bank_name,                                                  -- ���
       z.isp,                                                 -- ���.������
       z.tobo,                                -- BRANCH, ��� ������� ������
       z.fl_kursz,                                                    -- ??
       z.identkb,                 -- ������������� ������, �������� �� ��-�
       z.comm,                                               -- �����������
       c.branch,                                          -- BRANCH �������
       z.kurs_kl,
       z.contact_fio,
       z.contact_tel,
       z.verify_opt,
       z.close_type,
       zc.name,
       z.aims_code,
       z.s_pf / 100,
       z.ref_pf,
       z.ref_sps,
       zt.change_time,
       decode (
             z.sos,
             0, decode (
                   z.viza,
                   0, '������� ������������',
                   1,    '������������ ZAY2. ������� '
                      || decode (z.priority,
                                 1, '���� ZAY3',
                                 '������'),
                   2, '������������ ZAY3. ������� ������',
                   -1, '����� � ����',
                   ''),
             0.5, '�����.������� ��������������',
             1, '�����.������� ������������',
             2, '��������',
             -1, '�������',
             ''),
       z.operid_nokk,
       z.req_type,
       z.vdate_plan,
       z.reason_comm,
       z.f092
  from zayavka z, customer c, tabval t, tabval t1,
       accounts a, accounts b,
       top_contracts tc, zay_priority p,
       zay_aims za, v_kod_70_4 k, zay_close_types zc,
       (select id, change_time
          from zay_track zzz
         where change_time = (select max(change_time)
                                FROM zay_track
                               WHERE new_viza = 0 AND new_sos = 0
                                 and id = zzz.id)) zt
 where z.rnk = c.rnk
   and z.kv2 = t.kv
   and z.kv_conv = t1.kv(+)
   and z.priority = p.id
   and z.acc1 = a.acc(+)
   and z.acc0 = b.acc(+)
   and z.pid = tc.pid(+)
   and z.meta = za.aim(+)
   and z.product_group = k.p70(+)
   and z.close_type = zc.id(+)
   and z.id = zt.id(+)
 union all
select z.id, z.mfo, b.nb, z.req_id, z.dk, z.obz, z.nd, z.fdat, z.datt,
       z.rnk, z.nmk, z.custtype, z.nd_rnk,
       z.kv_conv, z.lcv_conv, z.kv2, z.lcv, z.dig,
       z.s2, z.s2s, z.s3, z.kom, z.skom, z.kurs_z, z.kurs_f,
       z.vdate, z.datz, z.acc0, z.nls_acc0, z.mfo0, z.nls0,
       z.okpo0, z.ostc0, z.acc1, z.ostc, z.nls,
       z.sos, z.ref, z.viza, z.priority, z.priorname, z.priorverify,
       z.idback, z.fl_pf, z.mfop, z.nlsp, z.okpop, z.rnk_pf,
       z.pid, z.contract, z.dat2_vmd, z.meta, z.aim_name, z.basis,
       z.product_group, z.product_group_name,
       z.num_vmd, z.dat_vmd, z.dat5_vmd,
       z.country, z.benefcountry, z.bank_code, z.bank_name,
       z.userid, z.branch, z.fl_kursz, z.identkb, z.comm,
       z.cust_branch, z.kurs_kl, z.contact_fio, z.contact_tel,
       z.verify_opt, z.close_type, z.close_type_name, z.aims_code,
       z.s_pf, z.ref_pf, z.ref_sps, z.start_time, z.state, z.operid_nokk, z.req_type,
       z.vdate_plan, z.reason_comm,null
  from zayavka_ru z, banks$base b
 where z.mfo = b.mfo;

PROMPT *** Create  grants  V_ZAY ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_ZAY           to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_ZAY           to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_ZAY           to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_ZAY           to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAY.sql =========*** End *** ========
PROMPT ===================================================================================== 
