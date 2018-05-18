begin
   branch_attribute_utl.create_attribute(p_attribute_code => 'ACC_USER', p_attribute_name => 'Перегляд рахунків по доступу', p_attribute_datatype=>'C');
   /*for c in (select kf from mv_kf where kf in (sys_context('bars_context','user_mfo')) ) loop  
       begin
           branch_attribute_utl.set_attribute_value(
                p_branch_code     =>  '/'||c.kf||'/',
                p_attribute_code  => 'ACC_USER',
                p_attribute_value => sys_context('bars_global','user_id'));        
       exception when others then null;
       end;         
   end loop; */       
end;
/
commit;
