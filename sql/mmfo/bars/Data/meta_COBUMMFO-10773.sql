

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/DATA/meta_COBUMMFO-10773.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** update meta_columns***

declare
  l_tabid number;
begin
  select tabid
    into l_tabid
    from meta_tables
   where tabname = 'V_FOREX_ANI35';
  
  update meta_columns mc
     set mc.colname = 'G13',
         mc.semantic = 'Осн.реф~~13'
   where mc.tabid = l_tabid
     and mc.colid = 27;
  
  select tabid
    into l_tabid
    from meta_tables
   where tabname = 'V_FXS_ARCHIVE';
  
  update meta_columns mc
     set mc.showpos = 10
   where mc.tabid = l_tabid
     and mc.colname = 'FX_TYPE';
  
  update meta_columns mc
     set mc.showpos = 11
   where mc.tabid = l_tabid
     and mc.colname = 'F092';
end;
/


PROMPT *** insert into meta_columns***

begin
  --ani34
  begin
  execute immediate q'[
    insert into meta_columns (TABID, COLID, COLNAME, COLTYPE, SEMANTIC, SHOWWIDTH, SHOWMAXCHAR, SHOWPOS, SHOWIN_RO, SHOWRETVAL, INSTNSSEMANTIC, EXTRNVAL, SHOWREL_CTYPE, SHOWFORMAT, SHOWIN_FLTR, SHOWREF, SHOWRESULT, CASE_SENSITIVE, NOT_TO_EDIT, NOT_TO_SHOW, SIMPLE_FILTER, FORM_NAME, BRANCH, WEB_FORM_NAME, OPER_ID, INPUT_IN_NEW_RECORD)
    values (8062, 27, 'G23', 'C', 'Ініціатор~~~~23', null, null, 27, 0, 0, 0, 0, null, null, 1, 0, null, null, 0, 0, 0, null, '/', null, null, 0)]';
  exception
    when others then
      if sqlcode <> -00001 then
        raise;
      end if;
  end;
  
  begin
  execute immediate q'[
    insert into meta_columns (TABID, COLID, COLNAME, COLTYPE, SEMANTIC, SHOWWIDTH, SHOWMAXCHAR, SHOWPOS, SHOWIN_RO, SHOWRETVAL, INSTNSSEMANTIC, EXTRNVAL, SHOWREL_CTYPE, SHOWFORMAT, SHOWIN_FLTR, SHOWREF, SHOWRESULT, CASE_SENSITIVE, NOT_TO_EDIT, NOT_TO_SHOW, SIMPLE_FILTER, FORM_NAME, BRANCH, WEB_FORM_NAME, OPER_ID, INPUT_IN_NEW_RECORD)
    values (1011813, 27, 'G23', 'C', 'Ініціатор~~~~23', null, null, 27, 0, 0, 0, 0, null, null, 1, 0, null, null, 0, 0, 0, null, '/', null, null, 0)]';
  exception
    when others then
      if sqlcode <> -00001 then
        raise;
      end if;
  end;
  
  --ani35
  begin
  execute immediate q'[
    insert into meta_columns (TABID, COLID, COLNAME, COLTYPE, SEMANTIC, SHOWWIDTH, SHOWMAXCHAR, SHOWPOS, SHOWIN_RO, SHOWRETVAL, INSTNSSEMANTIC, EXTRNVAL, SHOWREL_CTYPE, SHOWFORMAT, SHOWIN_FLTR, SHOWREF, SHOWRESULT, CASE_SENSITIVE, NOT_TO_EDIT, NOT_TO_SHOW, SIMPLE_FILTER, FORM_NAME, BRANCH, WEB_FORM_NAME, OPER_ID, INPUT_IN_NEW_RECORD)
    values (1012508, 29, 'G23', 'C', 'Ініціатор~~15', null, null, 27, 0, 0, 0, 0, null, null, 1, 0, null, null, 0, 0, 0, null, '/', null, null, 0)]';
  exception
    when others then
      if sqlcode <> -00001 then
        raise;
      end if;
  end;
  
  --archive
  begin
  execute immediate q'[
    insert into meta_columns (TABID, COLID, COLNAME, COLTYPE, SEMANTIC, SHOWWIDTH, SHOWMAXCHAR, SHOWPOS, SHOWIN_RO, SHOWRETVAL, INSTNSSEMANTIC, EXTRNVAL, SHOWREL_CTYPE, SHOWFORMAT, SHOWIN_FLTR, SHOWREF, SHOWRESULT, CASE_SENSITIVE, NOT_TO_EDIT, NOT_TO_SHOW, SIMPLE_FILTER, FORM_NAME, BRANCH, WEB_FORM_NAME, OPER_ID, INPUT_IN_NEW_RECORD)
    values (1011226, 43, 'INITIATOR', 'C', 'Ініціатор', null, null, 12, 0, 0, 0, 0, null, null, 0, 0, null, null, 0, 0, 0, null, '/', null, null, 0)]';
  exception
    when others then
      if sqlcode <> -00001 then
        raise;
      end if;
  end;
end;
/

COMMIT;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/DATA/meta_COBUMMFO-10773.sql =========*** End *** ===
PROMPT ===================================================================================== 
