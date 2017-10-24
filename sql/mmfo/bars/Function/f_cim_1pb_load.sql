
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_cim_1pb_load.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CIM_1PB_LOAD (p_date_begin in date, p_date_end in date, p_nls varchar2) return varchar2                                         
is 
   l_n number;
   l_kf varchar2(6);
   l_m1 number;
   l_m2 number;
begin
  l_m1:=0; l_m2:=0;
  for l in ( select ref_ca, kf, ref_ru, mfob, nlsb, nazn_ru, kod_n_ru, cl_type, cl_ipn, cl_name from cim_1pb_ru_doc_tmp ) loop
    select count(*) into l_n from cim_1pb_ru_doc where ref_ca=l.ref_ca;
    if l_n=1 then 
      update cim_1pb_ru_doc set kf=l.kf, ref_ru=l.ref_ru, mfob=l.mfob, nlsb=l.nlsb, nazn_ru=l.nazn_ru, kod_n_ru=l.kod_n_ru, cl_type=l.cl_type, cl_ipn=l.cl_ipn, cl_name=l.cl_name 
        where ref_ca=l.ref_ca; l_m1:=l_m1+1;
    else 
      insert into cim_1pb_ru_doc (ref_ca, kf, ref_ru, vdat, kv, s, mfoa, mfob, nlsa, nlsb, nazn_ru, kod_n_ca, kod_n_ru, cl_type, cl_ipn, cl_name)
        select l.ref_ca, l.kf, l.ref_ru, o.vdat, o.kv, o.s, o.mfoa, l.mfob, o.nlsa, l.nlsb, l.nazn_ru, w.value, l.kod_n_ru, l.cl_type, l.cl_ipn, l.cl_name
          from oper o left outer join operw w on w.tag='KOD_N' and w.ref=l.ref_ca
         where o.ref=l.ref_ca; l_m2:=l_m2+1;
    end if;    
  end loop;
  commit; select min(kf) into l_kf from cim_1pb_ru_doc_tmp; /* delete from cim_1pb_ru_doc_tmp;
  
  insert into cim_1pb_ru_doc_tmp (ref_ca, vdat, kv, s, mfoa, mfob, nlsa, nlsb, kod_n_ca)
    ( select o.ref, o.vdat, o.kv, o.s, o.mfoa, o.mfob, o.nlsa, o.nlsb, w.value
        from oper o 
             left outer join operw w on w.tag='KOD_N' and w.ref=o.ref
       where o.dk=1 and o.sos=5 and o.vdat<p_date_end and o.vdat>=p_date_begin and o.nlsb=p_nls and o.pdat<p_date_end and o.pdat>=p_date_begin ); 
  commit; */      
  return 'Завантаження даних за період з '||to_char(p_date_begin, 'dd.mm.yyyy')||' по ' ||to_char(p_date_end, 'dd.mm.yyyy')||' МФО: '||l_kf||' завершене успішно! Оновлено'||l_m1||', створено'||l_m2||' записів.';             
end f_cim_1pb_load;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_cim_1pb_load.sql =========*** End
 PROMPT ===================================================================================== 
 