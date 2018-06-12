begin
bc.go(300465);
begin
insert into branch_attribute_value (attribute_code,
                                    branch_code,
                                    attribute_value)
                    values ('$BASE','/300465/','3200'); 
  exception when others then if sqlcode=00001 then null; 
      end if;
      end;
begin                                                           
insert into   branch_attribute (attribute_code,attribute_desc,attribute_datatype)
              values('$BASE','Мінімальна Заробітна плата','C');   
   exception when others then if sqlcode=00001 then null; 
      end if;
      end;              
bc.home();
end;
/                            
grant select on branch_attribute_value to nbu_gateway;