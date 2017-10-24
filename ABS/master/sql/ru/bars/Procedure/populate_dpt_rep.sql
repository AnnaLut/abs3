

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/POPULATE_DPT_REP.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure POPULATE_DPT_REP ***

  CREATE OR REPLACE PROCEDURE BARS.POPULATE_DPT_REP (p_year number, p_division varchar2, dateTo date)
is
 p_date_begin date;
 p_mid_date date;
 p_date_end date;

 p_sql varchar2(5000);
begin
    p_date_begin := to_date('01/01/'||LTRIM(RTRIM(to_char(p_year))),'dd/mm/yyyy');
    p_mid_date := to_date('01/07/'||LTRIM(RTRIM(to_char(p_year))),'dd/mm/yyyy');
    p_date_end := to_date('01/01/'||LTRIM(RTRIM(to_char(p_year+1))),'dd/mm/yyyy');

    p_sql :=' truncate table DPT_REP_PORTFOLIO';
    execute immediate p_sql;
    commit;

    p_sql := 'insert into DPT_REP_PORTFOLIO(rec_id, BRANCH_ID, TYPE_ID, TYPE_NAME, CUST_TYPE, NBS, OB22)
                select '||to_char(p_year) ||',
                substr(a.BRANCH,1,15),
                dt.type_id,
                dt.type_name,
                ''ФО'',
                a.nbs,
                ob.ob22_dep
        from accounts a,
                dpt_ob22 ob,
                dpt_vidd dv,
                dpt_types dt
        where a.nbs = ob.nbs_dep
        and DV.VIDD = ob.vidd
        and dv.type_id = DT.TYPE_ID
        and a.branch like decode(''' ||p_division ||''', ''Поточне'',  sys_context (''bars_context'', ''user_branch''),''' ||p_division ||''')||''%''
        and a.daos < to_date('''||to_char(p_date_end,'dd/mm/yyyy')||''',''dd/mm/yyyy'') and (a.dazs is null or a.dazs >=to_date('''||to_char(p_date_end,'dd/mm/yyyy')||''',''dd/mm/yyyy''))
        group by
                   substr(a.BRANCH,1,15),
                   dt.type_name,
                   a.nbs,
                   ob.ob22_dep,
                   dt.type_id';

      execute immediate p_sql;
      commit;

      p_sql := '';
      p_sql := 'update DPT_REP_PORTFOLIO P
      set (p.count1, p.amount1)=(select count(a.acc),
                                              sum(p_icurval(a.kv, fost(a.acc, to_date('''||to_char(p_date_end,'dd/mm/yyyy')||''',''dd/mm/yyyy'')), to_date('''||to_char(p_date_end,'dd/mm/yyyy')||''',''dd/mm/yyyy'')))/100
                                              from accounts  a
                                              where a.branch like (P.BRANCH_ID||''%'')
                                              and a.nbs = P.NBS
                                              and a.ob22 = P.OB22
                                              and a.daos < to_date('''||to_char(p_date_end,'dd/mm/yyyy')||''',''dd/mm/yyyy'')
                                              and (a.dazs is null
                                                        or a.dazs >=to_date('''||to_char(p_date_end,'dd/mm/yyyy')||''',''dd/mm/yyyy'')                                                        )
                                              and exists (select 1 from dpt_deposit_clos where acc = a.acc and vidd in (select vidd from dpt_vidd where type_id = p.type_id)))
      where rec_id= '||to_char(p_year);

      execute immediate p_sql;
      commit;

      p_sql := '';
      p_sql := 'update DPT_REP_PORTFOLIO P
      set (p.count2_1, p.amount2_1)=(select count(a.acc),
                                              sum(p_icurval(dc.kv, dc.limit, dc.when))/100
                                              from accounts  a, dpt_deposit_clos dc
                                              where a.branch like (P.BRANCH_ID||''%'')
                                              and a.nbs = P.NBS
                                              and a.ob22 = P.OB22
                                              and a.daos < to_date('''||to_char(p_date_end,'dd/mm/yyyy')||''',''dd/mm/yyyy'') and (a.dazs is null or a.dazs >=to_date('''||to_char(p_date_end,'dd/mm/yyyy')||''',''dd/mm/yyyy''))
                                              and dc.acc = a.acc
                                              and dc.vidd in (select vidd from dpt_vidd where type_id = p.type_id)
                                              and dc.dat_begin between  to_date('''||to_char(p_date_begin,'dd/mm/yyyy')||''',''dd/mm/yyyy'') and  to_date('''||to_char(p_date_end,'dd/mm/yyyy')||''',''dd/mm/yyyy'')
                                              and dc.action_id in (0,3))
       where rec_id= '||to_char(p_year);

      execute immediate p_sql;
      commit;

      p_sql := '';
      p_sql := 'update DPT_REP_PORTFOLIO P
      set (p.count2_2, p.amount2_2)=(select count(a.acc),
                                              sum(p_icurval(dc.kv, dc.limit, dc.when))/100
                                              from accounts  a, dpt_deposit_clos dc
                                              where a.branch like (P.BRANCH_ID||''%'')
                                              and a.nbs = P.NBS
                                              and a.ob22 = P.OB22
                                              and a.daos < to_date('''||to_char(p_date_end,'dd/mm/yyyy')||''',''dd/mm/yyyy'') and (a.dazs is null or a.dazs >=to_date('''||to_char(p_date_end,'dd/mm/yyyy')||''',''dd/mm/yyyy''))
                                              and dc.acc = a.acc
                                              and dc.vidd in (select vidd from dpt_vidd where type_id = p.type_id)
                                              and dc.dat_begin between  to_date('''||to_char(p_mid_date,'dd/mm/yyyy')||''',''dd/mm/yyyy'') and  to_date('''||to_char(p_date_end,'dd/mm/yyyy')||''',''dd/mm/yyyy'')
                                              and dc.action_id in (0,3))
      where rec_id= '||to_char(p_year);

      execute immediate p_sql;
      commit;

      p_sql := '';
      p_sql := 'update DPT_REP_PORTFOLIO P
      set (p.count3_1, p.amount3_1)=(select count(a.acc),
                                              sum(p_icurval(dc.kv, dc.limit, dc.when))/100
                                              from accounts  a, dpt_deposit_clos dc
                                              where a.branch like (P.BRANCH_ID||''%'')
                                              and a.nbs = P.NBS
                                              and a.ob22 = P.OB22
                                              and a.daos < to_date('''||to_char(p_date_end,'dd/mm/yyyy')||''',''dd/mm/yyyy'') and (a.dazs is null or a.dazs >=to_date('''||to_char(p_date_end,'dd/mm/yyyy')||''',''dd/mm/yyyy''))
                                              and dc.acc = a.acc
                                              and dc.vidd in (select vidd from dpt_vidd where type_id = p.type_id)
                                              and dc.dat_begin between  to_date('''||to_char(p_date_begin,'dd/mm/yyyy')||''',''dd/mm/yyyy'') and  to_date('''||to_char(p_date_end,'dd/mm/yyyy')||''',''dd/mm/yyyy'')
                                              and dc.action_id in (2)
                                              and not exists (select 1 from dpt_deposit_clos where dc.deposit_id = deposit_id and action_id = 3 and when >= dc.when))
      where rec_id= '||to_char(p_year);


      execute immediate p_sql;
      commit;

      p_sql := '';
      p_sql := 'update DPT_REP_PORTFOLIO P
      set (p.count3_2, p.amount3_2)=(select count(a.acc),
                                              sum(p_icurval(dc.kv, dc.limit, dc.when))/100
                                              from accounts  a, dpt_deposit_clos dc
                                              where a.branch like (P.BRANCH_ID||''%'')
                                              and a.nbs = P.NBS
                                              and a.ob22 = P.OB22
                                              and a.daos < to_date('''||to_char(p_date_end,'dd/mm/yyyy')||''',''dd/mm/yyyy'') and (a.dazs is null or a.dazs >=to_date('''||to_char(p_date_end,'dd/mm/yyyy')||''',''dd/mm/yyyy''))
                                              and dc.acc = a.acc
                                              and dc.vidd in (select vidd from dpt_vidd where type_id = p.type_id)
                                              and dc.dat_begin between  to_date('''||to_char(p_mid_date,'dd/mm/yyyy')||''',''dd/mm/yyyy'') and  to_date('''||to_char(p_date_end,'dd/mm/yyyy')||''',''dd/mm/yyyy'')
                                              and dc.action_id in (2)
                                              and not exists (select 1 from dpt_deposit_clos where dc.deposit_id = deposit_id and action_id = 3 and when >= dc.when))
      where rec_id= '||to_char(p_year);

      execute immediate p_sql;
      commit;

      delete from DPT_REP_PORTFOLIO where count1+count2_1+count2_2+count3_1+count3_2 = 0 and rec_id = p_year;
      commit;

-- обработаем следующий год

    p_sql := '';
    p_sql := 'insert into DPT_REP_PORTFOLIO(rec_id, BRANCH_ID, TYPE_ID, TYPE_NAME, CUST_TYPE, NBS, OB22)
                select '||to_char(p_year+1) ||',
                substr(a.BRANCH,1,15),
                dt.type_id,
                dt.type_name,
                ''ФО'',
                a.nbs,
                ob.ob22_dep
        from accounts a,
                dpt_ob22 ob,
                dpt_vidd dv,
                dpt_types dt
        where a.nbs = ob.nbs_dep
        and DV.VIDD = ob.vidd
        and dv.type_id = DT.TYPE_ID
        and a.branch like decode(''' ||p_division ||''', ''Поточне'',  sys_context (''bars_context'', ''user_branch''),''' ||p_division ||''')||''%''
        and a.daos < to_date('''||to_char(DateTo,'dd/mm/yyyy')||''',''dd/mm/yyyy'') and (a.dazs is null or a.dazs >=to_date('''||to_char(DateTo,'dd/mm/yyyy')||''',''dd/mm/yyyy''))
        group by
                   substr(a.BRANCH,1,15),
                   dt.type_name,
                   a.nbs,
                   ob.ob22_dep,
                   dt.type_id';

      execute immediate p_sql;
      commit;

      p_sql := '';
      p_sql := 'update DPT_REP_PORTFOLIO P
      set (p.count1, p.amount1)=(select count(a.acc),
                                              sum(p_icurval(a.kv, fost(a.acc, to_date('''||to_char(DateTo,'dd/mm/yyyy')||''',''dd/mm/yyyy'')), to_date('''||to_char(DateTo,'dd/mm/yyyy')||''',''dd/mm/yyyy'')))/100
                                              from accounts  a
                                              where a.branch like (P.BRANCH_ID||''%'')
                                              and a.nbs = P.NBS
                                              and a.ob22 = P.OB22
                                              and a.daos < to_date('''||to_char(DateTo,'dd/mm/yyyy')||''',''dd/mm/yyyy'')
                                              and (a.dazs is null
                                                        or a.dazs >=to_date('''||to_char(DateTo,'dd/mm/yyyy')||''',''dd/mm/yyyy'')                                                        )
                                              and exists (select 1 from dpt_deposit_clos where acc = a.acc and vidd in (select vidd from dpt_vidd where type_id = p.type_id)))
      where rec_id= '||to_char(p_year+1);

      execute immediate p_sql;
      commit;

      p_sql := '';
      p_sql := 'update DPT_REP_PORTFOLIO P
      set (p.count2_1, p.amount2_1)=(select count(a.acc),
                                              sum(p_icurval(dc.kv, dc.limit, dc.when))/100
                                              from accounts  a, dpt_deposit_clos dc
                                              where a.branch like (P.BRANCH_ID||''%'')
                                              and a.nbs = P.NBS
                                              and a.ob22 = P.OB22
                                              and a.daos < to_date('''||to_char(DateTo,'dd/mm/yyyy')||''',''dd/mm/yyyy'') and (a.dazs is null or a.dazs >=to_date('''||to_char(DateTo,'dd/mm/yyyy')||''',''dd/mm/yyyy''))
                                              and dc.acc = a.acc
                                              and dc.vidd in (select vidd from dpt_vidd where type_id = p.type_id)
                                              and dc.dat_begin between  to_date('''||to_char(p_date_end,'dd/mm/yyyy')||''',''dd/mm/yyyy'') and  to_date('''||to_char(DateTo,'dd/mm/yyyy')||''',''dd/mm/yyyy'')
                                              and dc.action_id in (0,3))
      where rec_id= '||to_char(p_year+1);

      execute immediate p_sql;
      commit;

      p_sql := '';
      p_sql := 'update DPT_REP_PORTFOLIO P
      set (p.count2_2, p.amount2_2)=(select count(a.acc),
                                              sum(p_icurval(dc.kv, dc.limit, dc.when))/100
                                              from accounts  a, dpt_deposit_clos dc
                                              where a.branch like (P.BRANCH_ID||''%'')
                                              and a.nbs = P.NBS
                                              and a.ob22 = P.OB22
                                              and a.daos < to_date('''||to_char(DateTo,'dd/mm/yyyy')||''',''dd/mm/yyyy'') and (a.dazs is null or a.dazs >=to_date('''||to_char(DateTo,'dd/mm/yyyy')||''',''dd/mm/yyyy''))
                                              and dc.acc = a.acc
                                              and dc.vidd in (select vidd from dpt_vidd where type_id = p.type_id)
                                              and dc.dat_begin between  to_date('''||to_char(add_months(DateTo,-1),'dd/mm/yyyy')||''',''dd/mm/yyyy'') and  to_date('''||to_char(DateTo,'dd/mm/yyyy')||''',''dd/mm/yyyy'')
                                              and dc.action_id in (0,3))
      where rec_id= '||to_char(p_year+1);

      execute immediate p_sql;
      commit;

      p_sql := '';
      p_sql := 'update DPT_REP_PORTFOLIO P
      set (p.count3_1, p.amount3_1)=(select count(a.acc),
                                              sum(p_icurval(dc.kv, dc.limit, dc.when))/100
                                              from accounts  a, dpt_deposit_clos dc
                                              where a.branch like (P.BRANCH_ID||''%'')
                                              and a.nbs = P.NBS
                                              and a.ob22 = P.OB22
                                              and a.daos < to_date('''||to_char(DateTo,'dd/mm/yyyy')||''',''dd/mm/yyyy'') and (a.dazs is null or a.dazs >=to_date('''||to_char(DateTo,'dd/mm/yyyy')||''',''dd/mm/yyyy''))
                                              and dc.acc = a.acc
                                              and dc.vidd in (select vidd from dpt_vidd where type_id = p.type_id)
                                              and dc.dat_begin between  to_date('''||to_char(p_date_end,'dd/mm/yyyy')||''',''dd/mm/yyyy'') and  to_date('''||to_char(DateTo,'dd/mm/yyyy')||''',''dd/mm/yyyy'')
                                              and dc.action_id in (2)
                                              and not exists (select 1 from dpt_deposit_clos where dc.deposit_id = deposit_id and action_id = 3 and when >= dc.when))
      where rec_id= '||to_char(p_year+1);

      execute immediate p_sql;
      commit;

      p_sql := '';
      p_sql := 'update DPT_REP_PORTFOLIO P
      set (p.count3_2, p.amount3_2)=(select count(a.acc),
                                              sum(p_icurval(dc.kv, dc.limit, dc.when))/100
                                              from accounts  a, dpt_deposit_clos dc
                                              where a.branch like (P.BRANCH_ID||''%'')
                                              and a.nbs = P.NBS
                                              and a.ob22 = P.OB22
                                              and a.daos < to_date('''||to_char(DateTo,'dd/mm/yyyy')||''',''dd/mm/yyyy'') and (a.dazs is null or a.dazs >=to_date('''||to_char(DateTo,'dd/mm/yyyy')||''',''dd/mm/yyyy''))
                                              and dc.acc = a.acc
                                              and dc.vidd in (select vidd from dpt_vidd where type_id = p.type_id)
                                              and dc.dat_begin between  to_date('''||to_char(add_months(DateTo,-1),'dd/mm/yyyy')||''',''dd/mm/yyyy'') and  to_date('''||to_char(DateTo,'dd/mm/yyyy')||''',''dd/mm/yyyy'')
                                              and dc.action_id in (2)
                                              and not exists (select 1 from dpt_deposit_clos where dc.deposit_id = deposit_id and action_id = 3 and when >= dc.when))
      where rec_id= '||to_char(p_year+1);

      execute immediate p_sql;
      commit;

      delete from DPT_REP_PORTFOLIO where count1+count2_1+count2_2+count3_1+count3_2 = 0 and rec_id = p_year+1;
      commit;

end Populate_dpt_rep;
/
show err;

PROMPT *** Create  grants  POPULATE_DPT_REP ***
grant EXECUTE                                                                on POPULATE_DPT_REP to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/POPULATE_DPT_REP.sql =========*** 
PROMPT ===================================================================================== 
