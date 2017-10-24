

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_SWT_COPY_ATTRIBUTE.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_SWT_COPY_ATTRIBUTE ***

  CREATE OR REPLACE PROCEDURE BARS.P_SWT_COPY_ATTRIBUTE (p_ref oper.ref%type)
is
l_oper oper%rowtype;
l_swref sw_oper.swref%type;
l_d_rec oper.d_rec%type;
l_mt sw_journal.mt%type;
l_n operw.value%type;
begin
logger.info('p_swt_copy_attribute, ref=' || p_ref);
select t.* into l_oper from oper t where t.ref=p_ref;
select min(swref) into l_swref from sw_oper where ref=p_ref;
if (l_swref is not null) then 
 
select mt into l_mt from sw_journal where swref=l_swref;

begin
for k in(select * from sw_operw where swref=l_swref and tag not in ('23'))
    loop
        begin 
            insert into operw (ref, tag, value)
            values(p_ref, k.tag||k.opt, k.value);
        exception when dup_val_on_index then null;
                  when others then
                    if(sqlcode=-2291) then null; else raise; end if;
        end;
        --dbms_output.put_line(k.TAG||k.OPT||' ' ||''||k.VALUE);
    end loop;
   
--#fMT 103#nœ643#
--KOD_G

     begin
        select value into l_n from operw
        where ref=p_ref
        and tag='KOD_G';
     exception when no_data_found then
        l_n:=null;   
     end;
 
     if l_oper.d_rec is null then 
        l_d_rec:='#fMT '||l_mt||'#'||case when l_n is not null then 'nœ'||l_n||'#' else '' end;
     else 
        l_d_rec:='#fMT '||l_mt||l_oper.d_rec;
     end if;       
     
     logger.info('p_swt_copy_attribute:'||l_d_rec);
     
     update oper set d_rec= l_d_rec
     where ref=p_ref;
    
end;
end if;
end p_swt_copy_attribute;
/
show err;

PROMPT *** Create  grants  P_SWT_COPY_ATTRIBUTE ***
grant EXECUTE                                                                on P_SWT_COPY_ATTRIBUTE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_SWT_COPY_ATTRIBUTE.sql =========
PROMPT ===================================================================================== 
