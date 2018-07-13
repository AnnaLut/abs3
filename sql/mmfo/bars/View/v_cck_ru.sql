CREATE OR REPLACE VIEW V_CCK_RU AS
SELECT x.nd,
        x.ndi,
        x.ndg,
        (SELECT COUNT(*)
           FROM nd_acc n, accounts a
          WHERE n.nd = x.nd
            AND n.acc = a.acc
            AND a.tip = 'SS ') SS0,
        (SELECT COUNT(*)
           FROM cc_deal
          WHERE ndg = x.nd
            AND nd <> ndg
            and sos < 14) nd0,
        x.vidd,
        x.prod,
        x.isp,
        x.cc_id,
        x.rnk,
        x.kv,
        x.s,
        x.gpk,
        x.dsdate,
        x.dwdate,
        x.pr,
        x.ostc,
        x.sos,
        x.namk,
        x.acc8,
        x.dazs,
        x.branch,
        x.custtype,
        x.sdog,
        CASE
          WHEN vidd IN (2, 3) AND pr_tr = '1' THEN
           1
          ELSE
           0
        END tr,
        x.vidd_name,
        x.sos_name,
        x.daysn,
        x.freq,
        x.freqp,
        x.opl_date,
        x.opl_day,
        x.i_cr9
       ,coalesce(x.accc,0) accc
			 ,basey_name
			 ,basem
FROM (SELECT d.nd,
                d.ndi,
                d.ndg,
                d.vidd,
                d.prod,
                d.user_id isp,
                d.cc_id,
                d.rnk,
                a8.kv,
                d.LIMIT s,
                a8.vid gpk,
                d.sdate dsdate,
                d.wdate dwdate,
                acrn.fprocn(a8.acc, 0, gl.bd) pr,
                -a8.ostc / 100 ostc,
                case when d.nd in (select ndg from bars.cc_deal cd
                                              where cd.sos = 13)
                then 13
                else d.sos end sos, 
                c.nmk namk,
                a8.acc acc8,
                a8.dazs,
                d.branch,
                DECODE(d.vidd, 1, 2, 2, 2, 3, 2, 3) custtype,
                d.sdog,
                vid.name vidd_name,
                case when d.nd in (select ndg from bars.cc_deal cd
							                 where cd.sos = 13)
				then 'Проcрочен субдоговор'
				else sos.name end sos_name,
                ia.apl_dat opl_date,
                ia.s opl_day,
                (SELECT txt
                   FROM bars.nd_txt
                  WHERE nd = d.nd
                    AND tag = 'PR_TR') pr_tr,
                (SELECT txt
                   FROM bars.nd_txt
                  WHERE nd = d.nd
                    AND tag = 'DAYSN') daysn,
                (SELECT fr.name
                   FROM bars.nd_txt t, bars.freq fr
                  WHERE t.txt = fr.freq
                    AND nd = d.nd
                    AND t.tag = 'FREQP') freqp,
                (SELECT fr.name
                   FROM bars.nd_txt t, bars.freq fr
                  WHERE t.txt = fr.freq
                    AND nd = d.nd
                    AND t.tag = 'FREQ') freq,
                (SELECT DECODE(t.txt, 1, 'Не', '') || 'Відновлювана'
                   FROM nd_txt t
                  WHERE nd = d.nd
                    AND t.tag = 'I_CR9') i_cr9
								,(SELECT CASE WHEN nt.txt IS NULL THEN 0 ELSE 1 END
                   FROM bars.nd_txt nt
                  WHERE nt.nd = d.nd
                   AND nt.tag = 'ACC_VAL'
                   AND nt.kf =  d.kf ) accc
								,(select name from basey b where b.basey = ia.basem) basey_name
								,CASE WHEN ia.basey = 2 AND ia.basem = 1 AND ia.id = 0 THEN 'Старий ануїтет'
								      WHEN ia.basey = 2 AND ia.basem = 0 AND ia.id = 0 THEN 'Новий ануїтет'
											ELSE 'Класичний' 
								 END  basem 
           FROM (SELECT *
                   FROM bars.cc_deal
                  WHERE vidd IN (1, 2, 3)
                    AND sos > 0
                    AND sos < 14
                    AND nd = NVL(ndg, nd)) D,
                (select *
                   from bars.accounts
                  where tip = 'LIM'
                    and dazs is null) a8,
                bars.customer c,
                bars.nd_acc n,
                bars.cc_vidd vid,
                bars.cc_sos sos,
                bars.int_accn ia
          WHERE n.nd = d.nd
            AND d.vidd = vid.vidd
            AND d.sos = sos.sos
            AND c.rnk = d.rnk
            AND c.rnk = a8.rnk
            AND ia.acc = a8.acc
            AND ia.id = 0
            AND n.acc = a8.acc) x;

