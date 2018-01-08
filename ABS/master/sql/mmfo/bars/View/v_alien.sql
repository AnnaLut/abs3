

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ALIEN.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ALIEN ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ALIEN ("MFO", "NLS", "NLSALT", "KV", "OKPO", "NAME", "CRISK", "NOTESEC") AS 
  select
x0.mfo ,
x0.nls ,
x0.nlsalt ,
x0.kv ,
x0.okpo ,
substr (x0.name, 1, 38),
x0.crisk,
x0.notesec from  alien x0
        where (x0.id = (select x1.id
                from  staff x1 where (upper(x1.logname) = USER)));

PROMPT *** Create  grants  V_ALIEN ***
grant SELECT                                                                 on V_ALIEN         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ALIEN         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ALIEN.sql =========*** End *** ======
PROMPT ===================================================================================== 
