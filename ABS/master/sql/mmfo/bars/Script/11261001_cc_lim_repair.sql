prompt repair cc_lim by 11261001
begin
  bc.go(300465);

for c in (select * from (
select to_date('15.04.2017') as fdate ,67331977.66 as lim2 from dual union all
select to_date('15.05.2017') as fdate ,67131419.11 as lim2 from dual union all
select to_date('15.06.2017') as fdate ,66209382.53 as lim2 from dual union all
select to_date('15.07.2017') as fdate ,65287345.95 as lim2 from dual union all
select to_date('15.08.2017') as fdate ,64365309.37 as lim2 from dual union all
select to_date('15.09.2017') as fdate ,63443272.79 as lim2 from dual union all
select to_date('15.10.2017') as fdate ,62521236.21 as lim2 from dual union all
select to_date('15.11.2017') as fdate ,61599199.63 as lim2 from dual union all
select to_date('15.12.2017') as fdate ,60677163.05 as lim2 from dual union all
select to_date('15.01.2018') as fdate ,59755126.47 as lim2 from dual union all
select to_date('15.02.2018') as fdate ,58833089.89 as lim2 from dual union all
select to_date('15.03.2018') as fdate ,57911053.31 as lim2 from dual union all
select to_date('15.04.2018') as fdate ,56989016.73 as lim2 from dual union all
select to_date('15.05.2018') as fdate ,56066980.15 as lim2 from dual union all
select to_date('15.06.2018') as fdate ,55144943.57 as lim2 from dual union all
select to_date('15.07.2018') as fdate ,54222906.99 as lim2 from dual union all
select to_date('15.08.2018') as fdate ,53300870.41 as lim2 from dual union all
select to_date('15.09.2018') as fdate ,52378833.83 as lim2 from dual union all
select to_date('15.10.2018') as fdate ,51456797.25 as lim2 from dual union all
select to_date('15.11.2018') as fdate ,50534760.67 as lim2 from dual union all
select to_date('15.12.2018') as fdate ,49612724.09 as lim2 from dual union all
select to_date('15.01.2019') as fdate ,48690687.51 as lim2 from dual union all
select to_date('15.02.2019') as fdate ,47768650.93 as lim2 from dual union all
select to_date('15.03.2019') as fdate ,46846614.35 as lim2 from dual union all
select to_date('15.04.2019') as fdate ,45924577.77 as lim2 from dual union all
select to_date('15.05.2019') as fdate ,45002541.19 as lim2 from dual union all
select to_date('15.06.2019') as fdate ,44080504.61 as lim2 from dual union all
select to_date('15.07.2019') as fdate ,43158468.03 as lim2 from dual union all
select to_date('15.08.2019') as fdate ,42236431.45 as lim2 from dual union all
select to_date('15.09.2019') as fdate ,41314394.87 as lim2 from dual union all
select to_date('15.10.2019') as fdate ,40392358.29 as lim2 from dual union all
select to_date('15.11.2019') as fdate ,39470321.71 as lim2 from dual union all
select to_date('15.12.2019') as fdate ,38548285.13 as lim2 from dual union all
select to_date('15.01.2020') as fdate ,37626248.55 as lim2 from dual union all
select to_date('15.02.2020') as fdate ,36704211.97 as lim2 from dual union all
select to_date('15.03.2020') as fdate ,35782175.39 as lim2 from dual union all
select to_date('15.04.2020') as fdate ,34860138.81 as lim2 from dual union all
select to_date('15.05.2020') as fdate ,33938102.23 as lim2 from dual union all
select to_date('15.06.2020') as fdate ,33016065.65 as lim2 from dual union all
select to_date('15.07.2020') as fdate ,32094029.07 as lim2 from dual union all
select to_date('15.08.2020') as fdate ,31171992.49 as lim2 from dual union all
select to_date('15.09.2020') as fdate ,30249955.91 as lim2 from dual union all
select to_date('15.10.2020') as fdate ,29327919.33 as lim2 from dual union all
select to_date('15.11.2020') as fdate ,28405882.75 as lim2 from dual union all
select to_date('15.12.2020') as fdate ,27483846.17 as lim2 from dual union all
select to_date('15.01.2021') as fdate ,26561809.59 as lim2 from dual union all
select to_date('29.01.2021') as fdate ,0 as lim2 from dual ))
  loop
  cck_ui.glk_upd(p_mode => 1,
                 p_nd => 11261001,
                 p_fdat => c.fdate,
                 p_lim2 => c.lim2,
                 p_d9129 => 0,
                 p_daysn => null,
                 p_upd_flag => 0);
end loop;
commit;
end;
/
