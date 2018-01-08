

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/L_NAL.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to L_NAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''L_NAL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''L_NAL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''L_NAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table L_NAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.L_NAL 
   (	NLSF VARCHAR2(15), 
	NLSN VARCHAR2(15), 
	DDRR CHAR(4), 
	DD CHAR(2), 
	RR CHAR(2), 
	P080 CHAR(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to L_NAL ***
 exec bpa.alter_policies('L_NAL');


COMMENT ON TABLE BARS.L_NAL IS '';
COMMENT ON COLUMN BARS.L_NAL.NLSF IS '';
COMMENT ON COLUMN BARS.L_NAL.NLSN IS '';
COMMENT ON COLUMN BARS.L_NAL.DDRR IS '';
COMMENT ON COLUMN BARS.L_NAL.DD IS '';
COMMENT ON COLUMN BARS.L_NAL.RR IS '';
COMMENT ON COLUMN BARS.L_NAL.P080 IS '';



PROMPT *** Create  grants  L_NAL ***
grant SELECT                                                                 on L_NAL           to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on L_NAL           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on L_NAL           to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on L_NAL           to L_NAL;
grant SELECT                                                                 on L_NAL           to UPLD;
grant FLASHBACK,SELECT                                                       on L_NAL           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/L_NAL.sql =========*** End *** =======
PROMPT ===================================================================================== 
