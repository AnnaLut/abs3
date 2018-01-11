

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ANB_POROG.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ANB_POROG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ANB_POROG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ANB_POROG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ANB_POROG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ANB_POROG ***
begin 
  execute immediate '
  CREATE TABLE BARS.ANB_POROG 
   (	ID NUMBER(*,0), 
	S NUMBER, 
	S2 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ANB_POROG ***
 exec bpa.alter_policies('ANB_POROG');


COMMENT ON TABLE BARS.ANB_POROG IS 'Шкалы и пороги концентрации сумм';
COMMENT ON COLUMN BARS.ANB_POROG.ID IS 'Код Шкалы';
COMMENT ON COLUMN BARS.ANB_POROG.S IS 'Пороговая сумма-1';
COMMENT ON COLUMN BARS.ANB_POROG.S2 IS 'Пороговая сумма-2';




PROMPT *** Create  constraint XPK_ANB_POROG ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANB_POROG ADD CONSTRAINT XPK_ANB_POROG PRIMARY KEY (ID, S)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ANB_POROG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ANB_POROG ON BARS.ANB_POROG (ID, S) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ANB_POROG ***
grant SELECT                                                                 on ANB_POROG       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ANB_POROG       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ANB_POROG       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ANB_POROG       to RCC_DEAL;
grant SELECT                                                                 on ANB_POROG       to RPBN001;
grant SELECT                                                                 on ANB_POROG       to SALGL;
grant SELECT                                                                 on ANB_POROG       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ANB_POROG       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ANB_POROG.sql =========*** End *** ===
PROMPT ===================================================================================== 
