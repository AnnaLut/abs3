

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_Target.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_Target ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''S6_Target'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_Target ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_Target 
   (	Id NUMBER(5,0), 
	Name VARCHAR2(80), 
	Bls NUMBER(5,0), 
	OsnSch NUMBER(5,0), 
	ANALIT NUMBER(3,0), 
	OB22 NUMBER(3,0), 
	D30 NUMBER(3,0), 
	S181 NUMBER(3,0), 
	Closed DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_Target ***
 exec bpa.alter_policies('S6_Target');


COMMENT ON TABLE BARS.S6_Target IS '';
COMMENT ON COLUMN BARS.S6_Target.Id IS '';
COMMENT ON COLUMN BARS.S6_Target.Name IS '';
COMMENT ON COLUMN BARS.S6_Target.Bls IS '';
COMMENT ON COLUMN BARS.S6_Target.OsnSch IS '';
COMMENT ON COLUMN BARS.S6_Target.ANALIT IS '';
COMMENT ON COLUMN BARS.S6_Target.OB22 IS '';
COMMENT ON COLUMN BARS.S6_Target.D30 IS '';
COMMENT ON COLUMN BARS.S6_Target.S181 IS '';
COMMENT ON COLUMN BARS.S6_Target.Closed IS '';




PROMPT *** Create  constraint SYS_C005916 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_Target MODIFY (Id NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_S6_Target ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_S6_Target ON BARS.S6_Target (Id) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  S6_Target ***
grant SELECT                                                                 on S6_Target       to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_Target.sql =========*** End *** ===
PROMPT ===================================================================================== 
