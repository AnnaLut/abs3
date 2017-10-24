

PROMPT =====================================================================================
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAY_DEALER_ACCEPT.sql =========*** Ru
PROMPT =====================================================================================


PROMPT *** Create  view V_ZAY_DEALER_ACCEPT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAY_DEALER_ACCEPT ("ID", "Z_TYPE", "STATE", "MFO", "MFO_NAME", "RNK", "NMK", "LCV", "LCV_CONV", "KURS_KL", "KURS_F", "S2S", "SQ", "CHANGE_TIME") AS
   SELECT z.id,
          DECODE (z.dk,
                  1, 'Купівля',
                  2, 'Продаж',
                  3, 'Конверсія купівля',
                  4, 'Конверсія продаж',
                  NULL)
             z_type,
          z.state,
          z.mfo,
          z.mfo_name,
          z.rnk,
          z.nmk,
          z.lcv,
          z.lcv_conv,
          z.kurs_kl,
          z.kurs_f,
          z.s2 / 100 s2s,
          z.sq,
          t.change_time
     FROM v_zay z,  zay_track t
    WHERE z.id = t.id
      AND z.sos >= 0.5
      AND z.vdate = bankdate
      AND t.old_sos = 0
      AND t.new_sos = 0.5;

PROMPT *** Create  grants  V_ZAY_DEALER_ACCEPT ***
grant SELECT                                                                 on V_ZAY_DEALER_ACCEPT to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_ZAY_DEALER_ACCEPT to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_ZAY_DEALER_ACCEPT to ZAY;



PROMPT =====================================================================================
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAY_DEALER_ACCEPT.sql =========*** En
PROMPT =====================================================================================
