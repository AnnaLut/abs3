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
      values ('BRANCH_NAME_ENG', 'the PJSC �State Savings Bank of Ukraine� Vinnytsia Regional Directorate', '����� ��볿 ���������� �����', '302076'); 

--2  
  elsif  l_mmfo='/303398/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC �State Savings Bank of Ukraine� Volyn Regional Directorate', '����� ��볿 ���������� �����', '303398'); 
 
--3 
  elsif  l_mmfo='/305482/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC �State Savings Bank of Ukraine� Dnipropetrovsk Regional Directorate', '����� ��볿 ���������� �����', '305482');   
--4 
  elsif  l_mmfo='/311647/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC �the PJSC �State Savings Bank of Ukraine� Zhytomyr Regional Directorate', '����� ��볿 ���������� �����', '311647'); 
--5
  elsif  l_mmfo='/312356/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC �State Savings Bank of Ukraine� Zakarpattia Regional Directorate', '����� ��볿 ���������� �����', '312356'); 
--6
  elsif  l_mmfo='/313957/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC �State Savings Bank of Ukraine� Zaporizhzhia Regional Directorate', '����� ��볿 ���������� �����', '313957');
--7
  elsif  l_mmfo='/336503/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC �State Savings Bank of Ukraine� Ivano-Frankivsk Regional Directorate', '����� ��볿 ���������� �����', '336503');
--8
  elsif  l_mmfo='/323475/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC �State Savings Bank of Ukraine� Kirovohrad Regional Directorate', '����� ��볿 ���������� �����', '323475');
--9
  elsif  l_mmfo='/304665/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC �State Savings Bank of Ukraine� Luhansk Regional Directorate', '����� ��볿 ���������� �����', '304665');
--10
  elsif  l_mmfo='/325796/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC �State Savings Bank of Ukraine� Lviv Regional Directorate', '����� ��볿 ���������� �����', '325796');
--11
  elsif  l_mmfo='/325796/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC �State Savings Bank of Ukraine� Lviv Regional Directorate', '����� ��볿 ���������� �����', '325796');
--12
  elsif  l_mmfo='/326461/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC �State Savings Bank of Ukraine� Mykolaiv Regional Directorate', '����� ��볿 ���������� �����', '326461');
--13
  elsif  l_mmfo='/328845/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC �State Savings Bank of Ukraine� Odesa Regional Directorate', '����� ��볿 ���������� �����', '328845');  
--14
  elsif  l_mmfo='/331467/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC �State Savings Bank of Ukraine� Poltava Regional Directorate', '����� ��볿 ���������� �����', '331467');
--15
  elsif  l_mmfo='/333368/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC �State Savings Bank of Ukraine� Rivne Regional Directorate', '����� ��볿 ���������� �����', '333368');
--16
  elsif  l_mmfo='/337568/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC �State Savings Bank of Ukraine� Sumy Regional Directorate', '����� ��볿 ���������� �����', '337568');
--17
  elsif  l_mmfo='/338545/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC �State Savings Bank of Ukraine� Ternopil Regional Directorate', '����� ��볿 ���������� �����', '338545');
--18
  elsif  l_mmfo='/351823/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC �State Savings Bank of Ukraine� Kharkiv Regional Directorate', '����� ��볿 ���������� �����', '351823');
--19
  elsif  l_mmfo='/352457/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC �State Savings Bank of Ukraine� Kherson Regional Directorate', '����� ��볿 ���������� �����', '352457');
--20
  elsif  l_mmfo='/315784/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC �State Savings Bank of Ukraine� Khmelnytskyi Regional Directorate', '����� ��볿 ���������� �����', '315784');     
--21
  elsif  l_mmfo='/354507/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC �State Savings Bank of Ukraine� Cherkasy Regional Directorate', '����� ��볿 ���������� �����', '354507'); 
--22
  elsif  l_mmfo='/356334/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC �State Savings Bank of Ukraine� Chernivtsi Regional Directorate', '����� ��볿 ���������� �����', '356334');  
--23
  elsif  l_mmfo='/353553/' then 

     insert into BARS.PARAMS$BASE
       (par, val, comm, kf)
     values
     ('BRANCH_NAME_ENG', 'the PJSC �State Savings Bank of Ukraine� Chernihiv Regional Directorate', '����� ��볿 ���������� �����', '353553');   
  end if;
 
  exception when dup_val_on_index then null;
  suda;
end;
/

