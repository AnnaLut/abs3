CREATE OR REPLACE PACKAGE BODY crkr_rep AS


  -- Private constant declarations
  g_body_version constant varchar2(120) := 'Version Body 1.02 15.11.2016 00:00';

  -- Function and procedure implementations
  function header_version return varchar2 is
  begin
    return g_header_version;
  end;

  function body_version return varchar2 is
  begin
    return g_body_version;
  end;
  
FUNCTION f_actual_portfolio (
                              p_sFdat1 date,
                              p_sFdat2 date,
                              p_branch varchar2 default '%',  
							  p_act    varchar2 default '0'  
                            )  
   RETURN t_actul_portf PIPELINED  PARALLEL_ENABLE iS 
  c0    SYS_REFCURSOR;
  l_sql clob;
  l_c0 t_actul_portf;
  l_portf t_col_actul_portf;
  l_where varchar2(4000);
  p_limit_size pls_integer := 1000;
BEGIN
 
/*
          for k in (select   p.id,
                           max(case when O.OPER_TYPE in (5) then O.regdate when O.OPER_TYPE in (7) then null else null end)  as dat_actul,
                           max(case when O.OPER_TYPE in (6) then O.regdate when O.OPER_TYPE in (8) then null else null end)  as dat_bur,
                           ( case when p.ost >0 then P.rnk  else null end  ) rnk,
                           sum(case when O.OPER_TYPE in (5)  and o.regdate between p_sFdat1 and p_sFdat2+0.999 then 1 
                                    when O.OPER_TYPE in (7)  and o.regdate between p_sFdat1 and p_sFdat2+0.999 then -1 else 0 end)  as ACT_DEP,                  -- актцалізований
                           sum(case when O.OPER_TYPE in (6)  and o.regdate between p_sFdat1 and p_sFdat2+0.999 then 1 
                                    when O.OPER_TYPE in (8)  and o.regdate between p_sFdat1 and p_sFdat2+0.999 then -1 else 0 end)  as ACT_BUR,                -- актуаліз на похов
                           sum(case when O.OPER_TYPE in (1)  and o.regdate between p_sFdat1 and p_sFdat2+0.999 then O.AMOUNT else 0 end)  as PAY_DEP,           -- виплата компенсації
                           sum(case when O.OPER_TYPE in (2)  and o.regdate between p_sFdat1 and p_sFdat2+0.999 then O.AMOUNT else 0 end)  as PAY_BUR,           --  виплата поховання
                           sum(case when O.OPER_TYPE in (1,2,4) and O.oper_ost = 0 then 1 else 0 end)  as PAY_0, -- закриті під 0
                           P.OST -  sum(case when O.OPER_TYPE in (1,2) and o.regdate > p_sFdat2+0.999 then -O.AMOUNT 
                                    when O.OPER_TYPE in (3 )           and o.regdate > p_sFdat2+0.999 then  O.AMOUNT
                                    else 0 end) as ostd,
                           p.ost,
                           nvl(P.BRANCHACT_BUR, p.branchact) branch,
                           substr(nvl(P.BRANCHACT_BUR, p.branchact),2,6) kf
                    from COMPEN_PORTFOLIO p 
                         left join  compen_oper o  on   O.COMPEN_ID = p.id and O.STATE = 20
                    group by p.id , p.ost, P.rnk, nvl(P.BRANCHACT_BUR, p.branchact)
                   )
         loop  
  
            CONTINUE WHEN   trunc(k.dat_actul) is null and trunc(k.dat_bur) is null; 
         
           l_portf.id           := k.id        ;     
           l_portf.dat_actul    := trunc(k.dat_actul) ; 
           l_portf.dat_bur      := trunc(k.dat_bur)   ;
           l_portf.rnk          := k.rnk ; 
           l_portf.ACT_DEP      := least(greatest(k.ACT_DEP,0),1);   
           l_portf.ACT_BUR      := least(greatest(k.ACT_BUR,0),1);   
           l_portf.PAY_DEP      := k.PAY_DEP   ;   
           l_portf.PAY_BUR      := k.PAY_BUR   ; 
           l_portf.PAY_0        := k.PAY_0     ;    
           l_portf.ostd         := case when k.rnk is not null then k.ostd else 0 end;      
           l_portf.ost          := case when k.rnk is not null then k.ost  else 0 end;
           l_portf.branch       := k.BRANCH    ;
           l_portf.kf           := k.KF        ;   
 
            PIPE ROW(l_portf);   
        END LOOP;
 */
 
  if p_branch = '%' then null; 
                    else l_where := ' and p.branch like '''||p_branch||'%'' ';
  end if;
  
  if p_act = '0'    then null;
                    else l_where := l_where||' and ( p.BRANCHACT_BUR like ''/%'' or  p.branchact like ''/%'' ) ';
  End if;
  
   l_where :=  l_where ||' and (nvl(date_import,p.dato) < to_date('''||to_char(p_sFdat1,'dd/mm/yyyy')||''',''dd/mm/yyyy'') or nvl(date_import,p.dato) < to_date('''||to_char(p_sFdat2,'dd/mm/yyyy')||''',''dd/mm/yyyy'') )';
 
   l_sql := 'select  p.id,
                           max(case when O.OPER_TYPE in (5) then O.regdate when O.OPER_TYPE in (7) then null else null end)  as dat_actul,
                           max(case when O.OPER_TYPE in (6) then O.regdate when O.OPER_TYPE in (8) then null else null end)  as dat_bur,
                           ( case when p.ost >0 then P.rnk  else null end  ) rnk,
                           sum(case when O.OPER_TYPE in (5)  and o.regdate between p_sFdat1 and p_sFdat2+0.999 then 1 
                                    when O.OPER_TYPE in (7)  and o.regdate between p_sFdat1 and p_sFdat2+0.999 then -1 else 0 end)  as ACT_DEP,                  -- актцалізований
                           sum(case when O.OPER_TYPE in (6)  and o.regdate between p_sFdat1 and p_sFdat2+0.999 then 1 
                                    when O.OPER_TYPE in (8)  and o.regdate between p_sFdat1 and p_sFdat2+0.999 then -1 else 0 end)  as ACT_BUR,                -- актуаліз на похов
                           sum(case when O.OPER_TYPE in (1)  and o.regdate between p_sFdat1 and p_sFdat2+0.999 then O.AMOUNT else 0 end)  as PAY_DEP,           -- виплата компенсації
                           sum(case when O.OPER_TYPE in (2)  and o.regdate between p_sFdat1 and p_sFdat2+0.999 then O.AMOUNT else 0 end)  as PAY_BUR,           --  виплата поховання
                           sum(case when O.OPER_TYPE in (1,2,4) and O.oper_ost = 0 then 1 else 0 end)       as PAY_0, -- закриті під 0
						   sum(case when O.OPER_TYPE in (1,2,4) and O.oper_ost = 0 then amount else 0 end)  as sum_PAY_0, -- закриті під 0
                           P.OST -  sum(case when O.OPER_TYPE in (1,2,7,8) and o.regdate > p_sFdat1 then -O.AMOUNT 
                                    when O.OPER_TYPE in (3,5,6 )           and o.regdate > p_sFdat1 then  O.AMOUNT
                                    else 0 end) as ostf,                           
                           P.OST -  sum(case when O.OPER_TYPE in (1,2) and o.regdate > p_sFdat2+0.999 then -O.AMOUNT 
                                    when O.OPER_TYPE in (3 )           and o.regdate > p_sFdat2+0.999 then  O.AMOUNT
                                    else 0 end) as ostd,
                           p.ost,
                           nvl(P.BRANCHACT_BUR, p.branchact) branch_act,
						   nvl(p.branchact,p.branch) branch,
						   p.ob22,
                           substr(p.branch,2,6) kf
                    from COMPEN_PORTFOLIO p 
                         left join  compen_oper o  on   O.COMPEN_ID = p.id and O.STATE = 20 and  regdate >  p_sFdat1
                    where 1 = 1 '|| l_where ||'  and p.status > 0
                    group by p.id , p.ost, P.rnk, nvl(P.BRANCHACT_BUR, p.branchact), nvl(p.branchact,p.branch), P.BRANCH, p.ob22';
                    
    l_sql := replace (l_sql, 'p_sFdat1', 'to_date('''||to_char(p_sFdat1,'dd/mm/yyyy') ||''',''dd/mm/yyyy'')'); 
    l_sql := replace (l_sql, 'p_sFdat2', 'to_date('''||to_char(p_sFdat2,'dd/mm/yyyy') ||''',''dd/mm/yyyy'')'); 
    
    
    
   OPEN c0 FOR l_sql; 
    LOOP
      FETCH c0 BULK COLLECT INTO l_c0 LIMIT p_limit_size; 
      EXIT WHEN l_c0.COUNT = 0;
       
      /* Обработка пакета из (p_limit_size) записей... */
      FOR i IN 1 .. l_c0.COUNT 
        LOOP
           --CONTINUE WHEN   trunc(l_c0(i).dat_actul) is null and trunc(l_c0(i).dat_bur) is null; 
         
           l_portf.id           := l_c0(i).id        ;     
           l_portf.dat_actul    := trunc(l_c0(i).dat_actul) ; 
           l_portf.dat_bur      := trunc(l_c0(i).dat_bur)   ;
           l_portf.rnk          := l_c0(i).rnk ; 
           l_portf.ACT_DEP      := least(greatest(l_c0(i).ACT_DEP,0),1);   
           l_portf.ACT_BUR      := least(greatest(l_c0(i).ACT_BUR,0),1);   
           l_portf.PAY_DEP      := l_c0(i).PAY_DEP   ;   
           l_portf.PAY_BUR      := l_c0(i).PAY_BUR   ; 
           l_portf.PAY_0        := l_c0(i).PAY_0     ;    
		   l_portf.sum_PAY_0    := l_c0(i).sum_PAY_0     ;    
           --l_portf.ostf         := case when l_portf.ACT_DEP >0 or l_portf.ACT_BUR >0  or l_portf.PAY_DEP > 0  or l_portf.PAY_BUR > 0 or l_portf.dat_actul < p_sFdat1 or l_portf.dat_bur < p_sFdat1  then l_c0(i).ostf else 0 end;
           --l_portf.ostd         := case when l_portf.ACT_DEP >0 or l_portf.ACT_BUR >0  or l_portf.PAY_DEP > 0  or l_portf.PAY_BUR > 0 or l_portf.dat_actul < p_sFdat2 or l_portf.dat_bur < p_sFdat2  then l_c0(i).ostd else 0 end;      
		   
		   l_portf.ostf         := l_c0(i).ostf;
           l_portf.ostd         := l_c0(i).ostd;      

		   
           l_portf.ost          := l_c0(i).ost;
		   l_portf.branch_act   := l_c0(i).BRANCH_act;
           l_portf.branch       := l_c0(i).BRANCH    ;
		   l_portf.ob22         := l_c0(i).ob22    ;
           l_portf.kf           := l_c0(i).KF        ;   
 
            PIPE ROW(l_portf);
       END LOOP;     
            
    END LOOP;    
    
    CLOSE c0; 
   
  RETURN;
END;




END;
/

grant execute on crkr_rep to bars_access_defrole;