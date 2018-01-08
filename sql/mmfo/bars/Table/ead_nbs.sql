

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EAD_NBS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EAD_NBS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EAD_NBS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EAD_NBS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EAD_NBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.EAD_NBS 
   (	NBS CHAR(4), 
	CUSTTYPE NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EAD_NBS ***
 exec bpa.alter_policies('EAD_NBS');


COMMENT ON TABLE BARS.EAD_NBS IS 'Балансові рахунки для синхронізації з ЕА';
COMMENT ON COLUMN BARS.EAD_NBS.NBS IS 'Балансовий рахунок до відправки';
COMMENT ON COLUMN BARS.EAD_NBS.CUSTTYPE IS 'Групування для різних типів клієнта';




PROMPT *** Create  constraint SYS_C00109345 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_NBS MODIFY (NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109346 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_NBS MODIFY (CUSTTYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_EADNBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EADNBS ON BARS.EAD_NBS (NBS, CUSTTYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EAD_NBS ***
grant SELECT                                                                 on EAD_NBS         to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EAD_NBS.sql =========*** End *** =====
PROMPT ===================================================================================== 
