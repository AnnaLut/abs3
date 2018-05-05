SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET DEFINE       OFF
SET TIMING       ON
SET TRIMSPOOL    ON

declare
  l_d_qty   pls_integer := 0;
  l_u_qty   pls_integer := 0;
begin
  for c in ( select g.ROWID as RID
                  , g.KF
                  , g.RNK
                  , g.GCIF 
                  , c.KF    as CUST_KF
                  , c.RNK   as CUST_ID
               from EBKC_GCIF g
               left
               join CUSTOMER c
                 on ( c.RNK = g.RNK )
              where c.KF <> g.KF 
                 or c.RNK Is null 
           )
  loop
    case
    when ( c.CUST_ID Is Null )
    then
      delete EBKC_GCIF
       where ROWID = c.RID;
      l_d_qty := l_d_qty + 1;
    when ( c.KF != c.CUST_KF )
    then
      begin
        update EBKC_GCIF
           set KF = c.CUST_KF
         where ROWID = c.RID;
        l_u_qty := l_u_qty + 1;
      exception
        when others 
        then dbms_output.put_line( 'KF='||c.KF||', RNK='||c.RNK||', GCIF='||c.GCIF||', CUST_KF='||c.CUST_KF||' -> '||sqlerrm );
      end;
    else
      null;
    end case;
  end loop;
  dbms_output.put_line( to_char(l_d_qty)||' row(s) deleted.' );
  dbms_output.put_line( to_char(l_u_qty)||' row(s) updated.' );
end;
/

commit;

declare
  l_d_qty   pls_integer := 0;
  l_u_qty   pls_integer := 0;
begin
  for c in ( select g.ROWID as RID
                  , g.SLAVE_KF
                  , g.SLAVE_RNK
                  , g.GCIF 
                  , c.KF    as CUST_KF
                  , c.RNK   as CUST_ID
               from EBKC_SLAVE g
               left
               join CUSTOMER c
                 on ( c.RNK = g.SLAVE_RNK )
              where c.KF <> g.SLAVE_KF 
                 or c.RNK Is null 
           )
  loop
    case
    when ( c.CUST_ID Is Null )
    then
      delete EBKC_SLAVE
       where ROWID = c.RID;
      l_d_qty := l_d_qty + 1;
    when ( c.SLAVE_KF != c.CUST_KF )
    then
      begin
        update EBKC_SLAVE
           set SLAVE_KF = c.CUST_KF
         where ROWID = c.RID;
        l_u_qty := l_u_qty + 1;
      exception
        when others 
        then dbms_output.put_line( 'KF='||c.SLAVE_KF||', RNK='||c.SLAVE_RNK||', GCIF='||c.GCIF||', CUST_KF='||c.CUST_KF||' -> '||sqlerrm );
      end;
    else
      null;
    end case;
  end loop;
  dbms_output.put_line( to_char(l_d_qty)||' row(s) deleted.' );
  dbms_output.put_line( to_char(l_u_qty)||' row(s) updated.' );
end;
/

commit;

declare
  l_i_qty   pls_integer := 0;
begin
  for c in ( select KF, RNK, GCIF, CUST_TYPE
               from ( select s.SLAVE_KF as KF
                           , s.SLAVE_RNK as RNK
                           , s.GCIF
                           , s.CUST_TYPE 
                        from EBKC_SLAVE s
                        join MV_KF f
                          on ( f.KF = s.SLAVE_KF )
                    )
              minus
             select KF, RNK, GCIF, CUST_TYPE
               from EBKC_GCIF 
           )
  loop
    begin
      insert
        into EBKC_GCIF
           ( KF, RNK, GCIF, CUST_TYPE )
      values
           ( c.KF, c.RNK, c.GCIF, c.CUST_TYPE );
      l_i_qty := l_i_qty + 1;
    exception
      when DUP_VAL_ON_INDEX 
      then null;
    end;
  end loop;
  dbms_output.put_line( to_char(l_i_qty)||' row(s) inserted.' );
end;
/

declare
  e_tab_not_exists exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  execute immediate 'drop table EBKC_SLAVE';
  dbms_output.put_line( 'Table dropped.' );
exception
  when e_tab_not_exists 
  then null;
end;
/

declare
  e_pcd_not_exists       exception;
  pragma exception_init( e_pcd_not_exists, -04043 );
begin
  execute immediate 'drop procedure EBK_CREATE_RCIF';
  dbms_output.put_line( 'Procedure dropped.' );
exception
  when e_pcd_not_exists
  then null;
end;
/

declare
  e_tab_not_exists       exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  execute immediate 'drop table EBKC_RCIF';
  dbms_output.put_line( 'Table dropped.' );
exception
  when e_tab_not_exists 
  then null;
end;
/

declare
  e_tab_not_exists       exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  execute immediate 'drop table EBK_RCIF';
  dbms_output.put_line( 'Table dropped.' );
exception
  when e_tab_not_exists
  then null;
end;
/

declare
  e_job_not_exists       exception;
  pragma exception_init( e_job_not_exists, -27475 );
begin
  DBMS_SCHEDULER.DROP_JOB
  ( job_name  => 'EBK_RCIF_PACAKGES_JOB'
  , force     => TRUE );
  dbms_output.put_line( 'Job dropped.' );
exception
  when e_job_not_exists 
  then null;
end;
/

