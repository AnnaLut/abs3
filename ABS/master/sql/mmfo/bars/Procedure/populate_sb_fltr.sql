

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/POPULATE_SB_FLTR.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure POPULATE_SB_FLTR ***

  CREATE OR REPLACE PROCEDURE BARS.POPULATE_SB_FLTR (dat_ in date)
is
    dict   DICT_SB_FLTR%rowtype;
    level_count number := 0;
    group_count number :=0;
    tmp_date date;
    tmp_ref  number :=0;
    acc_set varchar2(500) := '';
    p_mfo varchar2(6);
    i smallint;
    j smallint;
    p_dat date;
    p_dat1 date;
    base_sql varchar2(15000);
    sql_str varchar2(5000);
    sql_str_1  varchar2(5000);
    sql_str_1_rev varchar2(5000);
    sql_const constant varchar2(500) := ' select nvl(sum(a.s),0)/100000 from tmp_oper a where ' ;
    sql_const_null constant varchar2(500) :='(select 0 from dual)';

   begin
        base_sql := '';
        sql_str_1 := '';
        p_dat :=dat_;
        p_dat1 :=p_dat+1;

        if p_dat is null then
            p_dat := to_char(sysdate,'dd/mm/yyyy');
        end if;


        select nvl(max(rec),0) into tmp_ref from tmp_oper;
        p_mfo := f_ourmfo_g;

             base_sql := ' truncate table tmp_oper';
            execute immediate base_sql;
            base_sql :='insert into tmp_oper(S1,S2,S,NLSA,NAMA,NLSB,NAMB,ND,MFOA,MFOB,SOS,REC,REF,DK)
                             select s1,s2, s1+s2,nlsa, nama,nlsb, namb,nd,mfoa, mfob, sos, rec, ref, dk
                                 from
                                ( SELECT
                                decode(ARC_RRP.dk,0,ARC_RRP.s,0) s1, decode(ARC_RRP.dk,1,ARC_RRP.s,0) s2,
                                 ARC_RRP.nd,   ARC_RRP.mfoa, ARC_RRP.mfob,
                                 ARC_RRP.sos,  ARC_RRP.rec,  ARC_RRP.ref , ARC_RRP.dk,
                                 ARC_RRP.nlsa NLSA, ARC_RRP.nam_A  namA,
                                 ARC_RRP.nlsB NLSB, ARC_RRP.nam_B  namB
                                 FROM arc_rrp
                                  WHERE ARC_RRP.fn_A like ''$_1ILP%''    and
                                    ARC_RRP.sos  >=3
                                    and ARC_RRP.dat_A >= to_date('''||to_char(p_dat,'dd/mm/yyyy')||''',''dd/mm/yyyy'') and ARC_RRP.dat_A <to_date('''||to_char(p_dat1,'dd/mm/yyyy')||''',''dd/mm/yyyy'')
                                    and arc_rrp.s>0 and arc_rrp.dk<2 and arc_rrp.kv=980
                                    UNION ALL  SELECT
                                decode(ARC_RRP.dk,1,ARC_RRP.s,0), decode(ARC_RRP.dk,0,ARC_RRP.s,0),
                                ARC_RRP.nd,   ARC_RRP.mfoa, ARC_RRP.mfob,
                                 ARC_RRP.sos,  ARC_RRP.rec,  ARC_RRP.ref , ARC_RRP.dk,
                                 ARC_RRP.nlsA, ARC_RRP.nam_A,
                                ARC_RRP.nlsB, ARC_RRP.nam_B
                                FROM  arc_rrp
                                WHERE ARC_RRP.fn_B like  ''$_1ILP%''  and
                                    ARC_RRP.sos > 3
                                  and ARC_RRP.dat_B >=to_date('''||to_char(p_dat,'dd/mm/yyyy')||''',''dd/mm/yyyy'') and ARC_RRP.dat_B <to_date('''||to_char(p_dat1,'dd/mm/yyyy')||''',''dd/mm/yyyy'')
                                  and arc_rrp.s>0 and arc_rrp.dk<2 and arc_rrp.kv=980
                                )';

            execute immediate base_sql;
            commit;


        base_sql := ' truncate table TMP_SB_FLTR';
        execute immediate base_sql;
        commit;

        sql_str :=  'insert into TMP_SB_FLTR ' ;
        select  nvl(max(count(*)),0) into level_count from DICT_SB_FLTR group by groupid;
        select  nvl(count(distinct groupid),0) into group_count from DICT_SB_FLTR;

              for j in 1..level_count
              loop
                    sql_str_1 := sql_str || ' values ( ';
                    for i in 1..group_count
                    loop
                        begin
                            select * into dict from DICT_SB_FLTR where GROUPID = i and levelId = j;
                            exception when no_data_found then select i,j,to_char(j),'' into dict from dual;
                        end;
                         sql_str_1 := sql_str_1
                                                         || case when dict.LevelId is not null
                                                                     then to_char(dict.LevelId)
                                                                     else to_char(i)
                                                              end || ','
                                                         || case when dict.LevelName is not null
                                                                     then ''''||to_char(dict.LevelName)||''''
                                                                     else ''''''
                                                              end
                                                         || ',(' || case when dict.filter is not null
                                                                         then  case    when    instr(upper(dict.LevelName),'S1') <> 0
                                                                                            then      replace(sql_const,'nvl(sum(a.s),0)/100000','nvl(sum(a.s1),0)/100000')||dict.filter
                                                                                            when    instr(upper(dict.LevelName),'S2') <> 0
                                                                                            then      replace(sql_const,'nvl(sum(a.s),0)/100000','nvl(sum(a.s2),0)/100000')||dict.filter
                                                                                            else       sql_const||dict.filter
                                                                                  end
                                                                         else sql_const_null
                                                                      end ||'),';
                    end loop;
                    select reverse(sql_str_1) into sql_str_1_rev from dual;
                    sql_str_1 := substr(sql_str_1, 1, length(sql_str_1) - instr(sql_str_1_rev, ',')) || ')';
                    execute immediate sql_str_1;
                    commit;
              end loop;

 end populate_sb_fltr;
/
show err;

PROMPT *** Create  grants  POPULATE_SB_FLTR ***
grant EXECUTE                                                                on POPULATE_SB_FLTR to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on POPULATE_SB_FLTR to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/POPULATE_SB_FLTR.sql =========*** 
PROMPT ===================================================================================== 
