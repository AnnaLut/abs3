

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STRU1.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STRU1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STRU1'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STRU1'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STRU1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STRU1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.STRU1 
   (	TYPE CHAR(8), 
	R020 CHAR(8), 
	OB22 CHAR(10), 
	TXT VARCHAR2(254)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STRU1 ***
 exec bpa.alter_policies('STRU1');


COMMENT ON TABLE BARS.STRU1 IS '';
COMMENT ON COLUMN BARS.STRU1.TYPE IS '';
COMMENT ON COLUMN BARS.STRU1.R020 IS '';
COMMENT ON COLUMN BARS.STRU1.OB22 IS '';
COMMENT ON COLUMN BARS.STRU1.TXT IS '';



PROMPT *** Create  grants  STRU1 ***
grant SELECT                                                                 on STRU1           to BARSREADER_ROLE;
grant SELECT                                                                 on STRU1           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STRU1           to BARS_DM;
grant SELECT                                                                 on STRU1           to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on STRU1           to STRU1;
grant SELECT                                                                 on STRU1           to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STRU1           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STRU1.sql =========*** End *** =======
PROMPT ===================================================================================== 
