

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_LockSaldo_View.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_LockSaldo_View ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_LockSaldo_View ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_LockSaldo_View 
   (	D_MODIFY DATE, 
	DaAutoUnLock DATE, 
	DaDocLock DATE, 
	DaDocUnLock DATE, 
	DaLock DATE, 
	DaUnLock DATE, 
	DocLock VARCHAR2(100), 
	DocUnLock VARCHAR2(100), 
	GROUP_U NUMBER(10,0), 
	I_VA NUMBER(5,0), 
	ISP_Lock NUMBER(5,0), 
	ISP_UnLock NUMBER(5,0), 
	Motive NUMBER(5,0), 
	NLS VARCHAR2(25), 
	SumLock NUMBER(20,2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_LockSaldo_View ***
 exec bpa.alter_policies('S6_LockSaldo_View');


COMMENT ON TABLE BARS.S6_LockSaldo_View IS '';
COMMENT ON COLUMN BARS.S6_LockSaldo_View.D_MODIFY IS '';
COMMENT ON COLUMN BARS.S6_LockSaldo_View.DaAutoUnLock IS '';
COMMENT ON COLUMN BARS.S6_LockSaldo_View.DaDocLock IS '';
COMMENT ON COLUMN BARS.S6_LockSaldo_View.DaDocUnLock IS '';
COMMENT ON COLUMN BARS.S6_LockSaldo_View.DaLock IS '';
COMMENT ON COLUMN BARS.S6_LockSaldo_View.DaUnLock IS '';
COMMENT ON COLUMN BARS.S6_LockSaldo_View.DocLock IS '';
COMMENT ON COLUMN BARS.S6_LockSaldo_View.DocUnLock IS '';
COMMENT ON COLUMN BARS.S6_LockSaldo_View.GROUP_U IS '';
COMMENT ON COLUMN BARS.S6_LockSaldo_View.I_VA IS '';
COMMENT ON COLUMN BARS.S6_LockSaldo_View.ISP_Lock IS '';
COMMENT ON COLUMN BARS.S6_LockSaldo_View.ISP_UnLock IS '';
COMMENT ON COLUMN BARS.S6_LockSaldo_View.Motive IS '';
COMMENT ON COLUMN BARS.S6_LockSaldo_View.NLS IS '';
COMMENT ON COLUMN BARS.S6_LockSaldo_View.SumLock IS '';




PROMPT *** Create  constraint SYS_C0019873 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_LockSaldo_View MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0019872 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_LockSaldo_View MODIFY (Motive NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0019871 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_LockSaldo_View MODIFY (I_VA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0019870 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_LockSaldo_View MODIFY (GROUP_U NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0019869 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_LockSaldo_View MODIFY (DaLock NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_LockSaldo_View.sql =========*** End
PROMPT ===================================================================================== 
