

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_GRP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_GRP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_GRP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_GRP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_GRP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_GRP ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_GRP 
   (	NAME VARCHAR2(70), 
	ORD NUMBER(*,0), 
	VK NUMBER(24,2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_GRP ***
 exec bpa.alter_policies('FIN_GRP');


COMMENT ON TABLE BARS.FIN_GRP IS 'Групи iнтеграцiї показникiв фiн.стану';
COMMENT ON COLUMN BARS.FIN_GRP.NAME IS 'Назва';
COMMENT ON COLUMN BARS.FIN_GRP.ORD IS '№ п/п';
COMMENT ON COLUMN BARS.FIN_GRP.VK IS 'вагомий коеф.групи';




PROMPT *** Create  index XPK_FIN_GRP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FIN_GRP ON BARS.FIN_GRP (ORD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_GRP ***
grant SELECT                                                                 on FIN_GRP         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_GRP         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_GRP         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_GRP         to R_FIN2;
grant SELECT                                                                 on FIN_GRP         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_GRP         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on FIN_GRP         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_GRP.sql =========*** End *** =====
PROMPT ===================================================================================== 
