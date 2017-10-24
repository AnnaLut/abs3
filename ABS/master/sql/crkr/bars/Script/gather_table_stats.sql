begin
  dbms_stats.gather_table_stats(ownname => 'BARS', tabname => 'COMPEN_MOTIONS', method_opt => 'FOR ALL INDEXED COLUMNS');
end;  
/

begin
  dbms_stats.gather_table_stats(ownname => 'BARS', tabname => 'COMPEN_BENEF', method_opt => 'FOR ALL INDEXED COLUMNS');
end;  
/
