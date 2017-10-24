
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_cp_hierarchy_int_ref.sql ========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CP_HIERARCHY_INT_REF (p_id in cp_kod.id%type, p_date_start date, p_date_finish date, p_CP_ACCTYPE cp_accounts.CP_ACCTYPE%type) return varchar2
is
l_res varchar2(32000);
/*ver 13/02/2017*/
begin
 bars_audit.info('f_cp_hierarchy_int_ref: start p_id=' || p_id ||', p_date_start= ' ||to_char(p_date_start,'dd/mm/yyyy') ||', p_date_finish= ' ||to_char(p_date_finish,'dd/mm/yyyy') ||',p_CP_ACCTYPE=' || p_CP_ACCTYPE );
 if p_CP_ACCTYPE = 'UNREC' then
 begin
  with deallst as (select ref from cp_deal where id = p_id),
   acclst as (select CP_ACC from cp_accounts ca, deallst where deallst.ref = ca.cp_ref and cp_acctype = p_CP_ACCTYPE ),
   sallst as (select acc, fdat from saldoa sa,acclst where sa.acc = acclst.cp_acc and fdat >  p_date_start  and fdat <= p_date_finish+1)  
            SELECT concatstr(o.ref)
              INTO l_res
              FROM opldok o, sallst                       
             WHERE     o.acc IN (sallst.acc)
                   AND o.dk = 0   
                   and o.fdat = sallst.fdat                 
                   AND o.sos = 5;  
 exception when no_data_found then l_res := '';
 end;
 end if;
  if p_CP_ACCTYPE = 'R' then
 begin
  with deallst as (select ref from cp_deal where id = p_id),
   acclst as (select CP_ACC from cp_accounts ca, deallst where deallst.ref = ca.cp_ref and cp_acctype = p_CP_ACCTYPE ),
   sallst as (select acc, fdat from saldoa sa,acclst where sa.acc = acclst.cp_acc and fdat >  p_date_start  and fdat <= p_date_finish+1)  
            SELECT concatstr(o.ref)
              INTO l_res
              FROM opldok o, sallst                       
             WHERE     o.acc IN (sallst.acc)
                   AND o.dk = 0   
                   and o.fdat = sallst.fdat                 
                   AND o.sos = 5                      
                   AND o.tt = 'FX%';  
 exception when no_data_found then l_res := '';
 end;
 end if;
  if p_CP_ACCTYPE = 'RR2' then
 begin
  with deallst as (select ref from cp_deal where id = p_id),
   acclst as (select CP_ACC from cp_accounts ca, deallst where deallst.ref = ca.cp_ref and cp_acctype in ('R', 'R2')),
   sallst as (select acc, fdat from saldoa sa,acclst where sa.acc = acclst.cp_acc and fdat >  p_date_start  and fdat <= p_date_finish+1)   
            SELECT concatstr(o.ref)
              INTO l_res
              FROM opldok o, sallst                       
             WHERE     o.acc IN (sallst.acc)
                   AND o.dk = 1  
                   AND o.fdat = sallst.fdat                 
                   AND o.sos = 5                      
                   AND o.tt IN ('FX7')
                   AND substr(o.txt,1,15) = 'Îòğèìàíèé êóïîí';
 exception when no_data_found then l_res := '';
 end;
 end if;
 
 if p_CP_ACCTYPE = 'D' then
 begin
  with deallst as (select ref from cp_deal where id = p_id),
   acclst as (select CP_ACC, cp_acctype from cp_accounts ca, deallst where deallst.ref = ca.cp_ref and cp_acctype in ('D','P')),
   sallst as (select acc, fdat, cp_acctype from saldoa sa,acclst where sa.acc = acclst.cp_acc and fdat >  p_date_start  and fdat <= p_date_finish+1)   
            SELECT concatstr(o.ref)
              INTO l_res
              FROM opldok o, sallst    
             WHERE o.acc IN (sallst.acc)               
               AND o.sos = 5
               AND o.fdat  = sallst.fdat  
               AND o.tt = 'FXM';       
 exception when no_data_found then l_res := '';
 end;
 end if;

 
 if p_CP_ACCTYPE = 'P' then
 begin
  with deallst as (select ref from cp_deal where id = p_id),
   acclst as (select CP_ACC from cp_accounts ca, deallst where deallst.ref = ca.cp_ref and cp_acctype in (p_CP_ACCTYPE)),
   sallst as (select acc, fdat from saldoa sa,acclst where sa.acc = acclst.cp_acc and fdat >  p_date_start  and fdat <= p_date_finish+1)   
            SELECT concatstr(o.ref)
              INTO l_res
              FROM opldok o, sallst    
             WHERE o.acc IN (sallst.acc)
               AND o.dk = 1
               AND o.sos = 5
               AND o.fdat  = sallst.fdat  
               AND o.tt = 'FXM';       
 exception when no_data_found then l_res := '';
 end;
 end if;
 
 if p_CP_ACCTYPE = 'TR' then
 begin 
   SELECT concatstr(ref)
     INTO l_res 
     FROM (
   SELECT o.ref
        FROM cp_arch ca, opldok o, oper o1, oper o2
       WHERE ca.id = p_id         
         AND ca.op in ('2','3')
         and o.ref = ca.ref
         AND o.fdat  between p_date_start and p_date_finish         
         and o.sos = 5
         and o1.ref = o.ref
         and O2.VDAT = o1.vdat and o1.sos = 5
         and o2.nazn = o1.nazn and o2.sos = 5 and o2.tt = 'F80'
         and o.acc in (select acc from accounts where nls = '37392555')
         and exists (select 1 from cp_accounts ca, opldok oo where ca.cp_acctype = 'S' and oo.ref = o.ref  and oo.sos = 5 and oo.acc = ca.cp_acc)
         AND o.tt = 'FXT'
      union all
      SELECT o.ref
        FROM cp_arch ca, opldok o
       WHERE ca.id = p_id         
         AND ca.op in ('2','3')
         and o.ref = ca.ref
         AND o.fdat  between p_date_start and p_date_finish         
         and o.sos = 5         
         and o.acc in (select acc from accounts where nls = '37392555')
         and not exists (select 1 from cp_accounts ca, opldok oo where oo.sos =5 and ca.cp_acctype = 'S' and oo.ref = o.ref and oo.acc = ca.cp_acc)
         AND o.tt = 'FXT');  
 exception when no_data_found then l_res :='';
 end;     
 end if;

 if p_CP_ACCTYPE = 'BOUGHT' then
  begin
   with deallst as (select ref from cp_deal where id = p_id)
       ,acclst  as (select deallst.ref, CP_ACC from cp_accounts ca, deallst where deallst.ref = ca.cp_ref /*and cp_acctype in ('N')*/)
       ,sallst  as (select acclst.ref, acc, fdat from saldoa sa,acclst where sa.acc = acclst.cp_acc and fdat > p_date_start  and fdat <= p_date_finish+1)
  SELECT concatstr(o.ref)      
    INTO l_res
    FROM deallst, acclst,sallst, opldok o
   WHERE acclst.REF = deallst.REF     
     AND sallst.ref = deallst.REF
     AND o.fdat  = sallst.fdat
     AND o.acc = sallst.acc   
     AND o.REF = deallst.REF
     AND acclst.cp_acc = o.acc
     AND o.sos = 5
     AND o.fdat  = sallst.fdat; 
  exception when no_data_found then l_res := '';
  end;  
 end if;

 if p_CP_ACCTYPE = 'SOLD' then
  begin
    SELECT concatstr(ref)
      INTO l_res 
      FROM (SELECT sum( (case when cpa.cp_acctype in ('N','R','R2','R','P') then o.sq 
                              when cpa.cp_acctype = 'D' then -o.sq                            
                         end)) 
                    + (select decode(otmp.dk, 1, otmp.sq, 0, -otmp.sq) from opldok otmp where otmp.TT = 'FXT' and otmp.sos=5 and otmp.ref = o.ref and otmp.dk= 1 and otmp.txt = 'ÖÏ: Òîğãîâèé ğåçóëüòàò') s
                     , o.ref        
                FROM cp_deal cd, cp_kod ck, cp_accounts cpa, cp_arch ca, opldok o
               WHERE ca.id = p_id
                 and ck.id = cd.id
                 and cd.id = ca.id
                 and CPA.CP_REF = cd.ref         
                 and cpa.cp_acc = o.acc
                 AND ca.op in ('2','3')
                 and o.ref = ca.ref
                 and o.sos = 5          
                 AND o.fdat  between p_date_start and p_date_finish
                 GROUP BY O.REF      );
  exception when no_data_found then l_res := '';
  end;  
 end if; 
 
  if p_CP_ACCTYPE = 'SETTLED' then
  begin
      SELECT concatstr(o.ref)      
        INTO l_res
        FROM cp_deal cd, cp_accounts cpa, cp_arch ca, opldok o
       WHERE ca.id = p_id
         and cd.id = ca.id
         and CPA.CP_REF = cd.ref
         and cpa.cp_acctype = 'N'
         and CD.ACC = o.acc
         AND ca.op in ('20','22')
         and o.ref = ca.ref
         and o.sos = 5
         AND o.fdat between p_date_start and p_date_finish 
         AND o.dk = 1; 
  exception when no_data_found then l_res := '';
  end;  
 end if; 
 
 if p_CP_ACCTYPE = 'RESERVED' then
  begin
    with deallst as (select ref from cp_deal where id = p_id)
    SELECT sum(case when fdat = trunc(p_date_start,'month')  then -rez39 
                    when fdat = trunc(p_date_finish,'month') then rez39            
                end)
       INTO l_res         
       FROM NBU23_REZ r, deallst       
      WHERE r.nd = deallst.REF 
       and fdat in (trunc(p_date_start,'month'), trunc(p_date_finish,'month'));    
             
  exception when no_data_found then l_res := '';
  end;  
 end if; 


 if p_CP_ACCTYPE = 'RANSOM' then
  begin
      SELECT concatstr(ca.ref)        
        INTO l_res
        FROM cp_kod ck, cp_arch ca,cp_ticket ct
       WHERE ca.id = p_id
         and ck.id = ca.id                  
         AND ca.op in ('2')
         and ca.ref = ct.ref         
         AND ct.dat_opl between p_date_start and p_date_finish
         and ct.okpob in (SELECT c.OKPO
                            FROM customer c
                           WHERE c.rnk = ck.rnk 
                           union all
                          SELECT co.CHILD_OKPO
                            FROM customer c, cp_okpo_corporation co
                           WHERE c.rnk = ck.rnk AND c.okpo = co.main_okpo);
  exception when no_data_found then l_res := '';
  end;  
 end if;


 if p_CP_ACCTYPE = 'OVERPRICED' then
  begin
   with deallst as (select ref from cp_deal where id = p_id)
       ,acclst  as (select deallst.ref, CP_ACC from cp_accounts ca, deallst where deallst.ref = ca.cp_ref and cp_acctype in ('S'))
       ,sallst  as (select acclst.ref, acc, fdat from saldoa sa,acclst where sa.acc = acclst.cp_acc and fdat > p_date_start  and fdat <= p_date_finish+1)
  SELECT concatstr(o.ref)     
    INTO l_res
    FROM deallst, acclst,sallst, opldok o      
   WHERE acclst.REF = deallst.REF     
     AND sallst.ref = deallst.REF
     AND o.fdat  = sallst.fdat
     --and o.tt not in ('096','097')
     and o.acc = sallst.acc
     and o.sos = 5;
  exception when no_data_found then l_res := '';
  end;  
 end if;

return nvl(l_res,'');
end f_cp_hierarchy_int_ref;
/
 show err;
 
PROMPT *** Create  grants  F_CP_HIERARCHY_INT_REF ***
grant EXECUTE                                                                on F_CP_HIERARCHY_INT_REF to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_cp_hierarchy_int_ref.sql ========
 PROMPT ===================================================================================== 
 