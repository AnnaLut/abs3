--ORA-01917: user or role does not exist

PROMPT =====================================================================================
PROMPT *** Run *** ======== Scripts /Sql/BARSUPL/grant/grant_packege.sql ========*** Run ***
PROMPT =====================================================================================

begin
    execute immediate 'grant EXECUTE on BARS_UPLOAD     to BARS';
 exception when others then 
    if sqlcode = -1917 then null; else raise; end if; 
end;
/

begin
    execute immediate 'grant EXECUTE on BARS_UPLOAD     to BARS_ACCESS_USER';
 exception when others then 
    if sqlcode = -1917 then null; else raise; end if; 
end;
/

begin
    execute immediate 'grant EXECUTE on BARS_UPLOAD     to UPLD';
 exception when others then 
    if sqlcode = -1917 then null; else raise; end if; 
end;
/

begin
    execute immediate 'grant EXECUTE on BARS_UPLOAD_USR to BARS';
 exception when others then 
    if sqlcode = -1917 then null; else raise; end if; 
end;
/

begin
    execute immediate 'grant EXECUTE on BARS_UPLOAD_USR to BARS_ACCESS_USER';
 exception when others then 
    if sqlcode = -1917 then null; else raise; end if; 
end;
/

begin
    execute immediate 'grant EXECUTE on BARS_UPLOAD_USR to UPLD';
 exception when others then 
    if sqlcode = -1917 then null; else raise; end if; 
end;
/

begin
    execute immediate 'grant EXECUTE on BARS_UPLOAD_UTL to BARS';
 exception when others then 
    if sqlcode = -1917 then null; else raise; end if; 
end;
/

begin
    execute immediate 'grant EXECUTE on BARS_UPLOAD_UTL to BARS_ACCESS_USER';
 exception when others then 
    if sqlcode = -1917 then null; else raise; end if; 
end;
/

begin
    execute immediate 'grant EXECUTE on BARS_UPLOAD_UTL to UPLD';
 exception when others then 
    if sqlcode = -1917 then null; else raise; end if; 
end;
/

PROMPT =====================================================================================
PROMPT *** End *** ======== Scripts /Sql/BARSUPL/grant/grant_packege.sql ========*** End ***
PROMPT =====================================================================================

