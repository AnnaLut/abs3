

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NRU_NLS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NRU_NLS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NRU_NLS ("BUSSL", "BUS", "BLKD", "BLK", "RNK", "OKPO", "NMK", "ADR", "TEL", "NLS", "KV", "DAPP", "OST", "KOL", "ZDAT", "ACC", "NBS", "BRANCH", "PRIM", "OK", "SERR") AS 
  select x.bussl,
          substr ( (select name from cust_business_line where id = x.bussl), 1, 25 ) as bus,
          x.blkd,
          substr ( (select name from rang where rang = x.blkd), 1, 25 ) as blk,
          x.rnk,
          x.okpo,
          x.nmk,
          x.adr,
          x.tel,
          x.nls,
          x.kv,
          x.dapp,
          x.ost,
          x.kol,
          x.zdat,
          x.acc,
          x.nbs,
          x.branch,
          case
             when x.blkd > 0
             then
                'Блоковано, необхідна додаткова перевірка рахунку'
             when x.kol > 0
             then
                'Пов`язані, необхідна додаткова перевірка рахунку'
             when x.nbs in ('2605', '2604')
             then
                '2605/2604, необхідна додаткова перевірка рахунку'
             else
                null -- в полі «Примітка» автоматично зазначається повідомлення «Увага, необхідна додаткова перевірка рахунку»,
          end
             prim, -- якщо наявне значення блокування, пов’язаності на рахунку або балансовий рахунок є 2605, 2604.
          x.accn / x.accn as ok,
          x.serr
     -- виконати перенесення на "НЕРУХОМІ"
     from (select a.acc,
                  d.zdat, -- 00 звітна дата
                  n.serr,
                  n.acc as accn,
                  to_number ( (select value from customerw where rnk = c.rnk and tag = 'BUSSL')) bussl, -- 01 Бізнес напрямок
                  c.rnk, -- 02 РНК
                  c.okpo, -- 03 ЄДРПОУ/ІПН
                  c.nmk, -- 04 Назва
                  c.adr, -- 05 Адреса клієнта
                  p.telr || ',' || p.telb tel, -- 06 Контактні телефони клієнта
                  a.nls, -- 07 № рахунку
                  a.nbs,
                  a.branch,
                  a.kv, -- 08 Вал
                  nvl (a.dapp, a.daos) as dapp, -- 09 Дата остан.руху
                  fost (a.acc, d.zdat) / 100 as ost, -- 10 Зал на дату
                  decode (a.blkd, 0, null, a.blkd) as blkd, -- 11 Статус/значення наявного блокування поточного рахунку
                  (select count (*) - 1 from accounts where rnk = c.rnk and dazs is null and nbs > '2' and nbs < '4') as kol -- 12 Наявність  пов’язаних рахунків до поточного рахунку
             from accounts a,
                  nru_bal b,
                  customer c,
                  corps p,
                  nru_ok n,
                  (select to_date (pul.get ('DAT'), 'dd.mm.yyyy') zdat from dual) d
            where     c.rnk = a.rnk
                  and a.nbs = b.nbs
                  and a.ob22 = decode (a.nbs, '2650', b.ob22, a.ob22)
                  and a.dazs is null
                  and c.rnk = p.rnk(+)
                  and nvl (a.dapp, a.daos) <= add_months (d.zdat, -36)
                  and a.acc = n.acc(+)) x;

PROMPT *** Create  grants  V_NRU_NLS ***
grant SELECT                                                                 on V_NRU_NLS       to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NRU_NLS.sql =========*** End *** ====
PROMPT ===================================================================================== 
