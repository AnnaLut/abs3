begin
    execute immediate 
	'Insert into OP_FIELD
		(tag, name, use_in_arch)
	Values
		(''CLV01'', ''CorpLight: ��� 1'', 1)';
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
		(''CLV02'', ''CorpLight: ��� 2'', 1)';
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
		(''CLV03'', ''CorpLight: ��� 3'', 1)';
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
		(''CLV04'', ''CorpLight: ��� 4'', 1)';
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
		(''CLV05'', ''CorpLight: ��� 5'', 1)';
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
		(''CLV06'', ''CorpLight: ��� 6'', 1)';
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
		(''CLV07'', ''CorpLight: ��� 7'', 1)';
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
		(''CLV08'', ''CorpLight: ��� 8'', 1)';
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
		(''CLV09'', ''CorpLight: ��� 9'', 1)';
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
		(''CLTIM'', ''CorpLight: ��� ���������'', 1)';
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
		(''CLTSB'', ''CorpLight: ��� �������� � ����'', 1)';
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
		(''CLTRB'', ''��� ��������� ������'', 1)';
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
		(''CLPID'', ''CorpLight: ID ���������'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/

COMMIT;

