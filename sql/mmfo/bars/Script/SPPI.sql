----11111 
   begin 
      for a in (select nd from NBU23_REZ where  fdat =(select max(fdat)  from NBU23_REZ) and KF=324805 
      and nbs in ('1500', '1502', '1510', '1512', '1513', '1514', '1520', '1521', '1522', '1523', '1524','1211','1212', '1410', '1420', '1430','1440', '1411',
       '1421', '1400', '1401','1402', '3010', '3011', '3012', '3013', '3014', '1412', '1413', '1414', '1422','1423','1424','3110', '3111', '3112', '3113', '3114',
       '3210', '3211', '3212', '3213', '3214', '2020', '2030', '2060', '2062', '2063', '2071', '2082', '2083', '2102', '2103', '2112', '2113', '2122', '2123', '2132',
       '2133', '2600', '2650', '2202', '2203', '2211', '2232', '2233', '2620', '2625', '2605', '2655') 
       and TIPA <> '4')
           loop
         CCK_APP.Set_ND_TXT (a.nd, p_tag =>'SPPI' ,p_TXT=>'Так');
         end loop;
         end;
/
COMMIT;
---2222
begin
for m in (select kf from mv_kf)
  loop
    bc.go (m.kf);
  for n in (select nd from (
       select nd,dat_close from w4_acc
       union all
       select nd,dat_close from bpk_acc)t
       where not exists (select nd from 
                                (select nd, dat_close from w4_acc
                                  union all
                                  select nd,dat_close from bpk_acc)i
                                  where i.nd=t.nd and i.dat_close is not null))
     loop
     bars_ow.set_bpk_parameter(n.nd, p_tag =>'SPPI',p_value=>'Так'); 
      end loop;
      end loop;
      end; 
/
COMMIT;    
---333333 
 begin
for m in (select kf from mv_kf)
  loop
    bc.go (m.kf); 
      for a in ( select distinct acc from NBU23_REZ where  fdat =(select max(fdat)  from NBU23_REZ) 
      and nbs in ('1811', '1812', '1819', '2800', '2801', '2802', '2805', '2806', '2809', '3548', '3570', '3578', '3541', '3710') )
        loop
         accreg.setAccountwParam(a.acc,p_tag =>'SPPI',p_val =>'Так');
          end loop;
          end loop;
          end;
/
COMMIT;
---444.11111
begin
  for k in (select kf from mv_kf) 
    loop
    bc.go (k.kf);  
    for n in (select nd
                from (select n.nd, sum(n.REZ39) srez39, sum(n.bv) sbv
                        from NBU23_REZ n
                       where 1 = 1
                         and n.fdat in (select max(fdat) from NBU23_REZ)
                         and (select max(mk.KOL_351)
                                from NBU23_REZ mk
                               where n.nd = mk.nd
                                and mk.fdat = n.fdat) > 360
                         and (nbs not like '12%' and nbs not like '9%' and
                             nbs not like '3%')
                         and (TIPA = '3' or TIPA = '10')
                       group by n.nd)
               where SREZ39 >= (0.95 * SBV)) 
               loop
      CCK_APP.Set_ND_TXT(n.nd, p_TAG => 'SPPI', p_TXT => 'Так');
    end loop;
  end loop;
  end;
/
COMMIT;
--4444.222222
begin
  for k in (select kf from mv_kf) 
    loop
     bc.go (k.kf); 
    for n in (select nd
                from (select n.nd, sum(n.REZ39) srez39, sum(n.bv) sbv
                        from NBU23_REZ n
                       where 1 = 1
                         and (select max(mk.KOL_351)
                                from NBU23_REZ mk
                               where n.nd = mk.nd
                                 and mk.fdat = n.fdat) > 360
                         and n.fdat in (select max(fdat) from NBU23_REZ)
                         and TIPA = '9'
                         and nbs not like '3541%'
                       group by n.nd)
               where SREZ39 >= (0.95 * SBV)) 
               loop
      cp.cp_set_tag(n.nd,p_TAG=>'SPPI',p_value=>'Так',p_type=>3);
    end loop;
  end loop;
  end;
/
COMMIT;
--Табл.6!!!
--BUS_MOD(1) - SPPI(Так) 
begin
  for k in (select kf from mv_kf)
  loop 
    bc.go(k.kf);
     for i in (select acc from accountsw where tag='BUS_MOD' and value=1 and kf=k.kf)
            loop
     accreg.setAccountwParam(i.acc, p_tag=>'SPPI' ,p_val=>'Так');  
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
     for i in (select nd from nd_txt where tag='BUS_MOD' and txt=1)
     loop
     CCK_APP.Set_ND_TXT (i.nd, p_tag =>'SPPI' ,p_txt=>'Так');  
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
     for i in (select c.ref from cp_refw c ,cp_deal dd  where tag='BUS_MOD' and value=1 and  dd.ref=c.ref)
     loop
    cp.cp_set_tag(i.ref, p_tag =>'SPPI' ,p_value=>'Так',p_type =>3);  
        end loop;
      end loop;
      end;  
/
COMMIT;
--BUS_MOD(2,3,4,5) - SPPI(Ні) 
begin
  for k in (select kf from mv_kf)
  loop 
    bc.go(k.kf);
     for i in (select acc from accountsw where tag='BUS_MOD' and value in (2,3,4,5)and kf=k.kf ) 
      loop
     accreg.setAccountwParam (i.acc, p_tag =>'SPPI' ,p_val=>'Ні');  
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
     for i in (select nd from nd_txt where tag='BUS_MOD' and txt in (2,3,4,5))
     loop
     CCK_APP.Set_ND_TXT (i.nd, p_tag =>'SPPI' ,p_txt=>'Ні');  
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
     for i in (select r.ref from cp_refw r , cp_deal dd  where tag='BUS_MOD' and value in (2,3,4,5) and r.ref=dd.ref)
     loop
    cp.cp_set_tag(i.ref, p_tag =>'SPPI' ,p_value=>'Ні',p_type =>3);  
        end loop;
      end loop;
      end;  
/
COMMIT;

