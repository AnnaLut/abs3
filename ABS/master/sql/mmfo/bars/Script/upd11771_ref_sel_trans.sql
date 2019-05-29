
declare
    l_file_3m        number;
begin        
     select id  into l_file_3m
       from nbur_ref_files
      where file_code ='#3M';

     delete from nbur_ref_sel_trans
      where file_id = l_file_3m and pr_del = 5
        and acc_num_db ='2909'
        and acc_num_cr ='2622';

insert into nbur_ref_sel_trans
         ( FILE_ID, KV, TT, MFO, COMM, PR_DEL, 
                    ACC_NUM_DB, OB22_DB, ACC_TYPE_DB,
                    ACC_NUM_CR, OB22_CR, ACC_TYPE_CR )
   values ( l_file_3m, null, null, null, null, 5, 
                   '2909', '82', null,
                   '2622', null, null ); 

insert into nbur_ref_sel_trans
         ( FILE_ID, KV, TT, MFO, COMM, PR_DEL, 
                    ACC_NUM_DB, OB22_DB, ACC_TYPE_DB,
                    ACC_NUM_CR, OB22_CR, ACC_TYPE_CR )
   values ( l_file_3m, null, null, null, null, 5, 
                   '2909', '56', null,
                   '2622', null, null ); 

commit;

end;
/

