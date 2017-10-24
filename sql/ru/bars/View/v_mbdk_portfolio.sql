CREATE OR REPLACE VIEW V_MBDK_PORTFOLIO AS
SELECT user_utl.get_user_name(m.userid) user_name,                      -- isp
       m.ostc / POWER (10, 2) ostc,                             -- ost body
       m.ostb / POWER (10, 2) ostb,                         -- ���� �� ���
       m.ostf / POWER (10, 2) ostf,                    -- �������� �� ���
       m.kv,                                                      -- ������
       m.nls,                                               -- ������� ���
       m.zdate,                                         -- ����� ����������
       m.sdate,                                              --���� �������
       m.wdate,                                          -- ���� ���������
       m.rnk,                                                        -- ���
       m.okpo,                                                    -- ������
       SUBSTR (m.nmk, 1, 38) nmk,                            --������������
       m.cc_id,                                             -- ����� �����
       m.nd,                                              -- �������� �����
       m.acc,                                                            --
       m.LIMIT,                                               -- ���� �����
       m.srok,                                                    -- �����
       m.wdate - gl.bd ost_srok,
       m.vidd,                                                 -- ��� �����
       m.tipd,                                            -- 1 ���� 2 �����
       m.kprolog,                                                        --
       m.bic,                                                        -- BIC
       m.swi_ref,                                   --��� �������� �������
       m.swo_ref,                                          -- ��� ���������
       m.nls_n,                                               -- ������� %%
       acrN.fprocN (m.acc, m.dk, bankdate) ratn,                --%% ������
       m.mdate_n,                                      -- ���� ��������� %%
       m.ostc_n / POWER (10, 2) ostcn,                        -- ������� %%
       m.ostb_n / POWER (10, 2) ostbn,
       m.ostf_n / POWER (10, 2) ostfn,
       m.acr_dat,                                   -- ���� �� ��� ����� %%
       m.mfokred,                                      -- ��� �������� Ҳ��
       m.acckred,                                  -- ������� �������� ���
       m.mfoperc,                                                 -- ��� %%
       m.accperc,
       m.nls_1819 S_1819,
       '��������' BUH,
       '��������' RAH,
       '��������' PROSTR,
       '��������' GPK,
       '��������' REPO,
       'zal' zal,
       case when (select count(*) from cc_accp p where p.accs = m.acc) = 0 then 0 else 1 end ZAL1
FROM   mbd_k m
ORDER BY m.nd DESC;


GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.V_MBDK_PORTFOLIO TO BARS_ACCESS_DEFROLE;
