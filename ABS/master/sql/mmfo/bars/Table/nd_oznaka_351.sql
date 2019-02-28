PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ND_OZNAKA_351.sql =========*** Run *** =====
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to ND_OZNAKA_351 ***

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ND_OZNAKA_351'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ND_OZNAKA_351'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ND_OZNAKA_351 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ND_OZNAKA_351 
      (	KF   VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''),
        ND   INTEGER,
        ID   INTEGER, 
	kod  varchar2(9) 
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to ND_OZNAKA_351 ***
 exec bpa.alter_policies('ND_OZNAKA_351');

COMMENT ON TABLE BARS.ND_OZNAKA_351 IS 'Ознака відповідно до положення 351';
COMMENT ON COLUMN BARS.ND_OZNAKA_351.ID IS 'ID ознаки';
COMMENT ON COLUMN BARS.ND_OZNAKA_351.kod IS 'Код ознаки';

PROMPT *** Create  constraint PK_ND_OZNAKA_351 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_OZNAKA_351 ADD CONSTRAINT PK_ND_OZNAKA_351 PRIMARY KEY (nd, id, kod)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

--PROMPT *** Create  index PK_ND_OZNAKA_351 ***
--begin   
-- execute immediate '
--  CREATE UNIQUE INDEX BARS.PK_ND_OZNAKA_351 ON BARS.ND_OZNAKA_351 (NBS) 
--  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
--  TABLESPACE BRSDYND ';
--exception when others then
--  if  sqlcode=-955  then null; else raise; end if;
-- end;
--/

PROMPT *** Create  grants  ND_OZNAKA_351 ***
grant SELECT                                                                 on ND_OZNAKA_351         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ND_OZNAKA_351         to RCC_DEAL;
grant SELECT                                                                 on ND_OZNAKA_351         to START1;
grant SELECT                                                                 on ND_OZNAKA_351         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ND_OZNAKA_351.sql =========*** End *** =====
PROMPT ===================================================================================== 
