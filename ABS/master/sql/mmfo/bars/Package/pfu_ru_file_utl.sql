
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/pfu_ru_file_utl.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.PFU_RU_FILE_UTL is

	-- Author  : YAROSLAV.KURTOV
	-- Created : 26.04.2017
	-- Purpose :
	G_EPP_KILLED_STATE_NEW constant number := 0;

  G_BLK number := 88;

	-- procedure pfu_files_processing;
	type t_state_rec is record(
		ref  varchar2(40),
		pdat varchar2(20),
		idr  varchar2(40));

	type t_state is table of t_state_rec iNDEX BY BINARY_INTEGER;

	procedure ref_state_processing(p_file_data in clob, p_fileid in number);

	procedure get_ebp_processing(p_file_data in clob, p_fileid in number);

	procedure get_cardkill_processing(p_file_data in clob,
																		p_fileid    in number);

	procedure get_report_processing(p_file_data in clob, p_fileid in number);

	procedure get_cm_error_processing(p_file_data in clob,
																		p_fileid    in number);

	procedure get_epp_state_processing(p_file_data in clob,
																		 p_fileid    in number);

	procedure get_restart_epp_processing(p_file_data in clob,
																			 p_fileid    in number);

	procedure get_create_paym_processing(p_file_data in clob, p_fileid in number);

	procedure get_branch_processing(p_file_data in clob, p_fileid in number);

	procedure get_acc_rest_processing(p_file_data in clob,
																		p_fileid    in number);

	procedure set_destruct_processing(p_file_data in clob,
																		p_fileid    in number);

	procedure set_epp_killed(p_epp_number in pfu_epp_line_processing.epp_number%type,
													 p_kill_type  in pfu_epp_kill_type.id_type%type);

  procedure set_card_block_processing(p_file_data in clob, p_fileid in number);

  procedure set_card_unblock_processing(p_file_data in clob, p_fileid in number);

	procedure repeat_block;

	type t_epp_num is table of varchar2(12);

end pfu_ru_file_utl;
/
CREATE OR REPLACE PACKAGE BODY BARS.PFU_RU_FILE_UTL is

	function get_ref_state_receipt(p_ref_list in t_state) return clob is
		l_clob      clob;
		l_domdoc    dbms_xmldom.domdocument;
		l_root_node dbms_xmldom.domnode;

		l_supp_element dbms_xmldom.domelement;

		l_supp_node dbms_xmldom.domnode;

		l_supp_tnode dbms_xmldom.domnode;

		l_supp_text dbms_xmldom.domtext;

		l_supplier_element dbms_xmldom.domelement;
		l_supplier_node    dbms_xmldom.domnode;
		l_sup_node         dbms_xmldom.domnode;
		l_suppp_node       dbms_xmldom.domnode;

		l_state number;
		l_nbs   accounts.nbs%type;
		l_tip   accounts.tip%type;

		l_ref   oper.ref%type;
		l_ref_a oper.ref_a%type;
		l_sos   oper.sos%type;
		l_nlsb  oper.nlsb%type;


	begin

		dbms_lob.createtemporary(l_clob, true, 12);
		-- Create an empty XML document
		l_domdoc := dbms_xmldom.newdomdocument;

		-- Create a root node
		l_root_node := dbms_xmldom.makenode(l_domdoc);

		-- Create a new Supplier Node and add it to the root node
		l_sup_node   := dbms_xmldom.appendchild(l_root_node,
																						dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
																																													 'root')));
		l_suppp_node := dbms_xmldom.appendchild(l_sup_node,
																						dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
																																													 'body')));
		if (p_ref_list.count != 0) then
			for i in p_ref_list.first .. p_ref_list.last loop
				begin
					select o.ref, o.ref_a, o.sos l_sos, o.nlsb
						into l_ref, l_ref_a, l_sos, l_nlsb
						from bars.oper o
					 where o.ref_a = p_ref_list(i).ref
						 and trunc(o.pdat) between to_date(p_ref_list(i).pdat, 'dd.mm.yyyy') and to_date(p_ref_list(i).pdat, 'dd.mm.yyyy') + 5
						 and o.kf = o.mfob
						 and o.mfoa = '300465';

					select ac.nbs, ac.tip
						into l_nbs, l_tip
						from accounts ac
					 where ac.nls = l_nlsb or (ac.nls = l_nlsb and ac.tip like 'W4%' and ac.nls like '2620%') -- COBUMMFO-7501 Добавлен поиск по альтернативе
						 and ac.kv = 980;

					if (/*l_nbs = '2625' and Comment COBUMMFO-7501 оставили проверку только по типу счета */ l_tip like 'W4%') then
						select pqh.resp_code
							into l_state
							from (select PQ.REF, PQ.ACC, PQ.SOS, PQ.F_N, PQ.RESP_CODE
											from OW_PKK_QUE PQ
										 where PQ.SOS = 1
										union
										select PH.REF, PH.ACC, 1, PH.F_N, PH.RESP_CODE
											from OW_PKK_HISTORY PH) pqh
						 where pqh.ref = l_ref;
					else
						l_state := case l_sos
												 when 5 then
													0
												 else
													-1
											 end;
					end if;
					-- For each record, create a new Supplier element
					-- and add this new Supplier element to the Supplier Parent node
					l_supplier_element := dbms_xmldom.createelement(l_domdoc, 'row');
					l_supplier_node    := dbms_xmldom.appendchild(l_suppp_node,
																												dbms_xmldom.makenode(l_supplier_element));

					-- Each Supplier node will get a Number node which contains the Supplier Number as text
					l_supp_element := dbms_xmldom.createelement(l_domdoc, 'ref');
					l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																										dbms_xmldom.makenode(l_supp_element));
					l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, l_ref_a);
					l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																										dbms_xmldom.makenode(l_supp_text));

					l_supp_element := dbms_xmldom.createelement(l_domdoc, 'state_id');
					l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																										dbms_xmldom.makenode(l_supp_element));
					l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, l_state);
					l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,

																										dbms_xmldom.makenode(l_supp_text));

					l_supp_element := dbms_xmldom.createelement(l_domdoc, 'idr');
					l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																										dbms_xmldom.makenode(l_supp_element));
					l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
																											 p_ref_list(i).idr);
					l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,

																										dbms_xmldom.makenode(l_supp_text));

				exception
					when others then
						null;
				end;
			end loop;
		end if;
		dbms_xmldom.writetoclob(l_domdoc, l_clob);
		dbms_xmldom.freedocument(l_domdoc);
		return l_clob;
	exception
		when others then
			l_clob := sqlerrm;
			return l_clob;
	end;

	function get_epp_state_receipt(p_epp_list in t_epp_num) return clob is
		l_clob      clob;
		l_domdoc    dbms_xmldom.domdocument;
		l_root_node dbms_xmldom.domnode;

		l_supp_element dbms_xmldom.domelement;

		l_supp_node dbms_xmldom.domnode;

		l_supp_tnode dbms_xmldom.domnode;

		l_supp_text dbms_xmldom.domtext;

		l_supplier_element dbms_xmldom.domelement;
		l_supplier_node    dbms_xmldom.domnode;
		l_sup_node         dbms_xmldom.domnode;
		l_suppp_node       dbms_xmldom.domnode;

		l_state_id pfu_epp_line_processing.state_id%type;
	begin

		dbms_lob.createtemporary(l_clob, true, 12);
		-- Create an empty XML document
		l_domdoc := dbms_xmldom.newdomdocument;

		-- Create a root node
		l_root_node := dbms_xmldom.makenode(l_domdoc);

		-- Create a new Supplier Node and add it to the root node
		l_sup_node   := dbms_xmldom.appendchild(l_root_node,
																						dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
																																													 'root')));
		l_suppp_node := dbms_xmldom.appendchild(l_sup_node,
																						dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
																																													 'body')));

		FOR i IN p_epp_list.FIRST .. p_epp_list.LAST loop
			select p.state_id
				into l_state_id
				from pfu_epp_line_processing p
			 where p.epp_number = p_epp_list(i);

			-- For each record, create a new Supplier element
			-- and add this new Supplier element to the Supplier Parent node
			l_supplier_element := dbms_xmldom.createelement(l_domdoc, 'row');
			l_supplier_node    := dbms_xmldom.appendchild(l_suppp_node,
																										dbms_xmldom.makenode(l_supplier_element));

			-- Each Supplier node will get a Number node which contains the Supplier Number as text
			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'epp_num');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, p_epp_list(i));
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'state_id');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, l_state_id);
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,

																								dbms_xmldom.makenode(l_supp_text));
		end loop;

		dbms_xmldom.writetoclob(l_domdoc, l_clob);
		dbms_xmldom.freedocument(l_domdoc);
		return l_clob;
	exception
		when others then
			return l_clob;
	end;

	function get_ebp_receipt(p_updid_pen in customer_update.idupd%type,
													 p_updid_acc in accounts_update.idupd%type)
		return clob is
		l_clob      clob;
		l_domdoc    dbms_xmldom.domdocument;
		l_root_node dbms_xmldom.domnode;

		l_supp_element dbms_xmldom.domelement;

		l_supp_node dbms_xmldom.domnode;

		l_supp_tnode dbms_xmldom.domnode;

		l_supp_text dbms_xmldom.domtext;

		l_supplier_element dbms_xmldom.domelement;
		l_supplier_node    dbms_xmldom.domnode;
		l_sup_node         dbms_xmldom.domnode;
		l_suppp_node       dbms_xmldom.domnode;

		l_pens_rec customer%rowtype;
		l_pers_rec person%rowtype;
		l_acc_rec  accounts%rowtype;

	begin

		dbms_lob.createtemporary(l_clob, true, 12);
		-- Create an empty XML document
		l_domdoc := dbms_xmldom.newdomdocument;

		-- Create a root node
		l_root_node := dbms_xmldom.makenode(l_domdoc);

		-- Create a new Supplier Node and add it to the root node
		l_sup_node   := dbms_xmldom.appendchild(l_root_node,
																						dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
																																													 'root')));
		l_suppp_node := dbms_xmldom.appendchild(l_sup_node,
																						dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
																																													 'body')));

		for sup_rec in (with last_accounts_update_id as
											 (select max(idupd) last_acc_id
												 from accounts_update t
												where t.idupd > nvl(p_updid_acc, 0)),
											last_customer_update_id as
											 (select max(idupd) last_pens_id
												 from customer_update t
												where t.idupd > nvl(p_updid_pen, 0))
											select dat.acc,
														 dat.rnk,
														 wau.last_acc_id  last_acc_id,
														 wcu.last_pens_id last_pens_id
												from (select a.acc, cu.rnk
																from customer_update cu
																join accounts a
																	on a.rnk = cu.rnk
																 and a.nbs in ('2620', '2625')
																 and a.kv = 980
															 where cu.idupd > nvl(p_updid_pen, 0)
															 group by a.acc, cu.rnk
															union
															select au.acc,
																		 min(au.rnk) keep(dense_rank last order by au.idupd) rnk
																from accounts_update au
															 where au.idupd > nvl(p_updid_acc, 0)
																 and au.nbs in ('2620', '2625')
																 and au.kv = 980
															 group by au.acc) dat
												left join last_accounts_update_id wau
													on 1 = 1
												left join last_customer_update_id wcu
													on 1 = 1) loop

			begin
				select cust.*
					into l_pens_rec
					from customer cust
				 where cust.rnk = sup_rec.rnk;
			exception
				when no_data_found then
					null;
			end;

			begin
				select pers.*
					into l_pers_rec
					from person pers
				 where pers.rnk = sup_rec.rnk;
			exception
				when no_data_found then
					null;
			end;

			begin
				select acc.*
					into l_acc_rec
					from accounts acc
				 where acc.acc = sup_rec.acc;
			exception
				when no_data_found then
					null;
			end;
			-- For each record, create a new Supplier element
			-- and add this new Supplier element to the Supplier Parent node
			l_supplier_element := dbms_xmldom.createelement(l_domdoc, 'row');
			l_supplier_node    := dbms_xmldom.appendchild(l_suppp_node,
																										dbms_xmldom.makenode(l_supplier_element));

			-- Each Supplier node will get a Number node which contains the Supplier Number as text of(l_row, 'rnk/text()'));
			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'rnk');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, l_pens_rec.rnk);
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'kf');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
																									 bars_context.extract_mfo(l_pens_rec.branch));
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'branchpens');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
																									 l_pens_rec.branch);
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'nmk');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
																									 rawtohex(utl_raw.cast_to_raw(l_pens_rec.nmk)));
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'okpo');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
																									 l_pens_rec.okpo);
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'adr');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
																									 rawtohex(utl_raw.cast_to_raw(l_pens_rec.adr)));
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'date_on');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
																									 to_char(l_pens_rec.date_on,
																													 'dd.mm.yyyy'));
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'date_off');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
																									 to_char(l_pens_rec.date_off,
																													 'dd.mm.yyyy'));
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'passp');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
																									 l_pers_rec.passp);
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'ser');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, l_pers_rec.ser);
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'numdoc');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
																									 l_pers_rec.numdoc);
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'pdate');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
																									 to_char(l_pers_rec.pdate,
																													 'dd.mm.yyyy'));
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'organ');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
																									 rawtohex(utl_raw.cast_to_raw(l_pers_rec.organ)));
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'bplace');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
																									 rawtohex(utl_raw.cast_to_raw(l_pers_rec.bplace)));
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'bday');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
																									 to_char(l_pers_rec.bday,
																													 'dd.mm.yyyy'));
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'cellphone');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
																									 l_pers_rec.cellphone);
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc,
																									'last_ebp_idupd');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
																									 sup_rec.last_pens_id);
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));
			--  acc attr

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'acc');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, l_acc_rec.acc);
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'nls');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, l_acc_rec.nls);
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'branchacc');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
																									 l_acc_rec.branch);
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'kv');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, l_acc_rec.kv);
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'ob22');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, l_acc_rec.ob22);
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'daos');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
																									 to_char(l_acc_rec.daos,
																													 'dd.mm.yyyy'));
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'dapp');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
																									 to_date(l_acc_rec.dapp,
																													 'dd.mm.yyyy'));
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'dazs');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
																									 to_char(l_acc_rec.dazs,
																													 'dd.mm.yyyy'));
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc,
																									'last_acc_idupd');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
																									 sup_rec.last_acc_id);
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

		end loop;
		dbms_xmldom.writetoclob(l_domdoc, l_clob);
		dbms_xmldom.freedocument(l_domdoc);
		return l_clob;
	exception
		when others then
			return l_clob;
	end;

	function get_cardkill_receipt return clob is
		l_clob      clob;
		l_domdoc    dbms_xmldom.domdocument;
		l_root_node dbms_xmldom.domnode;

		l_supp_element dbms_xmldom.domelement;

		l_supp_node dbms_xmldom.domnode;

		l_supp_tnode dbms_xmldom.domnode;

		l_supp_text dbms_xmldom.domtext;

		l_supplier_element dbms_xmldom.domelement;
		l_supplier_node    dbms_xmldom.domnode;
		l_sup_node         dbms_xmldom.domnode;
		l_suppp_node       dbms_xmldom.domnode;

	begin

		dbms_lob.createtemporary(l_clob, true, 12);
		-- Create an empty XML document
		l_domdoc := dbms_xmldom.newdomdocument;

		-- Create a root node
		l_root_node := dbms_xmldom.makenode(l_domdoc);

		-- Create a new Supplier Node and add it to the root node
		l_sup_node   := dbms_xmldom.appendchild(l_root_node,
																						dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
																																													 'root')));
		l_suppp_node := dbms_xmldom.appendchild(l_sup_node,
																						dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
																																													 'body')));

		for sup_rec in (select * from pfu_epp_killed t where t.state = 0) loop

			-- For each record, create a new Supplier element
			-- and add this new Supplier element to the Supplier Parent node
			l_supplier_element := dbms_xmldom.createelement(l_domdoc, 'row');
			l_supplier_node    := dbms_xmldom.appendchild(l_suppp_node,
																										dbms_xmldom.makenode(l_supplier_element));

			-- Each Supplier node will get a Number node which contains the Supplier Number as text of(l_row, 'rnk/text()'));
			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'epp_number');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
																									 sup_rec.epp_number);
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'kill_type');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
																									 sup_rec.kill_type);
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'kill_date');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));
			l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
																									 to_char(sup_rec.kill_date,
																													 'dd.mm.yyyy'));
			l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

		/* update pfu_epp_killed t
           set t.state = 1
         where t.epp_number = sup_rec.epp_number;*/

		end loop;
		dbms_xmldom.writetoclob(l_domdoc, l_clob);
		dbms_xmldom.freedocument(l_domdoc);
		return l_clob;
	exception
		when others then
			return l_clob;
	end;

	function get_report_receipt return clob is
		l_clob      clob;
		l_domdoc    dbms_xmldom.domdocument;
		l_root_node dbms_xmldom.domnode;

		l_supp_element dbms_xmldom.domelement;

		l_supp_node dbms_xmldom.domnode;

		l_supp_tnode dbms_xmldom.domnode;

		l_supp_text dbms_xmldom.domtext;

		l_supplier_element dbms_xmldom.domelement;
		l_supplier_node    dbms_xmldom.domnode;
		l_sup_node         dbms_xmldom.domnode;
		l_suppp_node       dbms_xmldom.domnode;
		l_count            number(2);
		l_date             date;

		l_rnk   number;
		l_datet date;
		l_mfo   varchar2(10);

	begin

		dbms_lob.createtemporary(l_clob, true, 12);
		-- Create an empty XML document
		l_domdoc := dbms_xmldom.newdomdocument;

		-- Create a root node
		l_root_node := dbms_xmldom.makenode(l_domdoc);

		-- Create a new Supplier Node and add it to the root node
		l_sup_node   := dbms_xmldom.appendchild(l_root_node,
																						dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
																																													 'root')));
		l_suppp_node := dbms_xmldom.appendchild(l_sup_node,
																						dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
																																													 'body')));
		l_date       := sysdate;
		for sup_rec in (select distinct a.acc, a.nls
											from accounts a
										 where a.nbs in ('2520', '2625')
											 and a.daos >= add_months(l_date, -12)
											 and a.dazs is null) loop

			select ac.rnk, ac.kf, nvl(ac.dapp, ac.daos)
				into l_rnk, l_mfo, l_datet
				from accounts ac
			 where ac.acc = sup_rec.acc;

			select count(*)
				into l_count
				from opldok o
			 where o.acc = sup_rec.acc
				 and o.dk = 1
				 and o.tt not in
						 (select t.tt from tts t where regexp_like(nlsk, '(6\d\d\d)')) --операция не комиссия
				 and o.fdat between add_months(l_date, -12) and l_date;
			if (l_count = 0) then
				-- For each record, create a new Supplier element
				-- and add this new Supplier element to the Supplier Parent node
				l_supplier_element := dbms_xmldom.createelement(l_domdoc, 'row');
				l_supplier_node    := dbms_xmldom.appendchild(l_suppp_node,
																											dbms_xmldom.makenode(l_supplier_element));

				-- Each Supplier node will get a Number node which contains the Supplier Number as text of(l_row, 'rnk/text()'));
				l_supp_element := dbms_xmldom.createelement(l_domdoc, 'acc_num');
				l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																									dbms_xmldom.makenode(l_supp_element));

				l_supp_text  := dbms_xmldom.createtextnode(l_domdoc, sup_rec.nls);
				l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

				l_supp_element := dbms_xmldom.createelement(l_domdoc, 'rnk');
				l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																									dbms_xmldom.makenode(l_supp_element));

				l_supp_text  := dbms_xmldom.createtextnode(l_domdoc, l_rnk);
				l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

				l_supp_element := dbms_xmldom.createelement(l_domdoc, 'mfo');
				l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																									dbms_xmldom.makenode(l_supp_element));

				l_supp_text  := dbms_xmldom.createtextnode(l_domdoc, l_mfo);
				l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

				l_supp_element := dbms_xmldom.createelement(l_domdoc, 'date_turn');
				l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																									dbms_xmldom.makenode(l_supp_element));

				l_supp_text  := dbms_xmldom.createtextnode(l_domdoc,
																									 to_char(l_datet,
																													 'dd.mm.yyyy'));
				l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																								dbms_xmldom.makenode(l_supp_text));

			end if;
		end loop;
		dbms_xmldom.writetoclob(l_domdoc, l_clob);
		dbms_xmldom.freedocument(l_domdoc);
		return l_clob;
	exception
		when others then
			return l_clob;
	end;

	function get_cm_error_receipt return clob is
		l_clob      clob;
		l_domdoc    dbms_xmldom.domdocument;
		l_root_node dbms_xmldom.domnode;

		l_supp_element dbms_xmldom.domelement;

		l_supp_node dbms_xmldom.domnode;

		l_supp_tnode dbms_xmldom.domnode;

		l_supp_text dbms_xmldom.domtext;

		l_supplier_element dbms_xmldom.domelement;
		l_supplier_node    dbms_xmldom.domnode;
		l_sup_node         dbms_xmldom.domnode;
		l_suppp_node       dbms_xmldom.domnode;
		l_count            number(2);

	begin

		dbms_lob.createtemporary(l_clob, true, 12);
		-- Create an empty XML document
		l_domdoc := dbms_xmldom.newdomdocument;

		-- Create a root node
		l_root_node := dbms_xmldom.makenode(l_domdoc);

		-- Create a new Supplier Node and add it to the root node
		l_sup_node   := dbms_xmldom.appendchild(l_root_node,
																						dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
																																													 'root')));
		l_suppp_node := dbms_xmldom.appendchild(l_sup_node,
																						dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
																																													 'body')));

		for sup_rec in (select c.*
											from bars.cm_client_que           c,
													 bars.pfu_epp_line_processing p
										 where c.id = p.reqid
											 and c.oper_status in (1, 2, 10)
											 and (c.datemod is null or c.datemod < sysdate - 3)) loop

			-- For each record, create a new Supplier element
			-- and add this new Supplier element to the Supplier Parent node
			l_supplier_element := dbms_xmldom.createelement(l_domdoc, 'row');
			l_supplier_node    := dbms_xmldom.appendchild(l_suppp_node,
																										dbms_xmldom.makenode(l_supplier_element));

			-- Each Supplier node will get a Number node which contains the Supplier Number as text of(l_row, 'rnk/text()'));
			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'id');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc, sup_rec.id);
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'datemod');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc,
																								 to_char(sup_rec.datemod,
																												 'dd.mm.yyyy'));
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'oper_type');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc,
																								 sup_rec.oper_type);
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'oper_status');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc,
																								 sup_rec.oper_status);
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'resp_txt');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc, sup_rec.resp_txt);
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'branch');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc, sup_rec.branch);
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'opendate');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc,
																								 to_char(sup_rec.opendate,
																												 'dd.mm.yyyy'));
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'clienttype');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc,
																								 sup_rec.clienttype);
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc,
																									'taxpayeridentifier');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc,
																								 sup_rec.taxpayeridentifier);
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'firstname');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc,
																								 sup_rec.firstname);
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'lastname');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc, sup_rec.lastname);
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'middlename');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc,
																								 sup_rec.middlename);
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'engfirstname');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc,
																								 sup_rec.engfirstname);
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'englastname');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc,
																								 sup_rec.englastname);
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'country');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc, sup_rec.country);
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'work');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc, sup_rec.work);
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'office');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc, sup_rec.office);
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'birthdate');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc,
																								 to_char(sup_rec.birthdate,
																												 'dd.mm.yyyy'));
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'birthplace');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc,
																								 sup_rec.birthplace);
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'gender');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc, sup_rec.gender);
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'typedoc');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc, sup_rec.typedoc);
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'paspnum');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc, sup_rec.paspnum);
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'paspseries');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc,
																								 sup_rec.paspseries);
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'paspdate');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc,
																								 to_char(sup_rec.paspdate,
																												 'dd.mm.yyyy'));
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'paspissuer');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc,
																								 sup_rec.paspissuer);
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc,
																									'contractnumber');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc,
																								 sup_rec.contractnumber);
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'productcode');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc,
																								 sup_rec.productcode);
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'card_type');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc,
																								 sup_rec.card_type);
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc,
																									'regnumberclient');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc,
																								 sup_rec.regnumberclient);
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc,
																									'regnumberowner');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc,
																								 sup_rec.regnumberowner);
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'card_br_iss');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc,
																								 sup_rec.card_br_iss);
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));
		end loop;
		dbms_xmldom.writetoclob(l_domdoc, l_clob);
		dbms_xmldom.freedocument(l_domdoc);
		return l_clob;
	exception
		when others then
			return l_clob;
	end;

	function get_branch_receipt return clob is
		l_clob      clob;
		l_domdoc    dbms_xmldom.domdocument;
		l_root_node dbms_xmldom.domnode;

		l_supp_element dbms_xmldom.domelement;

		l_supp_node dbms_xmldom.domnode;

		l_supp_tnode dbms_xmldom.domnode;

		l_supp_text dbms_xmldom.domtext;

		l_supplier_element dbms_xmldom.domelement;
		l_supplier_node    dbms_xmldom.domnode;
		l_sup_node         dbms_xmldom.domnode;
		l_suppp_node       dbms_xmldom.domnode;
		l_count            number(2);

	begin

		dbms_lob.createtemporary(l_clob, true, 12);
		-- Create an empty XML document
		l_domdoc := dbms_xmldom.newdomdocument;

		-- Create a root node
		l_root_node := dbms_xmldom.makenode(l_domdoc);

		-- Create a new Supplier Node and add it to the root node
		l_sup_node   := dbms_xmldom.appendchild(l_root_node,
																						dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
																																													 'root')));
		l_suppp_node := dbms_xmldom.appendchild(l_sup_node,
																						dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
																																													 'body')));

		for sup_rec in (select br.branch,
													 br.name,
													 bp.val,
													 br.date_opened,
													 br.date_closed
											from branch br
											left join branch_parameters bp
												on (br.branch = bp.branch and bp.tag = 'EPP_WORK')) loop

			-- For each record, create a new Supplier element
			-- and add this new Supplier element to the Supplier Parent node
			l_supplier_element := dbms_xmldom.createelement(l_domdoc, 'row');
			l_supplier_node    := dbms_xmldom.appendchild(l_suppp_node,
																										dbms_xmldom.makenode(l_supplier_element));

			-- Each Supplier node will get a Number node which contains the Supplier Number as text of(l_row, 'rnk/text()'));
			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'branch');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc, sup_rec.branch);
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'name');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc, sup_rec.name);
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'val');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc, sup_rec.val);
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'date_opened');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc,
																								 to_char(sup_rec.date_opened,
																												 'dd.mm.yyyy'));
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

			l_supp_element := dbms_xmldom.createelement(l_domdoc, 'date_closed');
			l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
																								dbms_xmldom.makenode(l_supp_element));

			l_supp_text  := dbms_xmldom.createtextnode(l_domdoc,
																								 to_char(sup_rec.date_closed,
																												 'dd.mm.yyyy'));
			l_supp_tnode := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

		end loop;
		dbms_xmldom.writetoclob(l_domdoc, l_clob);
		dbms_xmldom.freedocument(l_domdoc);
		return l_clob;
	exception
		when others then
			return l_clob;
	end;

	function get_acc_rest_receipt(p_acc    in accounts.nls%type,
																p_fileid in number) return clob is
		l_clob      clob;
		l_domdoc    dbms_xmldom.domdocument;
		l_root_node dbms_xmldom.domnode;

		l_supp_element dbms_xmldom.domelement;

		l_supp_node dbms_xmldom.domnode;

		l_supp_tnode dbms_xmldom.domnode;

		l_supp_text dbms_xmldom.domtext;

		l_supplier_element dbms_xmldom.domelement;
		l_supplier_node    dbms_xmldom.domnode;
		l_sup_node         dbms_xmldom.domnode;
		l_suppp_node       dbms_xmldom.domnode;

		l_ostc accounts.ostf%type;

	begin

		dbms_lob.createtemporary(l_clob, true, 12);

		select acc.ostc into l_ostc from accounts acc where acc.nls = p_acc;

		-- Create an empty XML document
		l_domdoc := dbms_xmldom.newdomdocument;

		-- Create a root node
		l_root_node := dbms_xmldom.makenode(l_domdoc);

		-- Create a new Supplier Node and add it to the root node
		l_sup_node   := dbms_xmldom.appendchild(l_root_node,
																						dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
																																													 'root')));
		l_suppp_node := dbms_xmldom.appendchild(l_sup_node,
																						dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
																																													 'body')));

		-- Each Supplier node will get a Number node which contains the Supplier Number as text
		l_supp_element := dbms_xmldom.createelement(l_domdoc, 'acc');
		l_supp_node    := dbms_xmldom.appendchild(l_suppp_node,
																							dbms_xmldom.makenode(l_supp_element));
		l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, p_acc);
		l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

		-- Each Supplier node will get a Number node which contains the Supplier Number as text
		l_supp_element := dbms_xmldom.createelement(l_domdoc, 'ostc');
		l_supp_node    := dbms_xmldom.appendchild(l_suppp_node,
																							dbms_xmldom.makenode(l_supp_element));
		l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, l_ostc);
		l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));

		-- Each Supplier node will get a Number node which contains the Supplier Number as text
		l_supp_element := dbms_xmldom.createelement(l_domdoc, 'fileid');
		l_supp_node    := dbms_xmldom.appendchild(l_suppp_node,
																							dbms_xmldom.makenode(l_supp_element));
		l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, p_fileid);
		l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
																							dbms_xmldom.makenode(l_supp_text));
dbms_xmldom.writetoclob(l_domdoc, l_clob);
		dbms_xmldom.freedocument(l_domdoc);
		return l_clob;
	exception
		when others then
			return l_clob;
	end;

  function get_create_paym_receipt(p_fio in varchar2,
                                   p_okpo in varchar2,
                                   p_sum in number,
                                   p_num_acc in number,
                                   p_acc2560 in number,
                                   p_date_dead in date,
                                   p_did in number) return clob is
    l_clob      clob;
    l_domdoc    dbms_xmldom.domdocument;
    l_root_node dbms_xmldom.domnode;

    l_supp_element dbms_xmldom.domelement;

    l_supp_node dbms_xmldom.domnode;

    l_supp_tnode dbms_xmldom.domnode;

    l_supp_text dbms_xmldom.domtext;

    l_supplier_element dbms_xmldom.domelement;
    l_supplier_node    dbms_xmldom.domnode;
    l_sup_node         dbms_xmldom.domnode;
    l_suppp_node       dbms_xmldom.domnode;

    l_ostc accounts.ostf%type;

    l_ref           oper.ref%type;
    l_tt            tts.tt%type := 'PKY';
    l_vob           oper.vob%type := 6;
    l_dk            oper.dk%type := 1;
    l_mfo           varchar2(10);
    l_okpo_b        varchar2(12);
    l_typ           varchar2(30);
    l_bankdate      date;
    l_nls_b         oper.nlsa%type;
    l_mfo_b         varchar2(9);
    l_nazn          varchar2(160);
    l_err           varchar2(4000);
    l_doc           varchar2(30);
    l_sum           number;

    l_acc_rec       accounts%rowtype;

  begin

    dbms_lob.createtemporary(l_clob, true, 12);

    select acc.ostc
      into l_ostc
      from accounts acc
     where acc.nls = p_num_acc;

    select * into l_acc_rec
      from accounts acc
     where acc.nls = p_acc2560;

    select c.okpo into l_okpo_b
      from customer c
     where c.rnk = l_acc_rec.rnk;

    -- Create an empty XML document
    l_domdoc := dbms_xmldom.newdomdocument;

    -- Create a root node
    l_root_node := dbms_xmldom.makenode(l_domdoc);

    -- Create a new Supplier Node and add it to the root node
    l_sup_node   := dbms_xmldom.appendchild(l_root_node,
                                            dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
                                                                                           'root')));
    l_suppp_node := dbms_xmldom.appendchild(l_sup_node,
                                            dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
                                                                                           'body')));

    l_bankdate  := gl.bd;

    if l_ostc >= p_sum then
      l_sum := p_sum;
      l_typ := 'ALL';
    else
      l_sum := l_ostc;
      l_typ := 'PART';
    end if;

    if (l_sum > 0) then
      gl.ref(l_ref);

      l_mfo := gl.kf;

      l_nazn  := substr('Повернення пенсійних коштів;'||p_fio||';'||p_okpo||';'||to_char(sysdate,'DD.MM.YYYY'), 1, 160);

      gl.in_doc3(l_ref,
                 l_tt,
                 l_vob,
                 l_ref,
                 sysdate,
                 sysdate,
                 l_dk,
                 '980',
                 l_sum,
                 '980',
                 l_sum,
                 null,
                 l_bankdate,
                 l_bankdate,
                 p_fio,
                 p_num_acc,
                 l_mfo,
                 substr(l_acc_rec.nms,1,38),
                 l_acc_rec.nls,
                 l_mfo,
                 l_nazn,
                 null,
                 p_okpo,
                 l_okpo_b,
                 null,
                 null,
                 0,
                 0,
                 null);

      -- Формирование проводок
      paytt(0,
            l_ref,
            l_bankdate,
            l_tt,
            1,
            '980',
            p_num_acc,
            l_sum,
            '980',
            l_acc_rec.nls,
            l_sum);

      chk.put_visa(l_ref, l_tt, 5, 2, null, null, null);
    else
        l_ref := 0;
        l_typ := 'NOTHING';
        l_sum := 0;
    end if;


    -- Each Supplier node will get a Number node which contains the Supplier Number as text
    l_supp_element := dbms_xmldom.createelement(l_domdoc, 'ref');
    l_supp_node    := dbms_xmldom.appendchild(l_suppp_node,
                                              dbms_xmldom.makenode(l_supp_element));
    l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, l_ref);
    l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                              dbms_xmldom.makenode(l_supp_text));

    -- Each Supplier node will get a Number node which contains the Supplier Number as text
    l_supp_element := dbms_xmldom.createelement(l_domdoc, 'typ');
    l_supp_node    := dbms_xmldom.appendchild(l_suppp_node,
                                              dbms_xmldom.makenode(l_supp_element));
    l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, l_typ);
    l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                              dbms_xmldom.makenode(l_supp_text));

    -- Each Supplier node will get a Number node which contains the Supplier Number as text
    l_supp_element := dbms_xmldom.createelement(l_domdoc, 'sum');
    l_supp_node    := dbms_xmldom.appendchild(l_suppp_node,
                                              dbms_xmldom.makenode(l_supp_element));
    l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, l_sum);
    l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                dbms_xmldom.makenode(l_supp_text));

        -- Each Supplier node will get a Number node which contains the Supplier Number as text
    l_supp_element := dbms_xmldom.createelement(l_domdoc, 'did');
    l_supp_node    := dbms_xmldom.appendchild(l_suppp_node,
                                              dbms_xmldom.makenode(l_supp_element));
    l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, p_did);
    l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                dbms_xmldom.makenode(l_supp_text));

    dbms_xmldom.writetoclob(l_domdoc, l_clob);
    dbms_xmldom.freedocument(l_domdoc);
    return l_clob;
  /*exception
    when others then
      return l_clob;*/
  end;

  function set_card_block_receipt(p_id     in pfu_epp_line_processing.id%type,
                                  p_nls    in accounts.nls%type,
										  						p_fileid in number) return clob is
		l_clob      clob;
		l_domdoc    dbms_xmldom.domdocument;
		l_root_node dbms_xmldom.domnode;

		l_supp_element dbms_xmldom.domelement;

		l_supp_node dbms_xmldom.domnode;

		l_supp_tnode dbms_xmldom.domnode;

		l_supp_text dbms_xmldom.domtext;

		l_supplier_element dbms_xmldom.domelement;
		l_supplier_node    dbms_xmldom.domnode;
		l_sup_node         dbms_xmldom.domnode;
		l_suppp_node       dbms_xmldom.domnode;

    l_nls   accounts.nls%type;
    l_acc   accounts.acc%type;
    l_blkd  accounts.blkd%type;
	  l_date  date;

    p_comment pfu_epp_line_processing.message%type;

	begin

		dbms_lob.createtemporary(l_clob, true, 12);
    if (p_nls is null and p_id is not null) then
        select t.nls into l_nls
          from pfu_epp_line_processing t
         where t.id = p_id;

        select t.blkd into l_blkd
          from accounts t
         where t.nls = l_nls;

       l_date :=sysdate;

        if (l_blkd = 0) then
           update accounts a
              set a.blkd = G_BLK
            where a.nls = l_nls;
           update pfu_epp_line_processing p
              set p.is_blk = 1,
                  p.date_blk = l_date,
                  p.state_id = 32,
                  p.message = 'Блокировка на счет установлена'
            where p.id = p_id;
            p_comment := 'Блокировка на счет установлена';
        else
           update pfu_epp_line_processing p
              set p.state_id = 32,
                  p.message = 'Есть иня блокировка на счете'
            where p.id = p_id;
            p_comment := 'Есть иная блокировка на счете';
        end if;

        -- Create an empty XML document
        l_domdoc := dbms_xmldom.newdomdocument;

        -- Create a root node
        l_root_node := dbms_xmldom.makenode(l_domdoc);

        -- Create a new Supplier Node and add it to the root node
        l_sup_node   := dbms_xmldom.appendchild(l_root_node,
                                                dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
                                                                                               'root')));
        l_suppp_node := dbms_xmldom.appendchild(l_sup_node,
                                                dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
                                                                                               'body')));

        -- Each Supplier node will get a Number node which contains the Supplier Number as text
        l_supp_element := dbms_xmldom.createelement(l_domdoc, 'isepp');
        l_supp_node    := dbms_xmldom.appendchild(l_suppp_node,
                                                  dbms_xmldom.makenode(l_supp_element));
        l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, 1);
        l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                  dbms_xmldom.makenode(l_supp_text));

        l_supp_element := dbms_xmldom.createelement(l_domdoc, 'id');
        l_supp_node    := dbms_xmldom.appendchild(l_suppp_node,
                                                  dbms_xmldom.makenode(l_supp_element));
        l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, p_id);
        l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                  dbms_xmldom.makenode(l_supp_text));

        l_supp_element := dbms_xmldom.createelement(l_domdoc, 'date_blk');
        l_supp_node    := dbms_xmldom.appendchild(l_suppp_node,
                                                  dbms_xmldom.makenode(l_supp_element));
        l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, to_char(l_date,'dd.mm.yyyy'));
        l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                  dbms_xmldom.makenode(l_supp_text));

        l_supp_element := dbms_xmldom.createelement(l_domdoc, 'comment');
        l_supp_node    := dbms_xmldom.appendchild(l_suppp_node,
                                                  dbms_xmldom.makenode(l_supp_element));
        l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, p_comment);
        l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                  dbms_xmldom.makenode(l_supp_text));
    elsif (p_id is null and p_nls is not null) then

        select t.blkd, t.acc into l_blkd, l_acc
          from accounts t
         where t.nls = p_nls;

       l_date :=sysdate;

        if (l_blkd = 0) then
           update accounts a
              set a.blkd = G_BLK
            where a.nls = p_nls;
            p_comment := 'Блокировка на счет установлена';
        else
           insert into acc_to_block_vso
           values (l_acc);
           p_comment := 'Есть иная блокировка на счете';
        end if;

        -- Create an empty XML document
        l_domdoc := dbms_xmldom.newdomdocument;

        -- Create a root node
        l_root_node := dbms_xmldom.makenode(l_domdoc);

        -- Create a new Supplier Node and add it to the root node
        l_sup_node   := dbms_xmldom.appendchild(l_root_node,
                                                dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
                                                                                               'root')));
        l_suppp_node := dbms_xmldom.appendchild(l_sup_node,
                                                dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
                                                                                               'body')));

        -- Each Supplier node will get a Number node which contains the Supplier Number as text

        l_supp_element := dbms_xmldom.createelement(l_domdoc, 'isepp');
        l_supp_node    := dbms_xmldom.appendchild(l_suppp_node,
                                                  dbms_xmldom.makenode(l_supp_element));
        l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, 0);
        l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                  dbms_xmldom.makenode(l_supp_text));

        l_supp_element := dbms_xmldom.createelement(l_domdoc, 'nls');
        l_supp_node    := dbms_xmldom.appendchild(l_suppp_node,
                                                  dbms_xmldom.makenode(l_supp_element));
        l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, p_nls);
        l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                  dbms_xmldom.makenode(l_supp_text));

        l_supp_element := dbms_xmldom.createelement(l_domdoc, 'date_blk');
        l_supp_node    := dbms_xmldom.appendchild(l_suppp_node,
                                                  dbms_xmldom.makenode(l_supp_element));
        l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, to_char(l_date,'dd.mm.yyyy'));
        l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                  dbms_xmldom.makenode(l_supp_text));

        l_supp_element := dbms_xmldom.createelement(l_domdoc, 'comment');
        l_supp_node    := dbms_xmldom.appendchild(l_suppp_node,
                                                  dbms_xmldom.makenode(l_supp_element));
        l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, p_comment);
        l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                  dbms_xmldom.makenode(l_supp_text));
    end if;


		dbms_xmldom.writetoclob(l_domdoc, l_clob);
		dbms_xmldom.freedocument(l_domdoc);
		return l_clob;
	exception
		when others then
			return l_clob;
	end;

   function set_card_unblock_receipt(p_id     in pfu_epp_line_processing.id%type,
                                     p_nls    in accounts.nls%type,
										  						   p_fileid in number) return clob is
		l_clob      clob;
		l_domdoc    dbms_xmldom.domdocument;
		l_root_node dbms_xmldom.domnode;

		l_supp_element dbms_xmldom.domelement;

		l_supp_node dbms_xmldom.domnode;

		l_supp_tnode dbms_xmldom.domnode;

		l_supp_text dbms_xmldom.domtext;

		l_supplier_element dbms_xmldom.domelement;
		l_supplier_node    dbms_xmldom.domnode;
		l_sup_node         dbms_xmldom.domnode;
		l_suppp_node       dbms_xmldom.domnode;

    l_nls   accounts.nls%type;
    l_acc   accounts.acc%type;
    l_blkd  accounts.blkd%type;
	  l_date  date;

    p_comment pfu_epp_line_processing.message%type;

	begin

		dbms_lob.createtemporary(l_clob, true, 12);
    if (p_nls is null and p_id is not null) then
        select t.nls into l_nls
          from pfu_epp_line_processing t
         where t.id = p_id;

        select t.blkd into l_blkd
          from accounts t
         where t.nls = l_nls;

       l_date :=sysdate;

        if (l_blkd = G_BLK) then
           update accounts a
              set a.blkd = 0
            where a.nls = l_nls;
        end if;
           update pfu_epp_line_processing p
              set p.is_blk = 1,
                  p.date_blk = l_date,
                  p.state_id = 33,
                  p.message = 'Счет разблокирован'
            where p.id = p_id;
            p_comment := 'Счет разблокирован';

        -- Create an empty XML document
        l_domdoc := dbms_xmldom.newdomdocument;

        -- Create a root node
        l_root_node := dbms_xmldom.makenode(l_domdoc);

        -- Create a new Supplier Node and add it to the root node
        l_sup_node   := dbms_xmldom.appendchild(l_root_node,
                                                dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
                                                                                               'root')));
        l_suppp_node := dbms_xmldom.appendchild(l_sup_node,
                                                dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
                                                                                               'body')));

        -- Each Supplier node will get a Number node which contains the Supplier Number as text
        l_supp_element := dbms_xmldom.createelement(l_domdoc, 'isepp');
        l_supp_node    := dbms_xmldom.appendchild(l_suppp_node,
                                                  dbms_xmldom.makenode(l_supp_element));
        l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, 1);
        l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                  dbms_xmldom.makenode(l_supp_text));

        l_supp_element := dbms_xmldom.createelement(l_domdoc, 'id');
        l_supp_node    := dbms_xmldom.appendchild(l_suppp_node,
                                                  dbms_xmldom.makenode(l_supp_element));
        l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, p_id);
        l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                  dbms_xmldom.makenode(l_supp_text));

        l_supp_element := dbms_xmldom.createelement(l_domdoc, 'date_blk');
        l_supp_node    := dbms_xmldom.appendchild(l_suppp_node,
                                                  dbms_xmldom.makenode(l_supp_element));
        l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, to_char(l_date,'dd.mm.yyyy'));
        l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                  dbms_xmldom.makenode(l_supp_text));

        l_supp_element := dbms_xmldom.createelement(l_domdoc, 'comment');
        l_supp_node    := dbms_xmldom.appendchild(l_suppp_node,
                                                  dbms_xmldom.makenode(l_supp_element));
        l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, p_comment);
        l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                  dbms_xmldom.makenode(l_supp_text));
    elsif (p_id is null and p_nls is not null) then

        select t.blkd, t.acc into l_blkd, l_acc
          from accounts t
         where t.nls = p_nls;

       l_date :=sysdate;

        if (l_blkd = G_BLK) then
           update accounts a
              set a.blkd = 0
            where a.nls = p_nls;
            p_comment := 'Счет разблокирован';
        else
           delete
             from acc_to_block_vso t
           where t.acc = l_acc;
           p_comment := 'Счет разблокирован';
        end if;

        -- Create an empty XML document
        l_domdoc := dbms_xmldom.newdomdocument;

        -- Create a root node
        l_root_node := dbms_xmldom.makenode(l_domdoc);

        -- Create a new Supplier Node and add it to the root node
        l_sup_node   := dbms_xmldom.appendchild(l_root_node,
                                                dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
                                                                                               'root')));
        l_suppp_node := dbms_xmldom.appendchild(l_sup_node,
                                                dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
                                                                                               'body')));

        -- Each Supplier node will get a Number node which contains the Supplier Number as text

        l_supp_element := dbms_xmldom.createelement(l_domdoc, 'isepp');
        l_supp_node    := dbms_xmldom.appendchild(l_suppp_node,
                                                  dbms_xmldom.makenode(l_supp_element));
        l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, 0);
        l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                  dbms_xmldom.makenode(l_supp_text));

        l_supp_element := dbms_xmldom.createelement(l_domdoc, 'nls');
        l_supp_node    := dbms_xmldom.appendchild(l_suppp_node,
                                                  dbms_xmldom.makenode(l_supp_element));
        l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, p_nls);
        l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                  dbms_xmldom.makenode(l_supp_text));

        l_supp_element := dbms_xmldom.createelement(l_domdoc, 'date_blk');
        l_supp_node    := dbms_xmldom.appendchild(l_suppp_node,
                                                  dbms_xmldom.makenode(l_supp_element));
        l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, to_char(l_date,'dd.mm.yyyy'));
        l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                  dbms_xmldom.makenode(l_supp_text));

        l_supp_element := dbms_xmldom.createelement(l_domdoc, 'comment');
        l_supp_node    := dbms_xmldom.appendchild(l_suppp_node,
                                                  dbms_xmldom.makenode(l_supp_element));
        l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, p_comment);
        l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                  dbms_xmldom.makenode(l_supp_text));
    end if;


		dbms_xmldom.writetoclob(l_domdoc, l_clob);
		dbms_xmldom.freedocument(l_domdoc);
		return l_clob;
	exception
		when others then
			return l_clob;
	end;

	function set_destruct_receipt(p_epp_number in pfu_epp_line_processing.epp_number%type)
		return clob is
		l_clob      clob;
		l_domdoc    dbms_xmldom.domdocument;
		l_root_node dbms_xmldom.domnode;

		l_supp_element dbms_xmldom.domelement;

		l_supp_node dbms_xmldom.domnode;

		l_supp_tnode dbms_xmldom.domnode;

		l_supp_text dbms_xmldom.domtext;

		l_supplier_element dbms_xmldom.domelement;
		l_supplier_node    dbms_xmldom.domnode;
		l_sup_node         dbms_xmldom.domnode;
		l_suppp_node       dbms_xmldom.domnode;

		l_nls  accounts.nls%type;
		l_blkd accounts.blkd%type;

		p_comment pfu_epp_line_processing.message%type;

	begin

		dbms_lob.createtemporary(l_clob, true, 12);

		update pfu_epp_killed t
			 set t.state = 1
		 where t.epp_number = p_epp_number;

		-- Create an empty XML document
		l_domdoc := dbms_xmldom.newdomdocument;

		-- Create a root node
		l_root_node := dbms_xmldom.makenode(l_domdoc);

		-- Create a new Supplier Node and add it to the root node
		l_sup_node   := dbms_xmldom.appendchild(l_root_node,
																						dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
																																													 'root')));
		l_suppp_node := dbms_xmldom.appendchild(l_sup_node,
																						dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
																																													 'body')));
		dbms_xmldom.writetoclob(l_domdoc, l_clob);
		dbms_xmldom.freedocument(l_domdoc);
		return l_clob;
	exception
		when others then
			return l_clob;
	end;

	procedure ref_state_processing(p_file_data in clob, p_fileid in number) is
		l_parser   dbms_xmlparser.parser;
		l_doc      dbms_xmldom.domdocument;
		l_rows     dbms_xmldom.domnodelist;
		l_row      dbms_xmldom.domnode;
		l_ref_list t_state;
		l_clob     clob;
	begin

		l_parser := dbms_xmlparser.newparser;
		dbms_xmlparser.parseclob(l_parser, p_file_data);
		l_doc := dbms_xmlparser.getdocument(l_parser);

		l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'row');
		for i in 0 .. dbms_xmldom.getlength(l_rows) - 1 loop
			l_row := dbms_xmldom.item(l_rows, i);

			l_ref_list(i).ref := dbms_xslprocessor.valueof(l_row, 'ref/text()');
			l_ref_list(i).pdat := dbms_xslprocessor.valueof(l_row, 'pdat/text()');
			l_ref_list(i).idr := dbms_xslprocessor.valueof(l_row, 'idr/text()');
		end loop;

		pfu_ru_epp_utl.set_file_state(p_fileid,
																	10,
																	'Файл оброблено');
		l_clob := get_ref_state_receipt(l_ref_list);
		if l_clob is not null then
			pfu_ru_epp_utl.set_file_state(p_fileid,
																		20,
																		'Квитанцію сформовано',
																		l_clob);
		end if;
		dbms_xmlparser.freeparser(l_parser);
		dbms_xmldom.freedocument(l_doc);

	end;

	procedure get_ebp_processing(p_file_data in clob, p_fileid in number) is
		l_parser     dbms_xmlparser.parser;
		l_doc        dbms_xmldom.domdocument;
		l_rows       dbms_xmldom.domnodelist;
		l_updid_pens customer_update.idupd%type;
		l_updid_acc  accounts_update.idupd%type;
		l_row        dbms_xmldom.domnode;
		l_clob       clob;
	begin

		l_parser := dbms_xmlparser.newparser;
		dbms_xmlparser.parseclob(l_parser, p_file_data);
		l_doc := dbms_xmlparser.getdocument(l_parser);

		l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'body');

		l_row := dbms_xmldom.item(l_rows, 0);

		l_updid_pens := to_number(dbms_xslprocessor.valueof(l_row,
																												'updid_pens/text()'));
		l_updid_acc  := to_number(dbms_xslprocessor.valueof(l_row,
																												'updid_acc/text()'));

		pfu_ru_epp_utl.set_file_state(p_fileid,
																	10,
																	'Файл оброблено');
		l_clob := get_ebp_receipt(l_updid_pens, l_updid_acc);
		if l_clob is not null then
			pfu_ru_epp_utl.set_file_state(p_fileid,
																		20,
																		'Квитанцію сформовано',
																		l_clob);
		end if;
		dbms_xmlparser.freeparser(l_parser);
		dbms_xmldom.freedocument(l_doc);

	end;

	procedure get_cardkill_processing(p_file_data in clob,
																		p_fileid    in number) is
		l_parser dbms_xmlparser.parser;
		l_doc    dbms_xmldom.domdocument;
		l_rows   dbms_xmldom.domnodelist;
		l_row    dbms_xmldom.domnode;
		l_clob   clob;
	begin

		l_parser := dbms_xmlparser.newparser;
		dbms_xmlparser.parseclob(l_parser, p_file_data);
		l_doc := dbms_xmlparser.getdocument(l_parser);

		l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'body');

		l_row := dbms_xmldom.item(l_rows, 0);

		pfu_ru_epp_utl.set_file_state(p_fileid,
																	10,
																	'Файл оброблено');
		l_clob := get_cardkill_receipt;
		if l_clob is not null then
			pfu_ru_epp_utl.set_file_state(p_fileid,
																		20,
																		'Квитанцію сформовано',
																		l_clob);
		end if;
		dbms_xmlparser.freeparser(l_parser);
		dbms_xmldom.freedocument(l_doc);

	end;

	procedure get_report_processing(p_file_data in clob, p_fileid in number) is
		l_parser dbms_xmlparser.parser;
		l_doc    dbms_xmldom.domdocument;
		l_rows   dbms_xmldom.domnodelist;
		l_row    dbms_xmldom.domnode;
		l_date   date;
		l_clob   clob;
	begin

		l_parser := dbms_xmlparser.newparser;
		dbms_xmlparser.parseclob(l_parser, p_file_data);
		l_doc := dbms_xmlparser.getdocument(l_parser);

		l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'body');

		l_row := dbms_xmldom.item(l_rows, 0);

		--    l_date  := to_date(dbms_xslprocessor.valueof(l_row,'daterep/text()'));

		pfu_ru_epp_utl.set_file_state(p_fileid,
																	10,
																	'Файл оброблено');
		l_clob := get_report_receipt;
		if l_clob is not null then
			pfu_ru_epp_utl.set_file_state(p_fileid,
																		20,
																		'Квитанцію сформовано',
																		l_clob);
		end if;
		dbms_xmlparser.freeparser(l_parser);
		dbms_xmldom.freedocument(l_doc);
	end;

	procedure get_cm_error_processing(p_file_data in clob,
																		p_fileid    in number) is
		l_parser dbms_xmlparser.parser;
		l_doc    dbms_xmldom.domdocument;
		l_rows   dbms_xmldom.domnodelist;
		l_row    dbms_xmldom.domnode;
		l_date   date;
		l_clob   clob;
	begin

		l_parser := dbms_xmlparser.newparser;
		dbms_xmlparser.parseclob(l_parser, p_file_data);
		l_doc := dbms_xmlparser.getdocument(l_parser);

		l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'body');

		l_row := dbms_xmldom.item(l_rows, 0);

		pfu_ru_epp_utl.set_file_state(p_fileid,
																	10,
																	'Файл оброблено');
		l_clob := get_cm_error_receipt;
		if l_clob is not null then
			pfu_ru_epp_utl.set_file_state(p_fileid,
																		20,
																		'Квитанцію сформовано',
																		l_clob);
		end if;
		dbms_xmlparser.freeparser(l_parser);
		dbms_xmldom.freedocument(l_doc);

	end;

	procedure get_epp_state_processing(p_file_data in clob,
																		 p_fileid    in number) is
		l_parser  dbms_xmlparser.parser;
		l_doc     dbms_xmldom.domdocument;
		l_rows    dbms_xmldom.domnodelist;
		l_row     dbms_xmldom.domnode;
		l_date    date;
		l_clob    clob;
		l_epp_err t_epp_num;
	begin

		l_parser := dbms_xmlparser.newparser;
		dbms_xmlparser.parseclob(l_parser, p_file_data);
		l_doc := dbms_xmlparser.getdocument(l_parser);

		l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'row');

		for i in 0 .. dbms_xmldom.getlength(l_rows) - 1 loop
			l_row := dbms_xmldom.item(l_rows, i);
			l_epp_err(i) := dbms_xslprocessor.valueof(l_row, 'epp_number/text()');
		end loop;

		pfu_ru_epp_utl.set_file_state(p_fileid,
																	10,
																	'Файл оброблено');
		l_clob := get_epp_state_receipt(l_epp_err);
		if l_clob is not null then
			pfu_ru_epp_utl.set_file_state(p_fileid,
																		20,
																		'Квитанцію сформовано',
																		l_clob);
		end if;
		dbms_xmlparser.freeparser(l_parser);
		dbms_xmldom.freedocument(l_doc);

	end;

	procedure get_restart_epp_processing(p_file_data in clob,
																			 p_fileid    in number) is
		l_parser  dbms_xmlparser.parser;
		l_doc     dbms_xmldom.domdocument;
		l_rows    dbms_xmldom.domnodelist;
		l_row     dbms_xmldom.domnode;
		l_date    date;
		l_clob    clob;
		l_epp_num pfu_epp_line_processing.epp_number%type;
		l_rnk     customer.rnk%type;
	begin
		tuda;
		l_parser := dbms_xmlparser.newparser;
		dbms_xmlparser.parseclob(l_parser, p_file_data);
		l_doc := dbms_xmlparser.getdocument(l_parser);

		l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'row');

		for i in 0 .. dbms_xmldom.getlength(l_rows) - 1 loop
			l_row     := dbms_xmldom.item(l_rows, i);
			l_epp_num := dbms_xslprocessor.valueof(l_row, 'epp_num/text()');
			l_rnk     := dbms_xslprocessor.valueof(l_row, 'rnk/text()');
			pfu_ru_epp_utl.create_epp_rnk(l_epp_num, l_rnk);
			update pfu_epp_line_processing elp
				 set elp.file_id = p_fileid
			 where elp.epp_number = l_epp_num;
		end loop;

		pfu_ru_epp_utl.set_file_state(p_fileid,
																	10,
																	'Файл оброблено');
		l_clob := pfu_ru_epp_utl.get_epp_receipt(p_fileid);
		if l_clob is not null then
			pfu_ru_epp_utl.set_file_state(p_fileid,
																		20,
																		'Квитанцію сформовано',
																		l_clob);
		end if;
		dbms_xmlparser.freeparser(l_parser);
		dbms_xmldom.freedocument(l_doc);

	end;

procedure get_create_paym_processing(p_file_data in clob, p_fileid in number) is
    l_parser   dbms_xmlparser.parser;
    l_doc      dbms_xmldom.domdocument;
    l_rows     dbms_xmldom.domnodelist;
    l_row      dbms_xmldom.domnode;
    l_date     date;
    l_clob     clob;
    l_fio       varchar2(170);
    l_okpo      pfu_epp_line_processing.tax_registration_number%type;
    l_sum       number;
    l_num_acc   pfu_epp_line_processing.nls%type;
    l_acc2560   accounts.nls%type;
    l_date_dead date;
    l_did       number;
  begin
    tuda;
    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_file_data);
    l_doc := dbms_xmlparser.getdocument(l_parser);

    l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'body');

 	  l_row := dbms_xmldom.item(l_rows, 0);

    l_fio        := dbms_xslprocessor.valueof(l_row, 'fio/text()');
    l_okpo       := dbms_xslprocessor.valueof(l_row, 'okpo/text()');
    l_sum        := dbms_xslprocessor.valueof(l_row, 'sum/text()');
    l_num_acc    := dbms_xslprocessor.valueof(l_row, 'num_acc/text()');
    l_acc2560    := dbms_xslprocessor.valueof(l_row, 'acc_2560/text()');
    l_date_dead  := dbms_xslprocessor.valueof(l_row, 'date_dead/text()');
    l_did        := dbms_xslprocessor.valueof(l_row, 'did/text()');

    pfu_ru_epp_utl.set_file_state(p_fileid, 10, 'Файл оброблено');
    l_clob := get_create_paym_receipt(l_fio, l_okpo, l_sum, l_num_acc, l_acc2560, l_date_dead, l_did);

    if l_clob is not null then
       pfu_ru_epp_utl.set_file_state(p_fileid, 20, 'Квитанцію сформовано', l_clob);
    end if;

    dbms_xmlparser.freeparser(l_parser);
    dbms_xmldom.freedocument(l_doc);

  end;

	procedure get_branch_processing(p_file_data in clob, p_fileid in number) is
		l_parser dbms_xmlparser.parser;
		l_doc    dbms_xmldom.domdocument;
		l_rows   dbms_xmldom.domnodelist;
		l_row    dbms_xmldom.domnode;
		l_date   date;
		l_clob   clob;
	begin

		l_parser := dbms_xmlparser.newparser;
		dbms_xmlparser.parseclob(l_parser, p_file_data);
		l_doc := dbms_xmlparser.getdocument(l_parser);

		l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'body');

		l_row := dbms_xmldom.item(l_rows, 0);

		pfu_ru_epp_utl.set_file_state(p_fileid,
																	10,
																	'Файл оброблено');
		l_clob := get_branch_receipt;
		if l_clob is not null then
			pfu_ru_epp_utl.set_file_state(p_fileid,
																		20,
																		'Квитанцію сформовано',
																		l_clob);
		end if;
		dbms_xmlparser.freeparser(l_parser);
		dbms_xmldom.freedocument(l_doc);
	end;

	procedure get_acc_rest_processing(p_file_data in clob,
																		p_fileid    in number) is
		l_parser dbms_xmlparser.parser;
		l_doc    dbms_xmldom.domdocument;
		l_rows   dbms_xmldom.domnodelist;
		l_row    dbms_xmldom.domnode;
		l_acc    varchar2(20);
		l_fileid varchar2(38);
		l_clob   clob;
	begin

		l_parser := dbms_xmlparser.newparser;
		dbms_xmlparser.parseclob(l_parser, p_file_data);
		l_doc := dbms_xmlparser.getdocument(l_parser);

		l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'body');

		l_row := dbms_xmldom.item(l_rows, 0);

		l_acc    := dbms_xslprocessor.valueof(l_row, 'acc/text()');
		l_fileid := dbms_xslprocessor.valueof(l_row, 'fileid/text()');

		pfu_ru_epp_utl.set_file_state(p_fileid,
																	10,
																	'Файл оброблено');
		l_clob := get_acc_rest_receipt(l_acc, l_fileid);
		if l_clob is not null then
			pfu_ru_epp_utl.set_file_state(p_fileid,
																		20,
																		'Квитанцію сформовано',
																		l_clob);
		end if;
		dbms_xmlparser.freeparser(l_parser);
		dbms_xmldom.freedocument(l_doc);

	end;

	procedure set_destruct_processing(p_file_data in clob,
																		p_fileid    in number) is
		l_parser     dbms_xmlparser.parser;
		l_doc        dbms_xmldom.domdocument;
		l_rows       dbms_xmldom.domnodelist;
		l_row        dbms_xmldom.domnode;
		l_epp_number pfu_epp_line_processing.epp_number%type;
		l_fileid     varchar2(38);
		l_clob       clob;
	begin

		l_parser := dbms_xmlparser.newparser;
		dbms_xmlparser.parseclob(l_parser, p_file_data);
		l_doc := dbms_xmlparser.getdocument(l_parser);

		l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'body');

		l_row := dbms_xmldom.item(l_rows, 0);

		l_epp_number := dbms_xslprocessor.valueof(l_row, 'epp_number/text()');

		pfu_ru_epp_utl.set_file_state(p_fileid,
																	10,
																	'”айл оброблено');
		l_clob := set_destruct_receipt(l_epp_number);
		if l_clob is not null then
			pfu_ru_epp_utl.set_file_state(p_fileid,
																		20,
																		'Љвитанцґю сформовано',
																		l_clob);
		end if;
		dbms_xmlparser.freeparser(l_parser);
		dbms_xmldom.freedocument(l_doc);

	end;

	procedure set_card_block_processing(p_file_data in clob,
													  					p_fileid    in number) is
		l_parser dbms_xmlparser.parser;
		l_doc    dbms_xmldom.domdocument;
		l_rows   dbms_xmldom.domnodelist;
		l_row    dbms_xmldom.domnode;
    l_epp    integer;
		l_id     varchar2(20);
    l_nls    accounts.nls%type;
		l_fileid varchar2(38);
		l_clob   clob;
	begin

		l_parser := dbms_xmlparser.newparser;
		dbms_xmlparser.parseclob(l_parser, p_file_data);
		l_doc := dbms_xmlparser.getdocument(l_parser);

		l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'body');

		l_row := dbms_xmldom.item(l_rows, 0);

    l_epp := dbms_xslprocessor.valueof(l_row, 'epp/text()');

    if l_epp = 0 then
      l_nls := dbms_xslprocessor.valueof(l_row, 'nls/text()');
      l_id := null;
    else
      l_nls := null;
   		l_id  := dbms_xslprocessor.valueof(l_row, 'id/text()');
    end if;

		pfu_ru_epp_utl.set_file_state(p_fileid,
																	10,
																	'‘айл оброблено');
		l_clob := set_card_block_receipt(l_id, l_nls, l_fileid);
		if l_clob is not null then
			pfu_ru_epp_utl.set_file_state(p_fileid,
																		20,
																		' витанц?ю сформовано',
																		l_clob);
		end if;
		dbms_xmlparser.freeparser(l_parser);
		dbms_xmldom.freedocument(l_doc);

	end;

  	procedure set_card_unblock_processing(p_file_data in clob,
													  					    p_fileid    in number) is
		l_parser dbms_xmlparser.parser;
		l_doc    dbms_xmldom.domdocument;
		l_rows   dbms_xmldom.domnodelist;
		l_row    dbms_xmldom.domnode;
    l_epp    integer;
		l_id     varchar2(20);
    l_nls    accounts.nls%type;
		l_fileid varchar2(38);
		l_clob   clob;
	begin

		l_parser := dbms_xmlparser.newparser;
		dbms_xmlparser.parseclob(l_parser, p_file_data);
		l_doc := dbms_xmlparser.getdocument(l_parser);

		l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'body');

		l_row := dbms_xmldom.item(l_rows, 0);

    l_epp := dbms_xslprocessor.valueof(l_row, 'epp/text()');

    if l_epp = 0 then
      l_nls := dbms_xslprocessor.valueof(l_row, 'nls/text()');
      l_id := null;
    else
      l_nls := null;
   		l_id  := dbms_xslprocessor.valueof(l_row, 'id/text()');
    end if;

		pfu_ru_epp_utl.set_file_state(p_fileid,
																	10,
																	'Файл оброблено');
		l_clob := set_card_unblock_receipt(l_id, l_nls, l_fileid);
		if l_clob is not null then
			pfu_ru_epp_utl.set_file_state(p_fileid,
																		20,
																		'Квитанцію сформовано',
																		l_clob);
		end if;
		dbms_xmlparser.freeparser(l_parser);
		dbms_xmldom.freedocument(l_doc);

	end;

	procedure set_epp_killed(p_epp_number in pfu_epp_line_processing.epp_number%type,
													 p_kill_type  in pfu_epp_kill_type.id_type%type) is

	begin

		insert into pfu_epp_killed
			(epp_number, kill_type, kill_date, state)
		values
			(p_epp_number, p_kill_type, sysdate, G_EPP_KILLED_STATE_NEW);
		commit;
	end;

	procedure repeat_block is
		l_blkd accounts.blkd%type;
	begin
		for c0 in (select *
								 from pfu_epp_line_processing pel
								where (pel.is_blk is null or pel.is_blk = 0)
									and pel.state_id = 32) loop

   bc.go(c0.bank_mfo);

			select t.blkd into l_blkd from accounts t where t.nls = c0.nls;

			if l_blkd = 0 then
				update pfu_epp_line_processing p
					 set p.is_blk   = 1,
							 p.date_blk = sysdate,
							 p.message  = 'Ѕлокировка на счет установлена'
				 where p.id = c0.id;
    update bars.accounts acc
       set acc.blkd = g_blk
     where acc.nls = c0.nls;
			end if;
		end loop;

    for c1 in (select *
								 from acc_to_block_vso) loop

			select t.blkd into l_blkd from accounts t where t.acc = c1.acc;

			if l_blkd = 0 then
         update bars.accounts acc
            set acc.blkd = g_blk
          where acc.acc = c1.acc;

          delete from acc_to_block_vso abv
           where abv.acc = c1.acc;
			end if;
		end loop;
	end;

	/*
    procedure pfu_files_processing is

    begin
      for i in (select *
                  from pfu_ca_files t
                 where t.state = 0 and t.id = 2
                   for update skip locked )
      loop
        if i.file_type = 4 then
          ref_state_processing(i.file_data, i.id);
        elsif i.file_type = 5 then
          get_ebp_processing(i.file_data, i.id);
        end if;
      end loop;
    end;
  */
/*
  procedure pfu_files_processing is

  begin
    for i in (select *
                from pfu_ca_files t
               where t.state = 0 and t.id = 2
                 for update skip locked )
    loop
      if i.file_type = 4 then
        ref_state_processing(i.file_data, i.id);
      elsif i.file_type = 5 then
        get_ebp_processing(i.file_data, i.id);
      end if;
    end loop;
  end;
*/
end pfu_ru_file_utl;
/
 show err;
 
PROMPT *** Create  grants  PFU_RU_FILE_UTL ***
grant EXECUTE                                                                on PFU_RU_FILE_UTL to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/pfu_ru_file_utl.sql =========*** End
 PROMPT ===================================================================================== 
 