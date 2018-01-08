--------------------------Вюшки-гляделки протокола
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_kwt_2924.sql ==========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create force view v_kwt_2924 ***

CREATE OR REPLACE FORCE VIEW bars.v_kwt_2924 as 
select aa.*,  tt.kol, ( SELECT SUBSTR (txt,1,100) FROM bars.sb_ob22 WHERE r020 = '2924' AND ob22 = aa.ob22) TXT 
FROM bars.kwt_a_2924 aa ,
    (select acc, count(*) kol from bars.kwt_t_2924  group by acc ) tt 
where aa.acc = tt.acc (+);
/

PROMPT *** Create  grants  v_kwt_2924 ***
grant DELETE, INSERT, SELECT, UPDATE ON  bars.v_kwt_2924    to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_kwt_2924.sql ==========*** End *** ==
PROMPT ===================================================================================== 




