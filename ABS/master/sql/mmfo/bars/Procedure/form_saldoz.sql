CREATE OR REPLACE PROCEDURE BARS.FORM_SALDOZ
( z_dat31   DATE
, p_acc     number default null
, p_korr    boolean default false
, p_incl_ZG boolean default false
) IS
  /**
  <b>FORM_SALDOZ</b> - ��������������� ���������� ������� �� ����� ����
  %param p_dat31 - ������� ������� �����������  �����
  %param p_acc  - ������������� ����������� �������
  %param p_korr  - ����������, ���� ������ ���� ����������� ��� ������� ����������
  %param p_incl_ZG  - �� �������� ������� ZG

  %version 3.4  20/03/2019 (09/02/2019)
  %usage   ��������������� ������� ��������� �������.
  */
  l_dat    DATE := trunc( z_dat31, 'MM' ); -- 1e ����� ������� �����-- �������� �����������:
  l_dat0   DATE := add_months( l_dat, 1 );
  l_dat1   DATE := last_day(l_dat0);
  
  l_dat_yyyy    DATE := DAT_NEXT_U(trunc(z_dat31, 'yyyy'), -1); --��������� ���� ���� ����
BEGIN

  bars_audit.info( $$PLSQL_UNIT||': Start '  ||to_char(l_dat, 'dd/mm/yyyy')||' �� '||to_char(z_dat31,'dd/mm/yyyy') );
  bars_audit.info( $$PLSQL_UNIT||': ������� '||to_char(l_dat0,'dd/mm/yyyy')||' < ' ||to_char(l_dat1, 'dd/mm/yyyy') );
    
  -- ����������� ����� ���� ����������� ��� ������� ����������
  if p_korr then
     for k in (select *
               from oper
               where vob = 96 and
                     vdat between l_dat0 and l_dat1 and
                     sos = 5 and
                     vdat <> z_dat31)
     loop
         update oper o
         set o.vdat = z_dat31
         where o.ref = k.ref;    
         commit;
     end loop;
  end if;
          
  if ( p_acc is null )
  then

    bars_audit.info( $$PLSQL_UNIT||': for all accounts.' );
    
    delete SALDOZ
     where FDAT = l_dat;
    
    if not p_incl_ZG then -- �� �������� ������� �� ��������� ����������
        insert
          into SALDOZ
             ( KF, FDAT, ACC, DOS, DOSQ, KOS, KOSQ, DOS_YR, DOSQ_YR, KOS_YR, KOSQ_YR )
        select /*+ FULL( o ) */ o.KF, l_dat, o.ACC
             , sum( case when ( o.DK = 0 and d.VOB = 96 ) then o.S  else 0 end ) as DOS
             , sum( case when ( o.DK = 0 and d.VOB = 96 ) then o.SQ else 0 end ) as DOSQ
             , sum( case when ( o.DK = 1 and d.VOB = 96 ) then o.S  else 0 end ) as KOS
             , sum( case when ( o.DK = 1 and d.VOB = 96 ) then o.SQ else 0 end ) as KOSQ
             , sum( case when ( o.DK = 0 and d.VOB = 99 ) then o.S  else 0 end ) as DOS_YR
             , sum( case when ( o.DK = 0 and d.VOB = 99 ) then o.SQ else 0 end ) as DOSQ_YR
             , sum( case when ( o.DK = 1 and d.VOB = 99 ) then o.S  else 0 end ) as KOS_YR
             , sum( case when ( o.DK = 1 and d.VOB = 99 ) then o.SQ else 0 end ) as KOSQ_YR
          from OPLDOK o
          join OPER   d
            on ( d.KF = o.KF and d.REF = o.REF )
         where o.FDAT between l_dat0 AND l_dat1
           and o.SOS  = 5
           and d.VDAT = any (z_dat31, l_dat_yyyy)
           and d.VOB  = any ( 96, 99 )
           and d.tt not like 'ZG%'
         group BY o.KF, o.ACC;
    else
        insert
          into SALDOZ
             ( KF, FDAT, ACC, DOS, DOSQ, KOS, KOSQ, DOS_YR, DOSQ_YR, KOS_YR, KOSQ_YR )
        select /*+ FULL( o ) */ o.KF, l_dat, o.ACC
             , sum( case when ( o.DK = 0 and d.VOB = 96 ) then o.S  else 0 end ) as DOS
             , sum( case when ( o.DK = 0 and d.VOB = 96 ) then o.SQ else 0 end ) as DOSQ
             , sum( case when ( o.DK = 1 and d.VOB = 96 ) then o.S  else 0 end ) as KOS
             , sum( case when ( o.DK = 1 and d.VOB = 96 ) then o.SQ else 0 end ) as KOSQ
             , sum( case when ( o.DK = 0 and d.VOB = 99 ) then o.S  else 0 end ) as DOS_YR
             , sum( case when ( o.DK = 0 and d.VOB = 99 ) then o.SQ else 0 end ) as DOSQ_YR
             , sum( case when ( o.DK = 1 and d.VOB = 99 ) then o.S  else 0 end ) as KOS_YR
             , sum( case when ( o.DK = 1 and d.VOB = 99 ) then o.SQ else 0 end ) as KOSQ_YR
          from OPLDOK o
          join OPER   d
            on ( d.KF = o.KF and d.REF = o.REF )
         where o.FDAT between l_dat0 AND l_dat1
           and o.SOS  = 5
           and d.VDAT = any (z_dat31, l_dat_yyyy)
           and d.VOB  = any ( 96, 99 )
         group BY o.KF, o.ACC;    
    end if;
    commit;
    
    insert
      into SALDOZ
         ( KF, FDAT, ACC, DOS, DOSQ, KOS, KOSQ, DOS_YR, DOSQ_YR, KOS_YR, KOSQ_YR )
    select s.KF, s.FDAT, a.ACCC
         , sum(s.DOS    ) as DOS
         , sum(s.DOSQ   ) as DOSQ
         , sum(s.KOS    ) as KOS
         , sum(s.KOSQ   ) as KOSQ
         , sum(s.DOS_YR ) as DOS_YR
         , sum(s.DOSQ_YR) as DOSQ_YR
         , sum(s.KOS_YR ) as KOS_YR
         , sum(s.KOSQ_YR) as KOSQ_YR
      from SALDOZ   s
      join ACCOUNTS a
        on ( a.KF = s.KF and a.ACC = s.ACC )
     WHERE s.FDAT = l_dat
       and a.NBS Is Null
     group by s.KF, s.FDAT, a.ACCC;
     commit;
     
     -- 
     if z_dat31 = to_date('31012019', 'ddmmyyyy') then
        --�������� � ��������� ZG
        FORM_SALDOZ(to_date('29122018', 'ddmmyyyy'), null, false, true);
        commit;
     end if;
  else

    bars_audit.info( $$PLSQL_UNIT||': for acc = '||to_char(p_acc) );

    delete SALDOZ
     where FDAT = l_dat
       and ACC  = p_acc;

    insert
      into SALDOZ
         ( KF, FDAT, ACC, DOS, DOSQ, KOS, KOSQ, DOS_YR, DOSQ_YR, KOS_YR, KOSQ_YR )
    select o.KF, l_dat, o.ACC
         , sum( case when ( o.DK = 0 and d.VOB = 96 ) then o.S  else 0 end ) as DOS
         , sum( case when ( o.DK = 0 and d.VOB = 96 ) then o.SQ else 0 end ) as DOSQ
         , sum( case when ( o.DK = 1 and d.VOB = 96 ) then o.S  else 0 end ) as KOS
         , sum( case when ( o.DK = 1 and d.VOB = 96 ) then o.SQ else 0 end ) as KOSQ
         , sum( case when ( o.DK = 0 and d.VOB = 99 ) then o.S  else 0 end ) as DOS_YR
         , sum( case when ( o.DK = 0 and d.VOB = 99 ) then o.SQ else 0 end ) as DOSQ_YR
         , sum( case when ( o.DK = 1 and d.VOB = 99 ) then o.S  else 0 end ) as KOS_YR
         , sum( case when ( o.DK = 1 and d.VOB = 99 ) then o.SQ else 0 end ) as KOSQ_YR
      from OPLDOK o
      join OPER   d
        on ( d.KF = o.KF and d.REF = o.REF )
     where o.FDAT between l_dat0 AND l_dat1
       and o.SOS  = 5
       and o.ACC  = p_acc
       and d.VDAT = any (z_dat31, l_dat_yyyy)
       and d.VOB  = any ( 96, 99 )
       and d.tt not like 'ZG%'
     group BY o.KF, o.ACC;
     commit;
  end if;

  bars_audit.info( $$PLSQL_UNIT||': Finish (���������� '||to_char(sql%rowcount)||' ������).' );

END FORM_SALDOZ;
/