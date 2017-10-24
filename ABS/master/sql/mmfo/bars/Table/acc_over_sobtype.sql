

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC_OVER_SOBTYPE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_OVER_SOBTYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACC_OVER_SOBTYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ACC_OVER_SOBTYPE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ACC_OVER_SOBTYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC_OVER_SOBTYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACC_OVER_SOBTYPE 
   (	ID NUMBER, 
	TXT VARCHAR2(150)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACC_OVER_SOBTYPE ***
 exec bpa.alter_policies('ACC_OVER_SOBTYPE');


COMMENT ON TABLE BARS.ACC_OVER_SOBTYPE IS 'Типы событий по договорам овердрафта';
COMMENT ON COLUMN BARS.ACC_OVER_SOBTYPE.ID IS 'Код события';
COMMENT ON COLUMN BARS.ACC_OVER_SOBTYPE.TXT IS 'Наименование события';




PROMPT *** Create  constraint XPK_ACC_OVER_SOBTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_SOBTYPE ADD CONSTRAINT XPK_ACC_OVER_SOBTYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ACC_OVER_SOBTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ACC_OVER_SOBTYPE ON BARS.ACC_OVER_SOBTYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACC_OVER_SOBTYPE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_SOBTYPE to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_SOBTYPE to BARS009;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_SOBTYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_OVER_SOBTYPE to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_SOBTYPE to TECH005;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_SOBTYPE to TECH006;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACC_OVER_SOBTYPE to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to ACC_OVER_SOBTYPE ***

  CREATE OR REPLACE PUBLIC SYNONYM ACC_OVER_SOBTYPE FOR BARS.ACC_OVER_SOBTYPE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC_OVER_SOBTYPE.sql =========*** End 
PROMPT ===================================================================================== 
