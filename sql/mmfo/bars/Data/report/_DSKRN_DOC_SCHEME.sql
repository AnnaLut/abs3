begin
  update doc_scheme d
     set d.name      = 'АКТ надання послуг',
         d.fr        = 1,
         d.file_name = 'SKRN_ACT.frx'
   where d.id = 'DSKRN_ACT';
  if sql%rowcount = 0 then
    insert into doc_scheme
      (id, name, fr, file_name)
    values
      ('DSKRN_ACT',
       'АКТ надання послуг',
       1,
       'SKRN_ACT.frx');
  end if;
  
  update doc_scheme d
     set d.name      = 'Рахунок-фактура',
         d.fr        = 1,
         d.file_name = 'SKRN_ACC.frx'
   where d.id = 'DSKRN_ACC';
  if sql%rowcount = 0 then
    insert into doc_scheme
      (id, name, fr, file_name)
    values
      ('DSKRN_ACC',
       'Рахунок-фактура',
       1,
       'SKRN_ACC.frx');
  end if;
end;
/
