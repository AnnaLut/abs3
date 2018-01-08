

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC_OVER_DEAL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_OVER_DEAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACC_OVER_DEAL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ACC_OVER_DEAL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACC_OVER_DEAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC_OVER_DEAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACC_OVER_DEAL 
   (	ACC NUMBER, 
	NLS VARCHAR2(20), 
	ACCO NUMBER, 
	NLSO VARCHAR2(20), 
	DAT DATE, 
	DAT2 DATE, 
	ND NUMBER, 
	STATUS VARCHAR2(3), 
	DT_ACTION DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACC_OVER_DEAL ***
 exec bpa.alter_policies('ACC_OVER_DEAL');


COMMENT ON TABLE BARS.ACC_OVER_DEAL IS '';
COMMENT ON COLUMN BARS.ACC_OVER_DEAL.ACC IS '';
COMMENT ON COLUMN BARS.ACC_OVER_DEAL.NLS IS '';
COMMENT ON COLUMN BARS.ACC_OVER_DEAL.ACCO IS '';
COMMENT ON COLUMN BARS.ACC_OVER_DEAL.NLSO IS '';
COMMENT ON COLUMN BARS.ACC_OVER_DEAL.DAT IS '';
COMMENT ON COLUMN BARS.ACC_OVER_DEAL.DAT2 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_DEAL.ND IS '';
COMMENT ON COLUMN BARS.ACC_OVER_DEAL.STATUS IS '';
COMMENT ON COLUMN BARS.ACC_OVER_DEAL.DT_ACTION IS '';



PROMPT *** Create  grants  ACC_OVER_DEAL ***
grant SELECT                                                                 on ACC_OVER_DEAL   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_DEAL   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_OVER_DEAL   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_DEAL   to RPBN002;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_DEAL   to START1;
grant SELECT                                                                 on ACC_OVER_DEAL   to UPLD;



PROMPT *** Create SYNONYM  to ACC_OVER_DEAL ***

  CREATE OR REPLACE PUBLIC SYNONYM ACC_OVER_DEAL FOR BARS.ACC_OVER_DEAL;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC_OVER_DEAL.sql =========*** End ***
PROMPT ===================================================================================== 
