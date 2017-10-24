

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_FEES.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_FEES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_FEES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INS_FEES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_FEES ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_FEES 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(300), 
	MIN_VALUE NUMBER, 
	PERC_VALUE NUMBER, 
	MAX_VALUE NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_FEES ***
 exec bpa.alter_policies('INS_FEES');


COMMENT ON TABLE BARS.INS_FEES IS '���� ����� �� ��������� �����������';
COMMENT ON COLUMN BARS.INS_FEES.ID IS '�������������';
COMMENT ON COLUMN BARS.INS_FEES.NAME IS '������������';
COMMENT ON COLUMN BARS.INS_FEES.MIN_VALUE IS '̳������� ����';
COMMENT ON COLUMN BARS.INS_FEES.PERC_VALUE IS '�������';
COMMENT ON COLUMN BARS.INS_FEES.MAX_VALUE IS '����������� ����';




PROMPT *** Create  constraint PK_INSFEES ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_FEES ADD CONSTRAINT PK_INSFEES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003101167 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_FEES MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INSFEES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INSFEES ON BARS.INS_FEES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INS_FEES ***
grant SELECT                                                                 on INS_FEES        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_FEES.sql =========*** End *** ====
PROMPT ===================================================================================== 
