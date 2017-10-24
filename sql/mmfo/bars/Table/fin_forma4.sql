

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_FORMA4.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_FORMA4 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_FORMA4'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_FORMA4'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_FORMA4'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_FORMA4 ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_FORMA4 
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




PROMPT *** ALTER_POLICIES to FIN_FORMA4 ***
 exec bpa.alter_policies('FIN_FORMA4');


COMMENT ON TABLE BARS.FIN_FORMA4 IS 'Додатковi данi про "Кредит"';
COMMENT ON COLUMN BARS.FIN_FORMA4.NAME IS 'Стаття';
COMMENT ON COLUMN BARS.FIN_FORMA4.ORD IS '№ п/п';
COMMENT ON COLUMN BARS.FIN_FORMA4.KOD IS 'Код';
COMMENT ON COLUMN BARS.FIN_FORMA4.POB IS 'Приз.~обов.';




PROMPT *** Create  constraint XPK_FIN_FORMA4 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_FORMA4 ADD CONSTRAINT XPK_FIN_FORMA4 PRIMARY KEY (ORD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FIN_FORMA4 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FIN_FORMA4 ON BARS.FIN_FORMA4 (ORD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_FORMA4 ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_FORMA4      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_FORMA4      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_FORMA4      to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_FORMA4      to R_FIN2;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_FORMA4      to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on FIN_FORMA4      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_FORMA4.sql =========*** End *** ==
PROMPT ===================================================================================== 
