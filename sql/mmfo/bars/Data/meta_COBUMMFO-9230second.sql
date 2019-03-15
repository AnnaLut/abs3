PROMPT =============================================================================================
PROMPT *** Run *** ========== Scripts /Sql/BARS/Data/meta_COBUMMFO-9230second.sql =========*** Run *** ===
PROMPT =============================================================================================

PROMPT *** update meta_table  ***
begin
  --раніше змінював 1014651 з SPS_UNION на V_SPS_UNION, але потім вирішив, що потрібні обидві, тому повертаю SPS_UNION
  bars_metabase.update_table(
    p_tabid       => 1014651,
    p_tabname     => 'SPS_UNION',
    p_tabsemantic => 'Групування',
    p_linesdef    => null);
end;
/

PROMPT *** create meta_table and meta_columns V_SPS_UNION ***
declare
  l_tab_id number;
begin
  begin
    bars_metabase.add_table(
      p_tabid               => null,
      p_tabname             => 'V_SPS_UNION',
      p_tabsemantic         => 'Групування',
      p_tabselect_statement => null,
      p_linesdef            => null);
  exception
    when others then
      if sqlcode <> -00001 then
        raise;
      end if;
  end;
  
  select mt.tabid
    into l_tab_id
    from meta_tables mt
   where mt.tabname = 'V_SPS_UNION';
  
  for c_meta_col in (select l_tab_id as tabid,
                            mc.colid,
                            mc.colname,
                            mc.coltype,
                            mc.semantic,
                            mc.showwidth,
                            mc.showmaxchar,
                            mc.showpos,
                            mc.showin_ro,
                            mc.showretval,
                            mc.instnssemantic,
                            mc.extrnval,
                            mc.showrel_ctype,
                            mc.showformat,
                            mc.showin_fltr,
                            mc.showref,
                            mc.showresult,
                            mc.case_sensitive,
                            mc.not_to_edit,
                            mc.not_to_show,
                            mc.simple_filter,
                            mc.form_name,
                            mc.branch,
                            mc.web_form_name,
                            mc.oper_id,
                            mc.input_in_new_record
                       from meta_columns mc
                      where mc.tabid = (select mt.tabid
                                          from meta_tables mt
                                         where mt.tabname = 'SPS_UNION'))
  loop
    begin
      insert into meta_columns
           values (c_meta_col.tabid,
                  c_meta_col.colid,
                  c_meta_col.colname,
                  c_meta_col.coltype,
                  c_meta_col.semantic,
                  c_meta_col.showwidth,
                  c_meta_col.showmaxchar,
                  c_meta_col.showpos,
                  c_meta_col.showin_ro,
                  c_meta_col.showretval,
                  c_meta_col.instnssemantic,
                  c_meta_col.extrnval,
                  c_meta_col.showrel_ctype,
                  c_meta_col.showformat,
                  c_meta_col.showin_fltr,
                  c_meta_col.showref,
                  c_meta_col.showresult,
                  c_meta_col.case_sensitive,
                  c_meta_col.not_to_edit,
                  c_meta_col.not_to_show,
                  c_meta_col.simple_filter,
                  c_meta_col.form_name,
                  c_meta_col.branch,
                  c_meta_col.web_form_name,
                  c_meta_col.oper_id,
                  c_meta_col.input_in_new_record);
    exception
      when others then
        if sqlcode <> -00001 then
          raise;
        end if;
    end;
  end loop;
end;
/

PROMPT *** remove excess function ***
begin
  umu.remove_func_from_arm_bypath(
    p_func_path => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=TSEL015[NSIFUNCTION][PROC=>SPS.SEL015(1,6,'''','''')][EXEC=>BEFORE][CONDITIONS=>US_ID=sys_context(''bars_global'',''user_id'')]',
    p_arm_code  => '$RM_@PPZ');
end;
/

PROMPT *** update function ***
begin
  update operlist ol
     set ol.funcname = '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=[PROC=>SPS.PAY_SOME_PEREKR(:Param0)][PAR=>:Param0(SEM=ID групування,TYPE=N,REF=V_SPS_UNION)][EXEC=>BEFORE][MSG=>OK]'
   where ol.funcname = '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=[PROC=>SPS.PAY_SOME_PEREKR(:Param0)][PAR=>:Param0(SEM=ID групування,TYPE=N,REF=SPS_UNION)][EXEC=>BEFORE][MSG=>OK]';
end;
/

COMMIT;

PROMPT =============================================================================================
PROMPT *** End *** ========== Scripts /Sql/BARS/Data/meta_COBUMMFO-9230second.sql =========*** End *** ===
PROMPT =============================================================================================
