

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SP_S200.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SP_S200 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SP_S200'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SP_S200'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SP_S200'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SP_S200 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SP_S200 
   (	S200 VARCHAR2(1), 
	TXT VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SP_S200 ***
 exec bpa.alter_policies('SP_S200');


COMMENT ON TABLE BARS.SP_S200 IS '';
COMMENT ON COLUMN BARS.SP_S200.S200 IS 'Код источника кредитования';
COMMENT ON COLUMN BARS.SP_S200.TXT IS 'Наименование';




PROMPT *** Create  constraint XPK_SP_S200 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SP_S200 ADD CONSTRAINT XPK_SP_S200 PRIMARY KEY (S200)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_SP_S200 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_SP_S200 ON BARS.SP_S200 (S200) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SP_S200 ***
grant SELECT                                                                 on SP_S200         to BARSREADER_ROLE;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on SP_S200         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SP_S200         to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on SP_S200         to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on SP_S200         to SP_S200;
grant SELECT                                                                 on SP_S200         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SP_S200         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SP_S200         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SP_S200.sql =========*** End *** =====
PROMPT ===================================================================================== 
