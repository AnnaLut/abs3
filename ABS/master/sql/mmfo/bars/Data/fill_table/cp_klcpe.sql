begin insert into cp_klcpe values('1', 'Облігації, випущені підприємствами'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_klcpe values('2', 'Облігації, випущені Державною іпотечною установою'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_klcpe values('3', 'Облігації, випущені банками'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_klcpe values('4', 'Облігації, випущені органами місцевого самоврядування '); exception when dup_val_on_index then null; end; 
/

begin insert into cp_klcpe values('5', 'Облігації, випущені небанківськими фінансовими установами'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_klcpe values('6', 'Цінні папери емітовані НБУ'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_klcpe values('7', 'Облігації, випущені органами державної влади '); exception when dup_val_on_index then null; end; 
/

begin insert into cp_klcpe values('8', 'Векселя'); exception when dup_val_on_index then null; end; 
/

commit;