prompt create view bars_intgr.vw_ref_skrynka_nd
create or replace force view bars_intgr.vw_ref_skrynka_nd
as
select  nd,
        n_sk,
        sos,
        fio,
        dokum,
        issued,
        adres,
        dat_begin,
        dat_end,
        tel,
        dover,
        nmk,
        dov_dat1,
        dov_dat2,
        dov_pasp,
        mfok,
        nlsk,
        custtype,
        o_sk,
        isp_dov,
        ndov,
        nls,
        ndoc,
        docdate,
        sdoc,
        tariff,
        fio2,
        issued2,
        adres2,
        pasp2,
        okpo1,
        okpo2,
        s_arenda,
        s_nds,
        sd,
        keycount,
        prskidka,
        peny,
        datr2,
        mr2,
        mr,
        datr,
        addnd,
        amort_date,
        branch,
        kf,
        deal_created,
        imported,
        dat_close,
        rnk
from bars.skrynka_nd t;

comment on table bars_intgr.vw_ref_skrynka_nd is '�������� ������';
comment on column bars_intgr.vw_ref_skrynka_nd.ND is '����� ��������';
comment on column bars_intgr.vw_ref_skrynka_nd.N_SK is '����� �����';
comment on column bars_intgr.vw_ref_skrynka_nd.SOS is '������ �������� 15 - ������, 1 - �����������, 0 - ������';
comment on column bars_intgr.vw_ref_skrynka_nd.FIO is '���';
comment on column bars_intgr.vw_ref_skrynka_nd.DOKUM is '�������� (�������...)';
comment on column bars_intgr.vw_ref_skrynka_nd.ISSUED is '��� �����';
comment on column bars_intgr.vw_ref_skrynka_nd.ADRES is '�����';
comment on column bars_intgr.vw_ref_skrynka_nd.DAT_BEGIN is '���� ������ ��������';
comment on column bars_intgr.vw_ref_skrynka_nd.DAT_END is '���� ����� ��������';
comment on column bars_intgr.vw_ref_skrynka_nd.TEL is '�������';
comment on column bars_intgr.vw_ref_skrynka_nd.DOVER is '������������';
comment on column bars_intgr.vw_ref_skrynka_nd.NMK is '������������ ������� (������)';
comment on column bars_intgr.vw_ref_skrynka_nd.DOV_DAT1 is '���� ������ �������� ������������';
comment on column bars_intgr.vw_ref_skrynka_nd.DOV_DAT2 is '���� ����� �������� ������������';
comment on column bars_intgr.vw_ref_skrynka_nd.DOV_PASP is '';
comment on column bars_intgr.vw_ref_skrynka_nd.MFOK is '��� �������';
comment on column bars_intgr.vw_ref_skrynka_nd.NLSK is '��������� ���� �������';
comment on column bars_intgr.vw_ref_skrynka_nd.CUSTTYPE is '��� �������';
comment on column bars_intgr.vw_ref_skrynka_nd.O_SK is '��� ����� (������)';
comment on column bars_intgr.vw_ref_skrynka_nd.ISP_DOV is '��� ����������� - ����������� ���� �����';
comment on column bars_intgr.vw_ref_skrynka_nd.NDOV is '����� �����������';
comment on column bars_intgr.vw_ref_skrynka_nd.NLS is '���� �����';
comment on column bars_intgr.vw_ref_skrynka_nd.NDOC is '����� ������� (���������� ��� ������)';
comment on column bars_intgr.vw_ref_skrynka_nd.DOCDATE is '���� �������';
comment on column bars_intgr.vw_ref_skrynka_nd.SDOC is '����� ��������';
comment on column bars_intgr.vw_ref_skrynka_nd.TARIFF is '��� ������';
comment on column bars_intgr.vw_ref_skrynka_nd.FIO2 is '��� ��� ���� �������';
comment on column bars_intgr.vw_ref_skrynka_nd.ISSUED2 is '��� ����� ������� ��� ����';
comment on column bars_intgr.vw_ref_skrynka_nd.ADRES2 is '����� ����������� ����';
comment on column bars_intgr.vw_ref_skrynka_nd.PASP2 is '����� � ����� �������� ����������� ����';
comment on column bars_intgr.vw_ref_skrynka_nd.OKPO1 is '���� ������� (��� ����� ���)';
comment on column bars_intgr.vw_ref_skrynka_nd.OKPO2 is '���� ����������� ���� (��� ����� ���)';
comment on column bars_intgr.vw_ref_skrynka_nd.S_ARENDA is '����� ������';
comment on column bars_intgr.vw_ref_skrynka_nd.S_NDS is '����� ���';
comment on column bars_intgr.vw_ref_skrynka_nd.SD is '������� ����� ��� ������� ������ �������';
comment on column bars_intgr.vw_ref_skrynka_nd.KEYCOUNT is '���������� ������� ������� ������';
comment on column bars_intgr.vw_ref_skrynka_nd.PRSKIDKA is '������� ������';
comment on column bars_intgr.vw_ref_skrynka_nd.PENY is '������� ������ (+ � �������� ������)';
comment on column bars_intgr.vw_ref_skrynka_nd.DATR2 is '���� �������� ����������� ����';
comment on column bars_intgr.vw_ref_skrynka_nd.MR2 is '����� �������� ����������� ����';
comment on column bars_intgr.vw_ref_skrynka_nd.MR is '����� �������� ����������';
comment on column bars_intgr.vw_ref_skrynka_nd.DATR is '���� �������� ����������';
comment on column bars_intgr.vw_ref_skrynka_nd.ADDND is '������� ����� ��� ����������';
comment on column bars_intgr.vw_ref_skrynka_nd.AMORT_DATE is '';
comment on column bars_intgr.vw_ref_skrynka_nd.BRANCH is '��� ���������';
comment on column bars_intgr.vw_ref_skrynka_nd.KF is '��� �������';
comment on column bars_intgr.vw_ref_skrynka_nd.DEAL_CREATED is '';
comment on column bars_intgr.vw_ref_skrynka_nd.IMPORTED is '';
comment on column bars_intgr.vw_ref_skrynka_nd.DAT_CLOSE is '';
comment on column bars_intgr.vw_ref_skrynka_nd.RNK is 'RNK �������';