

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/LINES_I.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to LINES_I ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''LINES_I'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''LINES_I'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''LINES_I'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table LINES_I ***
begin 
  execute immediate '
  CREATE TABLE BARS.LINES_I 
   (	FN VARCHAR2(30), 
	DAT DATE, 
	N NUMBER, 
	ERR VARCHAR2(4), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to LINES_I ***
 exec bpa.alter_policies('LINES_I');


COMMENT ON TABLE BARS.LINES_I IS 'Информация о файлах @I (вторая квитанция)';
COMMENT ON COLUMN BARS.LINES_I.FN IS '';
COMMENT ON COLUMN BARS.LINES_I.DAT IS '';
COMMENT ON COLUMN BARS.LINES_I.N IS '';
COMMENT ON COLUMN BARS.LINES_I.ERR IS '';
COMMENT ON COLUMN BARS.LINES_I.KF IS '';




PROMPT *** Create  constraint CC_LINESI_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_I MODIFY (KF CONSTRAINT CC_LINESI_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_LINESI ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_I ADD CONSTRAINT PK_LINESI PRIMARY KEY (FN, DAT, N)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_LINESI ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_LINESI ON BARS.LINES_I (FN, DAT, N) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  LINES_I ***
grant SELECT                                                                 on LINES_I         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on LINES_I         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on LINES_I         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on LINES_I         to RPBN002;
grant SELECT                                                                 on LINES_I         to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on LINES_I         to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to LINES_I ***

  CREATE OR REPLACE PUBLIC SYNONYM LINES_I FOR BARS.LINES_I;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/LINES_I.sql =========*** End *** =====
PROMPT ===================================================================================== 
