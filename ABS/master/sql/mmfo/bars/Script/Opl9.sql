
set serveroutput on

declare

  type t_rec_extrnval is record (
    tabid            meta_extrnval.tabid%type,
    colid            meta_extrnval.colid%type,
    srccolname       meta_columns.colname%type,
    tab_alias        meta_extrnval.tab_alias%type,
    tab_cond         meta_extrnval.tab_cond%type,
    src_cond         meta_extrnval.src_cond%type,
    col_dyn_tabname  varchar2(30));
  type t_tab_extrnval is table of t_rec_extrnval;
  l_extrnval     t_tab_extrnval := t_tab_extrnval();

  type t_rec_browsetbl is record (
    hosttabid   meta_browsetbl.hosttabid%type,
    hostcolid   meta_browsetbl.hostcolkeyid%type,
    addcolname  meta_columns.colname%type,
    varcolname  meta_columns.colname%type,
    addtabalias meta_browsetbl.addtabalias%type,
    cond_tag    meta_browsetbl.cond_tag%type);
  type t_tab_browsetbl is table of t_rec_browsetbl;
  l_browsetbl    t_tab_browsetbl := t_tab_browsetbl();

  type t_rec_filtertbl is record (
    tabid       meta_filtertbl.tabid%type,
    colid       meta_filtertbl.colid%type,
    fltcode     meta_filtertbl.filter_code%type,
    flag_ins    meta_filtertbl.flag_ins%type,
    flag_del    meta_filtertbl.flag_del%type,
    flag_upd    meta_filtertbl.flag_upd%type);
  type t_tab_filtertbl is table of t_rec_filtertbl;
  l_filtertbl    t_tab_filtertbl := t_tab_filtertbl();

  type t_rec_dependency is record (
    id               meta_dependency_cols.id%type,
    tabid            meta_dependency_cols.tabid%type,
    colid            meta_dependency_cols.colid%type,
    event            meta_dependency_cols.event%type,
    depcolid         meta_dependency_cols.depcolid%type,
    action_type      meta_dependency_cols.action_type%type,
    action_name      meta_dependency_cols.action_name%type,
    default_value    meta_dependency_cols.default_value%type,
    condition        meta_dependency_cols.condition%type);
  type t_tab_dependency is table of t_rec_dependency;
  l_dependency     t_tab_dependency := t_tab_dependency();

  l_tabid        meta_tables.tabid%type;
  l_tabname      meta_tables.tabname%type;
  l_tabsemantic  meta_tables.semantic%type;
  l_tablinesdef  varchar2(16);
  l_tabselect_statement meta_tables.select_statement%type;
  l_newtabid     meta_tables.tabid%type;
  l_newcolid     meta_columns.colid%type;
  l_varcolid     meta_columns.colid%type;
  l_colname      meta_columns.colname%type;

begin

  l_tabsemantic := 'Макет для ввода ручних перехідних (МСФЗ-9) операцій';
  l_tablinesdef := '10';
  l_tabselect_statement := '';
  l_tabname     := 'TEST_O9';

  -- получаем код таблицы
  l_tabid := bars_metabase.get_tabid(l_tabname);

  -- если таблица не описана в БМД
  if l_tabid is null then

    -- получаем код для новой таблицы
    l_tabid := bars_metabase.get_newtabid();

    -- добавляем описание таблицы в БМД
    bars_metabase.add_table(l_tabid, l_tabname, l_tabsemantic, l_tabselect_statement);

  -- если таблица описана в БМД
  else

    -- обновляем семантику таблицы
    bars_metabase.set_tabsemantic(l_tabid, l_tabsemantic);

    -- обновляем linesdef таблицы
    bars_metabase.set_tablinesdef(l_tabid, l_tablinesdef);

    -- обновляем select_statement таблицы
    bars_metabase.set_tabselect_statement(l_tabid, l_tabselect_statement);

    -- сохраняем ссылки сложных полей других таблиц на поля нашей таблицы
    select e.tabid, e.colid, c.colname, e.tab_alias, e.tab_cond, e.src_cond, e.col_dyn_tabname
      bulk collect
      into l_extrnval
      from meta_extrnval e, meta_columns c
     where e.srctabid = l_tabid
       and e.srctabid = c.tabid and e.srccolid = c.colid;

    -- сохраняем ссылки для условий фильтра полей других таблиц на поля нашей таблицы
    select b.hosttabid, b.hostcolkeyid, c.colname, v.colname, b.addtabalias, v.semantic
      bulk collect
      into l_browsetbl
      from meta_browsetbl b, meta_columns c, meta_columns v
     where b.addtabid = l_tabid
       and b.addtabid = c.tabid and b.addcolkeyid = c.colid
       and b.addtabid = v.tabid and b.var_colid = v.colid;

    -- сохраняем ссылки полей других таблиц на нашу вложенную таблицу
    select tabid, colid, filter_code, flag_ins, flag_del, flag_upd
      bulk collect
      into l_filtertbl
      from meta_filtertbl
     where filter_tabid = l_tabid and tabid <> l_tabid;

    -- сохраняем зависимости между колонками таблицы
    select id, tabid, colid, event, depcolid, action_type, action_name, default_value, condition
      bulk collect
      into l_dependency
      from meta_dependency_cols
     where tabid = l_tabid;

    -- удаляем описание полей
    bars_metabase.delete_metatables(l_tabid);

  end if;

  -- добавляем описание полей
  bars_metabase.add_column(l_tabid, 0, 'NPP', 'N', '№ пп', '.5', 3, 0, 1, 1, 0, 0, '', '', 1, 0, '', 0, 0, 1, '', '', 0);
  bars_metabase.add_column(l_tabid, 1, 'ZDAT', 'D', 'Зв.дата~01.ММ.РРРР', '1', 10, 1, 1, 0, 1, 0, '', '', 1, 0, '', 0, 0, 1, '', '', 0);
  bars_metabase.add_column(l_tabid, 2, 'KVD', 'N', 'Вал~Деб', '.5', 3, 2, 1, 0, 0, 0, '', '', 1, 0, '', 0, 0, 1, '', '', 0);
  bars_metabase.add_column(l_tabid, 3, 'NLSD', 'C', 'Рахунок~Деб', '1.5', 14, 3, 1, 0, 0, 0, '', '', 1, 0, '', 0, 0, 1, '', '', 0);
  bars_metabase.add_column(l_tabid, 4, 'SD', 'N', 'Сума~Деб', '1', 22, 4, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 1, '', '', 0);
  bars_metabase.add_column(l_tabid, 5, 'KVK', 'N', 'Вал~Крд', '.5', 3, 5, 1, 0, 0, 0, '', '', 1, 0, '', 0, 0, 1, '', '', 0);
  bars_metabase.add_column(l_tabid, 6, 'NLSK', 'C', 'Рахунок~Крд', '1.5', 14, 6, 1, 0, 0, 0, '', '', 1, 0, '', 0, 0, 1, '', '', 0);
  bars_metabase.add_column(l_tabid, 7, 'SK', 'N', 'Сума~Крд', '1', 22, 7, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 1, '', '', 0);
  bars_metabase.add_column(l_tabid, 8, 'OB22', 'C', 'Ob22~3800', '.5', 2, 8, 1, 0, 0, 0, '', '', 1, 0, '', 0, 0, 1, '', '', 0);
  bars_metabase.add_column(l_tabid, 9, 'NAZN', 'C', 'Признач.пл', '1.5', 60, 9, 1, 0, 0, 0, '', '', 1, 0, '', 0, 0, 1, '', '', 0);
  bars_metabase.add_column(l_tabid, 10, 'REF', 'N', 'Реф.док', '1', 22, 10, 1, 0, 0, 0, '', '', 1, 0, '', 1, 0, 1, '/barsroot/documentview/default.aspx?ref=:REF', '', 0);

  -- очищаем описание функций на справочник
  bars_metabase.delete_nsifunction(l_tabid);

  -- добавляем описание функции на справочник
  bars_metabase.add_nsifunction(l_tabid, 10, 'Виконати проводки ', 'OPL9 (:NPP) ', '', 'EACH', 'Робимо ?', 'ОК !', '', '', '', 23);

  -- восстанавливаем ссылки сложных полей других таблиц
  for i in 1..l_extrnval.count loop
    l_newcolid := bars_metabase.get_colid(l_tabid, l_extrnval(i).srccolname);
    if (l_newcolid is not null) then
      bars_metabase.add_extrnval(
        l_extrnval(i).tabid,
        l_extrnval(i).colid,
        l_tabid,
        l_newcolid,
        l_extrnval(i).tab_alias,
        l_extrnval(i).tab_cond,
        l_extrnval(i).src_cond,
        l_extrnval(i).col_dyn_tabname);
    end if;
  end loop;

  -- восстанавливаем ссылки полей для условий фильтра других таблиц
  for i in 1..l_browsetbl.count loop
    l_newcolid := bars_metabase.get_colid(l_tabid, l_browsetbl(i).addcolname);
    l_varcolid := bars_metabase.get_colid(l_tabid, l_browsetbl(i).varcolname);
    if (l_newcolid is not null and l_varcolid is not null) then
      bars_metabase.add_browsetbl( 
        l_browsetbl(i).hosttabid,
        l_tabid,
        l_browsetbl(i).addtabalias,
        l_browsetbl(i).hostcolid,
        l_newcolid,
        l_varcolid,
        l_browsetbl(i).cond_tag);
    end if;
  end loop;

  -- восстанавливаем ссылки полей других таблиц на нашу вложенную таблицу
  for i in 1..l_filtertbl.count loop
    bars_metabase.add_filtertbl(
      l_filtertbl(i).tabid,
      l_filtertbl(i).colid,
      l_tabid,
      l_filtertbl(i).fltcode,
      l_filtertbl(i).flag_ins,
      l_filtertbl(i).flag_del,
      l_filtertbl(i).flag_upd);
  end loop;

  -- восстанавливаем зависимости между колонками таблицы
  for i in 1..l_dependency.count loop
    bars_metabase.add_dependency(
      l_dependency(i).tabid,
      l_dependency(i).colid,
      l_dependency(i).event ,
      l_dependency(i).depcolid  ,
      l_dependency(i).action_type ,
      l_dependency(i).action_name ,
      l_dependency(i).default_value ,
      l_dependency(i).condition );
  end loop;

end;
/

commit;

begin  EXECUTE IMMEDIATE 
'drop table test_o9' ;
exception when others then   null;
end;
/
commit;

begin  EXECUTE IMMEDIATE 
'create table test_o9 (  zdat DATE,  kvd  INTEGER,  nlsd VARCHAR2(15),  sd   NUMBER,  kvk  INTEGER,  nlsk VARCHAR2(15),  sk   NUMBER,  ob22 CHAR(2),  nazn VARCHAR2(160),  ref  NUMBER,  npp  INTEGER) ' ;
exception when others then   if SQLCODE = -00955 then null;   else raise; end if;   -- ORA-00955: name is already used by an existing object
end;
/
commit;


GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.test_o9 TO BARS_ACCESS_DEFROLE;
------------------------------------------------------------------------------


declare 
 Arm_MMFO varchar2(10)        := '$RM_PRVN'; 
 Arm_RU   varchar2(10)        := 'PRVN'    ; -----------'$RM_OWAY' ; 
 fro_ operlist.FRONTEND%type  := 1     ;  
 id_  operlist.CODEOPER%type  ;  
 nam_ operlist.NAME%type      ;
 fun_ operlist.FUNCNAME%type  ;
 lik_ operlist.FUNCNAME%type  ;
 procedure ADD_fun ( p_lik varchar2) is
 begin   ------------ создать.обновить функцию
   begin select codeoper into id_ from operlist           where funcname  like p_lik  AND FRONTEND = fro_ ;
         update operlist set  name= nam_, funcname = fun_ where codeoper = id_;
   exception when no_data_found then  id_ := OPERLISTNEXTID ;
         Insert into OPERLIST (CODEOPER,NAME,DLGNAME,FUNCNAME,RUNABLE,ROLENAME,FRONTEND) Values (id_,nam_,'N/A', fun_,1,'BARS_ACCESS_DEFROLE', fro_ );
   end ;

   begin     EXECUTE IMMEDIATE  
     ' begin resource_utl.set_resource_access_mode ( resource_utl.get_resource_type_id(''ARM_WEB'') ,  
                                                     user_menu_utl.get_arm_id( :p_arm_code ), 
                                                     resource_utl.get_resource_type_id(''FUNCTION_WEB''), 
                                                     :p_resource_id ,               
                                                     1 ,                     
                                                     true ) ; 
       end ; ' using Arm_MMFO, id_;

   exception when others then   
       if SQLCODE = -06550 then null;   --   для РУ
           begin Insert into BARS.OPERAPP   (CODEAPP, CODEOPER, APPROVE, GRANTOR) Values   (Arm_RU, id_, 1, 1);
           exception when dup_val_on_index then  null; 
           end;
       else raise; 
       end if;  
   end;

 end add_fun ;
 -------------
BEGIN 
  nam_ := 'Макет для ввода ручних перехідних (МСФЗ-9) операцій';  
  lik_ := '%TEST_O9[NSIFUNCTION]%' ;
  fun_ := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0'||chr(38)||'sPar=TEST_O9[NSIFUNCTION][showDialogWindow=>false][EDIT_MODE=>MULTI_EDIT]'  ;
  ADD_fun  (lik_) ;
end;
/
commit;
-----------------------------

create or replace PROCEDURE Opl9  (p_NPP int ) is oo oper%rowtype;
begin 
 for k in (select t.rowid RI, t.* from test_O9 t where ref is null  and npp = p_NPP )
 loop
/*  
--ZDAT	D	Зв.дата~01.ММ.РРРР
--KVD	N	Вал~Деб
NLSD	C	Рахунок~Деб
SD	N	Сума~Деб
--KVK	N	Вал~Крд
NLSK	C	Рахунок~Крд
SK	N	Сума~Крд
OB22	C	Ob22~3800
NAZN	C	Признач.пл
*/

    oo.vdat := DAT_NEXT_U ( k.ZDAT, -1);
    oo.nlsA := k.NLSD ; 
    oo.nlsB := k.nlsK ; 
    OO.KV   := NVL( k.KVD, k.KVK);
    OO.KV2  := NVL( k.KVK, k.KVD);
    oo.nazn := NVL( k.nazn, 'Ручна перехідна (МСФЗ-9) операція') ; 

    If k.SK is null and k.SD is not null    then   oo.S  := k.SD *100;
       If     oo.kv = oo.kv2                then   oo.S2 := oo.S;
       ElsIf  oo.kv <> 980 and oo.Kv2 = 980 then   oo.S2 := gl.p_icurval ( oo.Kv , oo.S, oo.vdat);
       ElsIf  oo.kv =  980 and oo.Kv2<> 980 then   oo.S2 := gl.p_Ncurval ( oo.Kv2, oo.S, oo.vdat);
       end if ;

    ElsIf k.SD is null and k.SK is not null then   oo.S2 := k.SK *100;
       If     oo.kv = oo.kv2                then   oo.S  := oo.S2;
       ElsIf  oo.kv <> 980 and oo.Kv2 = 980 then   oo.S  := gl.p_Ncurval ( oo.Kv , oo.S2, oo.vdat);
       ElsIf  oo.kv =  980 and oo.Kv2<> 980 then   oo.S  := gl.p_Icurval ( oo.Kv2, oo.S2, oo.vdat);
       end if ;
    else oo.S := k.SD *100; oo.S2 := k.SK *100;
    end if ;

    begin select substr(nms,1,38) into oo.nam_A from accounts where kv=oo.kv  and nls=oo.nlsA; 
          select substr(nms,1,38) into oo.nam_B from accounts where kv=oo.kv2 and nls=oo.nlsB;
    EXCEPTION WHEN NO_DATA_FOUND THEN null; 
    end ;

--  SAVEPOINT do_OPL;
--  BEGIN 
       gl.ref (oo.REF);  
       gl.in_doc3 (ref_  => oo.REF  ,    tt_ => '013'  , vob_  => 6       , nd_    =>'FRS9_XX', vdat_ => oo.vdat, dk_   => 1 ,
                    kv_  => oo.kv   ,    s_  => oo.S   , kv2_  => oo.kv2  , s2_    => oo.S2   , sk_   => null   , data_ => gl.BDATE, datp_ => gl.bdate,
                  nam_a_ => oo.nam_a,  nlsa_ => oo.nlsa, mfoa_ => gl.aMfo , nam_b_ => oo.nam_b, nlsb_ => oo.nlsb, mfob_ => gl.aMfo ,
                   nazn_ => oo.nazn , d_rec_ => null   , id_a_ => gl.aOkpo, id_b_  => gl.aOkpo, id_o_ =>null    , sign_ => null    , sos_  => 1, prty_ => null );
       If k.Ob22 is not null and oo.kv <> oo.kv2 then 
          k.Ob22  := Substr ( '0'|| trim(k.Ob22), - 2  ) ;
          insert into operw (ref, tag, value) values (oo.REF, 'OB22', k.Ob22);
       end if;
       gl.payv(0, oo.ref, oo.vdat, '013', 1, oo.kv, oo.nlsa , oo.s, oo.kv2    ,oo.nlsb, oo.s2);
       gl.pay (2, oo.ref, gl.bdate);  -- по факту
--     delete from test_O9 where rowid = k.RI ;
       update test_O9 set ref = oo.REF where rowid = k.RI ;
--  EXCEPTION WHEN OTHERS THEN ROLLBACK TO do_OPL;  
--  END;

  end loop; -- k
  
end Opl9 ;
/
show err;

GRANT execute ON BARS.Opl9 TO BARS_ACCESS_DEFROLE;