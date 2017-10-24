CREATE OR REPLACE FORCE VIEW BARS.V_RESID_PARTNERS
(
   RNK,
   NMK,
   NMKK,
   MFO,
   BIC,
   NUM_ND,
   OKPO,
   KOD_B,
   LIM,
   DAT_ND,
   NB,
   BKI
)
AS
     SELECT c.rnk,
            c.nmk,
            c.nmkk,
            u.mfo,
            u.bic,
            u.num_nd,
            c.okpo,
            u.kod_b,
            c.lim / 100 lim,
            u.dat_nd,
            b.nb,
            u.bki
       FROM customer c, custbank u, banks b
      WHERE     c.date_off IS NULL
            AND c.rnk = u.rnk
            AND c.codcagent = 1
            AND c.okpo <> f_ourokpo
            AND u.mfo <> f_ourmfo
            AND u.mfo = b.mfo
            AND c.kf = SYS_CONTEXT ('bars_context', 'user_mfo')
   ORDER BY u.mfo, c.rnk;

COMMENT ON TABLE BARS.V_RESID_PARTNERS IS 'МБДК: Партнери-Резиденти';

COMMENT ON COLUMN BARS.V_RESID_PARTNERS.RNK IS 'Рнк';

COMMENT ON COLUMN BARS.V_RESID_PARTNERS.NMK IS 'Назва';

COMMENT ON COLUMN BARS.V_RESID_PARTNERS.NMKK IS 'Назва скорочена';

COMMENT ON COLUMN BARS.V_RESID_PARTNERS.MFO IS 'МФО';

COMMENT ON COLUMN BARS.V_RESID_PARTNERS.BIC IS 'BIC-код';

COMMENT ON COLUMN BARS.V_RESID_PARTNERS.NUM_ND IS '№ ГЕН. угоди';

COMMENT ON COLUMN BARS.V_RESID_PARTNERS.OKPO IS 'ЗКПО';

COMMENT ON COLUMN BARS.V_RESID_PARTNERS.KOD_B IS '1_ПБ';

COMMENT ON COLUMN BARS.V_RESID_PARTNERS.LIM IS 'Ліміт';

COMMENT ON COLUMN BARS.V_RESID_PARTNERS.DAT_ND IS 'Дата ГЕН. угоди';

COMMENT ON COLUMN BARS.V_RESID_PARTNERS.NB IS 'Назва банку по S_USH';

COMMENT ON COLUMN BARS.V_RESID_PARTNERS.BKI IS 'Ознака~передачі ПВБКІ ';


GRANT SELECT ON BARS.V_RESID_PARTNERS TO BARS_ACCESS_DEFROLE;
