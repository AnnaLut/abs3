begin
    execute immediate 
	'Insert into OP_FIELD
		(tag, name, use_in_arch)
	Values
		(''CLV01'', ''CorpLight: віза 1'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 
	'Insert into OP_FIELD
		(tag, name, use_in_arch)
	Values
		(''CLV02'', ''CorpLight: віза 2'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 
	'Insert into OP_FIELD
		(tag, name, use_in_arch)
	Values
		(''CLV03'', ''CorpLight: віза 3'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 
	'Insert into OP_FIELD
		(tag, name, use_in_arch)
	Values
		(''CLV04'', ''CorpLight: віза 4'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 
	'Insert into OP_FIELD
		(tag, name, use_in_arch)
	Values
		(''CLV05'', ''CorpLight: віза 5'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 
	'Insert into OP_FIELD
		(tag, name, use_in_arch)
	Values
		(''CLV06'', ''CorpLight: віза 6'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 
	'Insert into OP_FIELD
		(tag, name, use_in_arch)
	Values
		(''CLV07'', ''CorpLight: віза 7'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 
	'Insert into OP_FIELD
		(tag, name, use_in_arch)
	Values
		(''CLV08'', ''CorpLight: віза 8'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 
	'Insert into OP_FIELD
		(tag, name, use_in_arch)
	Values
		(''CLV09'', ''CorpLight: віза 9'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 
	'Insert into OP_FIELD
		(tag, name, use_in_arch)
	Values
		(''CLTIM'', ''CorpLight: Час створення'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 
	'Insert into OP_FIELD
		(tag, name, use_in_arch)
	Values
		(''CLTSB'', ''CorpLight: Час відправки в банк'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 
	'Insert into OP_FIELD
		(tag, name, use_in_arch)
	Values
		(''CLTRB'', ''Час одержання банком'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 
	'Insert into OP_FIELD
		(tag, name, use_in_arch)
	Values
		(''CLPID'', ''CorpLight: ID документу'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/

COMMIT;

