

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/IND_INFL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to IND_INFL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''IND_INFL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''IND_INFL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''IND_INFL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table IND_INFL ***
begin 
  execute immediate '
  CREATE TABLE BARS.IND_INFL 
   (	IDAT DATE, 
	IR NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to IND_INFL ***
 exec bpa.alter_policies('IND_INFL');


COMMENT ON TABLE BARS.IND_INFL IS '';
COMMENT ON COLUMN BARS.IND_INFL.IDAT IS '';
COMMENT ON COLUMN BARS.IND_INFL.IR IS '';




PROMPT *** Create  constraint XPK_INDINFL ***
begin   
 execute immediate '
  ALTER TABLE BARS.IND_INFL ADD CONSTRAINT XPK_INDINFL PRIMARY KEY (IDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_INDINFL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_INDINFL ON BARS.IND_INFL (IDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  IND_INFL ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on IND_INFL        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on IND_INFL        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on IND_INFL        to STO;
grant FLASHBACK,SELECT                                                       on IND_INFL        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/IND_INFL.sql =========*** End *** ====
PROMPT ===================================================================================== 
