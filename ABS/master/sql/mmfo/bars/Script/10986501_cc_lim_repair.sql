prompt repair cc_lim by 10986501
begin
  bc.go(300465);

for c in (select * from (
select to_date('15.04.2017') as fdate ,30521027.51 as lim2 from dual union all
select to_date('15.05.2017') as fdate ,30276422.21 as lim2 from dual union all
select to_date('15.06.2017') as fdate ,29651202.73 as lim2 from dual union all
select to_date('15.07.2017') as fdate ,29025983.25 as lim2 from dual union all
select to_date('15.08.2017') as fdate ,28400763.77 as lim2 from dual union all
select to_date('15.09.2017') as fdate ,27775544.29 as lim2 from dual union all
select to_date('15.10.2017') as fdate ,27150324.81 as lim2 from dual union all
select to_date('15.11.2017') as fdate ,26525105.33 as lim2 from dual union all
select to_date('15.12.2017') as fdate ,25899885.85 as lim2 from dual union all
select to_date('15.01.2018') as fdate ,25274666.37 as lim2 from dual union all
select to_date('15.02.2018') as fdate ,24649446.89 as lim2 from dual union all
select to_date('15.03.2018') as fdate ,24024227.41 as lim2 from dual union all
select to_date('15.04.2018') as fdate ,23399007.93 as lim2 from dual union all
select to_date('15.05.2018') as fdate ,22773788.45 as lim2 from dual union all
select to_date('15.06.2018') as fdate ,22148568.97 as lim2 from dual union all
select to_date('15.07.2018') as fdate ,21523349.49 as lim2 from dual union all
select to_date('15.08.2018') as fdate ,20898130.01 as lim2 from dual union all
select to_date('15.09.2018') as fdate ,20272910.53 as lim2 from dual union all
select to_date('15.10.2018') as fdate ,19647691.05 as lim2 from dual union all
select to_date('15.11.2018') as fdate ,19022471.57 as lim2 from dual union all
select to_date('15.12.2018') as fdate ,18397252.09 as lim2 from dual union all
select to_date('15.01.2019') as fdate ,17772032.61 as lim2 from dual union all
select to_date('15.02.2019') as fdate ,17146813.13 as lim2 from dual union all
select to_date('15.03.2019') as fdate ,16521593.65 as lim2 from dual union all
select to_date('15.04.2019') as fdate ,15896374.17 as lim2 from dual union all
select to_date('15.05.2019') as fdate ,15271154.69 as lim2 from dual union all
select to_date('15.06.2019') as fdate ,14645935.21 as lim2 from dual union all
select to_date('15.07.2019') as fdate ,14020715.73 as lim2 from dual union all
select to_date('15.08.2019') as fdate ,13395496.25 as lim2 from dual union all
select to_date('15.09.2019') as fdate ,12770276.77 as lim2 from dual union all
select to_date('15.10.2019') as fdate ,12145057.29 as lim2 from dual union all
select to_date('15.11.2019') as fdate ,11519837.81 as lim2 from dual union all
select to_date('15.12.2019') as fdate ,10894618.33 as lim2 from dual union all
select to_date('15.01.2020') as fdate ,10269398.85 as lim2 from dual union all
select to_date('15.02.2020') as fdate ,9644179.37 as lim2 from dual union all
select to_date('15.03.2020') as fdate ,9018959.89 as lim2 from dual union all
select to_date('15.04.2020') as fdate ,8393740.41 as lim2 from dual union all
select to_date('15.05.2020') as fdate ,7768520.93 as lim2 from dual union all
select to_date('15.06.2020') as fdate ,7143301.45 as lim2 from dual union all
select to_date('15.07.2020') as fdate ,6518081.97 as lim2 from dual union all
select to_date('15.08.2020') as fdate ,5892862.49 as lim2 from dual union all
select to_date('15.09.2020') as fdate ,5267643.01 as lim2 from dual union all
select to_date('15.10.2020') as fdate ,4642423.53 as lim2 from dual union all
select to_date('15.11.2020') as fdate ,4017204.05 as lim2 from dual union all
select to_date('15.12.2020') as fdate ,3391984.57 as lim2 from dual union all
select to_date('15.01.2021') as fdate ,2766765.09 as lim2 from dual union all
select to_date('29.01.2021') as fdate ,0 as lim2 from dual 
))
  loop
  cck_ui.glk_upd(p_mode => 1,
                 p_nd => 10986501,
                 p_fdat => c.fdate,
                 p_lim2 => c.lim2,
                 p_d9129 => 0,
                 p_daysn => null,
                 p_upd_flag => 0);
end loop;
commit;
end;
/
