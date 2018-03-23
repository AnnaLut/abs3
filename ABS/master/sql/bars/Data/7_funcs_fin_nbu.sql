set define off;


declare

  l_id number;
l_id_1 number;
l_id_2 number;
l_id_3 number;
l_id_4 number;
l_id_5 number;
l_id_6 number;
l_id_7 number;
l_id_8 number;
l_id_9 number;  
l_id_10 number; 
l_id_11 number; 
l_id_12 number; 
l_id_13 number; 
l_id_14 number; 


 procedure func2arm(p_func_id in number) is
  begin
    insert into operapp (codeapp, codeoper, approve)
    values ('KREW', p_func_id, 1);
  exception when dup_val_on_index then 
    null;
  end;  
  
    procedure add2deps(p_idpar in number, p_idchild in number) is
  begin
	  begin
		insert into operlist_deps (id_parent, id_child) values (p_idpar, p_idchild);
	  exception when dup_val_on_index then 
		null;
	  end;

  end;  
    
  function add_func(
    p_fname in varchar2, 
    p_ftext in varchar2,
    p_runable in number) return number
  is
   l_id number;
  begin
  
 l_id :=
      abs_utils.add_func (
         p_name       => p_ftext,
         p_funcname   => p_fname,
         p_rolename   => 'START1',
         p_frontend   => 1);
   
      
    return l_id;  
   
  end;
  



begin 

 DELETE from operlist_deps WHERE id_child = id_parent;
 commit; 

  l_id := add_func('/barsroot/barsweb/dynform.aspx?form=frm_fin2_cust', 'Розрахунок фінстану ЮО', 1);
  --func2arm(l_id);


  l_id_1 := add_func('/barsroot/barsweb/dynform.aspx?form=frm_fin2_kart_kl\S*', 'Карточка клієнта фінстан ЮО', 3);
   add2deps(l_id, l_id_1);
 
  l_id_2 := add_func('/barsroot/credit/fin_nbu/fin_form.aspx?okpo=\S*frm=\S*', 'Карточка форми', 3);
   add2deps(l_id, l_id_2);

  l_id_5 := add_func('/barsroot/credit/fin_nbu/fin_form_kpb.aspx?okpo=\S*frm=\S*', 'Карточка форми', 3);
   add2deps(l_id, l_id_5);

  l_id_6 := add_func('/barsroot/credit/fin_nbu/fin_form_obu.aspx?okpo=\S*frm=\S*', 'Карточка форми', 3);
   add2deps(l_id, l_id_6);

  l_id_7 := add_func('/barsroot/barsweb/dynform.aspx?form=frm_fin2_obu_pawn\S*', 'Фінстан ЮО застава', 3);
   add2deps(l_id, l_id_7);

  l_id_3 := add_func('/barsroot/barsweb/dynform.aspx?form=frm_fin2_form_k\S*', 'Контроль форми', 3);
   add2deps(l_id, l_id_3);

  l_id_4 := add_func('/barsroot/barsweb/dynform.aspx?form=frm_fin2_form_p\S*', 'Карточка форми2', 3);
   add2deps(l_id, l_id_4);

  l_id_7 := add_func('/barsroot/credit/fin_nbu/fin_list_conclusions.aspx?rnk=\S*nd=\S*', 'Фінстан ЮО print', 3);
   add2deps(l_id, l_id_7);

  l_id_8 := add_func('/barsroot/credit/fin_nbu/fin_kved.aspx?okpo=\S*rnk=\S*', 'Фінстан визначення КВЕД', 3);
  add2deps(l_id, l_id_8);

  l_id_9 := add_func('/barsroot/credit/fin_nbu/credit_defolt.aspx?\S*', 'Фінстан розрахунок постанова 351', 3);
  add2deps(l_id, l_id_9);

  l_id_10 := add_func('/barsroot/credit/fin_nbu/fin_list_dat.aspx?\S*', 'Фінстан розрахунок постанова 351 History', 3);
  add2deps(l_id, l_id_10);

  l_id_11 := add_func('/barsroot/barsweb/dynform.aspx?form=frm_fin2_kart_kontr\S*', 'Карточка контролера фінстан ЮО', 3);
  add2deps(l_id, l_id_11);

  l_id_12 := add_func('/barsroot/credit/fin_nbu/credit_defolt_kons.aspx?\S*', 'Фінстан розрахунок постанова 351', 3);
  add2deps(l_id, l_id_12);

  l_id_13 := add_func('/barsroot/credit/fin_nbu/print_fin.aspx?\S*', 'Фінстан друк постанова 351', 3);
  add2deps(l_id, l_id_13);
 
  l_id_14 := add_func('/barsroot/credit/fin_nbu/fin_form_f3.aspx?\S*', 'Фінстан Forma3', 3);
  add2deps(l_id, l_id_14);
   
   
   
end;  
/
commit;



grant execute on f_get_nd_txt to bars_access_defrole;

GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.STAN_OBS23 TO BARS_ACCESS_DEFROLE;
