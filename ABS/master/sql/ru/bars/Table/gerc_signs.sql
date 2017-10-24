-- ======================================================================================
-- Module : GERC_PAYMENTS
-- Author : inga
-- Date   : 26.01.2016
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED
SET DEFINE ON

@defs;

begin
  bpa.alter_policy_info( 'GERC_SIGNS', 'WHOLE',  null, null, null, null ); 
  bpa.alter_policy_info( 'GERC_SIGNS', 'FILIAL', null, null, null, null );
end;
/

begin
execute immediate 
  'CREATE TABLE BARS.GERC_SIGNS
    (  REC_DATE             DATE DEFAULT SYSDATE,
       ExternalDocumentId   VARCHAR2 (32)    NOT NULL,   
       Buffer               varchar2 (4000 BYTE),   
       DigitalSignature     CLOB,
       ValidationStatus     varchar2 (10)      
    ) TABLESPACE &tbs_mdl';
    exception
  when others then
    if sqlcode = -955 then null;
    else raise;
    end if;  
end;
/

COMMENT ON TABLE  BARS.GERC_SIGNS                       IS '��������, �����, ������� �� ���� ��� ���������';
COMMENT ON COLUMN BARS.GERC_SIGNS.REC_DATE              IS '���� ���������';
COMMENT ON COLUMN BARS.GERC_SIGNS.ExternalDocumentId    IS '������������� ��������� � ������ ����';
COMMENT ON COLUMN BARS.GERC_SIGNS.Buffer                IS '����� (������������ � ���)';
COMMENT ON COLUMN BARS.GERC_SIGNS.DigitalSignature      IS '�������� ����� vega2';
COMMENT ON COLUMN BARS.GERC_SIGNS.ValidationStatus      IS '������ ��������� � �������';

GRANT ALL ON BARS.GERC_SIGNS TO BARS_ACCESS_DEFROLE;
/



