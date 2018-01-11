

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_ChargePr.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_ChargePr ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''S6_ChargePr'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_ChargePr ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_ChargePr 
   (	NLS VARCHAR2(25), 
	GROUP_U NUMBER(10,0), 
	I_VA NUMBER(5,0), 
	PercenRate NUMBER(10,0), 
	DA DATE, 
	SERV_I_VA NUMBER(5,0), 
	SERV_DB_S VARCHAR2(25), 
	SERV_KR_S VARCHAR2(25)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_ChargePr ***
 exec bpa.alter_policies('S6_ChargePr');


COMMENT ON TABLE BARS.S6_ChargePr IS '';
COMMENT ON COLUMN BARS.S6_ChargePr.NLS IS '';
COMMENT ON COLUMN BARS.S6_ChargePr.GROUP_U IS '';
COMMENT ON COLUMN BARS.S6_ChargePr.I_VA IS '';
COMMENT ON COLUMN BARS.S6_ChargePr.PercenRate IS '';
COMMENT ON COLUMN BARS.S6_ChargePr.DA IS '';
COMMENT ON COLUMN BARS.S6_ChargePr.SERV_I_VA IS '';
COMMENT ON COLUMN BARS.S6_ChargePr.SERV_DB_S IS '';
COMMENT ON COLUMN BARS.S6_ChargePr.SERV_KR_S IS '';




PROMPT *** Create  constraint SYS_C005753 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_ChargePr MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005754 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_ChargePr MODIFY (GROUP_U NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005755 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_ChargePr MODIFY (I_VA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005756 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_ChargePr MODIFY (PercenRate NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005757 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_ChargePr MODIFY (DA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_S6_ChargePr ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_S6_ChargePr ON BARS.S6_ChargePr (NLS, I_VA) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  S6_ChargePr ***
grant SELECT                                                                 on S6_ChargePr     to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_ChargePr.sql =========*** End *** =
PROMPT ===================================================================================== 
