CREATE OR REPLACE procedure BARS.p_show_balance
( p_date     date
, p_refresh  number   default null
, p_eqviv    number   default null
, p_kv       varchar2 default null
, p_kv_grp   number   default null
, p_nbs      varchar2 default null
, p_nbs_grp  number   default null
, p_branch   varchar2 default null
) is
-------------------------------------------------------------------------------
--                                                                           --
-- Прооцедура подготовки данных для населения окна в форме Баланса WEB формы --
--                                                                           --
-- author     : anna.lut                                                     --
-- modifier   : andrii.biletskyi                                             --
-- version    : 1.2.1                                                        --
-- last modif : 29.06.2016                                                   --
-------------------------------------------------------------------------------
  
  --
  G_GROUP_0        constant  number(1) := 7;  -- группа 0 ( по банку вцілому   )
  G_GROUP_1        constant  number(1) := 8;  -- группа 1 ( по KF              )
  G_GROUP_2        constant  number(1) := 9;  -- группа 2 ( по KF,     NBS     )
  G_GROUP_3        constant  number(2) := 10; -- группа 3 ( по KF,     NBS, KV )
  G_GROUP_DETAILS  constant  number(2) := 11; -- группа 4 ( по BRANCH, NBS, KV )
  
  --
  l_has_data                 number(1) := 0;
  l_condition                varchar2(100);
  l_user_policy              varchar2(30);
  
begin
  
  bars.bars_audit.trace( 'p_show_balance: Start with (p_date=%s, p_refresh=%s).'
                       , to_char(p_date,'dd.mm.yyyy'), nvl(to_char(p_refresh),'null') );
  
  if ( p_date Is Null )
  then -- user didn`t specify report date
    raise_application_error( -20666, 'Parameter [p_date] must be specified!', true );
  else -- check data existence in the table on the report date
    
    l_user_policy := sys_context('bars_context','policy_group');
    
    select case
             when EXISTS( select 1
                            from BARS.TMP_SHOW_BALANCE_DATA
                           where SHOW_DATE = p_date )
             then 1
             else 0
           end
      into l_has_data
      from DUAL;
    
    l_condition := replace( q'[ (to_date('%dt','ddmmyyyy')) ]', '%dt', to_char(p_date,'ddmmyyyy') );
    
    if ( l_has_data = 1 )
    then -- data already exists in the table on the report date
      
      if ( p_refresh Is Not Null )
      then -- unconditional accumulation new data
        
        -- clearing existing data
        execute immediate 'ALTER TABLE BARS.TMP_SHOW_BALANCE_DATA TRUNCATE PARTITION FOR '||l_condition||' UPDATE INDEXES';
        
        -- reset indicator value
        l_has_data := 0;
        
      else -- user will read existing data
        
        null;
        
      end if;
      
    else
      
      execute immediate 'LOCK TABLE BARS.TMP_SHOW_BALANCE_DATA PARTITION FOR '||l_condition||' IN SHARE MODE';
      
    end if;
    
  end if;
  
  if ( l_has_data = 0 )
  then -- data accumulation on report date
    
    if ( l_user_policy != BARS_CONTEXT.GROUP_WHOLE )
    then
      BARS_CONTEXT.SET_POLICY_GROUP(BARS_CONTEXT.GROUP_WHOLE);
    end if;
    
    begin
      
      if ( p_date = gl.bd )
      then -- on current bank date
        
        insert /*+ APPEND */
          into BARS.TMP_SHOW_BALANCE_DATA
             ( SHOW_DATE, KF, KF_NAME, BRANCH, KV, NBS, DOS, DOSQ, KOS, KOSQ, OSTD, OSTDQ, OSTK, OSTKQ, ROW_TYPE )
        select /*+ PARALLEL 26 */ p_date
             , a.KF
             , r.NAME
             , a.BRANCH
             , a.KV
             , a.NBS
             , sum(dos) as DOS
             , sum(decode( kv, 980, dos
                             , 840, round(dos * rate_840,0)
                             , 978, round(dos * rate_978,0)
                             , 643, round(dos * rate_643,0)
                                  , gl.p_icurval(kv,dos, v.pdat) ) ) as DOSQ
             , sum(kos) AS KOS
             , sum(decode( kv, 980, kos
                             , 840, round(kos * rate_840,0)
                             , 978, round(koS * rate_978,0)
                             , 643, round(kos * rate_643,0)
                                  , gl.p_icurval(kv,kos, v.pdat) ) ) as KOSQ
             , sum(ostd) as OSTD
             , sum(decode( kv, 980, ostd
                             , 840, round(ostd * rate_840,0)
                             , 978, round(ostd * rate_978,0)
                             , 643, round(ostd * rate_643,0)
                                  , gl.p_icurval(kv,ostd, v.pdat) ) ) AS OSTDQ
             , sum(ostk) as OSTK
             , sum(decode( kv, 980, ostk
                             , 840, round(ostk * rate_840,0)
                             , 978, round(ostk * rate_978,0)
                             , 643, round(ostk * rate_643,0)
                                  , gl.p_icurval(kv,ostk, v.pdat) ) ) as OSTKQ
             , G_GROUP_DETAILS
          from ( select KF, BRANCH, NBS, KV
                      , sum(decode( dapp, p_date,    dos/100, 0 ) ) DOS
                      , sum(decode( dapp, p_date,    kos/100, 0 ) ) KOS
                      , sum(decode( sign(ostc),-1, -ostc/100, 0 ) ) OSTD
                      , sum(decode( sign(ostc), 1,  ostc/100, 0 ) ) OSTK
                   from BARS.ACCOUNTS a
                  where a.NBS not like '8%'
                    and a.NBS Not like '0%'
                    and a.NBS Is Not Null
                    and a.DAZS is Null
                  group by KF, BRANCH, NBS, KV
               ) a,
               ( select p_date as PDAT
                      , max(decode(kv, 840, rate_o/bsum, 0)) as rate_840
                      , max(decode(kv, 978, rate_o/bsum, 0)) as rate_978
                      , max(decode(kv, 643, rate_o/bsum, 0)) as rate_643
                   from BARS.CUR_RATES
                  where ( KV, VDATE ) in ( select KV, max(VDATE)
                                             from CUR_RATES
                                            where VDATE <= p_date
                                              and KV in ( 840, 978, 643 )
                                            group by KV )
               ) v
             , BARS.REGIONS r
         where r.kf = a.kf
         group by a.KF, r.NAME, a.BRANCH, a.NBS, a.KV
         order by a.KF,         a.BRANCH, a.NBS, a.KV
        ;
        
      else -- on previous bank date
      
        case 
          when ( p_date < to_date('01.01.2015','dd.mm.yyyy') )
          then -- Вказана дата менша від мінімально допустимої для ММФО
            raise_application_error( -20666, 'Date can`t be less than 01.01.2015 !', true );
          when ( p_date < DAT_NEXT_U( gl.bd, -1 * f_get_params('SNAP_LT',30) ) )
          then  -- інформація за вказану дату відсутня (зверніться до адміністратора )
            raise_application_error( -20666, 'Information on the date '||to_char(p_date,'dd.mm.yyyy')||' don`t available!', true );
          else
            null;
        end case;
        
        insert /*+ APPEND */
          into BARS.TMP_SHOW_BALANCE_DATA
             ( SHOW_DATE, KF, KF_NAME, BRANCH, NBS, KV, DOS, DOSQ, KOS, KOSQ, OSTD, OSTDQ, OSTK, OSTKQ, ROW_TYPE )
        select /*+ PARALLEL 26 */ s.FDAT
             , s.KF
             , r.NAME as KF_NAME
             , s.BRANCH
             , s.NBS
             , s.KV
             , s.DOS
             , s.DOSQ
             , s.KOS
             , s.KOSQ
             , s.OSTD
             , s.OSTDQ
             , s.OSTK
             , s.OSTKQ
             , G_GROUP_DETAILS
          from ( select b.FDAT
                      , a.KF
                      , a.BRANCH
                      , a.NBS
                      , a.KV
                      , sum( b.DOS                                 ) as DOS
                      , sum( b.DOSQ                                ) as DOSQ
                      , sum( b.KOS                                 ) as KOS
                      , sum( b.KOSQ                                ) as KOSQ
                      , sum( decode( sign(b.OST ),-1, -b.OST , 0 ) ) as OSTD
                      , sum( decode( sign(b.OSTQ),-1, -b.OSTQ, 0 ) ) as OSTDQ
                      , sum( decode( sign(b.OST ), 1,  b.OST , 0 ) ) as OSTK
                      , sum( decode( sign(b.OSTQ), 1,  b.OSTQ, 0 ) ) as OSTKQ
                   from BARS.ACCOUNTS a
                   join BARS.SNAP_BALANCES b
                     on ( b.KF = a.KF and b.ACC = a.ACC and b.FDAT = p_date )
                  where a.NBS Not like '8%'
                    and a.NBS Not like '0%'
                    and a.NBS Is Not Null
                    and ( b.DOS > 0 or b.KOS > 0 or b.OST <> 0 )
                  group by b.FDAT, a.KF, a.BRANCH, a.NBS, a.KV
               ) s
          join BARS.REGIONS r
            on ( r.KF = s.KF )
        ;
        
      end if;
      
      bars_audit.info( 'p_show_balance: Inserted '||sql%rowcount||' records.' );
      
      commit; -- because we used hint APPEND
      
      ---------------------------
      -- группировочные строки --
      ---------------------------
      
      -- группа #3 ( KF, NBS, KV )
      insert
        into TMP_SHOW_BALANCE_DATA
           ( SHOW_DATE, KF, KF_NAME, NBS, KV, DOS, DOSQ, KOS, KOSQ, OSTD, OSTDQ, OSTK, OSTKQ, ROW_TYPE )
      select SHOW_DATE, KF, KF_NAME, NBS, KV, 0, sum(DOSQ), 0, sum(KOSQ), 0, sum(OSTDQ), 0, sum(OSTKQ), G_GROUP_3
        from BARS.TMP_SHOW_BALANCE_DATA
       where SHOW_DATE = p_date
         and ROW_TYPE  = G_GROUP_DETAILS
       group by SHOW_DATE, KF, KF_NAME, NBS, KV;
      
      -- группа #2 ( KF, NBS )
      insert
        into TMP_SHOW_BALANCE_DATA
           ( SHOW_DATE, KF, KF_NAME, NBS, DOS, DOSQ, KOS, KOSQ, OSTD, OSTDQ, OSTK, OSTKQ, ROW_TYPE )
      select SHOW_DATE, KF, KF_NAME, NBS, 0, sum(DOSQ), 0, sum(KOSQ), 0, sum(OSTDQ), 0, sum(OSTKQ), G_GROUP_2
        from BARS.TMP_SHOW_BALANCE_DATA
       where SHOW_DATE = p_date
         and ROW_TYPE  = G_GROUP_3
       group by SHOW_DATE, KF, KF_NAME, NBS;
       
      -- группа #1 ( KF )
      insert 
        into TMP_SHOW_BALANCE_DATA
           ( SHOW_DATE, KF, KF_NAME, DOS, DOSQ, KOS, KOSQ, OSTD, OSTDQ, OSTK, OSTKQ, ROW_TYPE )
      select SHOW_DATE, KF, KF_NAME, 0, sum(DOSQ), 0, sum(KOSQ), 0, sum(OSTDQ), 0, sum(OSTKQ), G_GROUP_1
        from BARS.TMP_SHOW_BALANCE_DATA
       where SHOW_DATE = p_date
         and ROW_TYPE  = G_GROUP_2
       group by SHOW_DATE, KF, KF_NAME;
      
      -- группировочные строки (3-я группа - весь банк)
      insert
        into TMP_SHOW_BALANCE_DATA
           ( SHOW_DATE, KF, KF_NAME, DOS, DOSQ, KOS, KOSQ, OSTD, OSTDQ, OSTK, OSTKQ, ROW_TYPE )
      select SHOW_DATE, '/', 'Всі РУ', 0, sum(DOSQ), 0, sum(KOSQ), 0, sum(OSTDQ), 0, sum(OSTKQ), G_GROUP_0
        from BARS.TMP_SHOW_BALANCE_DATA
       where SHOW_DATE = p_date
         and ROW_TYPE  = G_GROUP_1
       group by SHOW_DATE;
      
      -- return user policy group
      BARS_CONTEXT.SET_POLICY_GROUP(l_user_policy);
      
    exception
      when NO_DATA_FOUND then
        BARS_CONTEXT.SET_POLICY_GROUP(l_user_policy);
    end;
    
  end if;
  
  bars.bars_audit.trace( 'p_show_balance: Exit.' );
  
end p_show_balance;
/

show err
