

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_PRICES.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_PRICES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_PRICES ("ID", "CP_ID", "KV", "DATP", "RATE", "VIDD", "CENA", "N1", "B1", "CENP", "KOL", "CENS") AS 
  with t_date as (select nvl(to_date(bars.pul.get('cp_v_date'),'dd.mm.yyyy'),gl.bd) dat from dual)
    select ID,
        CP_ID,
        KV,
        DATP,
        RATE,
        VIDD,
        CENA,
        abs(N1) N1,
        B1,
        case when nvl(N1,0) != 0 then  round(B1 * CENA/N1, 6) else null end CENP,
        case when nvl(CENA,0) != 0 then round(-N/CENA,6) else null end  KOL,
        case when nvl(N,0) != 0 then round((N - D + P + R + R2 + R3 + UNREC)*CENA/N,6) else null end CENS
        from
        (SELECT CP_KOD.ID,
         CP_KOD.cp_id,
         CP_KOD.kv,
         CP_KOD.datp,
         CP_KOD.IR RATE,
         SUBSTR (a0.nls, 1, 4) VIDD,
         CP_KOD.CENA,
         SUM (h.N) / 100 N1,
         SUM (h.sumb) / 100 B1,
         (SELECT nvl(sum(s.ostf-s.dos+s.kos),0)/100
            FROM saldoa s, cp_deal d, accounts a
           WHERE d.id = CP_KOD.ID
             and d.acc = s.acc
             and d.acc is not null
             and a.acc = d.acc
             and substr(a.nls,1,4) = SUBSTR (a0.nls, 1, 4)
             and (s.acc,s.fdat) = (select acc , max(fdat) from saldoa where acc=d.acc and fdat<=t.dat group by acc)) N,
          (SELECT nvl(sum(s.ostf-s.dos+s.kos),0)/100
            FROM saldoa s, cp_deal d, accounts a
           WHERE d.id = CP_KOD.ID
             and d.accd = s.acc
             and d.accd is not null
             and a.acc = d.acc
             and substr(a.nls,1,4) = SUBSTR (a0.nls, 1, 4)
             and (s.acc,s.fdat) = (select acc , max(fdat) from saldoa where acc=d.acc and fdat<=t.dat group by acc)) D,
         (SELECT nvl(sum(s.ostf-s.dos+s.kos),0)/100
            FROM saldoa s, cp_deal d, accounts a
           WHERE d.id = CP_KOD.ID
             and d.accP = s.acc
             and d.accP is not null
             and a.acc=d.acc
             and substr(a.nls,1,4) = SUBSTR (a0.nls, 1, 4)
             and (s.acc,s.fdat)=(select acc,max(fdat) from saldoa where acc=d.accP and fdat<=t.dat group by acc)) P,
         (SELECT nvl(sum(s.ostf-s.dos+s.kos),0)/100
            FROM saldoa s, cp_deal d, accounts a
           WHERE d.id = CP_KOD.ID
             and d.accR = s.acc
             and d.accR is not null
             and a.acc = d.acc
             and substr(a.nls,1,4) = substr(a0.nls,1,4)
             and (s.acc,s.fdat) = (select acc,max(fdat) from saldoa where acc=d.accR and fdat<=t.dat group by acc)) R,
         (SELECT nvl(sum(s.ostf-s.dos+s.kos),0)/100
            FROM saldoa s, cp_deal d, accounts a
           WHERE d.id = CP_KOD.ID
             and d.accR2 = s.acc
             and d.accR2 is not null
             and a.acc = d.acc
             and substr(a.nls,1,4) = substr(a0.nls,1,4)
             and (s.acc,s.fdat) = (select acc,max(fdat) from saldoa where acc=d.accR2 and fdat<=t.dat group by acc)) R2,
         (SELECT nvl(sum(s.ostf-s.dos+s.kos),0)/100
            FROM saldoa s, cp_deal d, accounts a
           WHERE d.id = CP_KOD.ID
             and d.accR3 = s.acc
             and d.accR3 is not null
             and a.acc = d.acc
             and substr(a.nls,1,4) = substr(a0.nls,1,4)
             and (s.acc,s.fdat) = (select acc,max(fdat) from saldoa where acc=d.accR2 and fdat<=t.dat group by acc)) R3,
         (SELECT nvl(sum(s.ostf-s.dos+s.kos),0)/100
            FROM saldoa s, cp_deal d, accounts a
           WHERE d.id = CP_KOD.ID
             and d.ACCUNREC = s.acc
             and d.ACCUNREC is not null
             and a.acc = d.acc
             and substr(a.nls,1,4) = substr(a0.nls,1,4)
             and (s.acc,s.fdat) = (select acc,max(fdat) from saldoa where acc=d.accR2 and fdat<=t.dat group by acc)) UNREC
    FROM cp_deal D,
         CP_KOD,
         cp_arch H,
         accounts a0,
         t_date t
   WHERE     CP_KOD.id = d.id
         AND CP_KOD.tip = 1
         AND d.acc = a0.acc
         AND d.REF = h.REF
GROUP BY CP_KOD.ID,
         CP_KOD.cp_id,
         CP_KOD.kv,
         CP_KOD.datp,
         CP_KOD.IR,
         SUBSTR (a0.nls, 1, 4),
         CP_KOD.CENA
ORDER BY CP_KOD.DATP);

PROMPT *** Create  grants  V_CP_PRICES ***
grant SELECT                                                                 on V_CP_PRICES     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_PRICES.sql =========*** End *** ==
PROMPT ===================================================================================== 
