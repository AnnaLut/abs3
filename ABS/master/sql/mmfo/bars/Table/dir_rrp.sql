

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DIR_RRP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DIR_RRP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DIR_RRP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DIR_RRP'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DIR_RRP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DIR_RRP ***
begin 
  execute immediate '
  CREATE TABLE BARS.DIR_RRP 
   (	KODN NUMBER(*,0), 
	NAME VARCHAR2(35), 
	MAXDOC NUMBER(*,0), 
	 CONSTRAINT PK_DIRRRP PRIMARY KEY (KODN) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DIR_RRP ***
 exec bpa.alter_policies('DIR_RRP');


COMMENT ON TABLE BARS.DIR_RRP IS 'Справочник направлений (РРП)';
COMMENT ON COLUMN BARS.DIR_RRP.KODN IS 'Код направления';
COMMENT ON COLUMN BARS.DIR_RRP.NAME IS 'Наименование кода направления';
COMMENT ON COLUMN BARS.DIR_RRP.MAXDOC IS '';




PROMPT *** Create  constraint CC_DIRRRP_KODN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DIR_RRP MODIFY (KODN CONSTRAINT CC_DIRRRP_KODN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DIRRRP ***
begin   
 execute immediate '
  ALTER TABLE BARS.DIR_RRP ADD CONSTRAINT PK_DIRRRP PRIMARY KEY (KODN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DIRRRP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DIRRRP ON BARS.DIR_RRP (KODN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DIR_RRP ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DIR_RRP         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DIR_RRP         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DIR_RRP         to DIR_RRP;
grant DELETE,INSERT,SELECT,UPDATE                                            on DIR_RRP         to SEP_ROLE;
grant SELECT                                                                 on DIR_RRP         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DIR_RRP         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DIR_RRP         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DIR_RRP.sql =========*** End *** =====
PROMPT ===================================================================================== 
