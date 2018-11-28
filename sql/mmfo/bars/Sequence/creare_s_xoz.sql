PROMPT ===================================================================================== 
PROMPT *** Run *** ======= Scripts /Sql/BARS/Sequence/S_XOZ.sql ======*** Run *** 
PROMPT ===================================================================================== 
--tarasenko
PROMPT *** Create  sequence S_XOZ ***
begin
execute immediate
   
'create sequence S_XOZ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20';
 exception
    when others then null;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ======= Scripts /Sql/BARS/Sequence/S_XOZ.sql ======*** End *** 
PROMPT ===================================================================================== 
/
