

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SP_S031.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SP_S031 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SP_S031'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SP_S031'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SP_S031'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SP_S031 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SP_S031 
   (	S031 VARCHAR2(2), 
	S030 VARCHAR2(1), 
	TXT VARCHAR2(148), 
	S031_OLD VARCHAR2(2), 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SP_S031 ***
 exec bpa.alter_policies('SP_S031');


COMMENT ON TABLE BARS.SP_S031 IS '';
COMMENT ON COLUMN BARS.SP_S031.S031 IS '';
COMMENT ON COLUMN BARS.SP_S031.S030 IS '';
COMMENT ON COLUMN BARS.SP_S031.TXT IS '';
COMMENT ON COLUMN BARS.SP_S031.S031_OLD IS '';
COMMENT ON COLUMN BARS.SP_S031.D_CLOSE IS 'Дата закрытия норматива';



PROMPT *** Create  grants  SP_S031 ***
grant SELECT                                                                 on SP_S031         to BARSREADER_ROLE;
grant SELECT                                                                 on SP_S031         to BARSUPL;
grant FLASHBACK,SELECT                                                       on SP_S031         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SP_S031         to BARS_DM;
grant SELECT                                                                 on SP_S031         to START1;
grant SELECT                                                                 on SP_S031         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SP_S031         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SP_S031         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SP_S031.sql =========*** End *** =====
PROMPT ===================================================================================== 
