

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_CUST.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_CUST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_CUST'', ''FILIAL'' , ''F'', ''F'', ''F'', ''F'');
               bpa.alter_policy_info(''FIN_CUST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_CUST ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_CUST 
   (	NMK VARCHAR2(38), 
	OKPO VARCHAR2(14), 
	CUSTTYPE NUMBER(*,0), 
	FZ CHAR(1), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	ISP NUMBER(*,0), 
	VED CHAR(5), 
	DATEA DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin 
execute immediate 'alter table FIN_CUST add branch varchar2(30)  DEFAULT sys_context(''bars_context'',''user_branch'')';
exception when others then       
  if sqlcode=-1430 then null; else raise; end if; 
end; 
/



PROMPT *** ALTER_POLICIES to FIN_CUST ***
 exec bpa.alter_policies('FIN_CUST');


COMMENT ON TABLE BARS.FIN_CUST IS '�������.������� � ������� ���.�����';
COMMENT ON COLUMN BARS.FIN_CUST.VED IS '���� ��������� �����������';
COMMENT ON COLUMN BARS.FIN_CUST.DATEA IS '';
COMMENT ON COLUMN BARS.FIN_CUST.NMK IS '������������ �������';
COMMENT ON COLUMN BARS.FIN_CUST.OKPO IS '����(��������) ��� ���';
COMMENT ON COLUMN BARS.FIN_CUST.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.FIN_CUST.FZ IS '����� ��i��=" " ��� M(���)';
COMMENT ON COLUMN BARS.FIN_CUST.BRANCH IS '';
COMMENT ON COLUMN BARS.FIN_CUST.ISP IS '�����.����������� � �����';




PROMPT *** Create  constraint FK_FIN_CUST_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_CUST ADD CONSTRAINT FK_FIN_CUST_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FINCUST_VED ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_CUST ADD CONSTRAINT FK_FINCUST_VED FOREIGN KEY (VED)
	  REFERENCES BARS.VED (VED) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_FIN_CUST ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_CUST ADD CONSTRAINT XPK_FIN_CUST PRIMARY KEY (OKPO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FIN_CUST_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_CUST MODIFY (BRANCH CONSTRAINT CC_FIN_CUST_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FIN_CUST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FIN_CUST ON BARS.FIN_CUST (OKPO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_CUST ***
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_CUST        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_CUST        to R_FIN2;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_CUST        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_CUST.sql =========*** End *** ====
PROMPT ===================================================================================== 
