
exec bars.bpa.alter_policy_info( 'CCK_OB22_9', 'WHOLE' , null, null, null, null ); 
exec bars.bpa.alter_policy_info( 'CCK_OB22_9', 'FILIAL', null, null, null, null );

begin  EXECUTE IMMEDIATE 'CREATE TABLE bars.CCK_OB22_9( 
  NBS      CHAR(4 BYTE),
  OB22     CHAR(2 BYTE),
  SDF      CHAR(6 BYTE), D6F      CHAR(6 BYTE), D7F      CHAR(6 BYTE),
  SDM      CHAR(6 BYTE), D6M      CHAR(6 BYTE), D7M      CHAR(6 BYTE),
  SDI      CHAR(6 BYTE), D6I      CHAR(6 BYTE), D7I      CHAR(6 BYTE),
  SDA      CHAR(6 BYTE), D6A      CHAR(6 BYTE), D7A      CHAR(6 BYTE),
  SNA      CHAR(6 BYTE), N6A      CHAR(6 BYTE), N7A      CHAR(6 BYTE),
  SRR      CHAR(6 BYTE), R6R      CHAR(6 BYTE), R7R      CHAR(6 BYTE)
) ' ;

exception when others then   if SQLCODE = -00955 then null;   else raise; end if;   -- ORA-00955: name is already used by an existing object
end;
/

exec  bars.bpa.alter_policies('CCK_OB22_9'); 

commit;


begin EXECUTE IMMEDIATE 'ALTER TABLE bars.CCK_OB22_9 add  CONSTRAINT XPK_CCKOB229  PRIMARY KEY  (NBS,OB22) ' ;
exception when others then   if SQLCODE = -02260 then null;   else raise; end if;   -- ORA-02260: table can have only one primary key
end;
/

begin EXECUTE IMMEDIATE 'alter table bars.cck_ob22_9 add ( D8F CHAR(6), D8M CHAR(6) ) ';
exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/

/*
begin EXECUTE IMMEDIATE 'ALTER TABLE BARS.CCK_OB22_9 ADD (  CONSTRAINT FK_CCKOB229  FOREIGN KEY (NBS,OB22)  REFERENCES BARS.CCK_OB22 (NBS,OB22) )' ;
exception when others then   if SQLCODE = -02275 then null;   else raise; end if;   -- ORA-02275: such a referential constraint already exists in the table
end;
/
*/

GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.CCK_OB22_9 TO BARS_ACCESS_DEFROLE;

COMMENT ON TABLE  BARS.CCK_OB22_9      IS  'Додаток (МСФЗ-9) до CCK_Ob22';


COMMENT ON COLUMN BARS.CCK_OB22_9.D8F  IS 'БС+Об22~6~S1~до спрв~FV_ADJ';
COMMENT ON COLUMN BARS.CCK_OB22_9.D8M  IS 'БС+Об22~6~S3~від модф~MODIF';    


COMMENT ON COLUMN BARS.CCK_OB22_9.NBS  IS 'БС  ~тіла~';
COMMENT ON COLUMN BARS.CCK_OB22_9.OB22 IS 'ob22~тіла';

COMMENT ON COLUMN BARS.CCK_OB22_9.SDF  IS 'БС+Об22~Д/П до справедл~FV_ADJ';
COMMENT ON COLUMN BARS.CCK_OB22_9.D6F  IS 'БС+Об22~6 кл.до справедл~FV_ADJ';    
COMMENT ON COLUMN BARS.CCK_OB22_9.D7F  IS 'БС+Об22~7 кл.до справедл~FV_ADJ';   

COMMENT ON COLUMN BARS.CCK_OB22_9.SDM  IS 'БС+Об22~Д/П від модифік~MODIF';
COMMENT ON COLUMN BARS.CCK_OB22_9.D6M  IS 'БС+Об22~6 кл.від модифік~MODIF';     
COMMENT ON COLUMN BARS.CCK_OB22_9.D7M  IS 'БС+Об22~7 кл.від модифік~MODIF'; 


COMMENT ON COLUMN BARS.CCK_OB22_9.SDA  IS 'БС+Об22~Д/П "технічний"~ACCRUAL';
COMMENT ON COLUMN BARS.CCK_OB22_9.D6A  IS 'БС+Об22~6 кл."технічний"~ACCRUAL';   
COMMENT ON COLUMN BARS.CCK_OB22_9.D7A  IS 'БС+Об22~7 кл."технічний"~ACCRUAL';  

COMMENT ON COLUMN BARS.CCK_OB22_9.SDI  IS 'БС+Об22~Д/П "грошовий"~GENERAL';
COMMENT ON COLUMN BARS.CCK_OB22_9.D6I  IS 'БС+Об22~6 кл."грошовий"~GENERAL';    
COMMENT ON COLUMN BARS.CCK_OB22_9.D7I  IS 'БС+Об22~7 кл."грошовий"~GENERAL';   

COMMENT ON COLUMN BARS.CCK_OB22_9.SNA  IS 'БС+Об22~Невизн.дох~AIRC_CCY'; 
COMMENT ON COLUMN BARS.CCK_OB22_9.N6A  IS 'БС+Об22~6 кл.Невизн.~AIRC_CCY';   
COMMENT ON COLUMN BARS.CCK_OB22_9.N7A  IS 'БС+Об22~7 кл.Невизн.~AIRC_CCY';  

COMMENT ON COLUMN BARS.CCK_OB22_9.SRR  IS 'БС+Об22~Переоц.~XLS'; 
COMMENT ON COLUMN BARS.CCK_OB22_9.R6R  IS 'БС+Об22~6 кл.Переоц.~XLS';               
COMMENT ON COLUMN BARS.CCK_OB22_9.R7R  IS 'БС+Об22~7 кл.Переоц.~XLS'; 
------------------
 
commit ;
-----------------------

begin EXECUTE IMMEDIATE 
'alter table bars.cck_ob22_9 add ( S1NP CHAR(6), S1NM CHAR(6),  S1VP CHAR(6), S1VM CHAR(6),  S3NP CHAR(6), S3NM CHAR(6),  S3VP CHAR(6), S3VM CHAR(6)  ) ';
exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/

COMMENT ON COLUMN BARS.CCK_OB22_9.S1NP  IS 'БС+Об22~NEW_FEE~плюс S1 грн~до спрв~FV_ADJ' ;
COMMENT ON COLUMN BARS.CCK_OB22_9.S1NM  IS 'БС+Об22~NEW_FEE~мінус S1 грн~до спрв~FV_ADJ';    
COMMENT ON COLUMN BARS.CCK_OB22_9.S1VP  IS 'БС+Об22~NEW_FEE~плюс S1 вал~до спрв~FV_ADJ' ;   
COMMENT ON COLUMN BARS.CCK_OB22_9.S1VM  IS 'БС+Об22~NEW_FEE~мінус S1 вал~до спрв~FV_ADJ';
COMMENT ON COLUMN BARS.CCK_OB22_9.S3NP  IS 'БС+Об22~NEW_FEE~плюс S3 грн~від модф~MODIF' ; 
COMMENT ON COLUMN BARS.CCK_OB22_9.S3NM  IS 'БС+Об22~NEW_FEE~мінус S3 грн~від модф~MODIF';
COMMENT ON COLUMN BARS.CCK_OB22_9.S3VP  IS 'БС+Об22~NEW_FEE~плюс S3 вал~від модф~MODIF' ; 
COMMENT ON COLUMN BARS.CCK_OB22_9.S3VM  IS 'БС+Об22~NEW_FEE~мінус S3 вал~від модф~MODIF';
