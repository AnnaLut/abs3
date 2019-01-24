
declare
    l_file_3m        number;
    l_file_c9        number;
    l_file_e2        number;
begin        
     select id  into l_file_3m
       from nbur_ref_files
      where file_code ='#3M';

     select id  into l_file_c9
       from nbur_ref_files
      where file_code ='#C9';

     select id  into l_file_e2
       from nbur_ref_files
      where file_code ='#E2';


delete from nbur_ref_sel_trans
 where file_id = l_file_3m;

insert into nbur_ref_sel_trans
         ( FILE_ID, KV, TT, MFO, COMM, PR_DEL, 
                    ACC_NUM_DB, OB22_DB, ACC_TYPE_DB,
                    ACC_NUM_CR, OB22_CR, ACC_TYPE_CR )
  select  l_file_3m, KV, TT, MFO, COMM, 6, 
                   ACC_NUM_DB, OB22_DB, ACC_TYPE_DB,
                   ACC_NUM_CR, OB22_CR, ACC_TYPE_CR 
 from nbur_ref_sel_trans
   where file_id =l_file_c9
     and nvl(pr_del,0) !=1 ;
                                             
insert into nbur_ref_sel_trans
         ( FILE_ID, KV, TT, MFO, COMM, PR_DEL, 
                    ACC_NUM_DB, OB22_DB, ACC_TYPE_DB,
                    ACC_NUM_CR, OB22_CR, ACC_TYPE_CR )
   values ( l_file_3m, null, null, null, null, 6, 
                   '2909', null, null,
                   '3720', '04', null ); 

insert into nbur_ref_sel_trans
         ( FILE_ID, KV, TT, MFO, COMM, PR_DEL, 
                    ACC_NUM_DB, OB22_DB, ACC_TYPE_DB,
                    ACC_NUM_CR, OB22_CR, ACC_TYPE_CR )
  select  l_file_3m, KV, TT, MFO, COMM, 5, 
                   ACC_NUM_DB, OB22_DB, ACC_TYPE_DB,
                   ACC_NUM_CR, OB22_CR, ACC_TYPE_CR 
 from nbur_ref_sel_trans
   where file_id =l_file_e2
     and nvl(pr_del,0) !=1 ;
                                             
commit;

end;
/

--    (6)       3720       2603     980
--    (5)       1919/04    1600     980
