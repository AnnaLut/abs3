

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/AUTO_SET_BPK_VNCRP.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  procedure AUTO_SET_BPK_VNCRP ***

  CREATE OR REPLACE PROCEDURE BARS.AUTO_SET_BPK_VNCRP 
( p_date date default gl.bdate
)
  is
l_new_VNCRP    bpk_parameters.value%type := null;
l_new_VNCRR    bpk_parameters.value%type := null;
/* Функція встановленя Первиного, поточного ВКР на договорах БПК по яких
не встановлений кредитний ліміт
та наявний несанкціонований овердрафт – встановлюється значення «Г»
Виконується в регламентних роботах.
*/
begin
    -- PRVN_FLOW.u_SNA(gl.bd); -- урегулирование НЕВИЗНАНИХ.
  if Dat_last(p_date) <> p_date then
  
    bars_audit.info ('AUTO_SET_BPK_VNCRP: null');
    null;
  else
    bars_audit.info ('AUTO_SET_BPK_VNCRP: not_null');
  for bpk_list_VNCRP in (
                         select         wa.nd,
                                        wa.acc_pk,
                                        wa.fin23 fin23_1,
                                        a.nls,
                                        a.lim,
                                        a.ostc,
                                        c.country,
                                        c.crisk
                          from w4_acc wa,  accounts a, customer c
                         where a.acc = wa.acc_pk
                           and a.rnk = c.rnk
                           and not exists
                                  (select 1
                                     from bpk_parameters
                                    where nd = wa.nd and tag = 'VNCRP')
               )
    loop
        if (nvl(bpk_list_VNCRP.lim,0) = 0 and bpk_list_VNCRP.ostc < 0) then
            l_new_VNCRP := 'Г';
        else
                case when (bpk_list_VNCRP.crisk = 1) 
                 then l_new_VNCRP := 'А';
                 when (bpk_list_VNCRP.crisk = 2)
                 then l_new_VNCRP := 'Б';  
                 when (bpk_list_VNCRP.crisk = 3) 
                 then l_new_VNCRP := 'В';  
                 when (bpk_list_VNCRP.crisk = 4)
                 then l_new_VNCRP := 'Г';
                 else 
                  l_new_VNCRP := null;
               end case;    
        end if;
        
        if l_new_VNCRP is not null then
            begin
                bars_audit.Info('bpk_list_VNCRP.nd = ' || to_char(bpk_list_VNCRP.nd) || ', l_new_VNCRP = ' || l_new_VNCRP);
                insert into bpk_parameters (nd, tag, value)
                values (bpk_list_VNCRP.nd, 'VNCRP', l_new_VNCRP);
            exception when dup_val_on_index then null; -- на всякий случай
            end;
        
        else 
        bars_audit.Info ('bpk_list_VNCRP.nd = ' 
                              || to_char(bpk_list_VNCRP.nd) 
                              || ', l_new_VNCRP = не визначено!'
                              || ' bpk_list_VNCRP.crisk = ' 
                              || bpk_list_VNCRP.crisk
                             );  
        end if;
      l_new_VNCRP := null;   
    end loop;


    for bpk_list_VNCRR in (
                         select         wa.nd,
                                        wa.acc_pk,
                                        wa.fin23 fin23_1,
                                        a.nls,
                                        a.lim,
                                        a.ostc,
                                        c.country,
                                        c.crisk
                          from w4_acc wa,  accounts a, customer c
                         where a.acc = wa.acc_pk
                           and a.rnk = c.rnk
                           and not exists
                                  (select 1
                                     from bpk_parameters
                                    where nd = wa.nd and tag = 'VNCRR')
               )
    loop
        if (nvl(bpk_list_VNCRR.lim,0) = 0 and bpk_list_VNCRR.ostc < 0) then
            l_new_VNCRR := 'Г';
        else
                case when (bpk_list_VNCRR.crisk = 1)
                 then l_new_VNCRR := 'А';
                 when (bpk_list_VNCRR.crisk = 2) 
                 then l_new_VNCRR := 'Б';  
                 when (bpk_list_VNCRR.crisk = 3)
                 then l_new_VNCRR := 'В';  
                 when (bpk_list_VNCRR.crisk = 4)
                 then l_new_VNCRR := 'Г';
                 else
                 l_new_VNCRR := null;
               end case;    
        end if;
        
        if l_new_VNCRR is not null then
            begin
                bars_audit.Info('bpk_list_VNCRR.nd = ' || to_char(bpk_list_VNCRR.nd) || ', l_new_VNCRR = ' || l_new_VNCRR);
                insert into bpk_parameters (nd, tag, value)
                values (bpk_list_VNCRR.nd, 'VNCRR', l_new_VNCRR);
            exception when dup_val_on_index then null; -- на всякий случай
            end;
        
        else 
        bars_audit.Info ('bpk_list_VNCRR.nd = ' 
                              || to_char(bpk_list_VNCRR.nd) 
                              || ', l_new_VNCRR = не визначено!'
                              || ' bpk_list_VNCRR.crisk = ' 
                              || bpk_list_VNCRR.crisk
                             );  
        end if;
        
        l_new_VNCRR := null;
    end loop;
    end if;
end;
/
show err;

PROMPT *** Create  grants  AUTO_SET_BPK_VNCRP ***
grant EXECUTE                                                                on AUTO_SET_BPK_VNCRP to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on AUTO_SET_BPK_VNCRP to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/AUTO_SET_BPK_VNCRP.sql =========**
PROMPT ===================================================================================== 
