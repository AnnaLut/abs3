

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBS_PRINT_BANK.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBS_PRINT_BANK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBS_PRINT_BANK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''NBS_PRINT_BANK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NBS_PRINT_BANK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBS_PRINT_BANK ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBS_PRINT_BANK 
   (	NBS CHAR(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBS_PRINT_BANK ***
 exec bpa.alter_policies('NBS_PRINT_BANK');


COMMENT ON TABLE BARS.NBS_PRINT_BANK IS 'Балансові рахунки по яких друкувати Назву банку';
COMMENT ON COLUMN BARS.NBS_PRINT_BANK.NBS IS 'Балансовий рахунок';




PROMPT *** Create  constraint PK_NBS_PRINT_BANK ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_PRINT_BANK ADD CONSTRAINT PK_NBS_PRINT_BANK PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBS_PRINT_BANK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_PRINT_BANK MODIFY (NBS CONSTRAINT CC_NBS_PRINT_BANK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NBS_PRINT_BANK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NBS_PRINT_BANK ON BARS.NBS_PRINT_BANK (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBS_PRINT_BANK ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NBS_PRINT_BANK  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBS_PRINT_BANK  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on NBS_PRINT_BANK  to START1;
grant FLASHBACK,SELECT                                                       on NBS_PRINT_BANK  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBS_PRINT_BANK.sql =========*** End **
PROMPT ===================================================================================== 
