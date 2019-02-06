CREATE OR REPLACE VIEW V_1DF_CASH_BACK_DBF AS
SELECT t1.dat,
       to_number(TO_CHAR ((t1.dat) , 'Q')) PERIOD,
       to_number(TO_CHAR ((t1.dat) , 'YYYY')) RIK,
       (select id_a from oper where ref = t1.ref )  pKOD,
       0 TYP,
       t1.nls,
       case when t1.lvl = '1' -- якщо немає документу, вираховуємо суму як зворотнє перетрворення від податку
           then NVL(t1.base/100,round((t1.S_TAXN)/0.18,2))
         else NVL(t1.base/100,round((t1.S_TAXN)/0.015,2))
       end  as s_nar,
       case when t1.lvl = '1' -- якщо немає документу, вираховуємо суму як зворотнє перетрворення від податку
           then NVL(t1.base/100,round((t1.S_TAXN)/0.18,2))
         else NVL(t1.base/100,round((t1.S_TAXN)/0.015,2))
       end  as s_dox,
       t1.S_TAXN as s_taxn,
       t1.S_TAXN as s_taxp,
       '' D_PRIYN,
       '' D_ZVILN,
       0 OZN_PILG,
       126 OZNAKA,
       t1.lvl
  FROM ( SELECT o.fdat dat,
                a.nls,
                nvl(od.Sq,0)/100 S_TAXN,
                0 s_3522,
                CASE
                   WHEN a.ob22 ='23' THEN '1'
                   WHEN a.ob22 ='38' THEN '2'
                END
                   AS lvl,
                od.ref,
                od2.acc,
                od2.fdat,
                od2.kf,
                ( -- намагаємось знайти відповідний документ для суми податку
                 select (case --якщо не вдалося однозначно визначити док-т (більше двох записів), то повертаємо null
                           when INSTR(LISTAGG (od_.s,';') WITHIN GROUP (order by od_.s),';') > 0  then null
                           else LISTAGG (od_.s,';') WITHIN GROUP (order by od_.s)
                         end)
                  FROM bars.accounts a_, bars.saldoa o_, opldok od_, operw w_
                 WHERE     a_.acc = o_.acc
                           and a_.acc = od_.acc
                           and od_.fdat = o_.fdat
                           and od_.dk = 1
                           AND od_.tt like 'OW%'
                           AND o_.fdat in (od2.fdat,
                                           (select max(fdat) keep (DENSE_RANK last ORDER BY fdat) from fdat where fdat < od2.fdat)
                                          ) -- базові документи м.б. завантажені в попередній день
                           and od_.acc = od2.acc
                           and od_.kf = od2.kf
                           and od_.s >= (
                                         case
                                           when a.ob22 ='23' then od.Sq/0.18-100
                                           when a.ob22 ='38' then od.Sq/0.015-100
                                           else 9999
                                         end
                                        ) -- базові документи мають бути в межах зворотнього перетрворення від податку
                           and od_.s <= (
                                         case
                                           when a.ob22 ='23' then od.Sq/0.18+100
                                           when a.ob22 ='38' then od.Sq/0.015+100
                                           else 0
                                         end
                                         ) -- базові документи мають бути в межах зворотнього перетрворення від податку
                           and od_.ref = w_.ref
                           and w_.tag = 'OW_SC'
                           and w_.value = 'APA3' -- додатковий параметр, що  визначає ознаку для базових документів
                ) as base
           FROM bars.accounts a, bars.saldoa o, opldok od, opldok od2
          WHERE     a.acc = o.acc
                AND a.nbs = '3622'
                AND ob22 IN ('23', '38')
                AND od.tt like 'OW%'
                and a.acc = od.acc and od.fdat = o.fdat
                -- AND o.fdat BETWEEN (TO_DATE (:sFdat1, 'dd/mm/yyyy')) and (TO_DATE (:sFdat2, 'dd/mm/yyyy'))
                and od.ref = od2.ref
                and od2.dk = 0
          GROUP BY o.fdat,a.nls,a.ob22, od.ref, od.dk, od.sq, od2.acc, od2.fdat,od2.kf
      ) t1;
grant SELECT                                                                 on v_1df_cash_back_dbf       to BARSREADER_ROLE;
grant SELECT                                                                 on v_1df_cash_back_dbf       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on v_1df_cash_back_dbf       to START1;
