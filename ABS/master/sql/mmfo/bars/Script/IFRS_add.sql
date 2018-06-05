COMMENT ON TABLE  BARS.IFRS           IS 'Класифікатор принципів обліку Активів по МСФЗ-9';
COMMENT ON COLUMN BARS.IFRS.IFRS_ID   IS 'Символьний код по IFRS корзины'  ;
COMMENT ON COLUMN BARS.IFRS.IFRS_NAME IS 'Опис принципу обліку Активів по МСФЗ-9';
--------------------------------------------------------------------------------

begin
Insert into BARS.IFRS
   (IFRS_ID, IFRS_NAME)
 Values
   ('AC', '1.Активи за за амортизованою собівартістю');
exception when others then   if SQLCODE = -00001 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/

begin
Insert into BARS.IFRS
   (IFRS_ID, IFRS_NAME)
 Values
   ('FVOCI', '2.Активи Справедлива вартість з переоцінкою на 5***(інш.сукуп.дох)');
exception when others then   if SQLCODE = -00001 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/

begin
Insert into BARS.IFRS
   (IFRS_ID, IFRS_NAME)
 Values
   ('FVTPL/Other', '3.Активи Справедлива вартість з переоцінкою на 6/7*(прибут.збиток)');
exception when others then   if SQLCODE = -00001 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/

COMMIT;


Update IFRS set IFRS_NAME = '1.Активи за за амортизованою собівартістю'                          where IFRS_ID ='AC';
Update IFRS set IFRS_NAME = '2.Активи Справедлива вартість з переоцінкою на 5***(інш.сукуп.дох)' where IFRS_ID ='FVOCI';
Update IFRS set IFRS_NAME = '3.Активи Справедлива вартість з переоцінкою на 6/7*(прибут.збиток)' where IFRS_ID ='FVTPL/Other';
commit;
-------------------
begin 
   EXECUTE IMMEDIATE 'update IFRS set K9 = null' ;
   EXECUTE IMMEDIATE 'alter table IFRS drop column  K9 ';
exception when others then  null;
end;
/

---------Корзин всего 5 и это пересечение параметра IFRS и параметра POCI.               
exec bars.bpa.alter_policy_info( 'K9', 'WHOLE' , null, null, null, null ); 
exec bars.bpa.alter_policy_info( 'K9', 'FILIAL', null, null, null, null );

begin  EXECUTE IMMEDIATE 'CREATE TABLE K9( k9 int, IFRS VARCHAR2 (15), POCI int ) ';
exception when others then   if SQLCODE = -00955 then null;   else raise; end if;   -- ORA-00955: name is already used by an existing object
end;
/

exec  bars.bpa.alter_policies('K9'); 

begin EXECUTE IMMEDIATE 'ALTER TABLE K9 add  CONSTRAINT XPK_K9  PRIMARY KEY  (K9 ) ' ;
exception when others then   if SQLCODE = -02260 then null;   else raise; end if;   -- ORA-02260: table can have only one primary key
end;
/

COMMENT ON TABLE  K9      IS 'Умовні "Корзини" обліку Активів по МСФЗ-9';
COMMENT ON COLUMN K9.K9   IS 'Числ.код~Корзини';
COMMENT ON COLUMN K9.IFRS IS 'Принцип обліку Активу по МСФЗ-9'  ;
COMMENT ON COLUMN K9.POCI IS 'Уточнення~POCI'  ;
                                   
GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.K9 TO BARS_ACCESS_DEFROLE;

----------------

begin EXECUTE IMMEDIATE 'ALTER TABLE K9 add  CONSTRAINT FK_K9IFRS    FOREIGN KEY (IFRS)   REFERENCES BARS.IFRS (IFRS_ID) ' ;
exception when others then   if SQLCODE = -02275 then null;   else raise; end if;   -- ORA-02275: such a referential constraint already exists in the table
end;
/

begin EXECUTE IMMEDIATE 'ALTER TABLE BARS.k9 ADD (  CONSTRAINT CHK_K9POCI CHECK ( POCI IN (0,1) ) ) ';
exception when others then   if SQLCODE = -02264 then null;   else raise; end if;   -- ORA-02264: name already used by an existing constraint
end;
/

begin EXECUTE IMMEDIATE 'alter table bars.k9 add ( name varchar2(30) ) ';
exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/

begin insert into k9 ( k9, IFRS, POCI ) values (1,'AC',0);
exception when others then   if SQLCODE = -00001 then null;   else raise; end if;   -- ORA-00001: unique constraint (BARS.XPK_K9) violated
end;
/

begin insert into k9 ( k9, IFRS, POCI ) values (2,'FVOCI',0);
exception when others then   if SQLCODE = -00001 then null;   else raise; end if;   -- ORA-00001: unique constraint (BARS.XPK_K9) violated
end;
/


begin insert into k9 ( k9, IFRS, POCI ) values (3,'FVTPL/Other',0);
exception when others then   if SQLCODE = -00001 then null;   else raise; end if;   -- ORA-00001: unique constraint (BARS.XPK_K9) violated
end;
/

begin insert into k9 ( k9, IFRS, POCI ) values (4,'AC',1);
exception when others then   if SQLCODE = -00001 then null;   else raise; end if;   -- ORA-00001: unique constraint (BARS.XPK_K9) violated
end;
/

begin insert into k9 ( k9, IFRS, POCI ) values (5,'FVOCI',1);
exception when others then   if SQLCODE = -00001 then null;   else raise; end if;   -- ORA-00001: unique constraint (BARS.XPK_K9) violated
end;
/

update k9 set name =  'IFRS='||ifrs||', POCI='||Decode(poci,0, 'Ні', 'Так');
commit;

commit;
