

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_POK.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_POK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_POK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_POK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_POK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_POK ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_POK 
   (	NAME VARCHAR2(70), 
	ORD NUMBER(*,0), 
	POK VARCHAR2(10), 
	GRP NUMBER(*,0), 
	VZ NUMBER(24,2), 
	TZ VARCHAR2(40)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_POK ***
 exec bpa.alter_policies('FIN_POK');


COMMENT ON TABLE BARS.FIN_POK IS 'Показники  фiн.-госп. дiяльностi';
COMMENT ON COLUMN BARS.FIN_POK.NAME IS 'Назва';
COMMENT ON COLUMN BARS.FIN_POK.ORD IS '№ п/п';
COMMENT ON COLUMN BARS.FIN_POK.POK IS 'Код';
COMMENT ON COLUMN BARS.FIN_POK.GRP IS 'Група интеграции';
COMMENT ON COLUMN BARS.FIN_POK.VZ IS 'Вагоме знач';
COMMENT ON COLUMN BARS.FIN_POK.TZ IS 'Теорет знач';




PROMPT *** Create  constraint XPK_FIN_POK ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_POK ADD CONSTRAINT XPK_FIN_POK PRIMARY KEY (ORD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FIN_POK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FIN_POK ON BARS.FIN_POK (ORD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_POK ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_POK         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_POK         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_POK         to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_POK         to R_FIN2;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_POK         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on FIN_POK         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_POK.sql =========*** End *** =====
PROMPT ===================================================================================== 
