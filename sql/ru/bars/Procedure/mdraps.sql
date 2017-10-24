

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/MDRAPS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure MDRAPS ***

  CREATE OR REPLACE PROCEDURE BARS.MDRAPS 
( dat_    date
) IS
  -- ̳���� ����� ������� (������)
  -- Ver: 5.7  12/02/2016
  --
  title   constant  varchar2(60) := 'MDRAPS';
  dat0_             DATE; -- ������� ���������� ���� ������� �����
  dat1_             DATE; -- ������ ����������� ���� �����
  dat2_             DATE; -- ������� ����������� ���� �����
  dat3_             DATE; -- ������ ���� ������������ �����
  l_errmsg          varchar2(500);
BEGIN

  bars_audit.info( 'MONDRAP: Start with dat_='||to_char(dat_,'dd.mm.yyyy') );

  IF ( dat_ Is Null )
  THEN
    raise_application_error( -20666, '�� ������� ���� ��� ���������� �����!' );
  ELSE
    dat1_ := trunc(dat_,'MM');
    dat2_ := last_day(dat1_);
    dat3_ := trunc(dat1_-1,'MM');
  END IF;

  -- �������� �� �������� ��� ������ ����� �����
  select LISTAGG(to_char(k.FDAT,'dd-mm-yyyy'),', ') WITHIN GROUP (order by k.FDAT)
    into l_errmsg
    from BARS.FDAT k
   where not exists (select 1 from BARS.SNAP_BALANCES where FDAT = k.FDAT)
     and k.FDAT between dat1_ and dat2_;

  IF ( l_errmsg Is Not Null )
  THEN
    raise_application_error( -20666, '³������ �������� ����� ������� ��: ' || l_errmsg );
  END IF;

  SELECT max(FDAT)
    INTO dat0_
    FROM SNAP_BALANCES
   WHERE FDAT between dat1_ and dat2_;

  IF ( dat0_ Is Null )
  THEN
    raise_application_error( -20666, '³����� ������ ����� ������� �� '|| F_MONTH_LIT(dat1_,1,2) || '��.' );
  END IF;

  -- �������� �������� ��������� ������� ���������� �����
  l_errmsg := BARS_UTL_SNAPSHOT.CHECK_SNP_RUNNING('MONBALS');

  if (l_errmsg is Not Null)
  then
    raise_application_error( -20666, '���������� �������� ����� ������� ��� �������� ������������ ' || l_errmsg );
  else
    -- ���������� �� �������� �������
    BARS_UTL_SNAPSHOT.SET_RUNNING_FLAG('MONBALS');
    gl.setp('MONBAL', SYS_CONTEXT ('USERENV', 'SID'), NULL); -- deprecated (for compatibility)
  end if;

  dbms_application_info.set_client_info( '���������� �������� ����� ������� �� ' || F_MONTH_LIT(dat1_,1,2) || '��.' );

  execute immediate 'TRUNCATE TABLE BARS.AGG_MONBALS_EXCHANGE';

  -- Գ����� SCN �� ����� ������� ����� ������� �� ����. SALDOZ
  BARS_UTL_SNAPSHOT.set_table_scn( 'SALDOZ', dat1_, dbms_flashback.get_system_change_number() );

  insert
    into BARS.AGG_MONBALS_EXCHANGE
       ( acc, fdat, rnk, ost, ostq, dos, kos, dosq, kosq,
         crdos, crkos, crdosq, crkosq, cudos, cukos, cudosq, cukosq )
  select NVL(b.acc, z.acc) acc, dat1_ fdat, NVL(b.rnk, 1) rnk,
         NVL(b.ost,  0) ost,    NVL(b.ostq, 0) ostq,
         NVL(b.dos,  0) dos,    NVL(b.kos,  0) kos,
         NVL(b.dosq, 0) dosq,   NVL(b.kosq, 0) kosq,
         NVL(z.rdos, 0) crdos,  NVL(z.rkos, 0) crkos,
         NVL(z.rdosq,0) crdosq, NVL(z.rkosq,0) crkosq,
         NVL(z.udos, 0) cudos,  NVL(z.ukos, 0) cukos,
         NVL(z.udosq,0) cudosq, NVL(z.ukosq,0) cukosq
    from ( select acc
                , sum(decode(fdat, dat0_, ost,  0)) ost
                , sum(decode(fdat, dat0_, ostq, 0)) ostq
                , sum(dos) dos, sum(dosq) dosq
                , sum(kos) kos, sum(kosq) kosq,
                  abs(max(decode(fdat, dat0_, rnk, -rnk))) rnk
             from SNAP_BALANCES
            where FDAT between dat1_ and dat2_
            group by ACC
         ) b
    full
    join ( select NVL(r.acc,u.acc) acc
                , r.dos rdos, r.dosq rdosq
                , r.kos rkos, r.kosq rkosq
                , u.dos udos, u.dosq udosq
                , u.kos ukos, u.kosq ukosq
             from ( select * from saldoz where fdat=dat1_ ) r
             full
             join ( select * from saldoz where fdat=dat3_ ) u
               on ( u.acc = r.acc )
         ) z
      on ( z.ACC = b.ACC );

  bars_audit.trace( '%s: %s row created.', title, to_char(SQL%ROWCOUNT) );

  COMMIT;

  -- partition is first locked to ensure that the partition is created
  execute immediate 'LOCK TABLE BARS.AGG_MONBALS PARTITION FOR (to_date('''
                    || to_char(dat1_,'ddmmyyyy') || ''',''DDMMYYYY'')) IN SHARE MODE';

  execute immediate 'ALTER TABLE BARS.AGG_MONBALS EXCHANGE PARTITION FOR (to_date('''
                    || to_char(dat1_,'ddmmyyyy') || ''',''DDMMYYYY'')) WITH TABLE BARS.AGG_MONBALS_EXCHANGE '
                    || 'INCLUDING INDEXES WITHOUT VALIDATION';

  execute immediate 'TRUNCATE TABLE BARS.AGG_MONBALS_EXCHANGE';

  gl.setp('MONBAL','',NULL); -- deprecated (for compatibility)

  BARS_UTL_SNAPSHOT.PURGE_RUNNING_FLAG();

  bars_audit.info( 'MONDRAP: Exit.' );

EXCEPTION
  WHEN OTHERS THEN
    gl.setp('MONBAL','',NULL); -- deprecated (for compatibility)
    BARS_UTL_SNAPSHOT.PURGE_RUNNING_FLAG();
    bars_audit.error( title || ': ' || dbms_utility.format_error_stack() ||
                            chr(10) || dbms_utility.format_error_backtrace() );
    raise;
END;
/
show err;

PROMPT *** Create  grants  MDRAPS ***
grant EXECUTE                                                                on MDRAPS          to ABS_ADMIN;
grant EXECUTE                                                                on MDRAPS          to BARSUPL;
grant EXECUTE                                                                on MDRAPS          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on MDRAPS          to START1;
grant EXECUTE                                                                on MDRAPS          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/MDRAPS.sql =========*** End *** ==
PROMPT ===================================================================================== 
