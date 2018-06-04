create or replace procedure MAKE_ADJ_INT_MONTHLY
is
  title constant varchar2(64) := 'dptweb.automakeintmnth:'; 
  l_kf           varchar2(6) := sys_context('bars_context','user_mfo');
  l_tmp          number;
  l_acrdate      date;
  l_runid        dpu_jobs_jrnl.run_id%type;
  l_error  boolean;
begin

  bars_audit.info( title||': Entry with l_kf='||l_kf );

  if ( l_kf Is Null )
  then

    for i in ( select KF
                 from MV_KF
                order by KF )
    loop
      BC.GO(i.KF);
      MAKE_ADJ_INT_MONTHLY();
      BC.HOME();
    end loop;

  else

    -- 
    COLLECT_SALDOHOLIDAY();

    l_acrdate := trunc(sysdate,'mm')-1;

    for b in ( select BRANCH
                 from BRANCH
                where BRANCH like '/'||l_kf||'/______/' 
                  and DATE_OPENED <= GL.BD()
                  and DATE_CLOSED Is Null
             )
    loop

      bars_audit.info( title||': Start with BRANCH='||b.BRANCH );

      BARS_CONTEXT.SUBST_BRANCH( b.BRANCH );

      begin

        insert
          into INT_QUEUE
             ( KF, BRANCH, DEAL_ID, DEAL_NUM, DEAL_DAT, CUST_ID, INT_ID
             , ACC_ID, ACC_NUM, ACC_CUR, ACC_NBS, ACC_NAME, ACC_ISO
             , ACC_OPEN, ACC_AMOUNT, INT_DETAILS, INT_TT, MOD_CODE )
        select d.kf, d.BRANCH, d.deposit_id, d.nd, d.datz, d.rnk, i.id
              , a.acc, a.nls, a.kv, a.nbs, substr(a.nms, 1, 38), t.lcv
              , a.daos, null, null, nvl(i.tt,'%%1'), 'DPT'
          from DPT_DEPOSIT   d
          join ACCOUNTS      a on ( a.ACC  = d.ACC )
          join DPT_VIDD      v on ( v.VIDD = d.VIDD )
          join INT_ACCN      i on ( i.ACC  = d.ACC and i.ID in ( 1, decode(v.amr_metr, 0, 1, 3) ) )
          join TABVAL$GLOBAL t on ( t.KV   = a.KV  )
         where d.BRANCH like b.BRANCH||'%'
           and a.DAOS <= l_acrdate
           and v.VIDD not in (103, 104, 106, 107, 108, 300)
           and i.ACR_DAT <= l_acrdate
           and lnnvl( i.STP_DAT <= i.ACR_DAT );

        l_tmp := sql%rowcount;

        commit;

      exception
        when NO_DATA_FOUND
        then l_tmp := 0;
        when OTHERS
        then bars_audit.error( title||': '||dbms_utility.format_error_stack() );
      end;

      bars_audit.info( title||': '||to_char(l_tmp)||' row(s) inserted.' );

      if ( l_tmp > 0 )
      then

        DPT_JOBS_AUDIT.P_START_JOB( p_modcode => 'DPT'
                                  , p_jobid   => 267
                                  , p_branch  => b.BRANCH
                                  , p_bdate   => GL.BD()
                                  , p_run_id  => l_runid );

        begin

          MAKE_INT( p_dat2      => l_acrdate
                  , p_runmode   => 1
                  , p_runid     => l_runid
                  , p_intamount => l_tmp
                  , p_errflg    => l_error);

          commit;

        exception
          when OTHERS
          then
            bars_audit.error( title||': '||dbms_utility.format_error_stack()
                                         ||dbms_utility.format_error_backtrace() );
            DPT_JOBS_AUDIT.P_FINISH_JOB( 'DPT', l_runid, sqlerrm );
        end;

        DPT_JOBS_AUDIT.P_FINISH_JOB( 'DPT', l_runid );

      end if;

      bars_audit.info( BARS_MSG.GET_MSG( 'DPT', 'AUTOMAKEINTMNTH_DONE', b.BRANCH ) );

      BARS_CONTEXT.SET_CONTEXT();

    end loop;

  end if;

  bars_audit.info( title||': Exit.' );

end MAKE_ADJ_INT_MONTHLY;
/

show errors;
