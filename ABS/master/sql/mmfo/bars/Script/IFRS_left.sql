--(Так)SPPI - IFRS=AC 
begin
  for k in (select kf from mv_kf)
  loop 
    bc.go(k.kf);
     for i in (select acc from accountsw where ((tag='BUS_MOD' and value in(1,6,7,8,9,10,11,12,13,14,15) )or (tag='SPPI' and value='Так')) and kf=k.kf
       group by acc
       having count(*)>1 )
     loop
     accreg.setAccountwParam (i.acc, p_tag =>'IFRS' ,p_val=>'AC');  
      end loop;
      end loop;
      end;
/
COMMIT;     
------------------------------------------------------------------      
begin
  for k in  (select kf from mv_kf)
  loop 
     bc.go(k.kf);
     for i in (select nd from nd_txt where ((tag='BUS_MOD' and txt in(1,6,7,8,9,10,11,12,13,14,15) )or (tag='SPPI' and txt='Так'))
       group by nd
       having count(*)>1)
     loop
     CCK_APP.Set_ND_TXT (i.nd, p_tag =>'IFRS' ,p_txt=>'AC');  
      end loop;
      end loop;
      end; 
/
COMMIT;    
-----------------------------------------------------------------
begin
  for k in  (select kf from mv_kf)
  loop 
      bc.go(k.kf);
     for i in (select r.ref from cp_refw r, cp_deal dd  where dd.ref=r.ref and ((tag='BUS_MOD' and value in(1,6,7,8,9,10,11,12,13,14,15) )or (tag='SPPI' and value='Так'))
       group by r.ref
        having count(*)>1)
     loop
    cp.cp_set_tag(i.ref, p_tag =>'IFRS' ,p_value=>'AC',p_type =>3);  
        end loop;
      end loop;
      end; 
/
COMMIT; 
------------------------------------------------------------------
begin
  for k in (select kf from mv_kf)
     loop
    bc.go(k.kf);
    for i in (select b.nd
                from bpk_parameters b,
                     (select nd from (
       select nd,dat_close from w4_acc
       union all
       select nd,dat_close from bpk_acc)t
       where not exists (select nd from 
                                (select nd, dat_close from w4_acc
                                  union all
                                  select nd,dat_close from bpk_acc)i
                                  where i.nd=t.nd and i.dat_close is not null)) a
               where b.nd = a.nd
                 and ((b.tag = 'BUS_MOD' and
                     value in (1, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15)) or
                     (b.tag = 'SPPI' and value = 'Так')) 
                     group by b.nd
                      having count(*)>1)
      loop
      bars_ow.set_bpk_parameter(i.nd, p_tag => 'IFRS', p_value => 'AC');
    end loop;
  end loop;
end;
/
COMMIT;
----------------------------------------------------------------      
--(Так)SPPI - IFRS=FVTLP   
 begin
  for k in (select kf from mv_kf)
  loop 
    bc.go(k.kf);
     for i in (select acc from accountsw where ((tag='BUS_MOD' and value in(2,4) )or (tag='SPPI' and value='Так')) and kf=k.kf
       group by acc
        having count(*)>1 )
     loop
     accreg.setAccountwParam (i.acc, p_tag =>'IFRS' ,p_val=>'FVTPL');  
      end loop;
      end loop;
      end;
/
COMMIT;     
------------------------------------------------------
begin
  for k in  (select kf from mv_kf)
  loop 
      bc.go(k.kf);
     for i in (select nd from nd_txt where ((tag='BUS_MOD' and txt in(2,4) )or (tag='SPPI' and txt='Так'))
                      group by nd
                       having count(*)>1 )
     loop
     CCK_APP.Set_ND_TXT (i.nd, p_tag =>'IFRS' ,p_txt=>'FVTPL');  
      end loop;
      end loop;
      end;
/
COMMIT;  
----------------------------------------------------------         
begin
  for k in  (select kf from mv_kf)
  loop 
      bc.go(k.kf);
     for i in (select c.ref from cp_refw c, cp_deal dd  where c.ref=dd.ref and ((tag='BUS_MOD' and value in(2,4)) or (tag='SPPI' and value='Так'))
                            group by c.ref
                             having count(*)>1 )
     loop
    cp.cp_set_tag(i.ref, p_tag =>'IFRS' ,p_value=>'FVTPL',p_type =>3);  
        end loop;
      end loop;
      end;
/
COMMIT; 
---------------------------------------------------------- 
begin
  for k in  (select kf from mv_kf)
  loop 
    bc.go(k.kf);
     for i in (select b.nd
                from bpk_parameters b,
                     (select nd from (
       select nd,dat_close from w4_acc
       union all
       select nd,dat_close from bpk_acc)t
       where not exists (select nd from 
                                (select nd, dat_close from w4_acc
                                  union all
                                  select nd,dat_close from bpk_acc)i
                                  where i.nd=t.nd and i.dat_close is not null)) a
        where b.nd=a.nd and ((tag='BUS_MOD' and value in(2,4))or (tag='SPPI' and value='Так'))
                         group by b.nd
                          having count(*)>1)
     loop
    bars_ow.set_bpk_parameter(i.nd, p_tag =>'IFRS',p_value =>'FVTPL');  
      end loop;
      end loop;
      end;
/
COMMIT; 
----------------------------------------------------------------      
--(Так)SPPI - IFRS=FVOCI       
 begin
  for k in (select kf from mv_kf)
  loop 
    bc.go (k.kf);
     for i in (select acc from accountsw where ((tag='BUS_MOD' and value in(3,5) )or (tag='SPPI' and value='Так')) and kf=k.kf
                  group by acc
                  having count(*)>1)
     loop
     accreg.setAccountwParam (i.acc, p_tag =>'IFRS' ,p_val=>'FVOCI');  
      end loop;
      end loop;
      end;
/
COMMIT;
------------------------------------------------------
begin
  for k in  (select kf from mv_kf)
  loop 
      bc.go (k.kf);
     for i in (select nd from nd_txt where ((tag='BUS_MOD' and txt in(3,5) )or (tag='SPPI' and txt='Так')) 
                      group by nd 
                      having count(*)>1)
     loop
     CCK_APP.Set_ND_TXT (i.nd, p_tag =>'IFRS' ,p_txt=>'FVOCI');  
      end loop;
      end loop;
      end;
/
COMMIT;     
----------------------------------------------------------         
begin
  for k in  (select kf from mv_kf)
  loop 
     bc.go (k.kf);
     for i in (select c.ref from cp_refw c , cp_deal dd  where c.ref=dd.ref and ((tag='BUS_MOD' and value in(3,5)) or (tag='SPPI' and value='Так'))
                      group by c.ref
                      having count(*)>1)
     loop
    cp.cp_set_tag(i.ref, p_tag =>'IFRS' ,p_value=>'FVOCI',p_type =>3);  
        end loop;
      end loop;
      end;
/
COMMIT;    
       