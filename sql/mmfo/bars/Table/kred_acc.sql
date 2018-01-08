

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KRED_ACC.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KRED_ACC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KRED_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.KRED_ACC 
   (	ACC NUMBER, 
	CUST_TYP NUMBER, 
	META_KR NUMBER, 
	TYP_OBESP NUMBER, 
	ZAHODY NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KRED_ACC ***
 exec bpa.alter_policies('KRED_ACC');


COMMENT ON TABLE BARS.KRED_ACC IS '';
COMMENT ON COLUMN BARS.KRED_ACC.ACC IS '';
COMMENT ON COLUMN BARS.KRED_ACC.CUST_TYP IS '';
COMMENT ON COLUMN BARS.KRED_ACC.META_KR IS '';
COMMENT ON COLUMN BARS.KRED_ACC.TYP_OBESP IS '';
COMMENT ON COLUMN BARS.KRED_ACC.ZAHODY IS '';




PROMPT *** Create  constraint SYS_C005693 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KRED_ACC MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_KRED_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.KRED_ACC ADD CONSTRAINT PK_KRED_ACC PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KRED_ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KRED_ACC ON BARS.KRED_ACC (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KRED_ACC ***
grant SELECT                                                                 on KRED_ACC        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KRED_ACC        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KRED_ACC        to BARS_DM;
grant INSERT,SELECT,UPDATE                                                   on KRED_ACC        to START1;
grant SELECT                                                                 on KRED_ACC        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KRED_ACC.sql =========*** End *** ====
PROMPT ===================================================================================== 
