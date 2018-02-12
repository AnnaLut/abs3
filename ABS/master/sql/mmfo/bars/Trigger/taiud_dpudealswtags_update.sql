CREATE OR REPLACE TRIGGER TAIUD_DPUDEALSWTAGS_UPDATE
after insert or update or delete on DPU_DEAL_SWTAGS
for each row
declare
  type t_tbl_type is table of dpu_tab_update.col_val%type index by dpu_tab_update.col_nm%type;
  tbl  t_tbl_type;
  l_chg_tp        dpu_tab_update.chg_tp%type;
  l_chg_dt        dpu_tab_update.chg_dt%type;
  l_chg_usr       dpu_tab_update.chg_usr%type;
  l_eff_dt        dpu_tab_update.eff_dt%type;
  l_tab_nm        dpu_tab_update.tab_nm%type;
  l_pk_val        dpu_tab_update.pk_val%type;
  l_col_nm        dpu_tab_update.col_nm%type;
  ---
  procedure FILL_TBL
  ( p_col_nm      varchar2
  , p_old_val     varchar2
  , p_new_val     varchar2
  ) is
  begin

    if ( ( l_chg_tp = 'D' ) or
         ( l_chg_tp = 'I' ) or
         ( p_old_val          != p_new_val             ) or
         ( p_old_val is null AND p_new_val is Not null ) or
         ( p_new_val is null AND p_old_val is Not null ) )
    then

      tbl(p_col_nm) := case l_chg_tp when 'D' then p_old_val else p_new_val end;

    end if;

  end FILL_TBL;
  ---
begin

  l_chg_tp := case
              when deleting  then 'D'
              when inserting then 'I'
              else 'U'           end;

  FILL_TBL( 'TAG56_NAME', :old.TAG56_NAME, :new.TAG56_NAME );
  FILL_TBL( 'TAG56_ADR',  :old.TAG56_ADR,  :new.TAG56_ADR  );
  FILL_TBL( 'TAG56_CODE', :old.TAG56_CODE, :new.TAG56_CODE );
  FILL_TBL( 'TAG57_NAME', :old.TAG57_NAME, :new.TAG57_NAME );
  FILL_TBL( 'TAG57_ADR',  :old.TAG57_ADR,  :new.TAG57_ADR  );
  FILL_TBL( 'TAG57_CODE', :old.TAG57_CODE, :new.TAG57_CODE );
  FILL_TBL( 'TAG57_ACC',  :old.TAG57_ACC,  :new.TAG57_ACC  );
  FILL_TBL( 'TAG59_NAME', :old.TAG59_NAME, :new.TAG59_NAME );
  FILL_TBL( 'TAG59_ADR',  :old.TAG59_ADR,  :new.TAG59_ADR  );
  FILL_TBL( 'TAG59_ACC',  :old.TAG59_ACC,  :new.TAG59_ACC  );

  If ( tbl.count > 0 )
  then

    l_chg_dt  := sysdate;
    l_chg_usr := USER_ID();
    l_eff_dt  := GL.BD();
    l_tab_nm  := 'DPU_DEAL_SWTAGS';
    l_pk_val  := case l_chg_tp when 'D' then :old.DPU_ID else :new.DPU_ID end;
    l_col_nm  := tbl.first;

    while ( l_col_nm is not null )
    loop

      insert
        into DPU_TAB_UPDATE
           ( CHG_ID, CHG_TP, CHG_DT, CHG_USR, EFF_DT, TAB_NM, PK_VAL, COL_NM, COL_VAL )
      values
           ( S_DPU_TAB_UPDATE.NextVal, l_chg_tp, l_chg_dt, l_chg_usr, l_eff_dt, l_tab_nm, l_pk_val, l_col_nm, tbl(l_col_nm) );

      l_col_nm := tbl.next(l_col_nm);

    end loop;

    tbl.delete();
    
  End If;
  
end TAIUD_DPUDEALSWTAGS_UPDATE;
/

show err

