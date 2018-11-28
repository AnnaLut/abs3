begin  EXECUTE IMMEDIATE 'ALTER TABLE FIN_DEBT ADD ( TERM_DAY number) ' ;
exception when others then   if SQLCODE = -01430 then null;   else raise; end if;  
end;
/

COMMENT ON COLUMN BARS.FIN_DEBT.TERM_DAY IS 'номер дн€ Ц к≥нцевий день кожного м≥с€ц€ дл€ погашенн€';