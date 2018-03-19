BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CLIENT_ZVT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CLIENT_ZVT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CLIENT_ZVT ***

begin
execute immediate'
                create table CLIENT_ZVT (rnk number,
                                         okpo number, 
                                         nmk varchar2(4000),
                                         branch_name varchar2(4000),
                                         first_date_corp2 date,
                                         first_date_corplight date,
                                         user_id number)';

exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/    

PROMPT *** ALTER_POLICIES to CLIENT_ZVT ***

 exec bpa.alter_policies('CLIENT_ZVT');
/             
