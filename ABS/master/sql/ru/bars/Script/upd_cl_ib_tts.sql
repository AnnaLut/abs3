delete from bars.chklist_tts where tt in ( 'CL1','CL2','IB1','IB2', 'IB5', 'CL5');


begin
    execute immediate 'insert into bars.chklist_tts (TT, IDCHK, PRIORITY, F_BIG_AMOUNT, SQLVAL, F_IN_CHARGE)
values (''CL1'', 7, 2, null, ''(((substr(nlsa,1,4) in (''''2600'''',''''2650'''',''''2603'''',''''2530'''',''''2541'''',''''2542'''',''''2544'''',''''2545'''')) and nvl(f_get_ob22(kv, nlsb), ''''02'''')=''''04'''' and kv=980 and substr(nlsb,1,4)=''''1919'''') or kv<>980)'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into bars.chklist_tts (TT, IDCHK, PRIORITY, F_BIG_AMOUNT, SQLVAL, F_IN_CHARGE)
values (''CL1'', 11, 3, null, ''((substr(NLSA,1,4) in (''''2062'''',''''2063'''',''''2072'''',''''2073'''',''''2082'''',''''2083'''',''''2102'''',''''2103'''',''''2112'''',''''2113'''',''''2122'''',''''2123'''',''''2132'''',''''2133'''')) or kv<>980 or (substr(NLSB,1,4) in (''''2909'''',''''2924'''')))'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into bars.chklist_tts (TT, IDCHK, PRIORITY, F_BIG_AMOUNT, SQLVAL, F_IN_CHARGE)
values (''CL1'', 25, 1, null, null, 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into bars.chklist_tts (TT, IDCHK, PRIORITY, F_BIG_AMOUNT, SQLVAL, F_IN_CHARGE)
values (''CL1'', 38, 4, null, ''( NLSA like ''''20%'''' or NLSA like ''''21%'''' or NLSA like ''''22%'''' )'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into bars.chklist_tts (TT, IDCHK, PRIORITY, F_BIG_AMOUNT, SQLVAL, F_IN_CHARGE)
values (''CL2'', 7, 2, null, ''kv<>980'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into bars.chklist_tts (TT, IDCHK, PRIORITY, F_BIG_AMOUNT, SQLVAL, F_IN_CHARGE)
values (''CL2'', 11, 4, null, ''((substr(NLSA,1,4) in (''''2062'''',''''2063'''',''''2072'''',''''2073'''',''''2082'''',''''2083'''',''''2102'''',''''2103'''',''''2112'''',''''2113'''',''''2122'''',''''2123'''',''''2132'''',''''2133'''')) or kv<>980 )'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into bars.chklist_tts (TT, IDCHK, PRIORITY, F_BIG_AMOUNT, SQLVAL, F_IN_CHARGE)
values (''CL2'', 25, 1, null, null, 3)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into bars.chklist_tts (TT, IDCHK, PRIORITY, F_BIG_AMOUNT, SQLVAL, F_IN_CHARGE)
values (''CL2'', 38, 6, null, ''( NLSA like ''''20%'''' or NLSA like ''''21%'''' or NLSA like ''''22%'''' )'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into bars.chklist_tts (TT, IDCHK, PRIORITY, F_BIG_AMOUNT, SQLVAL, F_IN_CHARGE)
values (''CL2'', 94, 8, null, ''( bis=1 )'', 3)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into bars.chklist_tts (TT, IDCHK, PRIORITY, F_BIG_AMOUNT, SQLVAL, F_IN_CHARGE)
values (''CL5'', 7, 2, null, ''kv<>980'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into bars.chklist_tts (TT, IDCHK, PRIORITY, F_BIG_AMOUNT, SQLVAL, F_IN_CHARGE)
values (''CL5'', 25, 1, null, null, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into bars.chklist_tts (TT, IDCHK, PRIORITY, F_BIG_AMOUNT, SQLVAL, F_IN_CHARGE)
values (''CL5'', 30, 3, null, ''bpk_visa30(ref, 1)=1'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into bars.chklist_tts (TT, IDCHK, PRIORITY, F_BIG_AMOUNT, SQLVAL, F_IN_CHARGE)
values (''IB1'', 7, 2, null, ''(((substr(nlsa,1,4) in (''''2600'''',''''2650'''',''''2603'''',''''2530'''',''''2541'''',''''2542'''',''''2544'''',''''2545'''')) and nvl(f_get_ob22(kv, nlsb), ''''02'''')=''''04'''' and kv=980 and substr(nlsb,1,4)=''''1919'''') or kv<>980)'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into bars.chklist_tts (TT, IDCHK, PRIORITY, F_BIG_AMOUNT, SQLVAL, F_IN_CHARGE)
values (''IB1'', 11, 5, null, ''((substr(NLSA,1,4) in (''''2062'''',''''2063'''',''''2072'''',''''2073'''',''''2082'''',''''2083'''',''''2102'''',''''2103'''',''''2112'''',''''2113'''',''''2122'''',''''2123'''',''''2132'''',''''2133'''')) or kv<>980 or (substr(NLSB,1,4) in (''''2909'''',''''2924'''')))'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into bars.chklist_tts (TT, IDCHK, PRIORITY, F_BIG_AMOUNT, SQLVAL, F_IN_CHARGE)
values (''IB1'', 25, 1, null, null, 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into bars.chklist_tts (TT, IDCHK, PRIORITY, F_BIG_AMOUNT, SQLVAL, F_IN_CHARGE)
values (''IB1'', 38, 6, null, ''( NLSA like ''''20%'''' or NLSA like ''''21%'''' or NLSA like ''''22%'''' )'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into bars.chklist_tts (TT, IDCHK, PRIORITY, F_BIG_AMOUNT, SQLVAL, F_IN_CHARGE)
values (''IB2'', 7, 2, null, ''kv<>980'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into bars.chklist_tts (TT, IDCHK, PRIORITY, F_BIG_AMOUNT, SQLVAL, F_IN_CHARGE)
values (''IB2'', 11, 4, null, ''((substr(NLSA,1,4) in (''''2062'''',''''2063'''',''''2072'''',''''2073'''',''''2082'''',''''2083'''',''''2102'''',''''2103'''',''''2112'''',''''2113'''',''''2122'''',''''2123'''',''''2132'''',''''2133'''')) or kv<>980 )'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into bars.chklist_tts (TT, IDCHK, PRIORITY, F_BIG_AMOUNT, SQLVAL, F_IN_CHARGE)
values (''IB2'', 25, 1, null, null, 3)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into bars.chklist_tts (TT, IDCHK, PRIORITY, F_BIG_AMOUNT, SQLVAL, F_IN_CHARGE)
values (''IB2'', 38, 6, null, ''( NLSA like ''''20%'''' or NLSA like ''''21%'''' or NLSA like ''''22%'''' )'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into bars.chklist_tts (TT, IDCHK, PRIORITY, F_BIG_AMOUNT, SQLVAL, F_IN_CHARGE)
values (''IB2'', 94, 8, null, ''( bis=1 )'', 3)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into bars.chklist_tts (TT, IDCHK, PRIORITY, F_BIG_AMOUNT, SQLVAL, F_IN_CHARGE)
values (''IB5'', 7, 2, null, ''kv<>980'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into bars.chklist_tts (TT, IDCHK, PRIORITY, F_BIG_AMOUNT, SQLVAL, F_IN_CHARGE)
values (''IB5'', 25, 1, null, null, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into bars.chklist_tts (TT, IDCHK, PRIORITY, F_BIG_AMOUNT, SQLVAL, F_IN_CHARGE)
values (''IB5'', 30, 3, null, ''bpk_visa30(ref, 1)=1'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

commit;