

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PAY_INTEREST_DEPOS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PAY_INTEREST_DEPOS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PAY_INTEREST_DEPOS ("TTB", "VOB", "NLS", "KV", "MFOB", "NLSB", "KVB", "DK", "SUMR", "ORIGINAL_AMOUNT", "NAMB", "NAZN", "ACC", "OKPO", "NMS", "NMK", "FLI", "SNLS", "ISP", "MAIN_ACCOUNT_NUMBER") AS 
  SELECT i.ttb,
            DECODE (
               a.kv,
               i.kvb, DECODE (i.mfob,
                              f_ourmfo_g, 6,
                              DECODE (SUBSTR (s.nls, 1, 1), '2', 1, 6)),
               16)
               vob,
            a.nls,
            a.kv,
            nvl(i.mfob, ra.kf),
            i.nlsb,
            i.kvb,
            CASE WHEN a.ostc < 0 THEN 0 ELSE 1 END AS dk,
            a.ostc / 100 sumr,
            a.ostc original_amount,
            nvl(i.namb, ra.nms),
            case when i.nazn is null then
                      'Виплата відсотків по рахунку ' || ma.nls
                 else i.nazn
            end,
            i.acc,
            NVL (i.okpo, k.okpo) okpo,
            a.nms,
            k.nmk,
            t.fli,
            s.nls snls,
            a.isp,                                                     --?
            ma.nls            
       FROM accounts a
            JOIN int_accN i ON i.acra = a.acc AND i.id = 1
            JOIN customer k ON k.rnk = a.rnk
            JOIN tts t ON t.tt = i.ttb
            JOIN saldo s ON s.acc = a.acc
            join accounts ma on ma.acc = i.acc
            left join accounts ra on RA.NLS = I.NLSB and RA.KV = a.kv and ra.kf = a.kf
      WHERE a.ostc > 0 AND a.ostc = a.ostb
   ORDER BY a.nls, a.kv;

PROMPT *** Create  grants  V_PAY_INTEREST_DEPOS ***
grant SELECT                                                                 on V_PAY_INTEREST_DEPOS to BARSREADER_ROLE;
grant SELECT                                                                 on V_PAY_INTEREST_DEPOS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PAY_INTEREST_DEPOS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PAY_INTEREST_DEPOS.sql =========*** E
PROMPT ===================================================================================== 
