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

comment on table bars_intgr.vw_ref_skrynka_nd is 'Договори оренди';
comment on column bars_intgr.vw_ref_skrynka_nd.ND is 'номер договора';
comment on column bars_intgr.vw_ref_skrynka_nd.N_SK is 'номер сейфа';
comment on column bars_intgr.vw_ref_skrynka_nd.SOS is 'статус договора 15 - закрыт, 1 - пролонгация, 0 - открыт';
comment on column bars_intgr.vw_ref_skrynka_nd.FIO is 'ФИО';
comment on column bars_intgr.vw_ref_skrynka_nd.DOKUM is 'документ (паспорт...)';
comment on column bars_intgr.vw_ref_skrynka_nd.ISSUED is 'кем выдан';
comment on column bars_intgr.vw_ref_skrynka_nd.ADRES is 'адрес';
comment on column bars_intgr.vw_ref_skrynka_nd.DAT_BEGIN is 'дата начала договора';
comment on column bars_intgr.vw_ref_skrynka_nd.DAT_END is 'дата конца договора';
comment on column bars_intgr.vw_ref_skrynka_nd.TEL is 'телефон';
comment on column bars_intgr.vw_ref_skrynka_nd.DOVER is 'доверенность';
comment on column bars_intgr.vw_ref_skrynka_nd.NMK is 'наименование клиента (юрлицо)';
comment on column bars_intgr.vw_ref_skrynka_nd.DOV_DAT1 is 'дата начала действия доверенности';
comment on column bars_intgr.vw_ref_skrynka_nd.DOV_DAT2 is 'дата конца действия доверенности';
comment on column bars_intgr.vw_ref_skrynka_nd.DOV_PASP is '';
comment on column bars_intgr.vw_ref_skrynka_nd.MFOK is 'МФО клиента';
comment on column bars_intgr.vw_ref_skrynka_nd.NLSK is 'расчетный счет клиента';
comment on column bars_intgr.vw_ref_skrynka_nd.CUSTTYPE is 'тип клиента';
comment on column bars_intgr.vw_ref_skrynka_nd.O_SK is 'тип сейфа (размер)';
comment on column bars_intgr.vw_ref_skrynka_nd.ISP_DOV is 'код исполнителя - доверенного лица банка';
comment on column bars_intgr.vw_ref_skrynka_nd.NDOV is 'номер доверености';
comment on column bars_intgr.vw_ref_skrynka_nd.NLS is 'счет сейфа';
comment on column bars_intgr.vw_ref_skrynka_nd.NDOC is 'номер договра (символьный для печати)';
comment on column bars_intgr.vw_ref_skrynka_nd.DOCDATE is 'дата договра';
comment on column bars_intgr.vw_ref_skrynka_nd.SDOC is 'сумма договора';
comment on column bars_intgr.vw_ref_skrynka_nd.TARIFF is 'код тарифа';
comment on column bars_intgr.vw_ref_skrynka_nd.FIO2 is 'ФИО дов лица клиента';
comment on column bars_intgr.vw_ref_skrynka_nd.ISSUED2 is 'кем выдан паспорт дов лица';
comment on column bars_intgr.vw_ref_skrynka_nd.ADRES2 is 'адрес доверенного лица';
comment on column bars_intgr.vw_ref_skrynka_nd.PASP2 is 'серия и номер паспорта доверенного лица';
comment on column bars_intgr.vw_ref_skrynka_nd.OKPO1 is 'окпо клиента (или идент код)';
comment on column bars_intgr.vw_ref_skrynka_nd.OKPO2 is 'окпо доверенного лица (или идент код)';
comment on column bars_intgr.vw_ref_skrynka_nd.S_ARENDA is 'сумма аренды';
comment on column bars_intgr.vw_ref_skrynka_nd.S_NDS is 'сумма НДС';
comment on column bars_intgr.vw_ref_skrynka_nd.SD is 'дневной тариф для расчета аренды частями';
comment on column bars_intgr.vw_ref_skrynka_nd.KEYCOUNT is 'количество выданых клиенту ключей';
comment on column bars_intgr.vw_ref_skrynka_nd.PRSKIDKA is 'процент скидки';
comment on column bars_intgr.vw_ref_skrynka_nd.PENY is 'процент штрафа (+ к дневному тарифу)';
comment on column bars_intgr.vw_ref_skrynka_nd.DATR2 is 'дата рождения доверенного лица';
comment on column bars_intgr.vw_ref_skrynka_nd.MR2 is 'место рождения доверенного лица';
comment on column bars_intgr.vw_ref_skrynka_nd.MR is 'место рождения арендатора';
comment on column bars_intgr.vw_ref_skrynka_nd.DATR is 'дата рождения арендатора';
comment on column bars_intgr.vw_ref_skrynka_nd.ADDND is 'текущий номер доп соглашения';
comment on column bars_intgr.vw_ref_skrynka_nd.AMORT_DATE is '';
comment on column bars_intgr.vw_ref_skrynka_nd.BRANCH is 'Код отделения';
comment on column bars_intgr.vw_ref_skrynka_nd.KF is 'Код филиала';
comment on column bars_intgr.vw_ref_skrynka_nd.DEAL_CREATED is '';
comment on column bars_intgr.vw_ref_skrynka_nd.IMPORTED is '';
comment on column bars_intgr.vw_ref_skrynka_nd.DAT_CLOSE is '';
comment on column bars_intgr.vw_ref_skrynka_nd.RNK is 'RNK клиента';