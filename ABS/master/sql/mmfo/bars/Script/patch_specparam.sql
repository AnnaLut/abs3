-- ================================================================================
-- Module : CAC
-- Author : BAA
-- Date   : 14.02.2018
-- ================================== <Comments> ==================================
-- recreate table SPECPARAM
-- ================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET DEFINE       OFF
SET ECHO         OFF
SET FEEDBACK     OFF
SET LINES        300
SET PAGES        500
SET TERMOUT      ON
SET TIMING       ON
SET TRIMSPOOL    ON
SET VERIFY       OFF

prompt -- ======================================================
prompt -- recreate table SPECPARAM
prompt -- ======================================================

declare
  l_tab_nm            varchar2(30);
  l_ptsn_f            number(1);
  l_col_lst           varchar2(2048);
  l_tab_stmt          varchar2(8000);
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
  pragma exception_init( e_tab_rd_only, -14139 );
  e_col_already_nn       exception;
  pragma exception_init( e_col_already_nn, -01442 );
begin

  l_tab_nm := 'SPECPARAM';

  -- перевірка наяності PARTITIONS
  select case
         when EXISTS( select 1
                        from ALL_TAB_PARTITIONS
                       where TABLE_OWNER = 'BARS'
                         and TABLE_NAME  = l_tab_nm )
         then 1
         else 0
         end
    into l_ptsn_f
    from dual;

  if ( l_ptsn_f = 0 )
  then -- якщо PARTITIONS відсутні

    begin
      execute immediate 'drop table TEST_'||l_tab_nm||' cascade constraints';
      dbms_output.put_line( 'Table "TEST_'||l_tab_nm||'" dropped.' );
    exception
      when e_tab_not_exists
      then null;
    end;

    execute immediate 'ALTER SESSION ENABLE PARALLEL DDL';
    execute immediate 'ALTER SESSION ENABLE PARALLEL DML';

    begin
      execute immediate 'alter table ' || l_tab_nm || ' read only';
    exception
      when e_tab_rd_only then
        dbms_output.put_line( 'Table "'|| l_tab_nm || '" is already in read-only mode.' );
    end;

    l_tab_stmt := 'create table TEST_' || l_tab_nm || q'[
( KF     default sys_context('bars_context','user_mfo') not null
, ACC                                                   not null
, R011
, R012
, R013
, R014
, R016
, R114
, D020
, K072
, KEKD
, KTK
, KVD
, KVK
, IDG
, IDS
, SPS
, KBK
, NKD
, ISTVAL
, S031
, S080
, S090
, S120
, S130
, S180
, S181
, S182
, S190
, S200
, S230
, S240
, S250
, S260
, S270
, S280
, S290
, S370
, S580
, Z290
, D1#F9
, NF#F9
, DP1
) tablespace BRSBIGD
COMPRESS FOR OLTP
PARALLEL 24
STORAGE( INITIAL 32K NEXT 32K )
PARTITION BY LIST (KF)
( PARTITION P_300465 VALUES ('300465')
, PARTITION P_302076 VALUES ('302076')
, PARTITION P_303398 VALUES ('303398')
, PARTITION P_304665 VALUES ('304665')
, PARTITION P_305482 VALUES ('305482')
, PARTITION P_311647 VALUES ('311647')
, PARTITION P_312356 VALUES ('312356')
, PARTITION P_313957 VALUES ('313957')
, PARTITION P_315784 VALUES ('315784')
, PARTITION P_322669 VALUES ('322669')
, PARTITION P_323475 VALUES ('323475')
, PARTITION P_324805 VALUES ('324805')
, PARTITION P_325796 VALUES ('325796')
, PARTITION P_326461 VALUES ('326461')
, PARTITION P_328845 VALUES ('328845')
, PARTITION P_331467 VALUES ('331467')
, PARTITION P_333368 VALUES ('333368')
, PARTITION P_335106 VALUES ('335106')
, PARTITION P_336503 VALUES ('336503')
, PARTITION P_337568 VALUES ('337568')
, PARTITION P_338545 VALUES ('338545')
, PARTITION P_351823 VALUES ('351823')
, PARTITION P_352457 VALUES ('352457')
, PARTITION P_353553 VALUES ('353553')
, PARTITION P_354507 VALUES ('354507')
, PARTITION P_356334 VALUES ('356334')
)
as
select /*+ parallel( 24 ) */ KF, ACC, R011, R012, R013, R014, R016, R114, D020, K072, KEKD, KTK, KVD, KVK, IDG, IDS, SPS, KBK, NKD, ISTVAL
     , S031, S080, S090, S120, S130, S180, S181, S182, S190, S200, S230, S240, S250, S260, S270, S280, S290, S370, S580, Z290, D1#F9, NF#F9, DP1
  from SPECPARAM
 order by ACC ]'; -- for better Clustering Factor

    execute immediate l_tab_stmt;
    dbms_output.put_line( 'Table "TEST_'||l_tab_nm||'" created.' );

    -- ======================================================
    -- Default Values
    -- ======================================================
    begin
      dbms_output.put_line( 'Copying default column values from source table.' );
      for dv in ( select COLUMN_NAME, DATA_DEFAULT, DEFAULT_LENGTH
                    from ALL_TAB_COLS t
                   where OWNER = 'BARS'
                     and TABLE_NAME = l_tab_nm
                     and COLUMN_NAME != 'KF'
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
          if ( regexp_like( t_stmt(t_stmt.last).ddl_txt, '\( *"?KF"? *,' ) )
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
    begin
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
    end;

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

  else -- якщо PARTITIONS наявні
    dbms_output.put_line( 'Table "'||l_tab_nm||'" already partitioned.' );
  end if;

end;
/

prompt -- ======================================================
prompt -- recreate trigger TAIUD_SPECPARAM_UPDATE
prompt -- ======================================================

create or replace trigger TAIUD_SPECPARAM_UPDATE
after insert or delete or update
of ACC, R011, R013, S080, S180, S181, S190, S200, S230, S240, D020, S260, S270, R014, K072, Z290, S250, S090,
   NKD, S031, R114, S280, S290, S370, R012, S580, S130, ISTVAL, KF
ON SPECPARAM
for each row
declare
  l_rec  SPECPARAM_UPDATE%rowtype;
  ---
  procedure SAVE_CHANGES
  is
  begin

    if ( l_rec.CHGACTION = 'D' )
    then
        l_rec.kf := :old.kf;     l_rec.ACC  := :old.ACC;  l_rec.R011 := :old.R011; l_rec.R013 := :old.R013;
        l_rec.S180 := :old.S180; l_rec.S181 := :old.S181; l_rec.S190 := :old.S190; l_rec.S200 := :old.S200;
        l_rec.S230 := :old.S230; l_rec.S240 := :old.S240; l_rec.D020 := :old.D020; l_rec.KF := :old.KF;
        l_rec.S260 := :old.S260; l_rec.S270 := :old.S270; l_rec.R014 := :old.R014; l_rec.K072 := :old.K072;
        l_rec.Z290 := :old.Z290; l_rec.S250 := :old.S250; l_rec.S090 := :old.S090; l_rec.NKD := :old.NKD;
        l_rec.S031 := :old.S031; l_rec.S080 := :old.S080; l_rec.R114 := :old.R114; l_rec.S280 := :old.S280;
        l_rec.S290 := :old.S290; l_rec.S370 := :old.S370; l_rec.R012 := :old.R012; l_rec.ISTVAL := :old.ISTVAL;
        l_rec.S580 := :old.S580; l_rec.S130 := :old.S130;
/*  далі поля, по яких ПОКИ ЩО, ПРИНАЙМНІ, не відслідковуємо змін значень
        l_rec.KEKD := :old.KEKD; l_rec.KTK := :old.KTK; l_rec.KVK := :old.KVK; l_rec.IDG := :old.IDG;
        l_rec.IDS  := :old.IDS;  l_rec.SPS := :old.SPS; l_rec.KBK := :old.KBK; l_rec.S120 := :old.S120;
        l_rec.S182 := :old.S182; l_rec.D1#F9 := :old.D1#F9; l_rec.NF#F9 := :old.NF#F9;
        l_rec.DP1  := :old.DP1;  l_rec.KVD := :old.KVD; l_rec.R016 := :old.R016;
*/
    else
        l_rec.kf := :new.kf;     l_rec.ACC  := :new.ACC;  l_rec.R011 := :new.R011; l_rec.R013 := :new.R013;
        l_rec.S180 := :new.S180; l_rec.S181 := :new.S181; l_rec.S190 := :new.S190; l_rec.S200 := :new.S200;
        l_rec.S230 := :new.S230; l_rec.S240 := :new.S240; l_rec.D020 := :new.D020; l_rec.KF := :new.KF;
        l_rec.S260 := :new.S260; l_rec.S270 := :new.S270; l_rec.R014 := :new.R014; l_rec.K072 := :new.K072;
        l_rec.Z290 := :new.Z290; l_rec.S250 := :new.S250; l_rec.S090 := :new.S090; l_rec.NKD := :new.NKD;
        l_rec.S031 := :new.S031; l_rec.S080 := :new.S080; l_rec.R114 := :new.R114; l_rec.S280 := :new.S280;
        l_rec.S290 := :new.S290; l_rec.S370 := :new.S370; l_rec.R012 := :new.R012; l_rec.ISTVAL := :new.ISTVAL;
        l_rec.S580 := :new.S580; l_rec.S130 := :new.S130; 
/*  далі поля, по яких ПОКИ ЩО, ПРИНАЙМНІ, не відслідковуємо змін значень
        l_rec.KEKD := :new.KEKD; l_rec.KTK := :new.KTK; l_rec.KVK := :new.KVK; l_rec.IDG := :new.IDG;
        l_rec.IDS := :new.IDS; l_rec.SPS := :new.SPS; l_rec.KBK := :new.KBK; l_rec.S120 := :new.S120;
        l_rec.S130 := :new.S130; l_rec.S182 := :new.S182; l_rec.D1#F9 := :new.D1#F9; l_rec.NF#F9 := :new.NF#F9;
        l_rec.DP1 := :new.DP1; l_rec.KVD := :new.KVD; l_rec.R016 := :new.R016;
*/
    end if;

    l_rec.IDUPD        := bars_sqnc.get_nextval( 'S_SPECPARAM_UPDATE', l_rec.kf );
    l_rec.EFFECTDATE   := COALESCE(gl.bd, glb_bankdate);
    l_rec.GLOBAL_BDATE := sysdate;
    l_rec.USER_NAME    := user_name;
    l_rec.fdat         := sysdate;

    insert into BARS.SPECPARAM_UPDATE values l_rec;

  end SAVE_CHANGES;
  ---
begin

  case
    when inserting
    then

      l_rec.CHGACTION := 'I';
      SAVE_CHANGES;

    when deleting
    then

      l_rec.CHGACTION := 'D';
      SAVE_CHANGES;

    when updating
    then

      case
        when (:old.ACC <> :new.ACC OR :old.KF <> :new.KF)
        then -- При зміні значеннь полів, що входять в PRIMARY KEY (для правильного відображення при вивантаженні даних до DWH)

          -- породжуємо в історії запис про видалення
          l_rec.CHGACTION := 'D';
          SAVE_CHANGES;

          -- породжуємо в історії запис про вставку
          l_rec.CHGACTION := 'I';
          SAVE_CHANGES;

        when ( :old.R011 != :new.R011 OR (:old.R011 IS NULL AND :new.R011 IS NOT NULL) OR (:old.R011 IS NOT NULL AND :new.R011 IS NULL) OR
               :old.R012 != :new.R012 OR (:old.R012 IS NULL AND :new.R012 IS NOT NULL) OR (:old.R012 IS NOT NULL AND :new.R012 IS NULL) OR
               :old.R013 != :new.R013 OR (:old.R013 IS NULL AND :new.R013 IS NOT NULL) OR (:old.R013 IS NOT NULL AND :new.R013 IS NULL) OR
               :old.R014 != :new.R014 OR (:old.R014 IS NULL AND :new.R014 IS NOT NULL) OR (:old.R014 IS NOT NULL AND :new.R014 IS NULL) OR
               :old.R114 != :new.R114 OR (:old.R114 IS NULL AND :new.R114 IS NOT NULL) OR (:old.R114 IS NOT NULL AND :new.R114 IS NULL) OR
               :old.S031 != :new.S031 OR (:old.S031 IS NULL AND :new.S031 IS NOT NULL) OR (:old.S031 IS NOT NULL AND :new.S031 IS NULL) OR
               :old.S080 != :new.S080 OR (:old.S080 IS NULL AND :new.S080 IS NOT NULL) OR (:old.S080 IS NOT NULL AND :new.S080 IS NULL) OR
               :old.S180 != :new.S180 OR (:old.S180 IS NULL AND :new.S180 IS NOT NULL) OR (:old.S180 IS NOT NULL AND :new.S180 IS NULL) OR
               :old.S090 != :new.S090 OR (:old.S090 IS NULL AND :new.S090 IS NOT NULL) OR (:old.S090 IS NOT NULL AND :new.S090 IS NULL) OR
               :old.S130 != :new.S130 OR (:old.S130 IS NULL AND :new.S130 IS NOT NULL) OR (:old.S130 IS NOT NULL AND :new.S130 IS NULL) OR
               :old.S181 != :new.S181 OR (:old.S181 IS NULL AND :new.S181 IS NOT NULL) OR (:old.S181 IS NOT NULL AND :new.S181 IS NULL) OR
               :old.S190 != :new.S190 OR (:old.S190 IS NULL AND :new.S190 IS NOT NULL) OR (:old.S190 IS NOT NULL AND :new.S190 IS NULL) OR
               :old.S200 != :new.S200 OR (:old.S200 IS NULL AND :new.S200 IS NOT NULL) OR (:old.S200 IS NOT NULL AND :new.S200 IS NULL) OR
               :old.S230 != :new.S230 OR (:old.S230 IS NULL AND :new.S230 IS NOT NULL) OR (:old.S230 IS NOT NULL AND :new.S230 IS NULL) OR
               :old.S240 != :new.S240 OR (:old.S240 IS NULL AND :new.S240 IS NOT NULL) OR (:old.S240 IS NOT NULL AND :new.S240 IS NULL) OR
               :old.S250 != :new.S250 OR (:old.S250 IS NULL AND :new.S250 IS NOT NULL) OR (:old.S250 IS NOT NULL AND :new.S250 IS NULL) OR
               :old.S260 != :new.S260 OR (:old.S260 IS NULL AND :new.S260 IS NOT NULL) OR (:old.S260 IS NOT NULL AND :new.S260 IS NULL) OR
               :old.S270 != :new.S270 OR (:old.S270 IS NULL AND :new.S270 IS NOT NULL) OR (:old.S270 IS NOT NULL AND :new.S270 IS NULL) OR
               :old.S280 != :new.S280 OR (:old.S280 IS NULL AND :new.S280 IS NOT NULL) OR (:old.S280 IS NOT NULL AND :new.S280 IS NULL) OR
               :old.S290 != :new.S290 OR (:old.S290 IS NULL AND :new.S290 IS NOT NULL) OR (:old.S290 IS NOT NULL AND :new.S290 IS NULL) OR
               :old.S370 != :new.S370 OR (:old.S370 IS NULL AND :new.S370 IS NOT NULL) OR (:old.S370 IS NOT NULL AND :new.S370 IS NULL) OR
               :old.S580 != :new.S580 OR (:old.S580 IS NULL AND :new.S580 IS NOT NULL) OR (:old.S580 IS NOT NULL AND :new.S580 IS NULL) OR
               :old.D020 != :new.D020 OR (:old.D020 IS NULL AND :new.D020 IS NOT NULL) OR (:old.D020 IS NOT NULL AND :new.D020 IS NULL) OR
               :old.K072 != :new.K072 OR (:old.K072 IS NULL AND :new.K072 IS NOT NULL) OR (:old.K072 IS NOT NULL AND :new.K072 IS NULL) OR
               :old.Z290 != :new.Z290 OR (:old.Z290 IS NULL AND :new.Z290 IS NOT NULL) OR (:old.Z290 IS NOT NULL AND :new.Z290 IS NULL) OR
               :old.NKD  != :new.NKD  OR (:old.NKD IS NULL  AND :new.NKD  IS NOT NULL) OR (:old.NKD  IS NOT NULL AND :new.NKD  IS NULL) OR
               :old.ISTVAL != :new.ISTVAL OR (:old.ISTVAL IS NULL AND :new.ISTVAL IS NOT NULL) OR (:old.ISTVAL IS NOT NULL AND :new.ISTVAL IS NULL)
            )
        then -- При зміні значеннь полів, що НЕ входять в PRIMARY KEY

          -- протоколюємо внесені зміни
          l_rec.CHGACTION := 'U';
          SAVE_CHANGES;

        else
          Null;
      end case;

    else
      null;
  end case;

end TAIUD_SPECPARAM_UPDATE;
/

show errors;
