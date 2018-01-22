create or replace procedure VP_2018  is l_nbs1 char(4); l_ob1 char(2);  l_nbs2 char(4); l_ob2 char(2);  l_nbs3 char(4); l_ob3 char(2);    a6 accounts%rowtype; 
       l_acc1 number; l_acc2 number; l_acc3 number ;     l_dat date;
       x_ob22 char(2) := 'XX';       x_branch varchar2(15) := 'XX';

  procedure op1  (aa6  IN OUT accounts%rowtype)   is
  begin 
     begin     select * into aa6  from accounts where nbs = aa6.nbs and ob22 = aa6.ob22 and branch = aa6.branch and dazs is null and acc = aa6.acc ;
     EXCEPTION WHEN NO_DATA_FOUND THEN
        begin  select * into aa6  from accounts where nbs = aa6.nbs and ob22 = aa6.ob22 and branch = aa6.branch and dazs is null and rownum = 1    ;
        EXCEPTION WHEN NO_DATA_FOUND THEN     OP_BS_OB1 ( PP_BRANCH => aa6.branch, P_BBBOO => aa6.nbs||aa6.ob22 );
               select * into aa6  from accounts where nbs = aa6.nbs and ob22 = aa6.ob22 and branch = aa6.branch and dazs is null and rownum = 1    ;
        end ;
     end ;
  end op1;
  ---------
begin
 
for f in (select * from mv_kf mm )
loop bc.go( f.kf);
  -----=======================================================================================================================------------
  For k in (select v.rowid RI, v.* , a.ob22, a.branch from vp_list v, accounts a where a.nbs ='3800' and a.dazs is null and v.acc3800 = a.acc  order by a.ob22, a.branch  )
  loop 
     If    k.ob22 = '03' then l_nbs1 := '6204' ; l_ob1 := '24' ; l_nbs2 := '6204' ; l_ob2 := '24' ; l_nbs3 := '6204' ; l_ob3 := '24' ; -- доходи та витрати . Бранч 0000	
     ElsIf k.ob22 = '22' then l_nbs1 := '6204' ; l_ob1 := '25' ; l_nbs2 := '6204' ; l_ob2 := '25' ; l_nbs3 := '6204' ; l_ob3 := '25' ; -- Вал Поз (купівля-продаж ЦІННИХАПВ)  
     ElsIf k.ob22 = '16' then l_nbs1 := '6204' ; l_ob1 := '17' ; l_nbs2 := '6204' ; l_ob2 := '17' ; l_nbs3 := '6204' ; l_ob3 := '17' ; -- Формування рез.фонду	           
     ---------------------------------------------------------------------------------------------------------------------------------
     ElsIf k.ob22 = '09' then l_nbs1 := '6204' ; l_ob1 := '15' ; l_nbs2 := '6214' ; l_ob2 := '03' ; l_nbs3 := '6214' ; l_ob3 := '02' ; -- (метал)	 
     ElsIf k.ob22 = '10' then l_nbs1 := '6204' ; l_ob1 := '01' ; l_nbs2 := '6214' ; l_ob2 := '04' ; l_nbs3 := '6214' ; l_ob3 := '01' ; -- купiвля-продаж    . Бранч 0000     
     ElsIf k.ob22 = '24' then l_nbs1 := '6204' ; l_ob1 := '26' ; l_nbs2 := '6218' ; l_ob2 := '05' ; l_nbs3 := '6218' ; l_ob3 := '06' ; -- ВП СВОП короткий (валютнй)          
     ElsIf k.ob22 = '29' then l_nbs1 := '6204' ; l_ob1 := '26' ; l_nbs2 := '6218' ; l_ob2 := '07' ; l_nbs3 := '6218' ; l_ob3 := '08' ; -- ВП СВОП короткий (депо)	       6204 
     ElsIf k.ob22 = '25' then l_nbs1 := '6204' ; l_ob1 := '26' ; l_nbs2 := '6214' ; l_ob2 := '06' ; l_nbs3 := '6214' ; l_ob3 := '05' ; -- ВП Звичайний Форекс (короткий)      
     ElsIf k.ob22 = '26' then l_nbs1 := '6204' ; l_ob1 := '26' ; l_nbs2 := '6216' ; l_ob2 := '01' ; l_nbs3 := '6216' ; l_ob3 := '02' ; -- ВП Звичайний Форекс (довгий-Forwar) 
     ElsIf k.ob22 = '27' then l_nbs1 := '6204' ; l_ob1 := '26' ; l_nbs2 := '6218' ; l_ob2 := '01' ; l_nbs3 := '6218' ; l_ob3 := '02' ; -- ВП СВОП (довгий- Forward) (валютни) 
     ElsIf k.ob22 = '30' then l_nbs1 := '6204' ; l_ob1 := '26' ; l_nbs2 := '6218' ; l_ob2 := '03' ; l_nbs3 := '6218' ; l_ob3 := '04' ; -- ВП СВОП (довгий- Forward) (депо)    
     ElsIf k.ob22 = '28' then l_nbs1 := '6204' ; l_ob1 := '27' ; l_nbs2 := '6214' ; l_ob2 := '09' ; l_nbs3 := '6214' ; l_ob3 := '10' ; -- іями погашення заборгованості за    
     ---------------------------------------------------------------------------------------------------------------------------------
     else goto XXX;
     end if;
     If k.ob22 in ( '03',  '22', '16' ) then  delete from spot where acc = k.acc3800 ;  end if;
     If gl.aMfo =' 300465' then a6.branch := Substr( k.branch,1,15) ; 
     else                       a6.branch := Substr( k.branch,1, 8) || '000000/' ;
     end if;
     If x_ob22 <> k.ob22 OR (gl.aMfo='300465' and x_Branch <> a6.branch ) then 
        a6.acc := k.acc6204 ; a6.nbs := l_nbs1 ; a6.ob22 := l_ob1 ;  op1 (a6) ; l_acc1 := a6.acc ; 
        a6.acc := k.acc_rrr ; a6.nbs := l_nbs2 ; a6.ob22 := l_ob2 ;  op1 (a6) ; l_acc2 := a6.acc ; 
        a6.acc := k.acc_rrs ; a6.nbs := l_nbs3 ; a6.ob22 := l_ob3 ;  op1 (a6) ; l_acc3 := a6.acc ; 
        x_ob22 := k.ob22    ; x_Branch := a6.branch; 
     end if;
     update vp_list set acc6204 = l_acc1, acc_rrr = l_acc2, acc_rrd = l_acc2, acc_rrs = l_acc3  where rowid = k.RI ;
     <<xxx>> null;
  end loop  ; -- k
  -----=======================================================================================================================------------
  select max( s.vdate) into l_dat from spot s ;
  for d in (select * from fdat where fdat > l_dat order by fdat)  loop SPOT_p ( Mode_ => 0 , dat_ => d.fdat ) ;   end loop;
  -----=======================================================================================================================------------
end loop  ; -- f 

bc.go('/');

end vp_2018 ;
/