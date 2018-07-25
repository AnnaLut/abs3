
begin
	delete from IBX_LIMITS;
	insert into IBX_LIMITS (NBS, MIN_AMOUNT, MAX_AMOUNT)values ('2620', 1, 149999);
	insert into IBX_LIMITS (NBS, MIN_AMOUNT, MAX_AMOUNT)values ('2625', 1, 149999);
end;
/