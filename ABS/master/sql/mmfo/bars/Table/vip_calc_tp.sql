

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VIP_CALC_TP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VIP_CALC_TP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VIP_CALC_TP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''VIP_CALC_TP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''VIP_CALC_TP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VIP_CALC_TP ***
begin 
  execute immediate '
  CREATE TABLE BARS.VIP_CALC_TP 
   (	ID VARCHAR2(6), 
	NAME VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VIP_CALC_TP ***
 exec bpa.alter_policies('VIP_CALC_TP');


COMMENT ON TABLE BARS.VIP_CALC_TP IS '';
COMMENT ON COLUMN BARS.VIP_CALC_TP.ID IS '';
COMMENT ON COLUMN BARS.VIP_CALC_TP.NAME IS '';




PROMPT *** Create  constraint PK_VIP_CALC_TP ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIP_CALC_TP ADD CONSTRAINT PK_VIP_CALC_TP PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_VIP_CALC_TP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_VIP_CALC_TP ON BARS.VIP_CALC_TP (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  VIP_CALC_TP ***
grant SELECT                                                                 on VIP_CALC_TP     to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on VIP_CALC_TP     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VIP_CALC_TP     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on VIP_CALC_TP     to START1;
grant SELECT                                                                 on VIP_CALC_TP     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VIP_CALC_TP.sql =========*** End *** =
PROMPT ===================================================================================== 
