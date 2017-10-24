using System;
using System.Collections.Generic;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using ibank.core;

/// <summary>
/// Summary description for VSepQdocs
/// </summary>
/// 
namespace qdocs
{
	public class VSepQdocsRecord : BbRecord
	{
		public VSepQdocsRecord() : base()
		{
			fillFields();
		}
		public VSepQdocsRecord(BbDataSource Parent) : base(Parent)
		{
			fillFields();
		}
		public VSepQdocsRecord(BbDataSource Parent, OracleDecimal RowScn,
			Decimal? DK, 
			Decimal? REC, 
			Decimal? REF,
			DateTime? DATD,  
			String ND, 
			Decimal? VOB, 
			String MFOA,
			String NLSA, 
			Decimal? KV, 
			Decimal? S, 
			String NLSB, 
			String NAM_B, 
			String NAZN, 
			String D_REC, 
			String FN_A, 
			DateTime? DAT_A, 
			String NAM_A,
			String ID_A, 
			String ID_B, 
			DateTime? DATP, 
			String NMS, 
			Decimal? OSTC, 
			Decimal? LIM, 
			Decimal? PAP, 
			Decimal? OTM ) : this(Parent)
		{
			this.DK = DK;
			this.REC = REC;
			this.REF = REF;
			this.DATD = DATD;
			this.ND = ND;
			this.VOB = VOB;
			this.MFOA = MFOA;
			this.NLSA = NLSA;
			this.KV = KV;
			this.S = S;
			this.NLSB = NLSB;
			this.NAM_B = NAM_B;
			this.NAZN = NAZN;
			this.D_REC = D_REC;
			this.FN_A = FN_A;
			this.DAT_A = DAT_A;
			this.NAM_A = NAM_A;
			this.ID_A = ID_A;
			this.ID_B = ID_B;
			this.DATP = DATP;
			this.NMS = NMS;
			this.OSTC = OSTC;
			this.LIM = LIM;
			this.PAP = PAP;
			this.OTM = OTM;
			this.RowScn = RowScn;
			this.IsRowscnSupported = false;
			this.ClearChanges();

		}
		private void fillFields()
		{
			Fields.Add(new BbField("DK", OracleDbType.Decimal, true, false, false, false, false, "V_SEP_QDOCS", ObjectTypes.View, "", ""));
			Fields.Add(new BbField("REC", OracleDbType.Decimal, true, false, false, false, false, "V_SEP_QDOCS", ObjectTypes.View, "", ""));
			Fields.Add(new BbField("REF", OracleDbType.Decimal, true, false, false, false, false, "V_SEP_QDOCS", ObjectTypes.View, "", ""));
			Fields.Add(new BbField("DATD", OracleDbType.Date, true, false, false, false, false, "V_SEP_QDOCS", ObjectTypes.View, "", ""));
			Fields.Add(new BbField("ND", OracleDbType.Varchar2, true, false, false, false, false, "V_SEP_QDOCS", ObjectTypes.View, "", ""));
			Fields.Add(new BbField("VOB", OracleDbType.Decimal, true, false, false, false, false, "V_SEP_QDOCS", ObjectTypes.View, "", ""));
			Fields.Add(new BbField("MFOA", OracleDbType.Varchar2, true, false, false, false, false, "V_SEP_QDOCS", ObjectTypes.View, "", ""));
			Fields.Add(new BbField("NLSA", OracleDbType.Varchar2, true, false, false, false, false, "V_SEP_QDOCS", ObjectTypes.View, "", ""));
			Fields.Add(new BbField("KV", OracleDbType.Decimal, true, false, false, false, false, "V_SEP_QDOCS", ObjectTypes.View, "", ""));
			Fields.Add(new BbField("S", OracleDbType.Decimal, true, false, false, false, false, "V_SEP_QDOCS", ObjectTypes.View, "", ""));
			Fields.Add(new BbField("NLSB", OracleDbType.Varchar2, true, false, false, false, false, "V_SEP_QDOCS", ObjectTypes.View, "", ""));
			Fields.Add(new BbField("NAM_B", OracleDbType.Varchar2, true, false, false, false, false, "V_SEP_QDOCS", ObjectTypes.View, "", ""));
			Fields.Add(new BbField("NAZN", OracleDbType.Varchar2, true, false, false, false, false, "V_SEP_QDOCS", ObjectTypes.View, "", ""));
			Fields.Add(new BbField("D_REC", OracleDbType.Varchar2, true, false, false, false, false, "V_SEP_QDOCS", ObjectTypes.View, "", ""));
			Fields.Add(new BbField("FN_A", OracleDbType.Varchar2, true, false, false, false, false, "V_SEP_QDOCS", ObjectTypes.View, "", ""));
			Fields.Add(new BbField("DAT_A", OracleDbType.Date, true, false, false, false, false, "V_SEP_QDOCS", ObjectTypes.View, "", ""));
			Fields.Add(new BbField("NAM_A", OracleDbType.Varchar2, true, false, false, false, false, "V_SEP_QDOCS", ObjectTypes.View, "", ""));
			Fields.Add(new BbField("ID_A", OracleDbType.Varchar2, true, false, false, false, false, "V_SEP_QDOCS", ObjectTypes.View, "", ""));
			Fields.Add(new BbField("ID_B", OracleDbType.Varchar2, true, false, false, false, false, "V_SEP_QDOCS", ObjectTypes.View, "", ""));
			Fields.Add(new BbField("DATP", OracleDbType.Date, true, false, false, false, false, "V_SEP_QDOCS", ObjectTypes.View, "", ""));
			Fields.Add(new BbField("NMS", OracleDbType.Varchar2, true, false, false, false, false, "V_SEP_QDOCS", ObjectTypes.View, "", ""));
			Fields.Add(new BbField("OSTC", OracleDbType.Decimal, true, false, false, false, false, "V_SEP_QDOCS", ObjectTypes.View, "", ""));
			Fields.Add(new BbField("LIM", OracleDbType.Decimal, true, false, false, false, false, "V_SEP_QDOCS", ObjectTypes.View, "", ""));
			Fields.Add(new BbField("PAP", OracleDbType.Decimal, true, false, false, false, false, "V_SEP_QDOCS", ObjectTypes.View, "", ""));
			Fields.Add(new BbField("OTM", OracleDbType.Decimal, true, false, false, false, false, "V_SEP_QDOCS", ObjectTypes.View, "", ""));
		}
	    public Decimal? DK { get { return (Decimal?)FindField("DK").Value; } set { SetField("DK", value); } }
		public Decimal? REC { get { return (Decimal?)FindField("REC").Value; } set { SetField("REC", value); } }
		public Decimal? REF { get { return (Decimal?)FindField("REF").Value; } set { SetField("REF", value); } }
		public DateTime? DATD { get { return (DateTime?)FindField("DATD").Value; } set { SetField("DATD", value); } }
		public String ND { get { return (String)FindField("ND").Value; } set { SetField("ND", value); } }
		public Decimal? VOB { get { return (Decimal?)FindField("VOB").Value; } set { SetField("VOB", value); } }
		public String MFOA { get { return (String)FindField("MFOA").Value; } set { SetField("MFOA", value); } }
		public String NLSA { get { return (String)FindField("NLSA").Value; } set { SetField("NLSA", value); } }
		public Decimal? KV { get { return (Decimal?)FindField("KV").Value; } set { SetField("KV", value); } }
		public Decimal? S { get { return (Decimal?)FindField("S").Value; } set { SetField("S", value); } }
		public String NLSB { get { return (String)FindField("NLSB").Value; } set { SetField("NLSB", value); } }
		public String NAM_B { get { return (String)FindField("NAM_B").Value; } set { SetField("NAM_B", value); } }
		public String NAZN { get { return (String)FindField("NAZN").Value; } set { SetField("NAZN", value); } }
		public String D_REC { get { return (String)FindField("D_REC").Value; } set { SetField("D_REC", value); } }
		public String FN_A { get { return (String)FindField("FN_A").Value; } set { SetField("FN_A", value); } }
		public DateTime? DAT_A { get { return (DateTime?)FindField("DAT_A").Value; } set { SetField("DAT_A", value); } }
		public String NAM_A { get { return (String)FindField("NAM_A").Value; } set { SetField("NAM_A", value); } }
		public String ID_A { get { return (String)FindField("ID_A").Value; } set { SetField("ID_A", value); } }
		public String ID_B { get { return (String)FindField("ID_B").Value; } set { SetField("ID_B", value); } }
		public DateTime? DATP { get { return (DateTime?)FindField("DATP").Value; } set { SetField("DATP", value); } }
		public String NMS { get { return (String)FindField("NMS").Value; } set { SetField("NMS", value); } }
		public Decimal? OSTC { get { return (Decimal?)FindField("OSTC").Value; } set { SetField("OSTC", value); } }
		public Decimal? LIM { get { return (Decimal?)FindField("LIM").Value; } set { SetField("LIM", value); } }
		public Decimal? PAP { get { return (Decimal?)FindField("PAP").Value; } set { SetField("PAP", value); } }
		public Decimal? OTM { get { return (Decimal?)FindField("OTM").Value; } set { SetField("OTM", value); } }
	}
	public sealed class VSepQdocsFilters : BbFilters
	{
		public VSepQdocsFilters(BbDataSource Parent) : base (Parent)
		{
			DK = new BBDecimalFilter(this, "DK");
			REC = new BBDecimalFilter(this, "REC");
			REF = new BBDecimalFilter(this, "REF");
			DATD = new BBDateFilter(this, "DATD");
			ND = new BBVarchar2Filter(this, "ND");
			VOB = new BBDecimalFilter(this, "VOB");
			MFOA = new BBVarchar2Filter(this, "MFOA");
			NLSA = new BBVarchar2Filter(this, "NLSA");
			KV = new BBDecimalFilter(this, "KV");
			S = new BBDecimalFilter(this, "S");
			NLSB = new BBVarchar2Filter(this, "NLSB"); 
			NAM_B = new BBVarchar2Filter(this, "NAM_B");
			NAZN = new BBVarchar2Filter(this, "NAZN");
			D_REC = new BBVarchar2Filter(this, "D_REC");
			FN_A = new BBVarchar2Filter(this, "FN_A");
			DAT_A = new BBDateFilter(this, "DAT_A");
			NAM_A = new BBVarchar2Filter(this, "NAM_A");
			ID_A = new BBVarchar2Filter(this, "ID_A");
			ID_B = new BBVarchar2Filter(this, "ID_B");
			DATP = new BBDateFilter(this, "DATP");
			NMS = new BBVarchar2Filter(this, "NMS");
			OSTC = new BBDecimalFilter(this, "OSTC");
			LIM = new BBDecimalFilter(this, "LIM");
			PAP = new BBDecimalFilter(this, "PAP");
			OTM = new BBDecimalFilter(this, "OTM");
		}
		public BBDecimalFilter DK;
		public BBDecimalFilter REC;
		public BBDecimalFilter REF;
		public BBDateFilter DATD;
		public BBVarchar2Filter ND;
		public BBDecimalFilter VOB;
		public BBVarchar2Filter MFOA;
		public BBVarchar2Filter NLSA;
		public BBDecimalFilter KV;
		public BBDecimalFilter S;
		public BBVarchar2Filter NLSB;
		public BBVarchar2Filter NAM_B;
		public BBVarchar2Filter NAZN;
		public BBVarchar2Filter D_REC;
		public BBVarchar2Filter FN_A;
		public BBDateFilter DAT_A;
		public BBVarchar2Filter NAM_A;
		public BBVarchar2Filter ID_A;
		public BBVarchar2Filter ID_B;
		public BBDateFilter DATP;
		public BBVarchar2Filter NMS;
		public BBDecimalFilter OSTC;
		public BBDecimalFilter LIM;
		public BBDecimalFilter PAP;
		public BBDecimalFilter OTM;
	}
	public partial class VSepQdocs : BbTable<VSepQdocsRecord, VSepQdocsFilters>
	{
		public VSepQdocs() : base(new BbConnection())
		{
		}
		public VSepQdocs(BbConnection Connection) : base(Connection)
		{

		}
		public override List<VSepQdocsRecord> Select(VSepQdocsRecord Item)
		{
			List<VSepQdocsRecord> res = new List<VSepQdocsRecord>();
			OracleDataReader rdr = null;
			ConnectionResult connectionResult = Connection.InitConnection();
			try
			{
				rdr = ExecuteReader(Item);
				while (rdr.Read())
				{
					res.Add(new VSepQdocsRecord(
						this,
						rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
						rdr.IsDBNull(1) ? (Decimal?)null : Convert.ToDecimal(rdr[1]),
						rdr.IsDBNull(2) ? (Decimal?)null : Convert.ToDecimal(rdr[2]),
						rdr.IsDBNull(3) ? (Decimal?)null : Convert.ToDecimal(rdr[3]),
						rdr.IsDBNull(4) ? (DateTime?)null : Convert.ToDateTime(rdr[4]),
						rdr.IsDBNull(5) ? (String)null : Convert.ToString(rdr[5]),
						rdr.IsDBNull(6) ? (Decimal?)null : Convert.ToDecimal(rdr[6]),
						rdr.IsDBNull(7) ? (String)null : Convert.ToString(rdr[7]),
						rdr.IsDBNull(8) ? (String)null : Convert.ToString(rdr[8]),
						rdr.IsDBNull(9) ? (Decimal?)null : Convert.ToDecimal(rdr[9]),
						rdr.IsDBNull(10) ? (Decimal?)null : Convert.ToDecimal(rdr[10]),
						rdr.IsDBNull(11) ? (String)null : Convert.ToString(rdr[11]),
						rdr.IsDBNull(12) ? (String)null : Convert.ToString(rdr[12]),
						rdr.IsDBNull(13) ? (String)null : Convert.ToString(rdr[13]),
						rdr.IsDBNull(14) ? (String)null : Convert.ToString(rdr[14]),
						rdr.IsDBNull(15) ? (String)null : Convert.ToString(rdr[15]),
						rdr.IsDBNull(16) ? (DateTime?)null : Convert.ToDateTime(rdr[16]),
						rdr.IsDBNull(17) ? (String)null : Convert.ToString(rdr[17]),
						rdr.IsDBNull(18) ? (String)null : Convert.ToString(rdr[18]),
						rdr.IsDBNull(19) ? (String)null : Convert.ToString(rdr[19]),
						rdr.IsDBNull(20) ? (DateTime?)null : Convert.ToDateTime(rdr[20]),
						rdr.IsDBNull(21) ? (String)null : Convert.ToString(rdr[21]),
						rdr.IsDBNull(22) ? (Decimal?)null : Convert.ToDecimal(rdr[22]),
						rdr.IsDBNull(23) ? (Decimal?)null : Convert.ToDecimal(rdr[23]),
						rdr.IsDBNull(24) ? (Decimal?)null : Convert.ToDecimal(rdr[24]),
						rdr.IsDBNull(25) ? (Decimal?)null : Convert.ToDecimal(rdr[25])));
				}
			}
			finally
			{
				DisposeDataReader(rdr);
				if (ConnectionResult.New == connectionResult)
					Connection.CloseConnection();
			}
			return res;
		}


	}
}