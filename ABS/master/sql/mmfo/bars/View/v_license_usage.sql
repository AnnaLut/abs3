

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_LICENSE_USAGE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_LICENSE_USAGE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_LICENSE_USAGE ("LICENSE_EXPIRED", "LIMIT_ACCOUNT", "PERM_ACCOUNT", "TEMP_ACCOUNT") AS 
  select l.expired, l.lim, s.perm, s.temp
  from (select sum(decode(expired, null, 1, 0)) perm,
               sum(decode(expired, null, 0, 1)) temp
          from staff$base
         where active = 1
           and logname not in ('BARS', 'HIST', 'FINMON')) s,
       (select max(decode(par, 'EXPDATE', to_date(val, 'dd/mm/yyyy'))) expired,
               max(decode(par, 'USRLIMIT', to_number(val))) lim
          from params
         where par in ('USRLIMIT', 'EXPDATE')) l
 ;

PROMPT *** Create  grants  V_LICENSE_USAGE ***
grant SELECT                                                                 on V_LICENSE_USAGE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_LICENSE_USAGE to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_LICENSE_USAGE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_LICENSE_USAGE.sql =========*** End **
PROMPT ===================================================================================== 
