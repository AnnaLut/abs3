PROMPT ===================================================================================== 
PROMPT http://jira.unity-bars.com.ua:11000/browse/COBUSUPABS-6187
PROMPT ===================================================================================== 

begin
  insert into bars.w4_sparam (GRP_CODE, TIP, NBS, SP_ID, VALUE)
  values ('SOCIAL', 'W4D', '3570', 4, '5');

  insert into bars.w4_sparam (GRP_CODE, TIP, NBS, SP_ID, VALUE)
  values ('SOCIAL', 'W4D', '3570', 9, '5');

  insert into bars.w4_sparam (GRP_CODE, TIP, NBS, SP_ID, VALUE)
  values ('SOCIAL', 'W4D', '3579', 4, '5');

  insert into bars.w4_sparam (GRP_CODE, TIP, NBS, SP_ID, VALUE)
  values ('SOCIAL', 'W4D', '3579', 9, '5');
  commit;

  
  
exception when others then
  null;
end ;
/