-- Изменение согласно новой трансформационной таблице 5.5

delete from transfer_2017 
 where (r020_old = '1527' and ob_old = '02') or
       (r020_old = '6042' and ob_old = 'K3') or
       (r020_old = '7096' and ob_old = '02') or
       (r020_old = '6399' and ob_old in ('D2','D3','D4','D5','D6','01','02','04','08','04') );
       
commit;
	   

insert into TRANSFER_2017(R020_OLD, OB_OLD, R020_NEW, OB_NEW, COMM)
values ('1527', '02', '1501', '02', 'прострочена заборгованість за кредитами овернайт, що надані іншим банкам');

insert into TRANSFER_2017(R020_OLD, OB_OLD, R020_NEW, OB_NEW, COMM)
values ('7096', '02', '7140', '02', 'амортизація дисконту');

insert into TRANSFER_2017(R020_OLD, OB_OLD, R020_NEW, OB_NEW, COMM)
values ('6042', 'K3', '6052', 'H5', 'за довгостроковими кредитами за банківським продуктом "зелена енергія" у національній валюті');
	   
	   
delete from transform_2017_forecast where nbs = '1527' and ob22 = '02';
delete from transform_2017_forecast where nbs = '6042' and ob22 = 'K3';
delete from transform_2017_forecast where nbs = '6399' and ob22 in ('D2','D3','D4','D5','D6','01','02','04','08','04') ;
delete from transform_2017_forecast where nbs = '7096' and ob22 = '02';

begin   
   for k in ( select kf from mv_kf) loop 
       for c in (select * from accounts 
                  where kf = k.kf 
                    and ( (nbs = '1527' and ob22 = '02') 
                           or 
                          (nbs = '6042' and ob22 = 'K3') 
                           or 
                          (nbs = '7096' and ob22 = '02') 
                         )
                    and dazs is null              
                ) loop               
               dbms_output.put_line(k.kf||' '||c.nls);
               p_transform_forecast_acc(p_accrow => c);               
       end loop;         
   end loop;            
end;
/

