PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAY_QUEUE.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAY_QUEUE ***

CREATE OR REPLACE FORCE VIEW BARS.V_ZAY_QUEUE
(
   ID,
   MFO,
   REQ_ID,
   DK,
   OBZ,
   ND,
   FDAT,
   DATT,
   RNK,
   NMK,
   ND_RNK,
   KV_CONV,
   LCV_CONV,
   KV2,
   LCV,
   DIG,
   S2,
   S2S,
   S3,
   KOM,
   SKOM,
   KURS_Z,
   KURS_F,
   VDATE,
   DATZ,
   ACC0,
   NLS_ACC0,
   MFO0,
   NLS0,
   OKPO0,
   OSTC0,
   ACC1,
   OSTC,
   NLS,
   SOS,
   REF,
   VIZA,
   PRIORITY,
   PRIORNAME,
   PRIORVERIFY,
   IDBACK,
   FL_PF,
   MFOP,
   NLSP,
   OKPOP,
   RNK_PF,
   PID,
   CONTRACT,
   DAT2_VMD,
   META,
   AIM_NAME,
   full_meta,
   BASIS,
   PRODUCT_GROUP,
   PRODUCT_GROUP_NAME,
   full_product_group,
   NUM_VMD,
   DAT_VMD,
   DAT5_VMD,
   COUNTRY,
   BENEFCOUNTRY,
   BANK_CODE,
   BANK_NAME,
   USERID,
   BRANCH,
   FL_KURSZ,
   IDENTKB,
   COMM,
   CUST_BRANCH,
   KURS_KL,
   CONTACT_FIO,
   CONTACT_TEL,
   VERIFY_OPT,
   CLOSE_TYPE_NAME,
   AIMS_CODE,
   S_PF,
   REF_PF,
   REF_SPS,
   START_TIME,
   STATE,
   OPERID_NOKK,
   REQ_TYPE,
   VDATE_PLAN,
   REASON_COMM,
   CODE_2C,
   P12_2C,
   ATTACHMENTS_COUNT
)
AS
   SELECT z.id,                                                  -- ��� ������
          SUBSTR (f_ourmfo, 1, 6),                                       -- ��
          NULL,                                               -- ��� ������ ��
          z.dk,                                         -- 1-�������/2-�������
          z.obz,                                                         -- ??
          z.nd,                                     -- ���������� ����� ������
          z.fdat,                                               -- ���� ������
          z.datt,                                                        -- ??
          z.rnk,                                                        -- ���
          c.nmk,                                                        -- ���
          c.nd,                            -- ����� ���. �� ������� - �� �����
          z.kv_conv,                       -- ������ ������ "�� ���"(����.���)
          t1.lcv,                          -- ������ ������ "�� ���"(����.���)
          z.kv2,                              -- ������ ������ "���"(����.���)
          t.lcv,                              -- ������ ������ "���"(����.���)
          t.dig,                                -- ���-�� ������ ����� �������
          z.s2,                                        -- ����� ������ (� ���)
          z.s2 / POWER (10, t.dig),           -- ����������� ����� (�� � ���.)
          z.s3,                                                         -- ???
          z.kom,                                           -- ������� ��������
          z.skom,                                            -- ����� ��������
          z.kurs_z,                                             -- ���� ������
          z.kurs_f,                             -- ���� ������ �� �����.������
          z.vdate,                                   -- ���� ����������.������
          NVL (z.datz, z.vdate),                                -- ���� ������
          z.acc0,                                             -- ��� ��� �����
          NVL (b.nls, z.nls0) nls_acc0,                     -- ����� ��� �����
          NVL (z.mfo0, SUBSTR (f_ourmfo, 1, 12)), -- ���� �������, �� ���0 ������, � ��������� mfo0, nls0
          NVL (z.nls0, b.nls),
          c.okpo,                                              -- ���� �������
          b.ostc,                                      -- ������� �� ��� �����
          z.acc1,                                             -- ��� ��� �����
          a.ostc,                                      -- ������� �� ��� �����
          a.nls,                                            -- ����� ��� �����
          z.sos, -- ��������� ������ (0-�������, 1 - ������������� �������, 2 - ��������)
          z.REF,                          -- ������� ��������������� ���������
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
          NVL (tc.name, z.contract),                                    -- ���
          NVL (tc.dateopen, z.dat2_vmd),                                -- ���
          z.meta,                                               -- ���� ������
          za.name,                                 -- ������������ ���� ������
          TO_CHAR (z.meta, 'FM09') || ' ' || za.name full_meta,
          z.basis,                                    -- ��������� ��� �������
          z.product_group,                                       -- ����������
          k.txt,                                     -- �������� product_group
          TO_CHAR (z.product_group, 'FM09') || ' ' || k.txt
             full_product_group,
          z.num_vmd,                                                    -- ���
          z.dat_vmd,                                                    -- ���
          z.dat5_vmd,                                                   -- ���
          NVL (z.country, tc.benefcountry),                             -- ���
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
          zc.name,
          z.aims_code,
          z.s_pf / 100,
          z.ref_pf,
          z.ref_sps,
          zt.change_time,
		  DECODE (
             z.sos,
             0, DECODE (
                   z.viza,
                   0, '�������� ���������',
                   1,    '��������� ZAY2.����� '
                      || DECODE (z.priority, 1, ' ZAY3', '�����'),
                   2, '��������� ZAY3.����� �����',
                   -1, '����� � ���',
                   ''),
             0.5, '�������.������ ���������',
             1, '�������.������ �������',
             2, '��������',
             -1, '��������',
             ''),
          z.operid_nokk,
          z.req_type,
          z.vdate_plan,
          z.reason_comm,
          z.code_2c,
          z.p12_2c,
          z.attachments_count
     FROM zayavka z,
          zay_queue q,
          customer c,
          tabval t,
          tabval t1,
          accounts a,
          accounts b,
          top_contracts tc,
          zay_priority p,
          zay_aims za,
          v_kod_70_4 k,
          zay_close_types zc,
          (SELECT id, change_time
             FROM zay_track
            WHERE new_viza = 0 AND new_sos = 0) zt
    WHERE     z.rnk = c.rnk
          AND z.id = q.id
          AND z.kv2 = t.kv
          AND z.kv_conv = t1.kv(+)
          AND z.priority = p.id
          AND z.acc1 = a.acc(+)
          AND z.acc0 = b.acc(+)
          AND z.pid = tc.pid(+)
          AND z.meta = za.aim(+)
          AND k.p70(+) = z.product_group
          AND z.id = zt.id(+)
          AND z.close_type = zc.id(+)
          AND z.branch LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask')
   UNION ALL
   SELECT id,
          mfo,
          req_id,
          dk,
          obz,
          nd,
          fdat,
          datt,
          rnk,
          nmk,
          nd_rnk,
          kv_conv,
          lcv_conv,
          kv2,
          lcv,
          dig,
          s2,
          s2s,
          s3,
          kom,
          skom,
          kurs_z,
          kurs_f,
          vdate,
          datz,
          acc0,
          nls_acc0,
          mfo0,
          nls0,
          okpo0,
          ostc0,
          acc1,
          ostc,
          nls,
          sos,
          REF,
          viza,
          priority,
          priorname,
          priorverify,
          idback,
          fl_pf,
          mfop,
          nlsp,
          okpop,
          rnk_pf,
          pid,
          contract,
          dat2_vmd,
          meta,
          aim_name,
          TO_CHAR (meta, 'FM09') || ' ' || aim_name full_meta,
          basis,
          product_group,
          product_group_name,
          TO_CHAR (product_group, 'FM09') || ' ' || product_group_name
             full_product_group,
          num_vmd,
          dat_vmd,
          dat5_vmd,
          country,
          benefcountry,
          bank_code,
          bank_name,
          userid,
          branch,
          fl_kursz,
          identkb,
          comm,
          cust_branch,
          kurs_kl,
          contact_fio,
          contact_tel,
          verify_opt,
          close_type_name,
          aims_code,
          s_pf,
          ref_pf,
          ref_sps,
          start_time,
          state,
          operid_nokk,
          req_type,
          vdate_plan,
          reason_comm,
          NULL,
          NULL,
          0 attachments_count
     FROM zayavka_ru
    WHERE     f_ourmfo_g = SYS_CONTEXT ('bars_context', 'user_mfo')
          AND f_ourmfo () = '300465';


CREATE OR REPLACE PUBLIC SYNONYM V_ZAY_QUEUE FOR BARS.V_ZAY_QUEUE;


GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.V_ZAY_QUEUE TO BARS_ACCESS_DEFROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.V_ZAY_QUEUE TO START1;

GRANT DELETE, INSERT, SELECT, UPDATE, FLASHBACK ON BARS.V_ZAY_QUEUE TO WR_ALL_RIGHTS;

GRANT SELECT ON BARS.V_ZAY_QUEUE TO ZAY;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAY_QUEUE.sql =========*** End *** ==
PROMPT ===================================================================================== 