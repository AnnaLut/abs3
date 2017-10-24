

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RNK_ND_PORT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RNK_ND_PORT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RNK_ND_PORT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''RNK_ND_PORT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RNK_ND_PORT ***
begin 
  execute immediate '
  CREATE TABLE BARS.RNK_ND_PORT 
   (	TIP VARCHAR2(4), 
	RNK NUMBER(*,0), 
	ND NUMBER(*,0), 
	S250 NUMBER(*,0), 
	GRP NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RNK_ND_PORT ***
 exec bpa.alter_policies('RNK_ND_PORT');


COMMENT ON TABLE BARS.RNK_ND_PORT IS '����������� �����';
COMMENT ON COLUMN BARS.RNK_ND_PORT.TIP IS '��� ������';
COMMENT ON COLUMN BARS.RNK_ND_PORT.RNK IS '���';
COMMENT ON COLUMN BARS.RNK_ND_PORT.ND IS '���.���������';
COMMENT ON COLUMN BARS.RNK_ND_PORT.S250 IS '����������� �����';
COMMENT ON COLUMN BARS.RNK_ND_PORT.GRP IS '������ ������������ ������';




PROMPT *** Create  constraint PK_RNK_ND_PORT ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNK_ND_PORT ADD CONSTRAINT PK_RNK_ND_PORT PRIMARY KEY (RNK, ND, TIP, GRP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_RNK_ND_PORT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_RNK_ND_PORT ON BARS.RNK_ND_PORT (RNK, ND, TIP, GRP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RNK_ND_PORT ***
grant SELECT                                                                 on RNK_ND_PORT     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RNK_ND_PORT     to RCC_DEAL;
grant SELECT                                                                 on RNK_ND_PORT     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RNK_ND_PORT.sql =========*** End *** =
PROMPT ===================================================================================== 
