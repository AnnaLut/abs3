

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PM_RRP.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PM_RRP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PM_RRP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PM_RRP'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PM_RRP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PM_RRP ***
begin 
  execute immediate '
  CREATE TABLE BARS.PM_RRP 
   (	PM NUMBER(*,0), 
	NAME VARCHAR2(35), 
	 CONSTRAINT PK_PMRRP PRIMARY KEY (PM) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PM_RRP ***
 exec bpa.alter_policies('PM_RRP');


COMMENT ON TABLE BARS.PM_RRP IS 'Методы проплаты документов РРП';
COMMENT ON COLUMN BARS.PM_RRP.PM IS 'Метод оплаты (0 - подокументно, 1 - пакетно по заголовкам)';
COMMENT ON COLUMN BARS.PM_RRP.NAME IS 'Наименование метода';




PROMPT *** Create  constraint CC_PMRRP_PM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PM_RRP MODIFY (PM CONSTRAINT CC_PMRRP_PM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PMRRP ***
begin   
 execute immediate '
  ALTER TABLE BARS.PM_RRP ADD CONSTRAINT PK_PMRRP PRIMARY KEY (PM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PMRRP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PMRRP ON BARS.PM_RRP (PM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PM_RRP ***
grant SELECT                                                                 on PM_RRP          to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PM_RRP          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PM_RRP          to PM_RRP;
grant DELETE,INSERT,SELECT,UPDATE                                            on PM_RRP          to SEP_ROLE;
grant SELECT                                                                 on PM_RRP          to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PM_RRP          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on PM_RRP          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PM_RRP.sql =========*** End *** ======
PROMPT ===================================================================================== 
