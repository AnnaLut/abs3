-- ================================================================================
-- Date   : 03.08.2018
-- ================================== <Comments> ==================================
-- recreate table BPK_PARAMETERS
-- ================================================================================

/*SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET DEFINE       OFF
SET ECHO         OFF
SET FEEDBACK     OFF
SET LINES        200
SET PAGES        200
SET TERMOUT      ON
SET TIMING       ON
SET TRIMSPOOL    ON
SET VERIFY       OFF

prompt -- ======================================================
prompt -- recreate table BPK_PARAMETERS
prompt -- ======================================================*/


begin
  execute immediate 'CREATE TABLE TMP_BPK_PARAMETERS AS select * from BPK_PARAMETERS';
  dbms_output.put_line( 'table TMP_BPK_PARAMETERS created.' );
exception
  when others
  then null;
end;
/


begin
bars_policy_adm.disable_policies(p_table_name => 'BPK_PARAMETERS_UPDATE');
end;
/
begin
bars_policy_adm.disable_policies(p_table_name => 'BPK_PARAMETERS');
end;
/



begin
  execute immediate 'ALTER TABLE BPK_PARAMETERS DROP CONSTRAINT PK_BPKPARAMETERS';
  dbms_output.put_line( 'PK dropped.' );
exception
  when others
  then null;
end;
/


declare
  E_IDX_NOT_EXISTS        exception;
  pragma exception_init( E_IDX_NOT_EXISTS, -01418 );
begin
  execute immediate 'drop index PK_BPKPARAMETERS';
  dbms_output.put_line( 'Index dropped.' );
exception
  when E_IDX_NOT_EXISTS
  then null;
end;
/

declare
  l_tab_nm            varchar2(30);
  l_ptsn_f            number(1);
  l_col_lst           varchar2(2048);
  l_tab_stmt          varchar2(32000);
  type r_stmt_type is record ( obj_tp    varchar2(30)
                             , obj_nm    varchar2(30)
                             , ddl_txt   varchar2(16384)
                             );
  type t_stmt_type is table of r_stmt_type;
  t_stmt              t_stmt_type := t_stmt_type();
  ---
  e_tab_not_exists       exception;
  pragma exception_init( e_tab_not_exists, -00942 );
  e_tab_rd_only          exception;
  pragma exception_init( e_tab_rd_only,    -14139 );
  e_col_already_nn       exception;
  pragma exception_init( e_col_already_nn, -01442 );
begin

  l_tab_nm := 'BPK_PARAMETERS';

  -- перевірка наяності SUBPARTITIONS
  select case
         when EXISTS( select 1
                        from ALL_TAB_SUBPARTITIONS
                       where TABLE_OWNER = 'BARS'
                         and TABLE_NAME  = l_tab_nm )
         then 1
         else 0
         end
    into l_ptsn_f
    from dual;

  if ( l_ptsn_f = 0 )
  then -- якщо SUBPARTITIONS відсутні

    begin
      execute immediate 'drop table TEST_'||l_tab_nm||' cascade constraints';
      dbms_output.put_line( 'Table "TEST_'||l_tab_nm||'" dropped.' );
    exception
      when e_tab_not_exists
      then null;
    end;

    execute immediate 'ALTER SESSION ENABLE PARALLEL DDL';
    execute immediate 'ALTER SESSION ENABLE PARALLEL DML';

    -- KF + all other columns
    select LISTAGG(t.COLUMN_NAME,', ') WITHIN GROUP ( order by case t.COLUMN_NAME when 'KF' then -1 else t.COLUMN_ID end )
      into l_col_lst
      from ALL_TAB_COLS t
     where t.OWNER = 'BARS'
       and t.TABLE_NAME = l_tab_nm
       and t.COLUMN_ID > 0
--     and t.HIDDEN_COLUMN = 'NO'
--     and t.VIRTUAL_COLUMN = 'NO'
    ;

    begin
      execute immediate 'alter table ' || l_tab_nm || ' read only';
    exception
      when e_tab_rd_only then
        dbms_output.put_line( 'Table "'|| l_tab_nm || '" is already in read-only mode.' );
    end;

    l_tab_stmt := 'create table TEST_' || l_tab_nm || chr(10) || '( ' ||
    replace('KF,'|| l_col_lst, 'KF,', q'[KF default sys_context('bars_context','user_mfo') not null,]' ) || q'[
) tablespace BRSACCM
PARALLEL 24
PARTITION BY LIST (TAG)
SUBPARTITION BY LIST (KF)
(
  partition P_VNCRP values ('VNCRP')
  ( SUBPARTITION VNCRPSP_300465 VALUES ( '300465' )
, SUBPARTITION VNCRPSP_302076 VALUES ( '302076' )
, SUBPARTITION VNCRPSP_303398 VALUES ( '303398' )
, SUBPARTITION VNCRPSP_304665 VALUES ( '304665' )
, SUBPARTITION VNCRPSP_305482 VALUES ( '305482' )
, SUBPARTITION VNCRPSP_311647 VALUES ( '311647' )
, SUBPARTITION VNCRPSP_312356 VALUES ( '312356' )
, SUBPARTITION VNCRPSP_313957 VALUES ( '313957' )
, SUBPARTITION VNCRPSP_315784 VALUES ( '315784' )
, SUBPARTITION VNCRPSP_322669 VALUES ( '322669' )
, SUBPARTITION VNCRPSP_323475 VALUES ( '323475' )
, SUBPARTITION VNCRPSP_324805 VALUES ( '324805' )
, SUBPARTITION VNCRPSP_325796 VALUES ( '325796' )
, SUBPARTITION VNCRPSP_326461 VALUES ( '326461' )
, SUBPARTITION VNCRPSP_328845 VALUES ( '328845' )
, SUBPARTITION VNCRPSP_331467 VALUES ( '331467' )
, SUBPARTITION VNCRPSP_333368 VALUES ( '333368' )
, SUBPARTITION VNCRPSP_335106 VALUES ( '335106' )
, SUBPARTITION VNCRPSP_336503 VALUES ( '336503' )
, SUBPARTITION VNCRPSP_337568 VALUES ( '337568' )
, SUBPARTITION VNCRPSP_338545 VALUES ( '338545' )
, SUBPARTITION VNCRPSP_351823 VALUES ( '351823' )
, SUBPARTITION VNCRPSP_352457 VALUES ( '352457' )
, SUBPARTITION VNCRPSP_353553 VALUES ( '353553' )
, SUBPARTITION VNCRPSP_354507 VALUES ( '354507' )
, SUBPARTITION VNCRPSP_356334 VALUES ( '356334' )
),
  partition P_VNCRR values ('VNCRR')
  ( SUBPARTITION VNCRRSP_300465 VALUES ( '300465' )
, SUBPARTITION VNCRRSP_302076 VALUES ( '302076' )
, SUBPARTITION VNCRRSP_303398 VALUES ( '303398' )
, SUBPARTITION VNCRRSP_304665 VALUES ( '304665' )
, SUBPARTITION VNCRRSP_305482 VALUES ( '305482' )
, SUBPARTITION VNCRRSP_311647 VALUES ( '311647' )
, SUBPARTITION VNCRRSP_312356 VALUES ( '312356' )
, SUBPARTITION VNCRRSP_313957 VALUES ( '313957' )
, SUBPARTITION VNCRRSP_315784 VALUES ( '315784' )
, SUBPARTITION VNCRRSP_322669 VALUES ( '322669' )
, SUBPARTITION VNCRRSP_323475 VALUES ( '323475' )
, SUBPARTITION VNCRRSP_324805 VALUES ( '324805' )
, SUBPARTITION VNCRRSP_325796 VALUES ( '325796' )
, SUBPARTITION VNCRRSP_326461 VALUES ( '326461' )
, SUBPARTITION VNCRRSP_328845 VALUES ( '328845' )
, SUBPARTITION VNCRRSP_331467 VALUES ( '331467' )
, SUBPARTITION VNCRRSP_333368 VALUES ( '333368' )
, SUBPARTITION VNCRRSP_335106 VALUES ( '335106' )
, SUBPARTITION VNCRRSP_336503 VALUES ( '336503' )
, SUBPARTITION VNCRRSP_337568 VALUES ( '337568' )
, SUBPARTITION VNCRRSP_338545 VALUES ( '338545' )
, SUBPARTITION VNCRRSP_351823 VALUES ( '351823' )
, SUBPARTITION VNCRRSP_352457 VALUES ( '352457' )
, SUBPARTITION VNCRRSP_353553 VALUES ( '353553' )
, SUBPARTITION VNCRRSP_354507 VALUES ( '354507' )
, SUBPARTITION VNCRRSP_356334 VALUES ( '356334' )
),
  partition P_SPPI values ('SPPI')
  ( SUBPARTITION SPPISP_300465 VALUES ( '300465' )
, SUBPARTITION SPPISP_302076 VALUES ( '302076' )
, SUBPARTITION SPPISP_303398 VALUES ( '303398' )
, SUBPARTITION SPPISP_304665 VALUES ( '304665' )
, SUBPARTITION SPPISP_305482 VALUES ( '305482' )
, SUBPARTITION SPPISP_311647 VALUES ( '311647' )
, SUBPARTITION SPPISP_312356 VALUES ( '312356' )
, SUBPARTITION SPPISP_313957 VALUES ( '313957' )
, SUBPARTITION SPPISP_315784 VALUES ( '315784' )
, SUBPARTITION SPPISP_322669 VALUES ( '322669' )
, SUBPARTITION SPPISP_323475 VALUES ( '323475' )
, SUBPARTITION SPPISP_324805 VALUES ( '324805' )
, SUBPARTITION SPPISP_325796 VALUES ( '325796' )
, SUBPARTITION SPPISP_326461 VALUES ( '326461' )
, SUBPARTITION SPPISP_328845 VALUES ( '328845' )
, SUBPARTITION SPPISP_331467 VALUES ( '331467' )
, SUBPARTITION SPPISP_333368 VALUES ( '333368' )
, SUBPARTITION SPPISP_335106 VALUES ( '335106' )
, SUBPARTITION SPPISP_336503 VALUES ( '336503' )
, SUBPARTITION SPPISP_337568 VALUES ( '337568' )
, SUBPARTITION SPPISP_338545 VALUES ( '338545' )
, SUBPARTITION SPPISP_351823 VALUES ( '351823' )
, SUBPARTITION SPPISP_352457 VALUES ( '352457' )
, SUBPARTITION SPPISP_353553 VALUES ( '353553' )
, SUBPARTITION SPPISP_354507 VALUES ( '354507' )
, SUBPARTITION SPPISP_356334 VALUES ( '356334' )
),
  partition P_BUS_MOD values ('BUS_MOD')
  ( SUBPARTITION BUS_MODSP_300465 VALUES ( '300465' )
, SUBPARTITION BUS_MODSP_302076 VALUES ( '302076' )
, SUBPARTITION BUS_MODSP_303398 VALUES ( '303398' )
, SUBPARTITION BUS_MODSP_304665 VALUES ( '304665' )
, SUBPARTITION BUS_MODSP_305482 VALUES ( '305482' )
, SUBPARTITION BUS_MODSP_311647 VALUES ( '311647' )
, SUBPARTITION BUS_MODSP_312356 VALUES ( '312356' )
, SUBPARTITION BUS_MODSP_313957 VALUES ( '313957' )
, SUBPARTITION BUS_MODSP_315784 VALUES ( '315784' )
, SUBPARTITION BUS_MODSP_322669 VALUES ( '322669' )
, SUBPARTITION BUS_MODSP_323475 VALUES ( '323475' )
, SUBPARTITION BUS_MODSP_324805 VALUES ( '324805' )
, SUBPARTITION BUS_MODSP_325796 VALUES ( '325796' )
, SUBPARTITION BUS_MODSP_326461 VALUES ( '326461' )
, SUBPARTITION BUS_MODSP_328845 VALUES ( '328845' )
, SUBPARTITION BUS_MODSP_331467 VALUES ( '331467' )
, SUBPARTITION BUS_MODSP_333368 VALUES ( '333368' )
, SUBPARTITION BUS_MODSP_335106 VALUES ( '335106' )
, SUBPARTITION BUS_MODSP_336503 VALUES ( '336503' )
, SUBPARTITION BUS_MODSP_337568 VALUES ( '337568' )
, SUBPARTITION BUS_MODSP_338545 VALUES ( '338545' )
, SUBPARTITION BUS_MODSP_351823 VALUES ( '351823' )
, SUBPARTITION BUS_MODSP_352457 VALUES ( '352457' )
, SUBPARTITION BUS_MODSP_353553 VALUES ( '353553' )
, SUBPARTITION BUS_MODSP_354507 VALUES ( '354507' )
, SUBPARTITION BUS_MODSP_356334 VALUES ( '356334' )
),
  partition P_IFRS values ('IFRS')
  ( SUBPARTITION IFRSSP_300465 VALUES ( '300465' )
, SUBPARTITION IFRSSP_302076 VALUES ( '302076' )
, SUBPARTITION IFRSSP_303398 VALUES ( '303398' )
, SUBPARTITION IFRSSP_304665 VALUES ( '304665' )
, SUBPARTITION IFRSSP_305482 VALUES ( '305482' )
, SUBPARTITION IFRSSP_311647 VALUES ( '311647' )
, SUBPARTITION IFRSSP_312356 VALUES ( '312356' )
, SUBPARTITION IFRSSP_313957 VALUES ( '313957' )
, SUBPARTITION IFRSSP_315784 VALUES ( '315784' )
, SUBPARTITION IFRSSP_322669 VALUES ( '322669' )
, SUBPARTITION IFRSSP_323475 VALUES ( '323475' )
, SUBPARTITION IFRSSP_324805 VALUES ( '324805' )
, SUBPARTITION IFRSSP_325796 VALUES ( '325796' )
, SUBPARTITION IFRSSP_326461 VALUES ( '326461' )
, SUBPARTITION IFRSSP_328845 VALUES ( '328845' )
, SUBPARTITION IFRSSP_331467 VALUES ( '331467' )
, SUBPARTITION IFRSSP_333368 VALUES ( '333368' )
, SUBPARTITION IFRSSP_335106 VALUES ( '335106' )
, SUBPARTITION IFRSSP_336503 VALUES ( '336503' )
, SUBPARTITION IFRSSP_337568 VALUES ( '337568' )
, SUBPARTITION IFRSSP_338545 VALUES ( '338545' )
, SUBPARTITION IFRSSP_351823 VALUES ( '351823' )
, SUBPARTITION IFRSSP_352457 VALUES ( '352457' )
, SUBPARTITION IFRSSP_353553 VALUES ( '353553' )
, SUBPARTITION IFRSSP_354507 VALUES ( '354507' )
, SUBPARTITION IFRSSP_356334 VALUES ( '356334' )
),
  partition P_DAT_ORIG_CA values ('DAT_ORIG_CA')
  ( SUBPARTITION DAT_ORIG_CASP_300465 VALUES ( '300465' )
, SUBPARTITION DAT_ORIG_CASP_302076 VALUES ( '302076' )
, SUBPARTITION DAT_ORIG_CASP_303398 VALUES ( '303398' )
, SUBPARTITION DAT_ORIG_CASP_304665 VALUES ( '304665' )
, SUBPARTITION DAT_ORIG_CASP_305482 VALUES ( '305482' )
, SUBPARTITION DAT_ORIG_CASP_311647 VALUES ( '311647' )
, SUBPARTITION DAT_ORIG_CASP_312356 VALUES ( '312356' )
, SUBPARTITION DAT_ORIG_CASP_313957 VALUES ( '313957' )
, SUBPARTITION DAT_ORIG_CASP_315784 VALUES ( '315784' )
, SUBPARTITION DAT_ORIG_CASP_322669 VALUES ( '322669' )
, SUBPARTITION DAT_ORIG_CASP_323475 VALUES ( '323475' )
, SUBPARTITION DAT_ORIG_CASP_324805 VALUES ( '324805' )
, SUBPARTITION DAT_ORIG_CASP_325796 VALUES ( '325796' )
, SUBPARTITION DAT_ORIG_CASP_326461 VALUES ( '326461' )
, SUBPARTITION DAT_ORIG_CASP_328845 VALUES ( '328845' )
, SUBPARTITION DAT_ORIG_CASP_331467 VALUES ( '331467' )
, SUBPARTITION DAT_ORIG_CASP_333368 VALUES ( '333368' )
, SUBPARTITION DAT_ORIG_CASP_335106 VALUES ( '335106' )
, SUBPARTITION DAT_ORIG_CASP_336503 VALUES ( '336503' )
, SUBPARTITION DAT_ORIG_CASP_337568 VALUES ( '337568' )
, SUBPARTITION DAT_ORIG_CASP_338545 VALUES ( '338545' )
, SUBPARTITION DAT_ORIG_CASP_351823 VALUES ( '351823' )
, SUBPARTITION DAT_ORIG_CASP_352457 VALUES ( '352457' )
, SUBPARTITION DAT_ORIG_CASP_353553 VALUES ( '353553' )
, SUBPARTITION DAT_ORIG_CASP_354507 VALUES ( '354507' )
, SUBPARTITION DAT_ORIG_CASP_356334 VALUES ( '356334' )
),
  partition P_DAT_CALC_PAY values ('DAT_CALC_PAY')
  ( SUBPARTITION DAT_CALC_PAYSP_300465 VALUES ( '300465' )
, SUBPARTITION DAT_CALC_PAYSP_302076 VALUES ( '302076' )
, SUBPARTITION DAT_CALC_PAYSP_303398 VALUES ( '303398' )
, SUBPARTITION DAT_CALC_PAYSP_304665 VALUES ( '304665' )
, SUBPARTITION DAT_CALC_PAYSP_305482 VALUES ( '305482' )
, SUBPARTITION DAT_CALC_PAYSP_311647 VALUES ( '311647' )
, SUBPARTITION DAT_CALC_PAYSP_312356 VALUES ( '312356' )
, SUBPARTITION DAT_CALC_PAYSP_313957 VALUES ( '313957' )
, SUBPARTITION DAT_CALC_PAYSP_315784 VALUES ( '315784' )
, SUBPARTITION DAT_CALC_PAYSP_322669 VALUES ( '322669' )
, SUBPARTITION DAT_CALC_PAYSP_323475 VALUES ( '323475' )
, SUBPARTITION DAT_CALC_PAYSP_324805 VALUES ( '324805' )
, SUBPARTITION DAT_CALC_PAYSP_325796 VALUES ( '325796' )
, SUBPARTITION DAT_CALC_PAYSP_326461 VALUES ( '326461' )
, SUBPARTITION DAT_CALC_PAYSP_328845 VALUES ( '328845' )
, SUBPARTITION DAT_CALC_PAYSP_331467 VALUES ( '331467' )
, SUBPARTITION DAT_CALC_PAYSP_333368 VALUES ( '333368' )
, SUBPARTITION DAT_CALC_PAYSP_335106 VALUES ( '335106' )
, SUBPARTITION DAT_CALC_PAYSP_336503 VALUES ( '336503' )
, SUBPARTITION DAT_CALC_PAYSP_337568 VALUES ( '337568' )
, SUBPARTITION DAT_CALC_PAYSP_338545 VALUES ( '338545' )
, SUBPARTITION DAT_CALC_PAYSP_351823 VALUES ( '351823' )
, SUBPARTITION DAT_CALC_PAYSP_352457 VALUES ( '352457' )
, SUBPARTITION DAT_CALC_PAYSP_353553 VALUES ( '353553' )
, SUBPARTITION DAT_CALC_PAYSP_354507 VALUES ( '354507' )
, SUBPARTITION DAT_CALC_PAYSP_356334 VALUES ( '356334' )
),
  partition P_FLAGINSURANCE values ('FLAGINSURANCE')
( SUBPARTITION FLAGINSURANCESP_300465 VALUES ( '300465' )
, SUBPARTITION FLAGINSURANCESP_302076 VALUES ( '302076' )
, SUBPARTITION FLAGINSURANCESP_303398 VALUES ( '303398' )
, SUBPARTITION FLAGINSURANCESP_304665 VALUES ( '304665' )
, SUBPARTITION FLAGINSURANCESP_305482 VALUES ( '305482' )
, SUBPARTITION FLAGINSURANCESP_311647 VALUES ( '311647' )
, SUBPARTITION FLAGINSURANCESP_312356 VALUES ( '312356' )
, SUBPARTITION FLAGINSURANCESP_313957 VALUES ( '313957' )
, SUBPARTITION FLAGINSURANCESP_315784 VALUES ( '315784' )
, SUBPARTITION FLAGINSURANCESP_322669 VALUES ( '322669' )
, SUBPARTITION FLAGINSURANCESP_323475 VALUES ( '323475' )
, SUBPARTITION FLAGINSURANCESP_324805 VALUES ( '324805' )
, SUBPARTITION FLAGINSURANCESP_325796 VALUES ( '325796' )
, SUBPARTITION FLAGINSURANCESP_326461 VALUES ( '326461' )
, SUBPARTITION FLAGINSURANCESP_328845 VALUES ( '328845' )
, SUBPARTITION FLAGINSURANCESP_331467 VALUES ( '331467' )
, SUBPARTITION FLAGINSURANCESP_333368 VALUES ( '333368' )
, SUBPARTITION FLAGINSURANCESP_335106 VALUES ( '335106' )
, SUBPARTITION FLAGINSURANCESP_336503 VALUES ( '336503' )
, SUBPARTITION FLAGINSURANCESP_337568 VALUES ( '337568' )
, SUBPARTITION FLAGINSURANCESP_338545 VALUES ( '338545' )
, SUBPARTITION FLAGINSURANCESP_351823 VALUES ( '351823' )
, SUBPARTITION FLAGINSURANCESP_352457 VALUES ( '352457' )
, SUBPARTITION FLAGINSURANCESP_353553 VALUES ( '353553' )
, SUBPARTITION FLAGINSURANCESP_354507 VALUES ( '354507' )
, SUBPARTITION FLAGINSURANCESP_356334 VALUES ( '356334' )
),
  partition P_DEFAULT values (DEFAULT)
( SUBPARTITION DEFAULTSP_300465 VALUES ( '300465' )
, SUBPARTITION DEFAULTSP_302076 VALUES ( '302076' )
, SUBPARTITION DEFAULTSP_303398 VALUES ( '303398' )
, SUBPARTITION DEFAULTSP_304665 VALUES ( '304665' )
, SUBPARTITION DEFAULTSP_305482 VALUES ( '305482' )
, SUBPARTITION DEFAULTSP_311647 VALUES ( '311647' )
, SUBPARTITION DEFAULTSP_312356 VALUES ( '312356' )
, SUBPARTITION DEFAULTSP_313957 VALUES ( '313957' )
, SUBPARTITION DEFAULTSP_315784 VALUES ( '315784' )
, SUBPARTITION DEFAULTSP_322669 VALUES ( '322669' )
, SUBPARTITION DEFAULTSP_323475 VALUES ( '323475' )
, SUBPARTITION DEFAULTSP_324805 VALUES ( '324805' )
, SUBPARTITION DEFAULTSP_325796 VALUES ( '325796' )
, SUBPARTITION DEFAULTSP_326461 VALUES ( '326461' )
, SUBPARTITION DEFAULTSP_328845 VALUES ( '328845' )
, SUBPARTITION DEFAULTSP_331467 VALUES ( '331467' )
, SUBPARTITION DEFAULTSP_333368 VALUES ( '333368' )
, SUBPARTITION DEFAULTSP_335106 VALUES ( '335106' )
, SUBPARTITION DEFAULTSP_336503 VALUES ( '336503' )
, SUBPARTITION DEFAULTSP_337568 VALUES ( '337568' )
, SUBPARTITION DEFAULTSP_338545 VALUES ( '338545' )
, SUBPARTITION DEFAULTSP_351823 VALUES ( '351823' )
, SUBPARTITION DEFAULTSP_352457 VALUES ( '352457' )
, SUBPARTITION DEFAULTSP_353553 VALUES ( '353553' )
, SUBPARTITION DEFAULTSP_354507 VALUES ( '354507' )
, SUBPARTITION DEFAULTSP_356334 VALUES ( '356334' )
)  
)   
as
select /*+ parallel( 24 ) */ ]' ||'(select kf from regions where code = substr (nd,-2,2)) KF,' || l_col_lst || q'[
  from ]'|| l_tab_nm;

    execute immediate l_tab_stmt;
    dbms_output.put_line( 'Table "TEST_'||l_tab_nm||'" created.' );

    -- ======================================================
    -- Default Values
    -- ======================================================
    begin
      dbms_output.put_line( 'Copying default column values from source table.' );
      for dv in ( select COLUMN_NAME, DATA_DEFAULT, DEFAULT_LENGTH
                    from ALL_TAB_COLS
                   where OWNER = 'BARS'
                     and TABLE_NAME = l_tab_nm
                     and COLUMN_NAME != 'KF'
                     and COLUMN_ID > 0
                     and DATA_DEFAULT IS NOT NULL
      ) loop
        begin
          l_tab_stmt := 'alter table TEST_' || l_tab_nm || ' modify ' || dv.COLUMN_NAME ||
                                ' default ' || SubStr( dv.DATA_DEFAULT, 1, dv.DEFAULT_LENGTH );
          execute immediate l_tab_stmt;
        exception
          when OTHERS then
            dbms_output.put_line( l_tab_stmt ||chr(10)|| sqlerrm );
        end;
      end loop;
    end;

    -- ======================================================
    -- Comments
    -- ======================================================
    begin
      dbms_output.put_line( 'Copying comments from source table.' );
      for c in ( select 'comment on table '||OWNER||'.TEST_'||TABLE_NAME||' is '||DBMS_ASSERT.ENQUOTE_LITERAL(COMMENTS) as STMT
                  from ALL_TAB_COMMENTS
                 where OWNER = 'BARS'
                   and TABLE_NAME = l_tab_nm
                 union all
                select 'comment on column '||OWNER||'.TEST_'||TABLE_NAME||'.'||COLUMN_NAME||' is '||DBMS_ASSERT.ENQUOTE_LITERAL(COMMENTS)
                  from ALL_COL_COMMENTS
                 where OWNER = 'BARS'
                   and TABLE_NAME = l_tab_nm
                   and COMMENTS Is Not Null
      ) loop
        begin
          execute immediate c.STMT;
          dbms_output.put_line( 'Comment created.' );
        exception
          when OTHERS then
            dbms_output.put_line( 'Comment creation error: ' || sqlerrm || chr(10) || c.STMT );
        end;
      end loop;
    end;

    -- ======================================================
    -- Grants
    -- ======================================================
    begin
      dbms_output.put_line( 'Copying privileges from source table.' );
      for c in ( select 'grant '||PRIVILEGE||' on TEST_'||TABLE_NAME||' to '||GRANTEE ||
                        case GRANTABLE when 'YES' then ' WITH GRANT OPTION' else '' end  as STMT
                   from ALL_TAB_PRIVS
                  where TABLE_SCHEMA = 'BARS'
                    and TABLE_NAME   = l_tab_nm
      ) loop
        begin
          execute immediate c.STMT;
          dbms_output.put_line( 'Grant complete.' );
        exception
          when OTHERS then
            dbms_output.put_line( 'Grant creation error: ' || sqlerrm || chr(10) || c.STMT );
        end;
      end loop;
    end;

    -- ======================================================
    -- Collect DDL for constraints, Indexes and Triggers
    -- ======================================================
    begin
      DBMS_METADATA.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'STORAGE', false );
      for k in ( select 'CONSTRAINT'    as OBJ_TP
                      , CONSTRAINT_NAME as OBJ_NM
                   from USER_CONSTRAINTS
                  where TABLE_NAME = l_tab_nm
                    and CONSTRAINT_TYPE = any ('P','U','C')
                    and CONSTRAINT_NAME not like 'CC%NN' -- Not Null
                  union all
                 select 'REF_CONSTRAINT' as OBJ_TP
                      , CONSTRAINT_NAME  as OBJ_NM
                   from USER_CONSTRAINTS
                  where TABLE_NAME = l_tab_nm
                    and CONSTRAINT_TYPE = 'R'
                  union all
                 select 'INDEX'      as OBJ_TP
                      , i.INDEX_NAME as OBJ_NM
                   from USER_INDEXES i
                   left
                   join ( select CONSTRAINT_NAME, INDEX_NAME
                            from USER_CONSTRAINTS
                           where TABLE_NAME = l_tab_nm
                             and CONSTRAINT_TYPE = any ('P','U')
                        ) c
                     on ( c.INDEX_NAME = i.INDEX_NAME )
                  where i.TABLE_OWNER = 'BARS'
                    and i.TABLE_NAME  = l_tab_nm
                    and c.INDEX_NAME Is Null
                  union all
                 select 'TRIGGER'    as OBJ_TP
                      , TRIGGER_NAME as OBJ_NM
                   from USER_TRIGGERS
                  where TABLE_NAME = l_tab_nm
             )
      loop
        t_stmt.EXTEND;
        t_stmt(t_stmt.last).OBJ_TP  := k.OBJ_TP;
        t_stmt(t_stmt.last).OBJ_NM  := k.OBJ_NM;
        t_stmt(t_stmt.last).DDL_TXT := DBMS_LOB.SUBSTR( DBMS_METADATA.GET_DDL( k.OBJ_TP, k.OBJ_NM ), 16000, 4 );
        case k.OBJ_TP
        when 'CONSTRAINT'
        then
          t_stmt(t_stmt.last).ddl_txt := replace( t_stmt(t_stmt.last).ddl_txt, ' DISABLE',  ' ENABLE'     );
          t_stmt(t_stmt.last).ddl_txt := replace( t_stmt(t_stmt.last).ddl_txt, ' VALIDATE', ' NOVALIDATE' );
          -- add replacement of constraints such as "CHECK (VIDD IS NOT NULL)" to "MODIFY VIDD NOT NULL"
        when 'TRIGGER'
        then
          t_stmt(t_stmt.last).ddl_txt := regexp_replace( t_stmt(t_stmt.last).ddl_txt, '(ALTER TRIGGER .+)' );
        when 'INDEX'
        then -- modify indexes that contains field "KF" (first in list) to local
          t_stmt(t_stmt.last).ddl_txt := replace( t_stmt(t_stmt.last).ddl_txt, 'BRSDYNI', 'BRSMDLI' );
          if ( regexp_like( t_stmt(t_stmt.last).ddl_txt, '\( *"?KF"? *,' ) and ( regexp_instr( t_stmt(t_stmt.last).ddl_txt, 'LOCAL' ) = 0 ) )
          then 
            t_stmt(t_stmt.last).ddl_txt := t_stmt(t_stmt.last).ddl_txt || ' LOCAL COMPRESS 1';
          end if;
        else
          null;
        end case;
      end loop;
    end;

    execute immediate 'drop table '||l_tab_nm||' cascade constraints';
    dbms_output.put_line( 'Table "'||l_tab_nm||'" dropped.' );

    execute immediate 'rename TEST_'||l_tab_nm||' to '||l_tab_nm;
    dbms_output.put_line( 'Rename complete.' );

    -- ======================================================
    -- Rename Not Null constraints
    -- ======================================================
    begin
      dbms_output.put_line( 'Rename Not Null constraints.' );
      for k in 
      ( select cc.CONSTRAINT_NAME, cc.COLUMN_NAME 
          from ALL_CONSTRAINTS  cs
          join ALL_CONS_COLUMNS cc
            on ( cc.CONSTRAINT_NAME = cs.CONSTRAINT_NAME ) 
         where cs.OWNER = 'BARS'
           and cs.TABLE_NAME = l_tab_nm
           and cs.CONSTRAINT_TYPE = 'C'
           and cc.CONSTRAINT_NAME like 'SYS%'
      ) loop
        begin
          execute immediate 'alter table '||l_tab_nm||' rename constraint ' || k.CONSTRAINT_NAME ||
                            ' to CC_'|| replace(l_tab_nm,'_') || '_' || replace(k.COLUMN_NAME,'_') || '_NN';
          dbms_output.put_line( 'Table altered.' );
        exception
          when OTHERS then 
            dbms_output.put_line( 'Constraint NOT renamed: '||sqlerrm );
        end;
      end loop;
    end;

    -- ======================================================
    -- Execute collected DDL
    -- ======================================================
    if ( t_stmt.count > 0 )
    then
      dbms_output.put_line( 'Copying constraints, index and triggers from source table.' );
      for r in t_stmt.first .. t_stmt.last
      loop
        begin
          execute immediate t_stmt(r).ddl_txt;
        exception
          when E_COL_ALREADY_NN
          then null;
          when OTHERS
          then dbms_output.put_line( 'Create ' || t_stmt(r).obj_tp || ' error => ' || sqlerrm || chr(10) || 'on stmt => ' || t_stmt(r).ddl_txt );
        end;
      end loop;
      t_stmt.delete();
    end if;

    begin
      execute immediate 'alter table '||l_tab_nm||' noparallel';
      dbms_output.put_line( 'Table altered.' );
    exception
      when others
      then dbms_output.put_line( sqlerrm );
    end;

    -- ======================================================
    -- Policies
    -- ======================================================
    BPA.ALTER_POLICIES( l_tab_nm );
    commit;

  else -- якщо SUBPARTITIONS наявні
    dbms_output.put_line( 'Table "'||l_tab_nm||'" already subpartitioned.' );
  end if;

  -- ======================================================
  -- set DBMS_STATS preference
  -- ======================================================
  DBMS_STATS.SET_TABLE_PREFS( OwnName => 'BARS'
                            , TabName => l_tab_nm
                            , pname   => 'INCREMENTAL'
                            , pvalue  => 'TRUE' );

end;
/


-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table BPK_PARAMETERS 
  add constraint PK_BPKPARAMETERS primary key (ND, TAG)
  using index 
  tablespace BRSDYNI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

begin
bars_policy_adm.enable_policies(p_table_name => 'BPK_PARAMETERS_UPDATE');
end;
/
begin
bars_policy_adm.enable_policies(p_table_name => 'BPK_PARAMETERS');
end;
/