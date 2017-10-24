

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CP_LEVELS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CP_LEVELS ***

  CREATE OR REPLACE PROCEDURE BARS.P_CP_LEVELS (p_date_start date, p_date_finish date)
is
begin
 execute immediate 'truncate table CP_HIERARCHY_LEVELS'; 
 for h_levels in (select id from cp_hierarchy)
     loop
     insert into CP_HIERARCHY_LEVELS (ID, TITLE, FIGURE, VALUE)
     WITH descript AS (select rownum RN, value
                        from((  SELECT 'Балансова вартість на початок періода' v0,
                                       'Всього доходів та витрат:' v1,
                                       '    -в прибутках чи збитках:' v2,
                                       '          процентні доходи' v3,
                                       '          торговий результат' v4,
                                       '          резерв' v5,
                                       '    -в іншому сукупному доході( чиста зміна справедливої вартості)' v6,
                                       '        Сплата купонного доходу' v7,
                                       '        Придбання' v8,
                                       '        Продаж' v9,
                                       '        Погашення' v10,
                                       '        Викуп' v11,
                                       '    Рекласифікація з Рівня '||to_char(h_levels.id)||' в інші рівні' v12,
                                       '    Рекласифікація з інших рівнів у Рівень '||to_char(h_levels.id) v13,
                                       'Балансова вартість на кінець періода' v14
                                  FROM DUAL)
                            unpivot
                            ( value
                                for value_type in
                                    (v0, v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11,v12,v13,v14))
                        )),
         valueset as
         (select rownum RN, value
            from((  SELECT  HIERARCHY_REP,                         
                           to_char(SUM(case when HIERARCHY_REP = h1 and DATE_START = p_date_start then nvl(BV,0) else 0 end)) v0,
                           ' ' as v1,
                           to_char(SUM(nvl(R_INT,0)) + SUM(nvl(TR,0)) + SUM(nvl(RESERVED,0))) AS v2,
                           to_char(SUM(nvl(R_INT,0))) v3,
                           to_char(SUM(nvl(TR,0))) v4,
                           to_char(SUM(nvl(RESERVED,0))) v5,
                           to_char(SUM(nvl(OVERPRICED,0))) v6,
                           to_char(SUM(nvl(R_PAY,0))) v7,
                           to_char(SUM(nvl(BOUGHT,0))) v8,
                           to_char(SUM(nvl(SOLD,0)))  v9,
                           to_char(SUM(nvl(SETTLED,0)))  v10,
                           to_char(SUM(nvl(RANSOM,0)))  v11,
                            to_char(concatstr(case when (HIERARCHY_REP = h_levels.id and h1 = HIERARCHY_REP and DATE_FINISH != p_date_finish) then nvl(f_cp_get_bvondate(id, 'BV', DATE_FINISH+1),0)
                                                  when (h1 = h_levels.id and h2 != h_levels.id and HIERARCHY_REP = h_levels.id) then nvl(BV_END,0)                                                  
                                                  when (h1 = h_levels.id and h2 = h_levels.id and HIERARCHY_REP != h_levels.id) then nvl(BV_END,0)
                                                  else 0
                                             end)) v12,                           
                           to_char(concatstr(case when (HIERARCHY_REP = h_levels.id and h2 = HIERARCHY_REP and DATE_START != p_date_start) then nvl(f_cp_get_bvondate(id, 'BV', DATE_START+1),0) 
                                                  when (h2 = h_levels.id and h1 != h_levels.id and HIERARCHY_REP = h_levels.id) then nvl(BV,0)                                                  
                                                  when (h2 = h_levels.id and h1 = h_levels.id and HIERARCHY_REP != h_levels.id) then nvl(BV,0)
                                                  else 0 
                                             end)) v13,
                           to_char(SUM(case when HIERARCHY_REP = h2 and DATE_FINISH = p_date_finish then nvl(BV_END,0) else 0 end)) v14
                      FROM cp_hierarchy_ids
                     where hierarchy_rep = h_levels.id
                     group by HIERARCHY_REP)
                unpivot
                ( value
                    for value_type in
                        (v0, v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11,v12,v13,v14)))
                        )
        select h_levels.id*10+ROWNUM, case when d.rn = 1 then 'Звіт за ієрархіями. Рівень '||h_levels.id else null end title,
               case when d.rn = 1 then d.value ||' '|| to_char(p_date_start, 'dd.mm.yyyy')
                    when d.rn = 15  then d.value ||' '|| to_char(p_date_finish, 'dd.mm.yyyy')
                    else d.value
               end descr, v.value from descript d, valueset v
        where d.RN = v.RN
         order by d.rn;
     end loop;

end;
/
show err;

PROMPT *** Create  grants  P_CP_LEVELS ***
grant EXECUTE                                                                on P_CP_LEVELS     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CP_LEVELS.sql =========*** End *
PROMPT ===================================================================================== 
