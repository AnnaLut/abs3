begin execute immediate 'CREATE TABLE tmp_T605 ( md int, nd number, G01 date , G02 number, G03 number,  G04 number, G05 number,  G06 number, G07 int,  G08 number,  G09 number, G10 number, G11 number) ' ;
exception when others then   if SQLCODE = -00955 then null;   else raise; end if;   -- ORA-00955: name is already used by an existing object
end;
/

COMMENT ON TABLE  tmp_T605      IS 'COBUSUPABS-5819.Розрахунок простроченої заборгованості за основним боргом, ';
COMMENT ON COLUMN tmp_T605.ND   IS 'Реф дог';                                        
COMMENT ON COLUMN tmp_T605.G01  IS 'Дата операції';                                        
COMMENT ON COLUMN tmp_T605.G02  IS 'Сума наданого кредиту';                                        
COMMENT ON COLUMN tmp_T605.G03  IS 'Сума чергового платежу по кредиту';                                        
COMMENT ON COLUMN tmp_T605.G04  IS 'Сума погашеного кредиту';                                        
COMMENT ON COLUMN tmp_T605.G05  IS 'Залишок заборгованості';                                        
COMMENT ON COLUMN tmp_T605.G06  IS 'Залишок простроченої заборгованості';                                        
COMMENT ON COLUMN tmp_T605.G07  IS 'К-ть днів прострочки';                                        
COMMENT ON COLUMN tmp_T605.G08  IS 'Розмір пені';                                        
COMMENT ON COLUMN tmp_T605.G09  IS 'Сума пені';                                        
COMMENT ON COLUMN tmp_T605.G10  IS '3% річних';                                        
COMMENT ON COLUMN tmp_T605.G11  IS 'Сума 3% річних';                                        

grant select on  tmp_t605 to BARS_ACCESS_DEFROLE ;