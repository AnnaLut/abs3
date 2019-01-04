

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_INT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_INT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_INT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_INT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_INT ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_INT 
   (	FDAT DATE, 
	INT NUMBER, 
	IR NUMBER, 
	KVA NUMBER, 
	NLSA VARCHAR2(15),
	NMSA VARCHAR2(70),
	OST NUMBER, 
	OSTT NUMBER, 
	TDAT DATE,
	NAZN VARCHAR2(160),
	NLSB VARCHAR2(15),
	TT VARCHAR2(3),
	RUNN NUMBER(1),
	ACC NUMBER,
	KVB NUMBER,
	NMSB VARCHAR2(70),
	ID_A VARCHAR2(14),
	ID_B VARCHAR2(14),
        ID NUMBER,
        USER_ID NUMBER default sys_context(''bars_global'',''user_id'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_INT ***
 exec bpa.alter_policies('CP_INT');


COMMENT ON TABLE BARS.CP_INT IS 'ЦП Нарахування купону';


PROMPT *** Create  index XPK_CP_INT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UNIQ_CP_INT ON BARS.CP_INT (ID, USER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  grants  CP_INT ***
grant SELECT                                                                 on CP_INT     to BARSREADER_ROLE;
grant SELECT                                                                 on CP_INT     to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_INT     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_INT     to BARS_DM;
grant SELECT                                                                 on CP_INT     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_INT.sql =========*** End *** =
PROMPT ===================================================================================== 
