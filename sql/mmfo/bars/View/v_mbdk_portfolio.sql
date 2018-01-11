

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBDK_PORTFOLIO.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBDK_PORTFOLIO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBDK_PORTFOLIO ("USER_NAME", "OSTC", "OSTB", "OSTF", "KV", "NLS", "DDATE", "ZDATE", "SDATE", "WDATE", "RNK", "OKPO", "NMK", "CC_ID", "ND", "ACC", "LIMIT", "SROK", "OST_SROK", "VIDD", "TIPD", "KPROLOG", "BIC", "SWI_REF", "SWO_REF", "NLS_N", "RATN", "IRR", "MDATE_N", "OSTCN", "OSTBN", "OSTFN", "ACR_DAT", "MFOKRED", "ACCKRED", "MFOPERC", "ACCPERC", "S_1819", "BUH", "RAH", "PROSTR", "GPK", "REPO", "ZAL", "ZAL1", "CODE_PRODUCT", "NAME_PRODUCT", "NBS", "OB22", "N_NBU", "D_NBU") AS 
  SELECT user_utl.get_user_name(m.userid) user_name,                      -- isp
       m.ostc / POWER (10, 2) ostc,                             -- ost body
       m.ostb / POWER (10, 2) ostb,                         -- план по тілу
       m.ostf / POWER (10, 2) ostf,                    -- майбутній по тілу
       m.kv,                                                      -- валюта
       m.nls,                                               -- рахунок тіла
       m.ddate,                                          -- дата заключення
       m.zdate,                                             -- дата початку
       m.sdate,                                              --Дата виплати
       m.wdate,                                          -- Дата закінчення
       m.rnk,                                                        -- РНК
       m.okpo,                                                    -- ЄДРПОУ
       SUBSTR (m.nmk, 1, 38) nmk,                            --Найменування
       m.cc_id,                                             -- Номер тікета
       m.nd,                                              -- Референс угоди
       m.acc,                                                            --
       m.LIMIT,                                               -- Сума угоди
       m.srok,                                                    -- Термін
       m.wdate - gl.bd ost_srok,
       m.vidd,                                                 -- Вид угоди
       m.tipd,                                            -- 1 розм 2 залуч
       m.kprolog,                                                        --
       m.bic,                                                        -- BIC
       m.swi_ref,                                   --Реф вхіднохо повідомл
       m.swo_ref,                                          -- Реф вихідного
       m.nls_n,                                               -- Рахунок %%
       acrN.fprocN (m.acc, m.dk, bankdate) ratn,                --%% ставка
       m.IRR ,                                               --еф.%% ставка
       m.mdate_n,                                      -- Дата погашення %%
       m.ostc_n / POWER (10, 2) ostcn,                        -- Залишок %%
       m.ostb_n / POWER (10, 2) ostbn,
       m.ostf_n / POWER (10, 2) ostfn,
       m.acr_dat,                                   -- Дата по яку нарах %%
       m.mfokred,                                      -- ЬФО партнера ТІЛО
       m.acckred,                                  -- Рахунок партнера тіло
       m.mfoperc,                                                 -- ДЛЯ %%
       m.accperc,
       m.nls_1819 S_1819,
       'Перегляд' BUH,
       'Перегляд' RAH,
       'Перегляд' PROSTR,
       'Перегляд' GPK,
       'Перегляд' REPO,
       'zal' zal,
       case when (select count(*) from cc_accp p where p.accs = m.acc) = 0 then 0 else 1 end ZAL1,
       CODE_PRODUCT,
       NAME_PRODUCT,
       NBS,
       OB22,
       N_NBU,
       D_NBU
FROM   mbd_k m
ORDER BY m.nd DESC;

PROMPT *** Create  grants  V_MBDK_PORTFOLIO ***
grant SELECT                                                                 on V_MBDK_PORTFOLIO to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_MBDK_PORTFOLIO to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_MBDK_PORTFOLIO to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBDK_PORTFOLIO.sql =========*** End *
PROMPT ===================================================================================== 
