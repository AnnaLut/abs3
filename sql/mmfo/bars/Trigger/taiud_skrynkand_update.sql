

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_SKRYNKAND_UPDATE.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_SKRYNKAND_UPDATE ***

CREATE OR REPLACE TRIGGER BARS.TAIUD_SKRYNKAND_UPDATE
-- version 1.1 29.11.2016
-- version 1.2 09.12.2016  V.Kharin
-- version 2.0 11.05.2017  V.Kharin
after insert or delete or update 
    ON BARS.SKRYNKA_ND
    for each row
/* !!! колонки БАЗОВОЇ таблиці, яких немає у ТРИГЕРІ :
  DAT_CLOSE, DEAL_CREATED, IMPORTED 
*/
declare

    l_rec SKRYNKA_ND_UPDATE%rowtype;

    procedure SAVE_CHANGES
    is
    begin

        if ( l_rec.CHGACTION = 3 )  -- delete
        then
            l_rec.nd         := :old.nd;        l_rec.n_sk         := :old.n_sk;      l_rec.sos := :old.sos;           l_rec.fio := :old.fio; 
            l_rec.adres      := :old.adres;     l_rec.dat_begin    := :old.dat_begin; l_rec.dat_end := :old.dat_end; 
            l_rec.tariff     := :old.tariff;    l_rec.branch       := :old.branch;    l_rec.o_sk := :old.o_sk; 
            l_rec.mfok       := :old.mfok;      l_rec.nlsk         := :old.nlsk;      l_rec.nls := :old.nls;           l_rec.ndoc := :old.ndoc; 
            l_rec.docdate    := :old.docdate;   l_rec.sdoc         := :old.sdoc;      l_rec.rnk := :old.rnk; 
            l_rec.kf         := :old.kf;
            l_rec.dokum      := :old.dokum;     l_rec.issued       := :old.issued;    l_rec.tel := :old.tel;           l_rec.dover := :old.dover;
            l_rec.nmk        := :old.nmk;       l_rec.dov_dat1     := :old.dov_dat1;  l_rec.dov_dat2 := :old.dov_dat2; l_rec.dov_pasp := :old.dov_pasp;
            l_rec.custtype   := :old.custtype;  l_rec.isp_dov      := :old.isp_dov;   l_rec.ndov := :old.ndov;         l_rec.fio2 := :old.fio2;
            l_rec.issued2    := :old.issued2;   l_rec.adres2       := :old.adres2;    l_rec.pasp2 := :old.pasp2;       l_rec.okpo1 := :old.okpo1;
            l_rec.okpo2      := :old.okpo2;     l_rec.s_arenda     := :old.s_arenda;  l_rec.s_nds := :old.s_nds;       l_rec.sd := :old.sd;
            l_rec.keycount   := :old.keycount;  l_rec.prskidka     := :old.prskidka;  l_rec.peny := :old.peny;         l_rec.datr2 := :old.datr2;
            l_rec.mr2        := :old.mr2;       l_rec.mr           := :old.mr;        l_rec.datr := :old.datr;         l_rec.addnd := :old.addnd;
            l_rec.amort_date := :old.amort_date;
        else
            l_rec.nd         := :new.nd;        l_rec.n_sk         := :new.n_sk;      l_rec.sos := :new.sos;           l_rec.fio := :new.fio; 
            l_rec.adres      := :new.adres;     l_rec.dat_begin    := :new.dat_begin; l_rec.dat_end := :new.dat_end; 
            l_rec.tariff     := :new.tariff;    l_rec.branch       := :new.branch;    l_rec.o_sk := :new.o_sk; 
            l_rec.mfok       := :new.mfok;      l_rec.nlsk         := :new.nlsk;      l_rec.nls := :new.nls;           l_rec.ndoc := :new.ndoc; 
            l_rec.docdate    := :new.docdate;   l_rec.sdoc         := :new.sdoc;      l_rec.rnk := :new.rnk; 
            l_rec.kf         := :new.kf;
            l_rec.dokum      := :new.dokum;     l_rec.issued       := :new.issued;    l_rec.tel := :new.tel;           l_rec.dover := :new.dover;
            l_rec.nmk        := :new.nmk;       l_rec.dov_dat1     := :new.dov_dat1;  l_rec.dov_dat2 := :new.dov_dat2; l_rec.dov_pasp := :new.dov_pasp;
            l_rec.custtype   := :new.custtype;  l_rec.isp_dov      := :new.isp_dov;   l_rec.ndov := :new.ndov;         l_rec.fio2 := :new.fio2;
            l_rec.issued2    := :new.issued2;   l_rec.adres2       := :new.adres2;    l_rec.pasp2 := :new.pasp2;       l_rec.okpo1 := :new.okpo1;
            l_rec.okpo2      := :new.okpo2;     l_rec.s_arenda     := :new.s_arenda;  l_rec.s_nds := :new.s_nds;       l_rec.sd := :new.sd;
            l_rec.keycount   := :new.keycount;  l_rec.prskidka     := :new.prskidka;  l_rec.peny := :new.peny;         l_rec.datr2 := :new.datr2;
            l_rec.mr2        := :new.mr2;       l_rec.mr           := :new.mr;        l_rec.datr := :new.datr;         l_rec.addnd := :new.addnd;
            l_rec.amort_date := :new.amort_date;
        end if;
        l_rec.idupd         := bars_sqnc.get_nextval('s_skrynka_nd_update', l_rec.kf);
        l_rec.effectdate    := coalesce(gl.bd, glb_bankdate);
        l_rec.global_bdate  := glb_bankdate;    -- sysdate
        l_rec.doneby        := user_name; --gl.aUID(NUMBER);    user_name(VARCHAR2);
        l_rec.chgdate       := sysdate;

        insert into BARS.SKRYNKA_ND_UPDATE values l_rec;

      end SAVE_CHANGES;

begin

  case
    when inserting
    then

      l_rec.CHGACTION := 1;
      SAVE_CHANGES;

    when deleting
    then

      l_rec.CHGACTION := 3;
      SAVE_CHANGES;

    when updating
    then

      case
        when (:old.nd <> :new.nd) or (:old.kf <> :new.kf)-- !!! analize changing PRIMARY KEY - columns
        then -- При зміні значеннь полів, що входять в PRIMARY KEY (для правильного відображення при вивантаженні даних до DWH)

          -- породжуємо в історії запис про видалення
          l_rec.CHGACTION := 3;
          SAVE_CHANGES;

          -- породжуємо в історії запис про вставку
          l_rec.CHGACTION := 1;
          SAVE_CHANGES;

        when ( 
                :old.n_sk <> :new.n_sk OR (:old.n_sk IS NULL AND :new.n_sk IS NOT NULL) OR (:old.n_sk IS NOT NULL AND :new.n_sk IS NULL)
                or :old.sos <> :new.sos OR (:old.sos IS NULL AND :new.sos IS NOT NULL) OR (:old.sos IS NOT NULL AND :new.sos IS NULL)
                or :old.fio <> :new.fio OR (:old.fio IS NULL AND :new.fio IS NOT NULL) OR (:old.fio IS NOT NULL AND :new.fio IS NULL)
                or :old.adres <> :new.adres OR (:old.adres IS NULL AND :new.adres IS NOT NULL) OR (:old.adres IS NOT NULL AND :new.adres IS NULL)
                or :old.dat_begin <> :new.dat_begin OR (:old.dat_begin IS NULL AND :new.dat_begin IS NOT NULL) OR (:old.dat_begin IS NOT NULL AND :new.dat_begin IS NULL)
                or :old.dat_end <> :new.dat_end OR (:old.dat_end IS NULL AND :new.dat_end IS NOT NULL) OR (:old.dat_end IS NOT NULL AND :new.dat_end IS NULL)
                or :old.tariff <> :new.tariff OR (:old.tariff IS NULL AND :new.tariff IS NOT NULL) OR (:old.tariff IS NOT NULL AND :new.tariff IS NULL)
                or :old.branch <> :new.branch OR (:old.branch IS NULL AND :new.branch IS NOT NULL) OR (:old.branch IS NOT NULL AND :new.branch IS NULL)
                or :old.o_sk <> :new.o_sk OR (:old.o_sk IS NULL AND :new.o_sk IS NOT NULL) OR (:old.o_sk IS NOT NULL AND :new.o_sk IS NULL)
                or :old.mfok <> :new.mfok OR (:old.mfok IS NULL AND :new.mfok IS NOT NULL) OR (:old.mfok IS NOT NULL AND :new.mfok IS NULL)
                or :old.nlsk <> :new.nlsk OR (:old.nlsk IS NULL AND :new.nlsk IS NOT NULL) OR (:old.nlsk IS NOT NULL AND :new.nlsk IS NULL)
                or :old.nls <> :new.nls OR (:old.nls IS NULL AND :new.nls IS NOT NULL) OR (:old.nls IS NOT NULL AND :new.nls IS NULL)
                or :old.ndoc <> :new.ndoc OR (:old.ndoc IS NULL AND :new.ndoc IS NOT NULL) OR (:old.ndoc IS NOT NULL AND :new.ndoc IS NULL)
                or :old.docdate <> :new.docdate OR (:old.docdate IS NULL AND :new.docdate IS NOT NULL) OR (:old.docdate IS NOT NULL AND :new.docdate IS NULL)
                or :old.sdoc <> :new.sdoc OR (:old.sdoc IS NULL AND :new.sdoc IS NOT NULL) OR (:old.sdoc IS NOT NULL AND :new.sdoc IS NULL)
                or :old.rnk <> :new.rnk OR (:old.rnk IS NULL AND :new.rnk IS NOT NULL) OR (:old.rnk IS NOT NULL AND :new.rnk IS NULL)
                or :old.dokum <> :new.dokum OR (:old.dokum IS NULL AND :new.dokum IS NOT NULL) OR (:old.dokum IS NOT NULL AND :new.dokum IS NULL)
                or :old.issued <> :new.issued OR (:old.issued IS NULL AND :new.issued IS NOT NULL) OR (:old.issued IS NOT NULL AND :new.issued IS NULL)
                or :old.tel <> :new.tel OR (:old.tel IS NULL AND :new.tel IS NOT NULL) OR (:old.tel IS NOT NULL AND :new.tel IS NULL)
                or :old.dover <> :new.dover OR (:old.dover IS NULL AND :new.dover IS NOT NULL) OR (:old.dover IS NOT NULL AND :new.dover IS NULL)
                or :old.nmk <> :new.nmk OR (:old.nmk IS NULL AND :new.nmk IS NOT NULL) OR (:old.nmk IS NOT NULL AND :new.nmk IS NULL)
                or :old.dov_dat1 <> :new.dov_dat1 OR (:old.dov_dat1 IS NULL AND :new.dov_dat1 IS NOT NULL) OR (:old.dov_dat1 IS NOT NULL AND :new.dov_dat1 IS NULL)
                or :old.dov_dat2 <> :new.dov_dat2 OR (:old.dov_dat2 IS NULL AND :new.dov_dat2 IS NOT NULL) OR (:old.dov_dat2 IS NOT NULL AND :new.dov_dat2 IS NULL)
                or :old.dov_pasp <> :new.dov_pasp OR (:old.dov_pasp IS NULL AND :new.dov_pasp IS NOT NULL) OR (:old.dov_pasp IS NOT NULL AND :new.dov_pasp IS NULL)
                or :old.custtype <> :new.custtype OR (:old.custtype IS NULL AND :new.custtype IS NOT NULL) OR (:old.custtype IS NOT NULL AND :new.custtype IS NULL)
                or :old.isp_dov <> :new.isp_dov OR (:old.isp_dov IS NULL AND :new.isp_dov IS NOT NULL) OR (:old.isp_dov IS NOT NULL AND :new.isp_dov IS NULL)
                or :old.ndov <> :new.ndov OR (:old.ndov IS NULL AND :new.ndov IS NOT NULL) OR (:old.ndov IS NOT NULL AND :new.ndov IS NULL)
                or :old.fio2 <> :new.fio2 OR (:old.fio2 IS NULL AND :new.fio2 IS NOT NULL) OR (:old.fio2 IS NOT NULL AND :new.fio2 IS NULL)
                or :old.issued2 <> :new.issued2 OR (:old.issued2 IS NULL AND :new.issued2 IS NOT NULL) OR (:old.issued2 IS NOT NULL AND :new.issued2 IS NULL)
                or :old.adres2 <> :new.adres2 OR (:old.adres2 IS NULL AND :new.adres2 IS NOT NULL) OR (:old.adres2 IS NOT NULL AND :new.adres2 IS NULL)
                or :old.pasp2 <> :new.pasp2 OR (:old.pasp2 IS NULL AND :new.pasp2 IS NOT NULL) OR (:old.pasp2 IS NOT NULL AND :new.pasp2 IS NULL)
                or :old.okpo1 <> :new.okpo1 OR (:old.okpo1 IS NULL AND :new.okpo1 IS NOT NULL) OR (:old.okpo1 IS NOT NULL AND :new.okpo1 IS NULL)
                or :old.okpo2 <> :new.okpo2 OR (:old.okpo2 IS NULL AND :new.okpo2 IS NOT NULL) OR (:old.okpo2 IS NOT NULL AND :new.okpo2 IS NULL)
                or :old.s_arenda <> :new.s_arenda OR (:old.s_arenda IS NULL AND :new.s_arenda IS NOT NULL) OR (:old.s_arenda IS NOT NULL AND :new.s_arenda IS NULL)
                or :old.s_nds <> :new.s_nds OR (:old.s_nds IS NULL AND :new.s_nds IS NOT NULL) OR (:old.s_nds IS NOT NULL AND :new.s_nds IS NULL)
                or :old.sd <> :new.sd OR (:old.sd IS NULL AND :new.sd IS NOT NULL) OR (:old.sd IS NOT NULL AND :new.sd IS NULL)
                or :old.keycount <> :new.keycount OR (:old.keycount IS NULL AND :new.keycount IS NOT NULL) OR (:old.keycount IS NOT NULL AND :new.keycount IS NULL)
                or :old.prskidka <> :new.prskidka OR (:old.prskidka IS NULL AND :new.prskidka IS NOT NULL) OR (:old.prskidka IS NOT NULL AND :new.prskidka IS NULL)
                or :old.peny <> :new.peny OR (:old.peny IS NULL AND :new.peny IS NOT NULL) OR (:old.peny IS NOT NULL AND :new.peny IS NULL)
                or :old.datr2 <> :new.datr2 OR (:old.datr2 IS NULL AND :new.datr2 IS NOT NULL) OR (:old.datr2 IS NOT NULL AND :new.datr2 IS NULL)
                or :old.mr2 <> :new.mr2 OR (:old.mr2 IS NULL AND :new.mr2 IS NOT NULL) OR (:old.mr2 IS NOT NULL AND :new.mr2 IS NULL)
                or :old.mr <> :new.mr OR (:old.mr IS NULL AND :new.mr IS NOT NULL) OR (:old.mr IS NOT NULL AND :new.mr IS NULL)
                or :old.datr <> :new.datr OR (:old.datr IS NULL AND :new.datr IS NOT NULL) OR (:old.datr IS NOT NULL AND :new.datr IS NULL)
                or :old.addnd <> :new.addnd OR (:old.addnd IS NULL AND :new.addnd IS NOT NULL) OR (:old.addnd IS NOT NULL AND :new.addnd IS NULL)
                or :old.amort_date <> :new.amort_date OR (:old.amort_date IS NULL AND :new.amort_date IS NOT NULL) OR (:old.amort_date IS NOT NULL AND :new.amort_date IS NULL)
        )
        then -- При зміні значеннь полів, що НЕ входять в PRIMARY KEY
          -- протоколюємо внесені зміни
          l_rec.CHGACTION := 2;
          SAVE_CHANGES;

        else
          Null;
      end case;

    else
      null;
  end case;

end TAIUD_SKRYNKAND_UPDATE;
/
ALTER TRIGGER BARS.TAIUD_SKRYNKAND_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_SKRYNKAND_UPDATE.sql =========
PROMPT ===================================================================================== 
