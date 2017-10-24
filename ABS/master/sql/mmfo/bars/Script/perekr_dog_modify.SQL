
begin
 update perekr_dog
 set kf='300465'
 where kf is null;
end;
/
commit;