

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_ND.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_ND ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_ND'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_ND'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_ND ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_ND 
   (	FDAT DATE, 
	IDF NUMBER(38,0), 
	KOD VARCHAR2(4), 
	S NUMBER(24,3), 
	ND NUMBER, 
	RNK NUMBER(*,0), 
	VAL_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_ND ***
 exec bpa.alter_policies('FIN_ND');


COMMENT ON TABLE BARS.FIN_ND IS '�i�.��i�� ��i���i�';
COMMENT ON COLUMN BARS.FIN_ND.FDAT IS '���� ��i��';
COMMENT ON COLUMN BARS.FIN_ND.IDF IS '�����';
COMMENT ON COLUMN BARS.FIN_ND.KOD IS '��� �����';
COMMENT ON COLUMN BARS.FIN_ND.S IS '�������� ��������';
COMMENT ON COLUMN BARS.FIN_ND.ND IS '��� ��';
COMMENT ON COLUMN BARS.FIN_ND.RNK IS '';
COMMENT ON COLUMN BARS.FIN_ND.VAL_DATE IS '����';




PROMPT *** Create  constraint XPK_FIN_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_ND ADD CONSTRAINT XPK_FIN_ND PRIMARY KEY (RNK, ND, IDF, KOD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FIN_ND ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FIN_ND ON BARS.FIN_ND (RNK, ND, IDF, KOD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_ND ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_ND          to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_ND          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_ND.sql =========*** End *** ======
PROMPT ===================================================================================== 
