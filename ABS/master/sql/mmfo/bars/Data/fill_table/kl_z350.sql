prompt       filling  KL_Z350

delete from BARS.KL_Z350;

Insert into BARS.KL_Z350   (Z350, TXT, D_OPEN, D_CLOSE, D_MODE) 
       Values ('1', '����', to_date('20180101','yyyymmdd'), null, null);
                                                    
Insert into BARS.KL_Z350   (Z350, TXT, D_OPEN, D_CLOSE, D_MODE) 
       Values ('2', '����� ����-��������', to_date('20180101','yyyymmdd'), null, null);
                                                    
Insert into BARS.KL_Z350   (Z350, TXT, D_OPEN, D_CLOSE, D_MODE) 
       Values ('3', '����-����������', to_date('20180101','yyyymmdd'), null, null);
                                                    

COMMIT;









