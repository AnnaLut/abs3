

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CM_SALARY_CARD.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CM_SALARY_CARD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CM_SALARY_CARD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CM_SALARY_CARD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CM_SALARY_CARD ***
begin 
  execute immediate '
  CREATE TABLE BARS.CM_SALARY_CARD 
   (	ID NUMBER(22,0), 
	CARD_CODE VARCHAR2(32), 
	CHG_DATE DATE DEFAULT sysdate, 
	CHG_USER VARCHAR2(64) DEFAULT user
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CM_SALARY_CARD ***
 exec bpa.alter_policies('CM_SALARY_CARD');


COMMENT ON TABLE BARS.CM_SALARY_CARD IS 'CardMake. ��������� ���� ���������� ��������';
COMMENT ON COLUMN BARS.CM_SALARY_CARD.ID IS '���������� ������������� �/� �������';
COMMENT ON COLUMN BARS.CM_SALARY_CARD.CARD_CODE IS '��� �����';
COMMENT ON COLUMN BARS.CM_SALARY_CARD.CHG_DATE IS '';
COMMENT ON COLUMN BARS.CM_SALARY_CARD.CHG_USER IS '';




PROMPT *** Create  constraint PK_CMSALARYCARD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_SALARY_CARD ADD CONSTRAINT PK_CMSALARYCARD PRIMARY KEY (ID, CARD_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CMSALARYCARD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CMSALARYCARD ON BARS.CM_SALARY_CARD (ID, CARD_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CM_SALARY_CARD ***
grant SELECT                                                                 on CM_SALARY_CARD  to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CM_SALARY_CARD  to CM_ACCESS_ROLE;
grant SELECT                                                                 on CM_SALARY_CARD  to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CM_SALARY_CARD.sql =========*** End **
PROMPT ===================================================================================== 
