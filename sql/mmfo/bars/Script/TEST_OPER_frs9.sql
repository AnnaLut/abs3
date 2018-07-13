begin  
 execute immediate  'CREATE TABLE BARS.TEST_OPER_frs9 AS SELECT * FROM BARS.OPER WHERE ND LIKE ''FRS9%'' AND SOS =5 AND PDAT > TO_DATE(''22-06-2018'', ''DD-MM-YYYY'') ';
 execute immediate  'CREATE INDEX BARS.IDX_OPERfrs9   ON BARS.TEST_OPER_frs9 (kf, vdat, REF) ' ;
exception when others then         if sqlcode=-955 then null; else raise; end if ; 
end;
/
