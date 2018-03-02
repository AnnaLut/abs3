
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

/*
begin EXECUTE IMMEDIATE 'ALTER TABLE BARS.CCK_OB22_9 ADD (  CONSTRAINT FK_CCKOB229  FOREIGN KEY (NBS,OB22)  REFERENCES BARS.CCK_OB22 (NBS,OB22) )' ;
exception when others then   if SQLCODE = -02275 then null;   else raise; end if;   -- ORA-02275: such a referential constraint already exists in the table
end;
/
*/

GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.CCK_OB22_9 TO BARS_ACCESS_DEFROLE;

COMMENT ON TABLE  BARS.CCK_OB22_9      IS  '������� (����-9) �� CCK_Ob22';
COMMENT ON COLUMN BARS.CCK_OB22_9.NBS  IS '��  ~���~';
COMMENT ON COLUMN BARS.CCK_OB22_9.OB22 IS 'ob22~���';

COMMENT ON COLUMN BARS.CCK_OB22_9.SDF  IS '��+��22~�/� �� ��������~FV_ADJ';
COMMENT ON COLUMN BARS.CCK_OB22_9.D6F  IS '��+��22~6 ��.�� ��������~FV_ADJ';    
COMMENT ON COLUMN BARS.CCK_OB22_9.D7F  IS '��+��22~7 ��.�� ��������~FV_ADJ';   

COMMENT ON COLUMN BARS.CCK_OB22_9.SDM  IS '��+��22~�/� �� �������~MODIF';
COMMENT ON COLUMN BARS.CCK_OB22_9.D6M  IS '��+��22~6 ��.�� �������~MODIF';     
COMMENT ON COLUMN BARS.CCK_OB22_9.D7M  IS '��+��22~7 ��.�� �������~MODIF'; 


COMMENT ON COLUMN BARS.CCK_OB22_9.SDA  IS '��+��22~�/� "��������"~ACCRUAL';
COMMENT ON COLUMN BARS.CCK_OB22_9.D6A  IS '��+��22~6 ��."��������"~ACCRUAL';   
COMMENT ON COLUMN BARS.CCK_OB22_9.D7A  IS '��+��22~7 ��."��������"~ACCRUAL';  

COMMENT ON COLUMN BARS.CCK_OB22_9.SDI  IS '��+��22~�/� "��������"~GENERAL';
COMMENT ON COLUMN BARS.CCK_OB22_9.D6I  IS '��+��22~6 ��."��������"~GENERAL';    
COMMENT ON COLUMN BARS.CCK_OB22_9.D7I  IS '��+��22~7 ��."��������"~GENERAL';   

COMMENT ON COLUMN BARS.CCK_OB22_9.SNA  IS '��+��22~������.���~AIRC_CCY'; 
COMMENT ON COLUMN BARS.CCK_OB22_9.N6A  IS '��+��22~6 ��.������.~AIRC_CCY';   
COMMENT ON COLUMN BARS.CCK_OB22_9.N7A  IS '��+��22~7 ��.������.~AIRC_CCY';  

COMMENT ON COLUMN BARS.CCK_OB22_9.SRR  IS '��+��22~������.~XLS'; 
COMMENT ON COLUMN BARS.CCK_OB22_9.R6R  IS '��+��22~6 ��.������.~XLS'; 
COMMENT ON COLUMN BARS.CCK_OB22_9.R7R  IS '��+��22~7 ��.������.~XLS'; 
