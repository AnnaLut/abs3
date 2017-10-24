

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_RESTR_ACC.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_RESTR_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_RESTR_ACC'', ''FILIAL'' , ''F'', ''F'', ''F'', null);
               bpa.alter_policy_info(''CCK_RESTR_ACC'', ''WHOLE'' , ''C'', ''C'', ''C'', null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_RESTR_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_RESTR_ACC 
   (	ACC NUMBER, 
	FDAT DATE, 
	VID_RESTR NUMBER, 
	TXT VARCHAR2(250), 
	SUMR NUMBER DEFAULT 0, 
	FDAT_END DATE, 
	PR_NO NUMBER DEFAULT 1
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_RESTR_ACC ***
 exec bpa.alter_policies('CCK_RESTR_ACC');


COMMENT ON TABLE BARS.CCK_RESTR_ACC IS 'Дати та види реструктуризації рахунків, що не в КП';
COMMENT ON COLUMN BARS.CCK_RESTR_ACC.SUMR IS 'Сума реструктуризованої заборгованості';
COMMENT ON COLUMN BARS.CCK_RESTR_ACC.FDAT_END IS 'Дата закінчення реструктуризації';
COMMENT ON COLUMN BARS.CCK_RESTR_ACC.PR_NO IS 'Ознака включення в файл #F8 (0 - не включати, 1 - включати)';
COMMENT ON COLUMN BARS.CCK_RESTR_ACC.ACC IS 'Ідентифікатор рахунку';
COMMENT ON COLUMN BARS.CCK_RESTR_ACC.FDAT IS 'Дата реструктуризації';
COMMENT ON COLUMN BARS.CCK_RESTR_ACC.VID_RESTR IS 'Вид реструктуризації';
COMMENT ON COLUMN BARS.CCK_RESTR_ACC.TXT IS 'Коментар';




PROMPT *** Create  constraint FK_CCKRESTR_ACC_VID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_RESTR_ACC ADD CONSTRAINT FK_CCKRESTR_ACC_VID FOREIGN KEY (VID_RESTR)
	  REFERENCES BARS.CCK_RESTR_VID (VID_RESTR) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCKRESTR_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_RESTR_ACC ADD CONSTRAINT FK_CCKRESTR_ACC FOREIGN KEY (ACC)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CCKRESTR_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_RESTR_ACC ADD CONSTRAINT PK_CCKRESTR_ACC PRIMARY KEY (ACC, VID_RESTR, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCKRESTR_ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCKRESTR_ACC ON BARS.CCK_RESTR_ACC (ACC, VID_RESTR, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CCK_RESTR_ACC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_RESTR_ACC   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_RESTR_ACC   to RCC_DEAL;



PROMPT *** Create SYNONYM  to CCK_RESTR_ACC ***

  CREATE OR REPLACE PUBLIC SYNONYM CCK_RESTR_ACC FOR BARS.CCK_RESTR_ACC;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_RESTR_ACC.sql =========*** End ***
PROMPT ===================================================================================== 
