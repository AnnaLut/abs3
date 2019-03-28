/* begin
    bc.home;

    NBUR_FILES.SET_FILE_DEPENDENCIES( p_file_pid  => NBUR_FILES.GET_FILE_ID('#01'), p_file_id => NBUR_FILES.GET_FILE_ID('#C5'));
    commit;
end;
/ 

begin
    bc.home;

    NBUR_FILES.SET_FILE_DEPENDENCIES( p_file_pid  => NBUR_FILES.GET_FILE_ID('#C5'), p_file_id => NBUR_FILES.GET_FILE_ID('#42'));
    commit;
end;
/ 
 */
 
delete from kl_f3_29 where kf = '42' and ddd in ('047', '051');
Insert into KL_F3_29
   (KF, R020, R050, R012, DDD, 
    TXT, S240)
 Values
   ('42', '9010', '22', '1', '047', 
    NULL, NULL);
Insert into KL_F3_29
   (KF, R020, R050, R012, DDD, 
    TXT, S240)
 Values
   ('42', '9015', '22', '1', '047', 
    NULL, NULL);
Insert into KL_F3_29
   (KF, R020, R050, R012, DDD, 
    TXT, S240)
 Values
   ('42', '9030', '22', '1', '047', 
    NULL, NULL);
Insert into KL_F3_29
   (KF, R020, R050, R012, DDD, 
    TXT, S240)
 Values
   ('42', '9031', '22', '1', '047', 
    NULL, NULL);
Insert into KL_F3_29
   (KF, R020, R050, R012, DDD, 
    TXT, S240)
 Values
   ('42', '9036', '22', '1', '047', 
    NULL, NULL);
Insert into KL_F3_29
   (KF, R020, R050, R012, DDD, 
    TXT, S240)
 Values
   ('42', '9500', '22', '1', '047', 
    NULL, NULL);
Insert into KL_F3_29
   (KF, R020, R050, R012, DDD, 
    TXT, S240)
 Values
   ('42', '9501', '22', '1', '047', 
    NULL, NULL);
Insert into KL_F3_29
   (KF, R020, R050, R012, DDD, 
    TXT, S240)
 Values
   ('42', '9502', '22', '1', '047', 
    NULL, NULL);
Insert into KL_F3_29
   (KF, R020, R050, R012, DDD, 
    TXT, S240)
 Values
   ('42', '9500', '11', '1', '051', 
    NULL, NULL);
COMMIT;
