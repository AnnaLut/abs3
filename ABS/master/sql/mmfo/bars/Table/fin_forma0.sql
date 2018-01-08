

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_FORMA0.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_FORMA0 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_FORMA0'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_FORMA0'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_FORMA0'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_FORMA0 ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_FORMA0 
   (	NAME VARCHAR2(70), 
	ORD NUMBER(*,0), 
	KOD CHAR(3), 
	POB NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_FORMA0 ***
 exec bpa.alter_policies('FIN_FORMA0');


COMMENT ON TABLE BARS.FIN_FORMA0 IS 'Заг.iнформац. пр позичальника';
COMMENT ON COLUMN BARS.FIN_FORMA0.NAME IS 'Стаття';
COMMENT ON COLUMN BARS.FIN_FORMA0.ORD IS '№ п/п';
COMMENT ON COLUMN BARS.FIN_FORMA0.KOD IS 'Код';
COMMENT ON COLUMN BARS.FIN_FORMA0.POB IS 'Приз.~обов.';




PROMPT *** Create  constraint XPK_FIN_FORMA0 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_FORMA0 ADD CONSTRAINT XPK_FIN_FORMA0 PRIMARY KEY (ORD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FIN_FORMA0 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FIN_FORMA0 ON BARS.FIN_FORMA0 (ORD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_FORMA0 ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_FORMA0      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_FORMA0      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_FORMA0      to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_FORMA0      to R_FIN2;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_FORMA0      to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on FIN_FORMA0      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_FORMA0.sql =========*** End *** ==
PROMPT ===================================================================================== 
