BEGIN INSERT INTO CC_VIDD (VIDD,CUSTTYPE,TIPD,NAME) VALUES (351, 2, 1, 'Господ.діяльність'); 
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; -- ORA-00001: unique constraint (BARS.PK_CCVIDD) violated
end;
/

BEGIN INSERT INTO ps ( nbs ,NAME) VALUES ('4600', 'Оренда' ); 
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; -- ORA-00001: unique constraint (BARS.PK_PS) violated
end;
/

BEGIN INSERT INTO ps ( nbs ,NAME) VALUES ('4609', 'Оренда' ); 
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; --ORA-00001: unique constraint (BARS.PK_PS) violated
end;
/


BEGIN INSERT INTO sb_ob22 ( r020, ob22, txt) values ('4600','01', 'Права користування за приміщеннями основного призначення за договорами з лізингу (оренди)' );
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; -- ORA-00001: unique constraint (BARS.PK_CCVIDD) violated
end;
/

BEGIN INSERT INTO sb_ob22 ( r020, ob22, txt) values ('4609','01', 'Права користування за приміщеннями основного призначення за договорами з лізингу (оренди)' );
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; -- ORA-00001: unique constraint (BARS.PK_CCVIDD) violated
end;
/

BEGIN INSERT INTO sb_ob22 ( r020, ob22, txt) values ('4600','02', 'Права користування за приміщеннями додатк.призначення за договорами з лізингу (оренди)' ) ;
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; -- ORA-00001: unique constraint (BARS.PK_CCVIDD) violated
end;
/

BEGIN INSERT INTO sb_ob22 ( r020, ob22, txt) values ('4609','02', 'Права користування за приміщеннями додатк.призначення за договорами з лізингу (оренди)' ) ;
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; -- ORA-00001: unique constraint (BARS.PK_CCVIDD) violated
end;
/


BEGIN INSERT INTO sb_ob22 ( r020, ob22, txt) values ('4600','03', 'Права користування за гаражі та місця паркування за договорами з лізингу (оренди)' ) ;
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; -- ORA-00001: unique constraint (BARS.PK_CCVIDD) violated
end;
/

BEGIN INSERT INTO sb_ob22 ( r020, ob22, txt) values ('4609','03', 'Права користування за гаражі та місця паркування за договорами з лізингу (оренди)' ) ;
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; -- ORA-00001: unique constraint (BARS.PK_CCVIDD) violated
end;
/

commit;
------------------------

BEGIN INSERT INTO sb_ob22 ( r020, ob22, txt) values ('3615','04', 'Кредиторська заборгованўсть за договорами з лізингу (оренди)' ) ;
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; -- ORA-00001: unique constraint (BARS.PK_CCVIDD) violated
end;
/

BEGIN INSERT INTO sb_ob22 ( r020, ob22, txt) values ('3618','01', 'Кредиторська заборгованўсть за послуги' ) ;
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; -- ORA-00001: unique constraint (BARS.PK_CCVIDD) violated
end;
/

BEGIN INSERT INTO sb_ob22 ( r020, ob22, txt) values ('7028','01', 'Процентнў витрати за фўнансовим лўзингом (орендою), який облўковуються за амортиз.собўвартўстю' ) ;
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; -- ORA-00001: unique constraint (BARS.PK_CCVIDD) violated
end;
/

BEGIN INSERT INTO sb_ob22 ( r020, ob22, txt) values ('7399','67', 'Iншў операцўйнў витрати' ) ;
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; -- ORA-00001: unique constraint (BARS.PK_CCVIDD) violated
end;
/
commit;
