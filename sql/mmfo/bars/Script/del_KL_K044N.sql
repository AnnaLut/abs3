
begin
   delete from BARS.KL_K044N
    where k040 ='004';
exception
   when others  then  null;
end;
/

begin
   delete from BARS.KL_K044N
    where k040 ='418';
exception
   when others  then  null;
end;
/

COMMIT;
