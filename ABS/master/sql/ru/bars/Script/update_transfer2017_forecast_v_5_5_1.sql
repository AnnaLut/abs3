delete from transform_2017_forecast where nbs = '1527' and ob22 = '02';
delete from transform_2017_forecast where nbs = '2205' and ob22 = '00';
delete from transform_2017_forecast where nbs = '3570' and ob22 = '19';
delete from transform_2017_forecast where nbs = '6399' and ob22 = '14';
delete from transform_2017_forecast where nbs = '7060' and ob22 = '01';

Insert into BARS.TRANSFER_2017(R020_OLD, OB_OLD, R020_NEW, OB_NEW, COMM, ID1)
 Values ('1527', '02', '1521', '02', 'прострочена заборгованість за кредитами овернайт, що надані іншим банкам',  9999);
commit;

/*
В банку треба в transfer_2017 СТРІЧКУ
1527  02    1501  02                прострочена заборгованість за кредитами овернайт, що надані іншим банкам         
 
ЗАМІНИТИ НА СТРІЧКУ:
 
1527  02    1521  02                прострочена заборгованість за кредитами овернайт, що надані іншим банкам          75

ВИДАЛИТИ СТРІЧКУ з ПРОДА ЇЇ НЕ МАЄ В 5.5.1 :
2205  00    2206  84                Неамортизована премiя за кредитами на поточнi потреби, що наданi фiзичним особам       728
3570  19    3570  19                нараховані доходи за рахунками фізичних осіб в системі WAY4            1419
6399  14    6340  14                доходи від реалізації пам"ятних, інвестиційних монет та футлярів для пам"ятних монет    1455
7060  01    7060  02                за короткостроковими  кредитами, що отримані від міжнародних та інших організацій         1641

-- Изменение согласно новой трансформационной таблице 5.5
*/

begin   
   for k in ( select kf from mv_kf) loop 
       for c in (select * from accounts 
                  where kf = k.kf 
                    and (nbs = '1527' and ob22 = '02') 
                    and dazs is null              
                ) loop               
               dbms_output.put_line(k.kf||' '||c.nls);
               p_transform_forecast_acc(p_accrow => c);               
       end loop;         
   end loop;            
end;
/

commit;
