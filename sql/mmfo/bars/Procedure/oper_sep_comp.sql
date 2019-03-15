

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/oper_sep_comp.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure oper_sep_comp ***
/*процедура збору даних для звіту СЕП Повернуті платежі 5641 (COBUMMFO-7226)*/
create or replace procedure oper_sep_comp (p_nd date,p_kd date,p_dd /*date delta*/number)
as
begin

 delete from tmp_opersep_rep;

 insert into tmp_opersep_rep
--OUT
 select o.ref, o.s, o.nlsa, o.nd, o.pdat, o.nazn, 'OUT' io
 from   oper o, ow_oic_ref r, ow_files f
 where  o.ref = r.ref
       and f.id = r.id
       and f.file_type = 'DOCUMENTS'
       and f.file_date between p_nd - p_dd and p_kd 
       and f.file_name like '%FREE%'
       and f.file_status = 2
       and o.nlsa like '2924%16'
 union
--IN  
 select o.ref, o.s, nlsa, nd, pdat, nazn, 'IN' io
 from   oper o, opldok d, accounts a
 where  o.nlsb like '2924%16'
       and o.tt = 'R01'
       and o.pdat between p_nd and p_kd + p_dd      
       and d.ref = o.ref
       and a.acc = d.acc
       and a.nbs in (3720, 3739);

end;

/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/oper_sep_comp.sql =========*** End *** =
PROMPT ===================================================================================== 
