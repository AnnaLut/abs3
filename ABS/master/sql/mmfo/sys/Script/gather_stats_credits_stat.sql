prompt gather stats BARS_DM.CREDITS_STAT
begin
    dbms_stats.gather_table_stats('BARS_DM', 'CREDITS_STAT', estimate_percent => 100, degree => 8, cascade =>true ); 
end;
/