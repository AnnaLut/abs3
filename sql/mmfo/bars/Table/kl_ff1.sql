

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_FF1.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_FF1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_FF1'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_FF1'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KL_FF1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_FF1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_FF1 
   (	NLSD VARCHAR2(15), 
	NLSK VARCHAR2(15), 
	TT VARCHAR2(3), 
	COMM VARCHAR2(60), 
	PR_DEL NUMBER, 
	OB22 VARCHAR2(2), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_FF1 ***
 exec bpa.alter_policies('KL_FF1');


COMMENT ON TABLE BARS.KL_FF1 IS 'Довiдник особових(бал.) рах. для вiдбору док-тiв в файл #F1';
COMMENT ON COLUMN BARS.KL_FF1.KF IS '';
COMMENT ON COLUMN BARS.KL_FF1.NLSD IS 'Особовий рах. Дт';
COMMENT ON COLUMN BARS.KL_FF1.NLSK IS 'Особовий рах. Кт';
COMMENT ON COLUMN BARS.KL_FF1.TT IS 'Код операцii';
COMMENT ON COLUMN BARS.KL_FF1.COMM IS 'Коментар';
COMMENT ON COLUMN BARS.KL_FF1.PR_DEL IS '';
COMMENT ON COLUMN BARS.KL_FF1.OB22 IS '';




PROMPT *** Create  constraint FK_KLFF1_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_FF1 ADD CONSTRAINT FK_KLFF1_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLFF1_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_FF1 MODIFY (KF CONSTRAINT CC_KLFF1_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KL_FF1 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_FF1          to ABS_ADMIN;
grant SELECT                                                                 on KL_FF1          to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_FF1          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_FF1          to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_FF1          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on KL_FF1          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_FF1.sql =========*** End *** ======
PROMPT ===================================================================================== 
