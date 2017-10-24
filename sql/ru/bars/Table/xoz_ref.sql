exec bpa.alter_policy_info( 'XOZ_REF', 'WHOLE' , null, null, null, null ); 
exec bpa.alter_policy_info( 'XOZ_REF', 'FILIAL', null, null, null, null );

begin    execute immediate ' CREATE TABLE BARS.XOZ_REF(  
  ACC    NUMBER                                 NOT NULL,
  REF1   NUMBER                                 NOT NULL,
  STMT1  NUMBER                                 NOT NULL,
  REF2   NUMBER,
  MDATE  DATE,
  S      NUMBER,
  FDAT   DATE                                   NOT NULL,
  S0     NUMBER,
  NOTP   INTEGER,
  PRG    INTEGER,
  BU     VARCHAR2(30 BYTE),
  DATZ   DATE
) ';
exception when others then   if SQLCODE = - 00955 then null;   else raise; end if; 
--ORA-00955: name is already used by an existing object
end;
/
exec  bpa.alter_policies('XOZ_REF'); 

COMMENT ON TABLE  BARS.XOZ_REF       IS '��������� ��������� (������� �� ������� ��� ���.���)';
COMMENT ON COLUMN BARS.XOZ_REF.REF1  IS '�������� ���������� ���������  �����';
COMMENT ON COLUMN BARS.XOZ_REF.STMT1 IS 'stmt ���������� ���������  �����';
COMMENT ON COLUMN BARS.XOZ_REF.REF2  IS '�������� ����������������� ��� ������';
COMMENT ON COLUMN BARS.XOZ_REF.ACC   IS '������������� ����� ���������';
COMMENT ON COLUMN BARS.XOZ_REF.MDATE IS '����-���� ��������';
COMMENT ON COLUMN BARS.XOZ_REF.S     IS '����-���� ��������';
COMMENT ON COLUMN BARS.XOZ_REF.FDAT  IS '����-���� ����.���.';
COMMENT ON COLUMN BARS.XOZ_REF.S0    IS '���� �������� (�����)';
COMMENT ON COLUMN BARS.XOZ_REF.NOTP  IS '������� "���.���". 1 = � ���-23 �� ��������� ��������� �� ����, ��� ���������';
COMMENT ON COLUMN BARS.XOZ_REF.PRG   IS '��� �������';
COMMENT ON COLUMN BARS.XOZ_REF.BU    IS '��� �������� �������';
COMMENT ON COLUMN BARS.XOZ_REF.DATZ  IS '����� ���� �������� ���.���.';


-- 10.04.2017 COBUSUPABS-5555 - XOZ 
begin    execute immediate ' ALTER TABLE BARS.XOZ_ref add ( refd number)  ';
exception when others then   if SQLCODE = - 01430 then null;   else raise; end if; --ORA-01430: column being added already exists in table
end;
/
COMMENT ON COLUMN BARS.XOZ_REF.REFd  IS '�������� ���.������ �� �� �� �������� �������';


GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.XOZ_REF TO BARS_ACCESS_DEFROLE;

begin    execute immediate '  ALTER TABLE BARS.XOZ_REF ADD (  CONSTRAINT PK_XOZREF  PRIMARY KEY  (REF1, STMT1)) ';
exception when others then   if SQLCODE = - 02260 then null;   else raise; end if; --ORA-02260: table can have only one primary key
end;
/

begin   execute immediate 'ALTER TABLE BARS.XOZ_REF ADD ( CONSTRAINT FK_XOZREF_REF2 FOREIGN KEY (REF2) REFERENCES OPER (REF) DISABLE)';
exception when others then if SQLCODE = - 02275 then null; else raise; end if; -- ORA-02275: such a referential constraint already exists in the table
end;
/

begin    execute immediate ' ALTER TABLE BARS.xoz_ref ADD (  CONSTRAINT CC_xozref_ref2datz CHECK (REF2 IS NULL AND DATZ IS NULL 
                                                                     OR 
                                                                   REF2 IS NOT NULL AND DATZ IS NOT NULL
                                                           )
                             ENABLE VALIDATE
                             )';
exception when others then if SQLCODE = - 02264 then null; else raise; end if; -- ORA-02264: name already used by an existing constraint
end;
/

begin    execute immediate ' ALTER TABLE BARS.XOZ_REF ADD (  CONSTRAINT CC_XOZREF_FDAT_MDATE  CHECK (FDAT <= MDATe)   ENABLE VALIDATE) ' ;
exception when others then   if SQLCODE = - 02264 then null;   else raise; end if; --ORA-02264: name already used by an existing constraint
end;
/
------------------------------------------------------------------------------------