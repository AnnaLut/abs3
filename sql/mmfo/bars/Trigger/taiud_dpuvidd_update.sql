CREATE OR REPLACE TRIGGER TAIUD_DPUVIDD_UPDATE
after insert or update or delete on DPU_VIDD
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

  FILL_TBL( 'VIDD'         , :old.VIDD         , :new.VIDD          );
  FILL_TBL( 'NAME'         , :old.NAME         , :new.NAME          );
  FILL_TBL( 'KV'           , :old.KV           , :new.KV            );
  FILL_TBL( 'SROK'         , :old.SROK         , :new.SROK          );
  FILL_TBL( 'BSD'          , :old.BSD          , :new.BSD           );
  FILL_TBL( 'BSN'          , :old.BSN          , :new.BSN           );
  FILL_TBL( 'BASEY'        , :old.BASEY        , :new.BASEY         );
  FILL_TBL( 'METR'         , :old.METR         , :new.METR          );
  FILL_TBL( 'BR_ID'        , :old.BR_ID        , :new.BR_ID         );
  FILL_TBL( 'FREQ_N'       , :old.FREQ_N       , :new.FREQ_N        );
  FILL_TBL( 'FREQ_V'       , :old.FREQ_V       , :new.FREQ_V        );
  FILL_TBL( 'ACC7'         , :old.ACC7         , :new.ACC7          );
  FILL_TBL( 'TT'           , :old.TT           , :new.TT            );
  FILL_TBL( 'COMPROC'      , :old.COMPROC      , :new.COMPROC       );
  FILL_TBL( 'ID_STOP'      , :old.ID_STOP      , :new.ID_STOP       );
  FILL_TBL( 'MIN_SUMM'     , :old.MIN_SUMM     , :new.MIN_SUMM      );
  FILL_TBL( 'LIMIT'        , :old.LIMIT        , :new.LIMIT         );
  FILL_TBL( 'PENYA'        , :old.PENYA        , :new.PENYA         );
  FILL_TBL( 'SHABLON'      , :old.SHABLON      , :new.SHABLON       );
  FILL_TBL( 'COMMENTS'     , :old.COMMENTS     , :new.COMMENTS      );
  FILL_TBL( 'FLAG'         , :old.FLAG         , :new.FLAG          );
  FILL_TBL( 'FL_ADD'       , :old.FL_ADD       , :new.FL_ADD        );
  FILL_TBL( 'FL_EXTEND'    , :old.FL_EXTEND    , :new.FL_EXTEND     );
  FILL_TBL( 'TIP_OST'      , :old.TIP_OST      , :new.TIP_OST       );
  FILL_TBL( 'DPU_TYPE'     , :old.DPU_TYPE     , :new.DPU_TYPE      );
  FILL_TBL( 'FL_AUTOEXTEND', :old.FL_AUTOEXTEND, :new.FL_AUTOEXTEND );
  FILL_TBL( 'DPU_CODE'     , :old.DPU_CODE     , :new.DPU_CODE      );
  FILL_TBL( 'MAX_SUMM'     , :old.MAX_SUMM     , :new.MAX_SUMM      );
  FILL_TBL( 'TYPE_ID'      , :old.TYPE_ID      , :new.TYPE_ID       );
  FILL_TBL( 'TERM_TYPE'    , :old.TERM_TYPE    , :new.TERM_TYPE     );
  FILL_TBL( 'TERM_MIN'     , :old.TERM_MIN     , :new.TERM_MIN      );
  FILL_TBL( 'TERM_MAX'     , :old.TERM_MAX     , :new.TERM_MAX      );
  FILL_TBL( 'TERM_ADD'     , :old.TERM_ADD     , :new.TERM_ADD      );
  FILL_TBL( 'IRVK'         , :old.IRVK         , :new.IRVK          );
  FILL_TBL( 'EXN_MTH_ID'   , :old.EXN_MTH_ID   , :new.EXN_MTH_ID    );

  If ( tbl.count > 0 )
  then
    
    l_chg_dt  := sysdate;
    l_chg_usr := USER_ID();
    l_eff_dt  := GL.BD();
    l_tab_nm  := 'DPU_VIDD';
    l_pk_val  := case l_chg_tp when 'D' then :old.VIDD else :new.VIDD end;
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
  
end TAIUD_DPUVIDD_UPDATE;
/

show err

