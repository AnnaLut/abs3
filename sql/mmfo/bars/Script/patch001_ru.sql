declare
  l_mmfo varchar2(100);
begin
 tuda;
  select sys_context('bars_context','user_branch') 
    into l_mmfo
  from dual;
  
  if l_mmfo='/303398/' then

--1   
      insert into BARS.PARAMS$BASE
        (par, val, comm, kf)
      values ('BRANCH_NAME_ENG', 'the PJSC УState Savings Bank of UkraineФ Vinnytsia Regional Directorate', 'Ќазва ф≥л≥њ англ≥йською мовою', '302076'); 

--2  
  elsif  l_mmfo='/303398/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC УState Savings Bank of UkraineФ Volyn Regional Directorate', 'Ќазва ф≥л≥њ англ≥йською мовою', '303398'); 
 
--3 
  elsif  l_mmfo='/305482/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC УState Savings Bank of UkraineФ Dnipropetrovsk Regional Directorate', 'Ќазва ф≥л≥њ англ≥йською мовою', '305482');   
--4 
  elsif  l_mmfo='/311647/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC Уthe PJSC УState Savings Bank of UkraineФ Zhytomyr Regional Directorate', 'Ќазва ф≥л≥њ англ≥йською мовою', '311647'); 
--5
  elsif  l_mmfo='/312356/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC УState Savings Bank of UkraineФ Zakarpattia Regional Directorate', 'Ќазва ф≥л≥њ англ≥йською мовою', '312356'); 
--6
  elsif  l_mmfo='/313957/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC УState Savings Bank of UkraineФ Zaporizhzhia Regional Directorate', 'Ќазва ф≥л≥њ англ≥йською мовою', '313957');
--7
  elsif  l_mmfo='/336503/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC УState Savings Bank of UkraineФ Ivano-Frankivsk Regional Directorate', 'Ќазва ф≥л≥њ англ≥йською мовою', '336503');
--8
  elsif  l_mmfo='/323475/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC УState Savings Bank of UkraineФ Kirovohrad Regional Directorate', 'Ќазва ф≥л≥њ англ≥йською мовою', '323475');
--9
  elsif  l_mmfo='/304665/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC УState Savings Bank of UkraineФ Luhansk Regional Directorate', 'Ќазва ф≥л≥њ англ≥йською мовою', '304665');
--10
  elsif  l_mmfo='/325796/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC УState Savings Bank of UkraineФ Lviv Regional Directorate', 'Ќазва ф≥л≥њ англ≥йською мовою', '325796');
--11
  elsif  l_mmfo='/325796/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC УState Savings Bank of UkraineФ Lviv Regional Directorate', 'Ќазва ф≥л≥њ англ≥йською мовою', '325796');
--12
  elsif  l_mmfo='/326461/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC УState Savings Bank of UkraineФ Mykolaiv Regional Directorate', 'Ќазва ф≥л≥њ англ≥йською мовою', '326461');
--13
  elsif  l_mmfo='/328845/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC УState Savings Bank of UkraineФ Odesa Regional Directorate', 'Ќазва ф≥л≥њ англ≥йською мовою', '328845');  
--14
  elsif  l_mmfo='/331467/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC УState Savings Bank of UkraineФ Poltava Regional Directorate', 'Ќазва ф≥л≥њ англ≥йською мовою', '331467');
--15
  elsif  l_mmfo='/333368/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC УState Savings Bank of UkraineФ Rivne Regional Directorate', 'Ќазва ф≥л≥њ англ≥йською мовою', '333368');
--16
  elsif  l_mmfo='/337568/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC УState Savings Bank of UkraineФ Sumy Regional Directorate', 'Ќазва ф≥л≥њ англ≥йською мовою', '337568');
--17
  elsif  l_mmfo='/338545/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC УState Savings Bank of UkraineФ Ternopil Regional Directorate', 'Ќазва ф≥л≥њ англ≥йською мовою', '338545');
--18
  elsif  l_mmfo='/351823/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC УState Savings Bank of UkraineФ Kharkiv Regional Directorate', 'Ќазва ф≥л≥њ англ≥йською мовою', '351823');
--19
  elsif  l_mmfo='/352457/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC УState Savings Bank of UkraineФ Kherson Regional Directorate', 'Ќазва ф≥л≥њ англ≥йською мовою', '352457');
--20
  elsif  l_mmfo='/315784/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC УState Savings Bank of UkraineФ Khmelnytskyi Regional Directorate', 'Ќазва ф≥л≥њ англ≥йською мовою', '315784');     
--21
  elsif  l_mmfo='/354507/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC УState Savings Bank of UkraineФ Cherkasy Regional Directorate', 'Ќазва ф≥л≥њ англ≥йською мовою', '354507'); 
--22
  elsif  l_mmfo='/356334/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC УState Savings Bank of UkraineФ Chernivtsi Regional Directorate', 'Ќазва ф≥л≥њ англ≥йською мовою', '356334');  
--23
  elsif  l_mmfo='/353553/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC УState Savings Bank of UkraineФ Chernihiv Regional Directorate', 'Ќазва ф≥л≥њ англ≥йською мовою', '353553');   
  end if;
 
  exception when dup_val_on_index then null;
  suda;
end;
/

