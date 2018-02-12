begin insert into cp_voper values('01', 'Продаж'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_voper values('02', 'Обмін (міна)'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_voper values('03', 'Зворотній викуп'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_voper values('04', 'Погашення'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_voper values('05', 'Повернення платнику коштів або майна (майнових прав), попередньо внесених ним до статутного капіталу емітента'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_voper values('06', 'Дарування/успадкування'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_voper values('07', 'Передача об’єкта (частини об’єкта) житлового будівництва'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_voper values('08', 'Викуп'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_voper values('09', 'Повторний продаж'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_voper values('10', 'Розміщення'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_voper values('11', 'Конвертація'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_voper values('12', 'Здійснення внеску до статутного капіталу'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_voper values('13', 'Видача ордерного або боргового цінного паперу'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_voper values('14', 'Погашення'); exception when dup_val_on_index then null; end; 
/

commit;