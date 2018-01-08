

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EX_KL351.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EX_KL351 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EX_KL351'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''EX_KL351'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EX_KL351 ***
begin 
  execute immediate '
  CREATE TABLE BARS.EX_KL351 
   (	ACC NUMBER(*,0), 
	PAWN NUMBER(*,0), 
	KL_351 NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EX_KL351 ***
 exec bpa.alter_policies('EX_KL351');


COMMENT ON TABLE BARS.EX_KL351 IS 'Исключения из правил определения коэф. ликв. 351';
COMMENT ON COLUMN BARS.EX_KL351.ACC IS 'ACC счета';
COMMENT ON COLUMN BARS.EX_KL351.PAWN IS 'Вид залога';
COMMENT ON COLUMN BARS.EX_KL351.KL_351 IS 'Значение коеф. лікв.';
COMMENT ON COLUMN BARS.EX_KL351.KF IS '';




PROMPT *** Create  constraint PK_EX_KL351 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EX_KL351 ADD CONSTRAINT PK_EX_KL351 PRIMARY KEY (ACC, PAWN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EXKL351_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EX_KL351 MODIFY (KF CONSTRAINT CC_EXKL351_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_EX_KL351 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EX_KL351 ON BARS.EX_KL351 (ACC, PAWN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EX_KL351 ***
grant SELECT                                                                 on EX_KL351        to BARSREADER_ROLE;
grant SELECT                                                                 on EX_KL351        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EX_KL351        to RCC_DEAL;
grant SELECT                                                                 on EX_KL351        to START1;
grant SELECT                                                                 on EX_KL351        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EX_KL351.sql =========*** End *** ====
PROMPT ===================================================================================== 
