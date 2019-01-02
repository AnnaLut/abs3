
delete from nbur_ref_sel_trans
 where file_id =33551;

insert into nbur_ref_sel_trans
         ( FILE_ID, KV, TT, MFO, COMM, PR_DEL, 
                    ACC_NUM_DB, OB22_DB, ACC_TYPE_DB,
                    ACC_NUM_CR, OB22_CR, ACC_TYPE_CR )
  select  33551, KV, TT, MFO, substr('C9'||COMM,1,250), PR_DEL, 
                   ACC_NUM_DB, OB22_DB, ACC_TYPE_DB,
                   ACC_NUM_CR, OB22_CR, ACC_TYPE_CR 
 from nbur_ref_sel_trans
   where file_id =16757
     and (pr_del is null or pr_del !=1);
                                             
insert into nbur_ref_sel_trans
         ( FILE_ID, KV, TT, MFO, COMM, PR_DEL, 
                    ACC_NUM_DB, OB22_DB, ACC_TYPE_DB,
                    ACC_NUM_CR, OB22_CR, ACC_TYPE_CR )
   values ( 33551, null, null, null, 'C9 3M', null, 
                   '2909', null, null,
                   '3720', '04', null ); 

commit;

           