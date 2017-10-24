prompt repair cc_lim by 10922701
begin
  bc.go(300465);

for c in (select * from (
select to_date('15.04.2017') as fdate ,46561067.01 as lim2 from dual union all
select to_date('15.05.2017') as fdate ,46367800.10 as lim2 from dual union all
select to_date('15.06.2017') as fdate ,46017108.63 as lim2 from dual union all
select to_date('15.07.2017') as fdate ,45225773.69 as lim2 from dual union all
select to_date('15.08.2017') as fdate ,44434438.75 as lim2 from dual union all
select to_date('15.09.2017') as fdate ,43643103.81 as lim2 from dual union all
select to_date('15.10.2017') as fdate ,42851768.87 as lim2 from dual union all
select to_date('15.11.2017') as fdate ,42060433.93 as lim2 from dual union all
select to_date('15.12.2017') as fdate ,41269098.99 as lim2 from dual union all
select to_date('15.01.2018') as fdate ,40477764.05 as lim2 from dual union all
select to_date('15.02.2018') as fdate ,39686429.11 as lim2 from dual union all
select to_date('15.03.2018') as fdate ,38895094.17 as lim2 from dual union all
select to_date('15.04.2018') as fdate ,38103759.23 as lim2 from dual union all
select to_date('15.05.2018') as fdate ,37312424.29 as lim2 from dual union all
select to_date('15.06.2018') as fdate ,36521089.35 as lim2 from dual union all
select to_date('15.07.2018') as fdate ,35729754.41 as lim2 from dual union all
select to_date('15.08.2018') as fdate ,34938419.47 as lim2 from dual union all
select to_date('15.09.2018') as fdate ,34147084.53 as lim2 from dual union all
select to_date('15.10.2018') as fdate ,33355749.59 as lim2 from dual union all
select to_date('15.11.2018') as fdate ,32564414.65 as lim2 from dual union all
select to_date('15.12.2018') as fdate ,31773079.71 as lim2 from dual union all
select to_date('15.01.2019') as fdate ,30981744.77 as lim2 from dual union all
select to_date('15.02.2019') as fdate ,30190409.83 as lim2 from dual union all
select to_date('15.03.2019') as fdate ,29399074.89 as lim2 from dual union all
select to_date('15.04.2019') as fdate ,28607739.95 as lim2 from dual union all
select to_date('15.05.2019') as fdate ,27816405.01 as lim2 from dual union all
select to_date('15.06.2019') as fdate ,27025070.07 as lim2 from dual union all
select to_date('15.07.2019') as fdate ,26233735.13 as lim2 from dual union all
select to_date('15.08.2019') as fdate ,25442400.19 as lim2 from dual union all
select to_date('15.09.2019') as fdate ,24651065.25 as lim2 from dual union all
select to_date('15.10.2019') as fdate ,23859730.31 as lim2 from dual union all
select to_date('15.11.2019') as fdate ,23068395.37 as lim2 from dual union all
select to_date('15.12.2019') as fdate ,22277060.43 as lim2 from dual union all
select to_date('15.01.2020') as fdate ,21485725.49 as lim2 from dual union all
select to_date('15.02.2020') as fdate ,20694390.55 as lim2 from dual union all
select to_date('15.03.2020') as fdate ,19903055.61 as lim2 from dual union all
select to_date('15.04.2020') as fdate ,19111720.67 as lim2 from dual union all
select to_date('15.05.2020') as fdate ,18320385.73 as lim2 from dual union all
select to_date('15.06.2020') as fdate ,17529050.79 as lim2 from dual union all
select to_date('15.07.2020') as fdate ,16737715.85 as lim2 from dual union all
select to_date('15.08.2020') as fdate ,15946380.91 as lim2 from dual union all
select to_date('15.09.2020') as fdate ,15155045.97 as lim2 from dual union all
select to_date('15.10.2020') as fdate ,14363711.03 as lim2 from dual union all
select to_date('15.11.2020') as fdate ,13572376.09 as lim2 from dual union all
select to_date('15.12.2020') as fdate ,12781041.15 as lim2 from dual union all
select to_date('15.01.2021') as fdate ,11989706.21 as lim2 from dual union all
select to_date('29.01.2021') as fdate ,11198371.27 as lim2 from dual)
 
)
  loop
  cck_ui.glk_upd(p_mode => 1,
                 p_nd => 10922701,
                 p_fdat => c.fdate,
                 p_lim2 => c.lim2,
                 p_d9129 => 0,
                 p_daysn => null,
                 p_upd_flag => 0);
end loop;
commit;
end;
/
