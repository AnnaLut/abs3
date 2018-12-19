prompt       filling  KL_K045

delete from BARS.KL_K045;

Insert into BARS.KL_K045   (K045, TXT, D_OPEN, D_CLOSE, D_MODE) 
       Values ('1', 'На території України', to_date('20180101','yyyymmdd'), null, null);
                                                    
Insert into BARS.KL_K045   (K045, TXT, D_OPEN, D_CLOSE, D_MODE) 
       Values ('2', 'За межами України', to_date('20180101','yyyymmdd'), null, null);
                                                    

COMMIT;











