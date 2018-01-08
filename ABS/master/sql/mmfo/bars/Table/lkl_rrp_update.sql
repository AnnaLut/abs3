

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/LKL_RRP_UPDATE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to LKL_RRP_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''LKL_RRP_UPDATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''LKL_RRP_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''LKL_RRP_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table LKL_RRP_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.LKL_RRP_UPDATE 
   (	MFO VARCHAR2(12), 
	DAT DATE, 
	USERID NUMBER(38,0), 
	LIM NUMBER(24,0), 
	LNO NUMBER(24,0), 
	DAT_SYS DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'', ''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to LKL_RRP_UPDATE ***
 exec bpa.alter_policies('LKL_RRP_UPDATE');


COMMENT ON TABLE BARS.LKL_RRP_UPDATE IS '';
COMMENT ON COLUMN BARS.LKL_RRP_UPDATE.MFO IS '';
COMMENT ON COLUMN BARS.LKL_RRP_UPDATE.DAT IS '';
COMMENT ON COLUMN BARS.LKL_RRP_UPDATE.USERID IS '';
COMMENT ON COLUMN BARS.LKL_RRP_UPDATE.LIM IS '';
COMMENT ON COLUMN BARS.LKL_RRP_UPDATE.LNO IS '';
COMMENT ON COLUMN BARS.LKL_RRP_UPDATE.DAT_SYS IS '';
COMMENT ON COLUMN BARS.LKL_RRP_UPDATE.KF IS '';



PROMPT *** Create  grants  LKL_RRP_UPDATE ***
grant INSERT,SELECT,UPDATE                                                   on LKL_RRP_UPDATE  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on LKL_RRP_UPDATE  to BARS_DM;
grant INSERT,SELECT                                                          on LKL_RRP_UPDATE  to SETLIM01;



PROMPT *** Create SYNONYM  to LKL_RRP_UPDATE ***

  CREATE OR REPLACE PUBLIC SYNONYM LKL_RRP_UPDATE FOR BARS.LKL_RRP_UPDATE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/LKL_RRP_UPDATE.sql =========*** End **
PROMPT ===================================================================================== 
