SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET APPINFO      ON

alter index IDX_OPER_VDAT_KF modify default attributes tablespace BRSOPERI;

SET FEEDBACK OFF

-- procedure SPLIT_PARTITION
declare
  l_spl_stmt   varchar2(512);
  l_ptsn1_nm   varchar2(30);
  l_split_dt   varchar2(64);
begin
  for c1 in ( select add_months( trunc(sysdate,'YYYY'), level*3 ) as DT
                   , '_Q'||to_char(level) as QTR_NUM
               from dual
            connect by level <= 4 )
  loop
    l_split_dt := 'to_date('||DBMS_ASSERT.ENQUOTE_LITERAL(to_char(c1.DT,'YYYYMMDD'))||',''YYYYMMDD'')';
    l_ptsn1_nm := 'OPER_Y'||to_char(extract( year from sysdate ))||c1.QTR_NUM;
    l_spl_stmt := 'alter index IDX_OPER_VDAT_KF split partition P_MAXVALUE at ( '||l_split_dt||
                  ', MAXVALUE ) into ( partition '||l_ptsn1_nm||'_MAXVALUE, partition P_MAXVALUE )';
    begin
      dbms_output.put_line( l_spl_stmt );
      execute immediate l_spl_stmt;
      dbms_output.put_line( 'Index altered.' );
    exception
      when OTHERS then
        dbms_output.put_line( sqlerrm );
    end;
    for c2 in ( select KF from regions order by KF )
    loop
      l_spl_stmt := 'alter index IDX_OPER_VDAT_KF split partition %ptsn1_nm_MAXVALUE at ( %dt, ''%kf'' ) into ( partition %ptsn1_nm_%kf, partition %ptsn1_nm_MAXVALUE )';
      l_spl_stmt := replace( l_spl_stmt, '%ptsn1_nm', l_ptsn1_nm );
      l_spl_stmt := replace( l_spl_stmt, '%dt', l_split_dt );
      l_spl_stmt := replace( l_spl_stmt, '%kf', c2.KF );
      dbms_output.put_line( l_spl_stmt );
      begin
        execute immediate l_spl_stmt;
        dbms_output.put_line( 'Index altered.' );
      exception
        when OTHERS then
          dbms_output.put_line( 'split error: '||sqlerrm );
      end;
      begin
        execute immediate 'alter index IDX_OPER_VDAT_KF rebuild partition '||l_ptsn1_nm||'_'||c2.KF||' parallel 24';
        dbms_output.put_line( 'Index altered.' );
      exception
        when OTHERS then
          dbms_output.put_line( 'rebuild error: '||sqlerrm );
      end;
      if ( c2.KF = '356334' )
      then -- last
        begin
          execute immediate 'alter index IDX_OPER_VDAT_KF drop partition '||l_ptsn1_nm||'_MAXVALUE';
          dbms_output.put_line( 'Index altered.' );
        exception
          when OTHERS then
            dbms_output.put_line( 'drop error: '||sqlerrm );
        end;
      end if;
    end loop;
  end loop;
end;
/

SET FEEDBACK ON

alter index IDX_OPER_VDAT_KF rebuild partition P_MAXVALUE tablespace BRSOPERI parallel 24;
