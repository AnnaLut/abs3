

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PKK_QUE_ARC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PKK_QUE_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PKK_QUE_ARC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PKK_QUE_ARC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PKK_QUE_ARC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PKK_QUE_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.PKK_QUE_ARC 
   (	REF NUMBER, 
	ACC NUMBER, 
	TT CHAR(3), 
	TIP CHAR(3), 
	SOS NUMBER, 
	F_N VARCHAR2(12), 
	F_D DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PKK_QUE_ARC ***
 exec bpa.alter_policies('PKK_QUE_ARC');


COMMENT ON TABLE BARS.PKK_QUE_ARC IS '';
COMMENT ON COLUMN BARS.PKK_QUE_ARC.REF IS '';
COMMENT ON COLUMN BARS.PKK_QUE_ARC.ACC IS '';
COMMENT ON COLUMN BARS.PKK_QUE_ARC.TT IS '';
COMMENT ON COLUMN BARS.PKK_QUE_ARC.TIP IS '';
COMMENT ON COLUMN BARS.PKK_QUE_ARC.SOS IS '';
COMMENT ON COLUMN BARS.PKK_QUE_ARC.F_N IS '';
COMMENT ON COLUMN BARS.PKK_QUE_ARC.F_D IS '';




PROMPT *** Create  constraint SYS_C005144 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_QUE_ARC MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005145 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_QUE_ARC MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PKK_QUE_ARC ***
grant SELECT                                                                 on PKK_QUE_ARC     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PKK_QUE_ARC     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PKK_QUE_ARC     to START1;
grant SELECT                                                                 on PKK_QUE_ARC     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PKK_QUE_ARC.sql =========*** End *** =
PROMPT ===================================================================================== 
