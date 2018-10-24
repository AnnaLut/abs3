begin
Insert into BARS.NBUR_REF_EKP2   (EKP, DSC)    Values ('A4B001', 'Cтатутний капітал банківської групи/підгрупи');
exception                                           
  when DUP_VAL_ON_INDEX then    null;                                    
end;                                                
/                                                   
                                                    
begin                                               
Insert into BARS.NBUR_REF_EKP2   (EKP, DSC)    Values ('A4B002', 'Регулятивний капітал банківської групи/підгрупи');
exception
  when DUP_VAL_ON_INDEX then    null;
end;
/

begin
Insert into BARS.NBUR_REF_EKP2   (EKP, DSC)    Values ('A4B003', 'Вирахування суми вкладень у капітал інших учасників банківської групи/підгрупи');
exception                                           
  when DUP_VAL_ON_INDEX then    null;                                    
end;                                                
/                                                   
                                                    
begin                                               
Insert into BARS.NBUR_REF_EKP2   (EKP, DSC)    Values ('A4B004', 'Регулятивний капітал банківської групи/підгрупи без урахування страхових компаній');
exception
  when DUP_VAL_ON_INDEX then    null;
end;
/

begin
Insert into BARS.NBUR_REF_EKP2   (EKP, DSC)    Values ('A4B005', 'Необхідний розмір регулятивного капіталу банківської групи/підгрупи');
exception                                           
  when DUP_VAL_ON_INDEX then    null;                                    
end;                                                
/                                                   
                                                    
begin                                               
Insert into BARS.NBUR_REF_EKP2   (EKP, DSC)    Values ('A4B006', 'Сукупні активи банківської групи/підгрупи з кінцевим строком погашення до 31 дня');
exception
  when DUP_VAL_ON_INDEX then    null;
end;
/

begin
Insert into BARS.NBUR_REF_EKP2   (EKP, DSC)    Values ('A4B007', 'Сукупні зобов’язання банківської групи/підгрупи з кінцевим строком погашення до 31 дня');
exception                                           
  when DUP_VAL_ON_INDEX then    null;                                    
end;                                                
/                                                   
                                                    
begin                                               
Insert into BARS.NBUR_REF_EKP2   (EKP, DSC)    Values ('A4B008', 'Сукупні активи банківської групи/підгрупи з кінцевим строком погашення до 1 року');
exception
  when DUP_VAL_ON_INDEX then    null;
end;
/

begin
Insert into BARS.NBUR_REF_EKP2   (EKP, DSC)    Values ('A4B009', 'Сукупні зобов’язання банківської групи з кінцевим строком погашення до 1 року');
exception                                           
  when DUP_VAL_ON_INDEX then    null;                                    
end;                                                
/                                                   
                                                    
begin                                               
Insert into BARS.NBUR_REF_EKP2   (EKP, DSC)    Values ('A4B010', 'Максимальна сукупна сума всіх вимог та позабалансових зобов’язань банківської групи/підгрупи щодо одного контрагента (групи пов’язаних контрагентів)');
exception
  when DUP_VAL_ON_INDEX then    null;
end;
/

begin
Insert into BARS.NBUR_REF_EKP2   (EKP, DSC)    Values ('A4B011', 'Сума кредиту, що не включається до розрахунку нормативу максимального розміру кредитного ризику на одного контрагента (Н7к) по банківській групі/підгрупі');
exception                                           
  when DUP_VAL_ON_INDEX then    null;                                    
end;                                                
/                                                   
                                                    
begin                                               
Insert into BARS.NBUR_REF_EKP2   (EKP, DSC)    Values ('A4B012', 'Сума всіх великих кредитних ризиків щодо всіх контрагентів (груп пов’язаних контрагентів) банківської групи/підгрупи');
exception
  when DUP_VAL_ON_INDEX then    null;
end;
/

begin
Insert into BARS.NBUR_REF_EKP2   (EKP, DSC)    Values ('A4B013', 'Максимальна сукупна сума всіх вимог та позабалансових зобов’язань банківської групи/підгрупи щодо однієї пов’язаної особи');
exception                                           
  when DUP_VAL_ON_INDEX then    null;                                    
end;                                                
/                                                   
                                                    
begin                                               
Insert into BARS.NBUR_REF_EKP2   (EKP, DSC)    Values ('A4B014', 'Сума всіх вимог та позабалансових зобов’язань банківської групи/підгрупи щодо всіх пов’язаних осіб');
exception
  when DUP_VAL_ON_INDEX then    null;
end;
/

begin
Insert into BARS.NBUR_REF_EKP2   (EKP, DSC)    Values ('A4B015', 'Сума всіх вимог та позабалансових зобов’язань банківської групи/підгрупи щодо всіх пов’язаних осіб, які не є фінансовими установами');
exception                                           
  when DUP_VAL_ON_INDEX then    null;                                    
end;                                                
/                                                   
                                                    
begin                                               
Insert into BARS.NBUR_REF_EKP2   (EKP, DSC)    Values ('A4B016', 'Максимальна сума коштів банківської групи/підгрупи, які інвестуються для участі в статутному капіталі юридичної особи, що не є фінансовою установою');
exception
  when DUP_VAL_ON_INDEX then    null;
end;
/

begin
Insert into BARS.NBUR_REF_EKP2   (EKP, DSC)    Values ('A4B017', 'Сума коштів банківської групи/підгрупи, що інвестуються для участі в статутному капіталі юридичних осіб, що не є фінансовими установами');
exception                                           
  when DUP_VAL_ON_INDEX then    null;                                    
end;                                                
/                                                   
                                                    
COMMIT;






