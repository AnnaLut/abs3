

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_DAT.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_DAT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_DAT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_DAT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_DAT ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_DAT 
   (	RNK NUMBER, 
	ND NUMBER, 
	FDAT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_DAT ***
 exec bpa.alter_policies('FIN_DAT');


COMMENT ON TABLE BARS.FIN_DAT IS 'История изменения ';
COMMENT ON COLUMN BARS.FIN_DAT.RNK IS 'Код ';
COMMENT ON COLUMN BARS.FIN_DAT.ND IS 'Код ';
COMMENT ON COLUMN BARS.FIN_DAT.FDAT IS 'Звітна дата';




PROMPT *** Create  constraint XPK_FIN_DAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_DAT ADD CONSTRAINT XPK_FIN_DAT PRIMARY KEY (RNK, ND, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FIN_DAT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FIN_DAT ON BARS.FIN_DAT (RNK, ND, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_DAT ***
grant INSERT,SELECT,UPDATE                                                   on FIN_DAT         to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_DAT.sql =========*** End *** =====
PROMPT ===================================================================================== 
