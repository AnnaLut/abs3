declare
    l_bs varchar2(4);
    l_ob varchar2(2);
begin
    for c in (select branch, ob22, name, bs1, ob1, bs2, ob2, bs3, ob3 from branch_opelot) loop
        begin 
           select r020_new, ob_new into l_bs, l_ob from transfer_2017 where r020_old = c.bs1 and ob_old = c.ob1;
           update branch_opelot set bs1 = l_bs, ob1 = l_ob where branch = c.branch and ob22 = c.ob22 and name = c.name;
        exception when no_data_found then null;
        end;           
        begin 
           select r020_new, ob_new into l_bs, l_ob from transfer_2017 where r020_old = c.bs2 and ob_old = c.ob2;
           update branch_opelot set bs2 = l_bs, ob2 = l_ob where branch = c.branch and ob22 = c.ob22 and name = c.name;
        exception when no_data_found then null;
        end;        
        begin 
           select r020_new, ob_new into l_bs, l_ob from transfer_2017 where r020_old = c.bs3 and ob_old = c.ob3;
           update branch_opelot set bs3 = l_bs, ob3 = l_ob where branch = c.branch and ob22 = c.ob22 and name = c.name;
        exception when no_data_found then null;
        end;        
    end loop;
end;    
/

commit;