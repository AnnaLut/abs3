begin execute immediate 'CREATE TABLE tmp_K605 ( md int, nd number , G01 date , G02 number, G03 number,  G04 number, G05 number,  G06 number, G07 int,  G08 number,  G09 number, G10 number, G11 number, NCOL  INT) ' ;
exception when others then   if SQLCODE = - 00955 then null;   else raise; end if; --ORA-00955: name is already used by an existing object
end;
/

begin   execute immediate 'alter table    tmp_K605  add ( NCOL int )';
exception when others then     if sqlcode= -01430 then null; else raise; end if; -- ORA-01430: column being added already exists in table
end; 
/

COMMENT ON TABLE  tmp_K605      IS 'COBUSUPABS-5819.Розрахунок простроченої заборгованості з комісії ';
COMMENT ON COLUMN tmp_K605.ND   IS 'Реф дог';                                        
COMMENT ON COLUMN tmp_K605.G01  IS 'Дата операції';                                        
COMMENT ON COLUMN tmp_K605.G02  IS 'Сума нарахованої комісії';                                        
COMMENT ON COLUMN tmp_K605.G03  IS 'Сума чергового платежу по комісії, що підлягала сплаті, згідно ГПК';                                        
COMMENT ON COLUMN tmp_K605.G04  IS 'Сума погашеної комісії';                                        
COMMENT ON COLUMN tmp_K605.G05  IS 'Залишок заборгованості';                                        
COMMENT ON COLUMN tmp_K605.G06  IS 'Залишок простроченої заборгованості';                                        
COMMENT ON COLUMN tmp_K605.G07  IS 'К-ть днів прострочки';                                        
COMMENT ON COLUMN tmp_K605.G08  IS 'Розмір пені';                                        
COMMENT ON COLUMN tmp_K605.G09  IS 'Сума пені';                                        
COMMENT ON COLUMN tmp_K605.G10  IS '3% річних';                                        
COMMENT ON COLUMN tmp_K605.G11  IS 'Сума 3% річних';
COMMENT ON COLUMN TMP_K605.NCOL IS 'цвет строки';                                        

grant select on  tmp_K605 to BARS_ACCESS_DEFROLE ;
