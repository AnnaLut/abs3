

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REP_OTCHGRP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REP_OTCHGRP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REP_OTCHGRP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REP_OTCHGRP'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''REP_OTCHGRP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REP_OTCHGRP ***
begin 
  execute immediate '
  CREATE TABLE BARS.REP_OTCHGRP 
   (	OTCHGRP NUMBER, 
	NAME VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REP_OTCHGRP ***
 exec bpa.alter_policies('REP_OTCHGRP');


COMMENT ON TABLE BARS.REP_OTCHGRP IS 'Описание отчетных групп ';
COMMENT ON COLUMN BARS.REP_OTCHGRP.OTCHGRP IS '';
COMMENT ON COLUMN BARS.REP_OTCHGRP.NAME IS '';




PROMPT *** Create  constraint XPK_REP_OTCHGRP_OTCHGRP ***
begin   
 execute immediate '
  ALTER TABLE BARS.REP_OTCHGRP ADD CONSTRAINT XPK_REP_OTCHGRP_OTCHGRP PRIMARY KEY (OTCHGRP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_REP_OTCHGRP_OTCHGRP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_REP_OTCHGRP_OTCHGRP ON BARS.REP_OTCHGRP (OTCHGRP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REP_OTCHGRP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on REP_OTCHGRP     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REP_OTCHGRP     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on REP_OTCHGRP     to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REP_OTCHGRP.sql =========*** End *** =
PROMPT ===================================================================================== 
