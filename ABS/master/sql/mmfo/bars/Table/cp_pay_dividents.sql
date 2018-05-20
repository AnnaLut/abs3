

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_PAY_DIVIDENTS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_PAY_dividents ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_PAY_DIVIDENTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_PAY_DIVIDENTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_PAY_DIVIDENTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_PAY_DIVIDENTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_PAY_DIVIDENTS 
   (	REF     NUMBER, 
	USER_ID NUMBER DEFAULT sys_context(''bars_global'',''user_id'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_PAY_DIVIDENTS ***
 exec bpa.alter_policies('CP_PAY_DIVIDENTS');


COMMENT ON TABLE BARS.CP_PAY_DIVIDENTS IS '��� ������� �������� �� ���� ��';
COMMENT ON COLUMN BARS.CP_PAY_DIVIDENTS.REF IS 'REF �����';
COMMENT ON COLUMN BARS.CP_PAY_DIVIDENTS.USER_ID IS '����������';

begin   
 execute immediate 'create unique index UK_CP_PAY_DIVIDENTS ON CP_PAY_DIVIDENTS ( USER_ID, REF ) tablespace brssmli ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint CC_CP_PAY_DIVIDENTS_REF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_PAY_DIVIDENTS ADD CONSTRAINT CC_CP_PAY_DIVIDENTS_REF CHECK (REF is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_CP_PAY_DIVIDENTS_USER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_PAY_DIVIDENTS ADD CONSTRAINT CC_CP_PAY_DIVIDENTS_USER CHECK (USER_ID is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  CP_PAY_DIVIDENTS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_PAY_DIVIDENTS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_PAY_DIVIDENTS     to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_PAY_DIVIDENTS.sql =========*** End *** =
PROMPT ===================================================================================== 
