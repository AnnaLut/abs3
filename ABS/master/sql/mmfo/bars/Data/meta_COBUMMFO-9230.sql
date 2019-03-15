PROMPT =============================================================================================
PROMPT *** Run *** ========== Scripts /Sql/BARS/Data/meta_COBUMMFO-9230.sql =========*** Run *** ===
PROMPT =============================================================================================

PROMPT *** add meta_table SPS_UNION ***
begin
  bars_metabase.add_table(
    p_tabid               => 1014651,
    p_tabname             => 'SPS_UNION',
    p_tabsemantic         => 'Групування',
    p_tabselect_statement => null,
    p_linesdef            => null);
exception when dup_val_on_index then null;
end;
/

PROMPT *** add meta_table SPS_SPR ***
begin
  bars_metabase.add_table(
    p_tabid               => 1014652,
    p_tabname             => 'SPS_SPR',
    p_tabsemantic         => 'Спосіб обчислення суми',
    p_tabselect_statement => null,
    p_linesdef            => null);
exception when dup_val_on_index then null;
end;
/

PROMPT *** add meta_columns SPS_SPR and SPS_UNION ***
begin
  for c_col in (select mt.tabid,
                       row_number() over (partition BY tc.TABLE_NAME order by tc.TABLE_NAME, tc.COLUMN_ID) as colid,
                       tc.COLUMN_NAME as colname,
                       case
                         when tc.DATA_TYPE = 'NUMBER' then 'N'
                         else 'C'
                       end as coltype,
                       coalesce(cc.COMMENTS, 
                         case tc.COLUMN_NAME
                           when 'SPS' then 'SPS'
                           when 'SPS_NAME' then 'Назва SPS'
                           when 'DESCRIPTION' then 'Опис SPS'
                           when 'UNION_ID' then 'ID групування'
                           when 'UNION_NAME' then 'Назва групування'
                          end) as semantic,
                       null as showwidth,
                       null as showmaxchar,
                       null as showpos,
                       0 as showin_ro,
                       case
                         when (mt.tabid = 1014652 and cc.COLUMN_NAME = 'SPS') or (mt.tabid = 1014651 and cc.COLUMN_NAME = 'UNION_ID') then 1
                         else 0
                       end as showretval,
                       case
                         when (mt.tabid = 1014652 and cc.COLUMN_NAME = 'SPS_NAME') or (mt.tabid = 1014651 and cc.COLUMN_NAME = 'UNION_NAME') then 1
                         else 0
                       end  as instnssemantic,
                       case
                         when (mt.tabid = 1014651 and cc.COLUMN_NAME = 'SPS') then 1
                         else 0
                       end as extrnval,
                       null as showrel_ctype,
                       null as showformat,
                       0 as showin_fltr,
                       0 as showref,
                       null as showresult,
                       0 as nottoedit,
                       0 as nottoshow,
                       0 as simplefilter,
                       null as webformname,
                       null as formname,
                       0 as inputinnewrecord
                  from all_tab_columns tc
                  join all_col_comments cc on cc.OWNER = tc.OWNER and cc.TABLE_NAME = tc.TABLE_NAME and cc.COLUMN_NAME = tc.COLUMN_NAME
                  join meta_tables mt on mt.tabname = cc.TABLE_NAME
                 where tc.TABLE_NAME in ('SPS_UNION', 'SPS_SPR')
                 order by tc.TABLE_NAME, tc.COLUMN_ID
                 )
  loop
    begin
      bars_metabase.add_column(
        p_tabid            => c_col.tabid,
        p_colid            => c_col.colid,
        p_colname          => c_col.colname,
        p_coltype          => c_col.coltype,
        p_semantic         => c_col.semantic,
        p_showwidth        => c_col.showwidth,
        p_showmaxchar      => c_col.showmaxchar,
        p_showpos          => c_col.showpos,
        p_showin_ro        => c_col.showin_ro,
        p_showretval       => c_col.showretval,
        p_instnssemantic   => c_col.instnssemantic,
        p_extrnval         => c_col.extrnval,
        p_showrel_ctype    => c_col.showformat,
        p_showformat       => c_col.showformat,
        p_showin_fltr      => c_col.showin_fltr,
        p_showref          => c_col.showref,
        p_showresult       => c_col.showresult,
        p_nottoedit        => c_col.nottoedit,
        p_nottoshow        => c_col.nottoshow,
        p_simplefilter     => c_col.simplefilter,
        p_webformname      => c_col.webformname,
        p_formname         => c_col.formname,
        p_inputinnewrecord => c_col.inputinnewrecord);
    exception when dup_val_on_index then null;
    end;
  end loop;
end;
/

PROMPT *** add extrnval on SPS_SPR and SPS_UNION ***
declare
  l_tabid number;
begin
  select tabid
    into l_tabid
    from meta_tables
   where tabname = 'SPS_GROUP_RU';
  
  bars_metabase.update_column(
    p_tabid            => l_tabid,
    p_colid            => 4,
    p_colname          => 'UNION_ID',
    p_coltype          => 'N',
    p_semantic         => 'ID групування',
    p_showwidth        => null,
    p_showmaxchar      => null,
    p_showpos          => null,
    p_showin_ro        => 0,
    p_showretval       => 0,
    p_instnssemantic   => 0,
    p_extrnval         => 1,
    p_showrel_ctype    => null,
    p_showformat       => null,
    p_showin_fltr      => 0,
    p_showref          => 0,
    p_showresult       => null,
    p_nottoedit        => 0,
    p_nottoshow        => 0,
    p_simplefilter     => 0,
    p_formname         => null,
    p_webformname      => null,
    p_inputinnewrecord => 0);

  begin
    bars_metabase.add_extrnval(
      p_tabid         => l_tabid,
      p_colid         => 4,
      p_srctabid      => 1014651,
      p_srccolid      => 1,
      p_tab_alias     => null,
      p_tab_cond      => null,
      p_src_cond      => null,
      p_coldyntabname => null);
  exception when dup_val_on_index then null;
  end;
  
  begin
    bars_metabase.add_extrnval(
      p_tabid         => 1014651,
      p_colid         => 3,
      p_srctabid      => 1014652,
      p_srccolid      => 1,
      p_tab_alias     => null,
      p_tab_cond      => null,
      p_src_cond      => null,
      p_coldyntabname => null);
  exception when dup_val_on_index then null;
  end;
end;
/

PROMPT *** add tab SPS_UNION in arm ***
begin
  begin
    BARS_METABASE.ADDTABLETOREF(GET_TABID('SPS_UNION'), 11);
  exception when dup_val_on_index then null;
  end;
  
  begin
    user_menu_utl.ADD_REFERENCE2ARM(
      p_reference_id   => GET_TABID('SPS_UNION'),
      p_arm_code       => '$RM_@PPZ',
      p_access_mode_id => 2,
      p_approve        => 1);
  exception when dup_val_on_index then null;
  end;
end;
/

COMMIT;

PROMPT =============================================================================================
PROMPT *** End *** ========== Scripts /Sql/BARS/Data/meta_COBUMMFO-9230.sql =========*** End *** ===
PROMPT =============================================================================================
