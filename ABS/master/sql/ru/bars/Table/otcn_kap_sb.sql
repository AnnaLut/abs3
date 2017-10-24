

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_KAP_SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_KAP_SB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_KAP_SB'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_KAP_SB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_KAP_SB ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTCN_KAP_SB 
   (	ACC NUMBER, 
	PR NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_KAP_SB ***
 exec bpa.alter_policies('OTCN_KAP_SB');


COMMENT ON TABLE BARS.OTCN_KAP_SB IS 'Процент субординированного долга для расчета регулят. капитала';
COMMENT ON COLUMN BARS.OTCN_KAP_SB.ACC IS '';
COMMENT ON COLUMN BARS.OTCN_KAP_SB.PR IS '';




PROMPT *** Create  constraint SYS_C0010757 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_KAP_SB MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_KAP_SB ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_KAP_SB     to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_KAP_SB     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OTCN_KAP_SB     to RPBN002;
grant SELECT                                                                 on OTCN_KAP_SB     to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTCN_KAP_SB     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_KAP_SB.sql =========*** End *** =
PROMPT ===================================================================================== 
