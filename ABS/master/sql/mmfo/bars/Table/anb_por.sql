

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ANB_POR.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ANB_POR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ANB_POR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ANB_POR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ANB_POR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ANB_POR ***
begin 
  execute immediate '
  CREATE TABLE BARS.ANB_POR 
   (	ID NUMBER(*,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ANB_POR ***
 exec bpa.alter_policies('ANB_POR');


COMMENT ON TABLE BARS.ANB_POR IS 'Шкалы концентрации сумм';
COMMENT ON COLUMN BARS.ANB_POR.ID IS 'Код Шкалы';
COMMENT ON COLUMN BARS.ANB_POR.NAME IS 'Наименование шкалы';




PROMPT *** Create  constraint XPK_ANB_POR ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANB_POR ADD CONSTRAINT XPK_ANB_POR PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ANB_POR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ANB_POR ON BARS.ANB_POR (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ANB_POR ***
grant SELECT                                                                 on ANB_POR         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ANB_POR         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ANB_POR         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ANB_POR         to RCC_DEAL;
grant SELECT                                                                 on ANB_POR         to SALGL;
grant SELECT                                                                 on ANB_POR         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ANB_POR         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ANB_POR.sql =========*** End *** =====
PROMPT ===================================================================================== 
