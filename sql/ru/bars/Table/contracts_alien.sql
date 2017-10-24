

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CONTRACTS_ALIEN.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CONTRACTS_ALIEN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CONTRACTS_ALIEN'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CONTRACTS_ALIEN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CONTRACTS_ALIEN ***
begin 
  execute immediate '
  CREATE TABLE BARS.CONTRACTS_ALIEN 
   (	RNK NUMBER, 
	BENEFRNK NUMBER, 
	BENEFNAME VARCHAR2(50), 
	BENEFCOUNTRY NUMBER, 
	BENEFADR VARCHAR2(50), 
	BENEFBANK VARCHAR2(50), 
	BENEFACC VARCHAR2(50), 
	BENEFBIC CHAR(11), 
	BANK_CODE VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CONTRACTS_ALIEN ***
 exec bpa.alter_policies('CONTRACTS_ALIEN');


COMMENT ON TABLE BARS.CONTRACTS_ALIEN IS '�������� ��������. ���������� ������������-������������';
COMMENT ON COLUMN BARS.CONTRACTS_ALIEN.RNK IS '���.� �������-���������';
COMMENT ON COLUMN BARS.CONTRACTS_ALIEN.BENEFRNK IS '���.� �������-�����������';
COMMENT ON COLUMN BARS.CONTRACTS_ALIEN.BENEFNAME IS '������������ �������-�����������';
COMMENT ON COLUMN BARS.CONTRACTS_ALIEN.BENEFCOUNTRY IS '��� ������ �������-�����������';
COMMENT ON COLUMN BARS.CONTRACTS_ALIEN.BENEFADR IS '����� �����������';
COMMENT ON COLUMN BARS.CONTRACTS_ALIEN.BENEFBANK IS '���� �����������';
COMMENT ON COLUMN BARS.CONTRACTS_ALIEN.BENEFACC IS '���� �����������';
COMMENT ON COLUMN BARS.CONTRACTS_ALIEN.BENEFBIC IS 'BIC-��� ����� �����������';
COMMENT ON COLUMN BARS.CONTRACTS_ALIEN.BANK_CODE IS '��� ����� �����������';



PROMPT *** Create  grants  CONTRACTS_ALIEN ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CONTRACTS_ALIEN to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CONTRACTS_ALIEN.sql =========*** End *
PROMPT ===================================================================================== 
