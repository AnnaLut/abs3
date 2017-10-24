

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_RNK_OKPO.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_RNK_OKPO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_RNK_OKPO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_RNK_OKPO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_RNK_OKPO ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_RNK_OKPO 
   (	RNK NUMBER(*,0), 
	OKPO VARCHAR2(14), 
	FIN NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_RNK_OKPO ***
 exec bpa.alter_policies('FIN_RNK_OKPO');


COMMENT ON TABLE BARS.FIN_RNK_OKPO IS '������������ ��������� �������� ���.�����';
COMMENT ON COLUMN BARS.FIN_RNK_OKPO.RNK IS '���';
COMMENT ON COLUMN BARS.FIN_RNK_OKPO.OKPO IS '����';
COMMENT ON COLUMN BARS.FIN_RNK_OKPO.FIN IS '���� �����������';




PROMPT *** Create  constraint PK_FIN_RNK_OKPO ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_RNK_OKPO ADD CONSTRAINT PK_FIN_RNK_OKPO PRIMARY KEY (RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FIN_RNK_OKPO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FIN_RNK_OKPO ON BARS.FIN_RNK_OKPO (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_RNK_OKPO ***
grant SELECT                                                                 on FIN_RNK_OKPO    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_RNK_OKPO    to RCC_DEAL;
grant SELECT                                                                 on FIN_RNK_OKPO    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_RNK_OKPO.sql =========*** End *** 
PROMPT ===================================================================================== 
