

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAN_KAT23_DEB.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAN_KAT23_DEB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAN_KAT23_DEB'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''STAN_KAT23_DEB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAN_KAT23_DEB ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAN_KAT23_DEB 
   (	KAT NUMBER(38,0), 
	NAME VARCHAR2(35), 
	K NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAN_KAT23_DEB ***
 exec bpa.alter_policies('STAN_KAT23_DEB');


COMMENT ON TABLE BARS.STAN_KAT23_DEB IS 'НБУ-23/5. Категорiя якостi для деб.заборг.';
COMMENT ON COLUMN BARS.STAN_KAT23_DEB.KAT IS 'Код';
COMMENT ON COLUMN BARS.STAN_KAT23_DEB.NAME IS 'Назва ';
COMMENT ON COLUMN BARS.STAN_KAT23_DEB.K IS 'пок.ризику деб.заборг.НБУ-23';




PROMPT *** Create  constraint CC_STANKAT23_D_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAN_KAT23_DEB MODIFY (NAME CONSTRAINT CC_STANKAT23_D_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STANKAT23_D_KAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAN_KAT23_DEB MODIFY (KAT CONSTRAINT CC_STANKAT23_D_KAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAN_KAT23_DEB ***
grant SELECT                                                                 on STAN_KAT23_DEB  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAN_KAT23_DEB  to RCC_DEAL;
grant SELECT                                                                 on STAN_KAT23_DEB  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAN_KAT23_DEB.sql =========*** End **
PROMPT ===================================================================================== 
