CREATE OR REPLACE FORCE VIEW BARS.V_ZAY_DEALER_ACCEPT
AS
   SELECT id,
          DECODE (dk,
                  1, 'Купівля',
                  2, 'Продаж',
                  3, 'Конверсія купівля',
                  4, 'Конверсія продаж',
                  NULL)
             z_type,
          state,
          mfo,
          mfo_name,
          rnk,
          nmk,
          lcv,
          lcv_conv,
          kurs_kl,
          kurs_f,
          s2 / 100 s2s,
          sq
     FROM v_zay
    WHERE viza >= 0.5 AND sos = 1 AND vdate = bankdate;
    
SHOW ERRORS;

CREATE OR REPLACE PUBLIC SYNONYM V_ZAY_DEALER_ACCEPT FOR BARS.V_ZAY_DEALER_ACCEPT;

GRANT SELECT ON BARS.V_ZAY_DEALER_ACCEPT TO BARS_ACCESS_DEFROLE;

GRANT DELETE, INSERT, SELECT, UPDATE, FLASHBACK ON BARS.V_ZAY_DEALER_ACCEPT TO WR_ALL_RIGHTS;

GRANT SELECT ON BARS.V_ZAY_DEALER_ACCEPT TO ZAY;
