--
-- old reporting module
--
declare
  e_tab_not_exists       exception;
  pragma exception_init( e_tab_not_exists, -00942 );
  e_col_not_exists       exception;
  pragma exception_init( e_col_not_exists, -00904 );
  e_cannot_dec_col_len   exception;
  pragma exception_init( e_cannot_dec_col_len, -01441 );
  ---
  procedure ALTER_TAB
  ( p_tab_nm in varchar2
  , p_col_nm in varchar2
  ) is
  begin
    begin
      execute immediate 'alter table '||p_tab_nm||' modify '||p_col_nm||' varchar2(254)';
      dbms_output.put_line( 'Table "'||p_tab_nm||'" altered.' );
    exception
      when e_tab_not_exists 
      then dbms_output.put_line( 'Table "'||p_tab_nm||'" does not exist.' );
      when e_col_not_exists 
      then dbms_output.put_line( 'Column "'||p_col_nm||'" does not exist in table.' );
      when e_cannot_dec_col_len
      then dbms_output.put_line( 'Cannot decrease column length because some value is too big.' );
    end;
  end ALTER_TAB;
  ---
begin
  ALTER_TAB( 'TMP_NBU',         'ZNAP' );
  ALTER_TAB( 'RNBU_TRACE',      'ZNAP' );
  ALTER_TAB( 'RNBU_TRACE_ARCH', 'ZNAP' );
end;
/

--
-- new reporting module
--
begin
  -- NBUR_AGG_PROTOCOLS
  NBUR_UTIL.SET_COL('NBUR_AGG_PROTOCOLS','FIELD_VALUE','VARCHAR2(256)');
  
  -- NBUR_AGG_PROTOCOLS_ARCH
  NBUR_UTIL.SET_COL('NBUR_AGG_PROTOCOLS_ARCH','FIELD_VALUE','VARCHAR2(256)');
  
  -- NBUR_DETAIL_PROTOCOLS
  NBUR_UTIL.SET_COL('NBUR_DETAIL_PROTOCOLS','FIELD_VALUE','VARCHAR2(256)');
  
  -- NBUR_DETAIL_PROTOCOLS_ARCH
  NBUR_UTIL.SET_COL('NBUR_DETAIL_PROTOCOLS_ARCH','FIELD_VALUE','VARCHAR2(256)');
  
end;
/
