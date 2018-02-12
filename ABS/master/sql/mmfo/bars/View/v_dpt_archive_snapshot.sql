CREATE OR REPLACE VIEW V_DPT_ARCHIVE_SNAPSHOT
(kf, branch, dpt_id, nd, vidd_id, vidd_nm, ccy_id, ccy_code, ctr_amt, cust_id, cust_nm, acc_num, dep_bal, int_bal, rate, ctr_dt, beg_dt, end_dt, cnt_dubl, user_id, ebpy, rpt_dt, wb)
AS
SELECT d.KF,
            d.BRANCH,
            d.deposit_id,
            d.ND,
            d.VIDD,
            d.type_name,
            d.kv,
            d.lcv,
            d.LIMIT,
            d.rnk,
            d.nmk,
            d.nls,
            NVL (fost (d.acc, gl.bd) / t.denom, 0)
               AS DEP_BAL,
            NVL (fost (d.acra, gl.bd) / t.denom, 0)
               AS INT_BAL,
            NVL (acrn.fproc (d.acc, gl.bd), 0) AS RATE,
            d.datz,
            d.dat_begin,
            d.dat_end,
            NVL (d.cnt_dubl, 0) AS CNT_DUBL,
            d.USERID,
            CASE WHEN D.ARCHDOC_ID > 0 THEN '���' WHEN D.ARCHDOC_ID = -1 THEN 'Ͳ' ELSE '' END EBPY,
            d.rpt_dt,
			d.wb
       FROM MV_DPT_DEPOSIT_ARC d
       JOIN BARS.TABVAL$GLOBAL t ON (t.KV = d.KV);
comment on table V_DPT_ARCHIVE is '����� �������� ��';
comment on column V_DPT_ARCHIVE.KF is '��� ������ (���)';
comment on column V_DPT_ARCHIVE.BRANCH is '��� ��������� (����)';
comment on column V_DPT_ARCHIVE.DPT_ID is '��. ����������� ��������';
comment on column V_DPT_ARCHIVE.ND is '����� ��������';
comment on column V_DPT_ARCHIVE.VIDD_ID is '��. ���� ��������';
comment on column V_DPT_ARCHIVE.VIDD_NM is '����� ���� ��������';
comment on column V_DPT_ARCHIVE.CCY_ID is '������';
comment on column V_DPT_ARCHIVE.CCY_CODE is '���������� ��� ������';
comment on column V_DPT_ARCHIVE.CTR_AMT is '���� ��������';
comment on column V_DPT_ARCHIVE.CUST_ID is '��. �볺���';
comment on column V_DPT_ARCHIVE.CUST_NM is '����� �볺���';
comment on column V_DPT_ARCHIVE.ACC_NUM is '����� ����������� �������';
comment on column V_DPT_ARCHIVE.DEP_BAL is '������� �� ����������� �������';
comment on column V_DPT_ARCHIVE.INT_BAL is '������� �� ����������� �������';
comment on column V_DPT_ARCHIVE.RATE is '³������� ������';
comment on column V_DPT_ARCHIVE.CTR_DT is '���� ��������� ��������';
comment on column V_DPT_ARCHIVE.BEG_DT is '���� ������� 䳿 ��������';
comment on column V_DPT_ARCHIVE.END_DT is '���� ��������� 䳿 ��������';
comment on column V_DPT_ARCHIVE.CNT_DUBL is '�-�� ����������� ��������';
comment on column V_DPT_ARCHIVE.EBPY is '���';
comment on column V_DPT_ARCHIVE.RPT_DT is '����� ����';
grant select on V_DPT_ARCHIVE_SNAPSHOT to bars_access_defrole;