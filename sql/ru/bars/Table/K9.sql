PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/K9.sql =========*** Run *** ======
PROMPT ===================================================================================== 

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
 
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/K9.sql =========*** End *** ======
PROMPT ===================================================================================== 
/
