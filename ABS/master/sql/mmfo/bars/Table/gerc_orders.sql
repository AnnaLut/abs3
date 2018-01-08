-- ======================================================================================
-- Module : GERC_PAYMENTS
-- Author : inga
-- Date   : 16.12.2015
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED
SET DEFINE ON

begin
  bpa.alter_policy_info( 'GERC_ORDERS', 'WHOLE',  null, null, null, null ); 
  bpa.alter_policy_info( 'GERC_ORDERS', 'FILIAL', null, null, null, null );
end;
/

begin
execute immediate 
  'CREATE TABLE BARS.GERC_ORDERS
    (  REF                  NUMBER,
       DocumentNumber       VARCHAR2(10) DEFAULT NULL,              
       OperationType        CHAR(3)      ,
       DocumentType         NUMBER       ,  
       DocumentDate         DATE       ,  
       DebitMfo             VARCHAR2 (12 Byte)       ,  
       CreditMfo            VARCHAR2 (12 Byte)       ,  
       DebitAccount         VARCHAR2 (15)   ,
       CreditAccount        VARCHAR2 (15)   ,
       DebitName            VARCHAR2 (38)   ,
       CreditName           VARCHAR2 (38)   ,
       DebitEdrpou          VARCHAR2 (14)   ,
       CreditEdrpou         VARCHAR2 (14)   ,
       Amount               NUMBER,
       Currency             CHAR(3),
       Purpose              VARCHAR2 (160),
       CashSymbol           NUMBER (2),
       DebitFlag            NUMBER (1),
       AdditionalRequisites VARCHAR2 (60 Byte),
       DigitalSignature     VARCHAR2 (4000 BYTE),
       DocumentAuthor       VARCHAR2 (100),
       Branch               VARCHAR2 (30 Byte),
       ExternalDocumentId   VARCHAR2 (32)    ,   
       REQ_MESSAGE          VARCHAR2 (400)
    ) TABLESPACE BRSBIGD';
    exception
  when others then
    if sqlcode = -955 then null;
    else raise;
    end if;  
end;
/

BEGIN
 EXECUTE IMMEDIATE 'ALTER TABLE GERC_ORDERS ADD ( 
       CONSTRAINT FK_GERC_OPRDERS_TTS           FOREIGN KEY (OperationType) REFERENCES TTS (TT), 
       CONSTRAINT FK_GERC_OPRDERS_BRANCH        FOREIGN KEY (BRANCH) REFERENCES BRANCH (BRANCH),
       CONSTRAINT FK_GERC_OPRDERS_DOCUMENTTYPE  FOREIGN KEY (DOCUMENTTYPE) REFERENCES VOB (VOB),
       CONSTRAINT FK_GERC_OPRDERS_DebitMfo      FOREIGN KEY (DebitMfo) REFERENCES BANKS$BASE (MFO),
       CONSTRAINT FK_GERC_OPRDERS_CreditMfo     FOREIGN KEY (CreditMfo) REFERENCES BANKS$BASE (MFO),
       CONSTRAINT FK_GERC_OPRDERS_DebitFlag     FOREIGN KEY (DebitFlag) REFERENCES DK (DK)
       )';
EXCEPTION WHEN OTHERS THEN IF (SQLCODE = -02275) THEN NULL; END IF;
END;
/

begin
 execute immediate 'alter table GERC_ORDERS add (our_buffer varchar2(4000), gerc_sign varchar2(4000))';
exception when others then if (sqlcode = -1430) then null; end if;
end;
/

begin   
 execute immediate 'ALTER TABLE GERC_ORDERS ADD CONSTRAINT CC_GERC_ORDERS_EXTID_NN CHECK (EXTERNALDOCUMENTID IS NOT NULL) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

/*
begin
  execute immediate 'CREATE INDEX BARS.IDX_GERC_ORDERS_EXTID ON BARS.GERC_ORDERS (EXTERNALDOCUMENTID) TABLESPACE brsmdli';
exception
  when others then
    if sqlcode = -01408 or sqlcode = -955 then null;
    else raise;
    end if;  
end;
/
*/
begin
    execute immediate 'drop index IDX_GERC_ORDERS_EXTID';
 exception when others then 
    if sqlcode = -1418 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'create unique index UIDX_GERC_ORDERS_EXTID on GERC_ORDERS (EXTERNALDOCUMENTID)
                       tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


COMMENT ON TABLE  BARS.GERC_ORDERS                  IS '��������, �������� �� ����';
COMMENT ON COLUMN BARS.GERC_ORDERS.DocumentNumber   IS '����� ���������';
COMMENT ON COLUMN BARS.GERC_ORDERS.OperationType    IS '��� �������� (������ ��������, �� ������ �������� ��� ��������� ����� ����� ���-����� �� �� ���������, �� ���� ��������� � ������)';
COMMENT ON COLUMN BARS.GERC_ORDERS.DocumentType     IS '��� ��������� (1-��. ���������, 6-���.�����)';
COMMENT ON COLUMN BARS.GERC_ORDERS.DocumentDate     IS '���� ���������';
COMMENT ON COLUMN BARS.GERC_ORDERS.DebitMfo         IS '��� ����������';
COMMENT ON COLUMN BARS.GERC_ORDERS.CreditMfo        IS '��� ����������';
COMMENT ON COLUMN BARS.GERC_ORDERS.DebitAccount     IS '������� ����������';
COMMENT ON COLUMN BARS.GERC_ORDERS.CreditAccount    IS '������� ����������';
COMMENT ON COLUMN BARS.GERC_ORDERS.DebitName        IS '����� ������� ����������';
COMMENT ON COLUMN BARS.GERC_ORDERS.CreditName       IS '����� ������� ����������';
COMMENT ON COLUMN BARS.GERC_ORDERS.DebitEdrpou      IS '������ ����������';
COMMENT ON COLUMN BARS.GERC_ORDERS.CreditEdrpou     IS '������ ����������';
COMMENT ON COLUMN BARS.GERC_ORDERS.Amount           IS '���� �������� � ���.';
COMMENT ON COLUMN BARS.GERC_ORDERS.Currency         IS '��� ������ � ������ ISO (UAH)';
COMMENT ON COLUMN BARS.GERC_ORDERS.Purpose          IS '����������� �������';
COMMENT ON COLUMN BARS.GERC_ORDERS.CashSymbol       IS '������ �������� �����';
COMMENT ON COLUMN BARS.GERC_ORDERS.DebitFlag        IS '������ �����/������ (0-��., 1-��.)';
COMMENT ON COLUMN BARS.GERC_ORDERS.AdditionalRequisites IS '�������� �������� ���';
COMMENT ON COLUMN BARS.GERC_ORDERS.DigitalSignature     IS '�������� ����� (����� �� ���������������)';
COMMENT ON COLUMN BARS.GERC_ORDERS.DocumentAuthor       IS '���� ����������� ���, �� ���� ����� ���� �������� ��������';
COMMENT ON COLUMN BARS.GERC_ORDERS.Branch               IS '��� �������� � ���';
COMMENT ON COLUMN BARS.GERC_ORDERS.ExternalDocumentId   IS '������������� ��������� � ������ ����';
COMMENT ON COLUMN BARS.GERC_ORDERS.REQ_MESSAGE          IS '��������� ��� ���������';
COMMENT ON COLUMN BARS.GERC_ORDERS.REQ_MESSAGE          IS '��������� ��� ���������';
COMMENT ON COLUMN BARS.GERC_ORDERS.our_buffer           IS '��� ����� ��� ���������';
COMMENT ON COLUMN BARS.GERC_ORDERS.gerc_sign            IS '������� ���� ��� ���������';


GRANT ALL ON BARS.GERC_ORDERS TO BARS_ACCESS_DEFROLE;
/

