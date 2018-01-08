

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CIM_1PB_SYNK.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CIM_1PB_SYNK ***

  CREATE OR REPLACE PROCEDURE BARS.P_CIM_1PB_SYNK (p_dat in varchar2, --Дата звіту
                                           p_sync in varchar2 default '0' -- Виконання синхронізації 
                                           )                                          
is 
   l_dat date;
   l_date_begin date;
   l_date_end date;
   l_date_max date;
   l_n number;  
begin

  if p_sync<>'0' then  
    l_dat:=to_date(p_dat, 'dd/mm/yyyy'); l_date_begin:=trunc(last_day(add_months(l_dat,-2))+1); 
    l_date_end:=trunc(last_day(add_months(l_dat,-1))+1);
  
    if p_sync='1' then
      for l in ( select d.ref_ca, d.kod_n_ru from v_cim_1pb_doc d where d.md is not null and d.vdat<l_date_end and d.vdat>=l_date_begin) loop
        select count(*) into l_n from operw w where w.tag='KOD_N' and w.ref=l.ref_ca;
        if l_n=0 then
          insert into operw (ref, tag, value, kf) values (l.ref_ca, 'KOD_N', l.kod_n_ru, f_ourmfo);    
        else
          update operw set value=l.kod_n_ru where tag='KOD_N' and ref=l.ref_ca;            
        end if;
        update cim_1pb_ru_doc set changed=1, md=null where ref_ca=l.ref_ca;
      end loop;   
    elsif p_sync='2' then
      for l in ( select d.ref_ca, d.kod_n_ru from v_cim_1pb_doc d 
                  where (d.kod_n_ca like '8273%' or d.kod_n_ca is null) and (d.kod_n_ca<>d.kod_n_ru or d.kod_n_ca is null) and 
                        d.kod_n_ru is not null and d.vdat<l_date_end and d.vdat>=l_date_begin ) loop
        select count(*) into l_n from operw w where w.tag='KOD_N' and w.ref=l.ref_ca;
        if l_n=0 then
          insert into operw (ref, tag, value, kf) values (l.ref_ca, 'KOD_N', l.kod_n_ru, f_ourmfo);    
        else
          update operw set value=l.kod_n_ru where tag='KOD_N' and ref=l.ref_ca;            
        end if;
        update cim_1pb_ru_doc set changed=1, md=null where ref_ca=l.ref_ca;
      end loop;   
    end if;  
    commit;
  end if;  
  -- передаєм дату в pul, щоб потім використати у фільтрі
  PUL.Set_Mas_Ini( 'sFdat1', to_char(add_months(to_date(p_dat, 'dd/mm/yyyy'), -1), 'yyyymm'), 'Пар.sFdat1' );
 
end p_cim_1pb_synk;
/
show err;

PROMPT *** Create  grants  P_CIM_1PB_SYNK ***
grant EXECUTE                                                                on P_CIM_1PB_SYNK  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CIM_1PB_SYNK.sql =========*** En
PROMPT ===================================================================================== 
