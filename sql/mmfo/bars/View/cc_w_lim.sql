CREATE OR REPLACE VIEW CC_W_LIM2 AS
SELECT nd,
       fdat,
       otm,
       not_9129,
       lim2 / 100 lim2,
       sumg / 100 sumg,
       sump / 100 sump,
       sumk / 100 sumk,
       sumo / 100 sumo,
       sump1 / 100 sump1,
       fost_h(acc, fdat) / 100 ost,
       (sumo + sump1) / 100 sumo1,
       not_sn sn
  FROM (SELECT acc,
               nd,
               fdat,
               lim2,
               nvl(sumg, 0) sumg,
               nvl(sumo, 0) - nvl(sumg, 0) - nvl(sumk, 0) sump,
               nvl(sumk, 0) sumk,
               nvl(sumo, 0) sumo,
               0 sump1,
               nvl(otm, 0) otm,
               nvl(not_9129, 0) not_9129,
               not_sn
          FROM cc_lim
        UNION ALL
        SELECT a.acc, ad.nd, o.fdat, 0, 0, 0, 0, 0, o.s sump1, 0, 0, NULL
          FROM cc_add ad,
               opldok o,
               (SELECT * FROM accounts WHERE tip = 'SNO') a
         WHERE o.tt = 'GPP'
           AND ad.refp = o.ref
           AND o.dk = 1
           AND o.acc = a.acc);
