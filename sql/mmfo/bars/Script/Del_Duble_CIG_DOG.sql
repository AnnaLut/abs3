-- Удаляет дубли с неправильным типом
begin
    for rec in (
-- 1 cig_dog_noninstalment
select cg.branch cg_branch, cg.id cg_id, dno.dog_id, 1 n, cg.cust_id
  from (select cd.nd, count(*)
          from bars.CIG_DOG_GENERAL cd
         where 1 = 1
         group by cd.nd
        having count(cd.nd) > 1) x,
       bars.CIG_DOG_GENERAL cg,
       bars.cig_dog_noninstalment dno
 where cg.nd = x.nd
   and cg.contract_type = 3
   and cg.id = dno.dog_id
union -- 2 CIG_DOG_CREDIT
select cg.branch cg_branch, cg.id cg_id, dc.dog_id, 2 n, cg.cust_id
  from (select cd.nd, count(*)
          from bars.CIG_DOG_GENERAL cd
         where 1 = 1
         group by cd.nd
        having count(cd.nd) > 1) x,
       bars.CIG_DOG_GENERAL cg,
       bars.CIG_DOG_CREDIT dc
 where cg.nd = x.nd
   and cg.contract_type = 3
   and cg.id = dc.dog_id
union -- 3 cig_dog_instalment
select cg.branch cg_branch, cg.id cg_id, din.dog_id, 3 n, cg.cust_id
  from (select cd.nd, count(*)
          from bars.CIG_DOG_GENERAL cd
         where 1 = 1
         group by cd.nd
        having count(cd.nd) > 1) x,
       bars.CIG_DOG_GENERAL cg,
       bars.cig_dog_instalment din
 where cg.nd = x.nd
   and cg.contract_type = 3
   and cg.id = din.dog_id
)
   loop   
      
 begin
 if     rec.n = 1 then  
      delete cig_dog_noninstalment t 
           where t.dog_id = rec.cg_id and t.branch  = rec.cg_branch;
 elsif  rec.n = 2 then   
      delete bars.CIG_DOG_CREDIT t
           where t.dog_id = rec.cg_id and t.branch = rec.cg_branch;   
 elsif  rec.n = 3 then   
      delete bars.cig_dog_instalment t
           where t.dog_id = rec.cg_id and t.branch = rec.cg_branch;   
 end if; 
    
  delete bars.CIG_DOG_GENERAL cg2
         where cg2.id      = rec.cg_id
           and cg2.branch  = rec.cg_branch;    

   EXCEPTION
             WHEN others then   /*raise_application_error(-20001,'rec.cust_id: '||rec.cust_id ||' rec.cg_branch : '||rec.cg_branch|| ' rec.cg_id: ' ||rec.cg_id||' :\ '||sqlerrm ); -- */
             bars_audit.info ('CIG_ERROR : CIG_DOG_GENERAL.ID'||rec.cg_id||' dog_id:'||rec.dog_id ||': ' ||sqlerrm);  
       end;   
   end loop;   
 
end;
