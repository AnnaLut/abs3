

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INFLATION_SALDOA.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INFLATION_SALDOA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INFLATION_SALDOA ("ACC", "FDAT", "OSTF", "DOS", "KOS") AS 
  select  acc,
          FDAT,
--          -(dos-kos+sum(decode(fdat,fv,ostf_orig,0) -dos+kos)  over ( partition by acc  order by fdat asc range unbounded preceding))/100 OSTF,
          -(dos-kos+sum(decode(fdat,fv,ostf_orig,0) -dos+kos)  over ( partition by acc  order by fdat asc range unbounded preceding))/100 OSTF,
          DOS/100,
          KOS/100
         FROM
         (
           select FIRST_VALUE(fdat) OVER (partition by acc order by fdat ) fv , acc, FDAT, OSTF OSTF_orig, DOS, KOS
           FROM
           (
              select    acc, FDAT, OSTF, DOS, KOS from tmp_inflation_saldoa
              union
              select    acc, FDAT, OSTF, DOS, KOS from saldoa a where not exists (select 1 from tmp_inflation_saldoa t where t.acc=a.acc and t.fdat=a.fdat )
          )
);

PROMPT *** Create  grants  V_INFLATION_SALDOA ***
grant SELECT                                                                 on V_INFLATION_SALDOA to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_INFLATION_SALDOA to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_INFLATION_SALDOA to RCC_DEAL;
grant SELECT                                                                 on V_INFLATION_SALDOA to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INFLATION_SALDOA.sql =========*** End
PROMPT ===================================================================================== 
