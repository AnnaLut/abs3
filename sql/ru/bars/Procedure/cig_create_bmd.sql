

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CIG_CREATE_BMD.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CIG_CREATE_BMD ***

  CREATE OR REPLACE PROCEDURE BARS.CIG_CREATE_BMD (p_tab_name in varchar2, p_semantic in varchar2) is

  l_id number;

  function next_tabid return number is
    tabid_ number;
  begin
    select max(tabid)+1 into tabid_ from meta_tables;
	  return tabid_;
  end;

  function next_colid (tabid_ number) return number is
  colid_ number;
  begin
    select max(colid)+1 into colid_ from meta_columns where tabid=tabid_;
	  return colid_;
  end;

begin
  select tabid into l_id from meta_tables where upper(tabname)=upper(p_tab_name);

  exception when no_data_found then

    l_id := next_tabid;

    insert into meta_tables
      (tabid, tabname, semantic)
    values
      (l_id, p_tab_name, p_semantic);

    insert into meta_columns
      (tabid, colid, colname, coltype, semantic, showwidth, showmaxchar,
        showpos, showin_ro, showretval, instnssemantic, extrnval, showrel_ctype, showformat,
        showin_fltr )
    values
      (l_id, 2, 'KOD', 'C', 'Значение', 1, 10, 3, 1, 1, 0, 0, null, null, 1);

    insert into meta_columns
      ( tabid, colid, colname, coltype, semantic, showwidth, showmaxchar,
        showpos, showin_ro, showretval, instnssemantic, extrnval, showrel_ctype, showformat,
        showin_fltr )
    values
      (l_id, 3, 'TXT', 'C', 'Расшифровка', 5, 100, 2, 1, 0, 1, 0, null, null, 1);

    insert into meta_columns
      ( tabid, colid, colname, coltype, semantic, showwidth, showmaxchar,
        showpos, showin_ro, showretval, instnssemantic, extrnval, showrel_ctype, showformat,
        showin_fltr )
     values
      ( l_id, 1, 'ID', 'N', '№ пп', 1, 22, 1, 1, 0, 0, 0, null, null, 1);

end cig_create_bmd;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CIG_CREATE_BMD.sql =========*** En
PROMPT ===================================================================================== 
