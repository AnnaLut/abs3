using Bars.Oracle;
using Bars.Web.Report;
using System;
using System.Data;
using Oracle.DataAccess.Types;
using System.Diagnostics;
using System.IO;
using System.Text;
using Oracle.DataAccess.Client;
using System.Web;

namespace BarsWeb.Areas.ReserveAccs.Models.Bases
{
	public class ReservedRtfReporter : RtfReporter
	{
		public string resNls { get; set; }
		public int resKv { get; set; }

		public ReservedRtfReporter(HttpContext ctx) : base(ctx) {}
		public void GenerateReserveReport()
		{
			try
			{
				if (_nEvent != -1 && _nLevel != -1)
				{
					_cmd.CommandText =  "ALTER SESSION SET EVENTS '" + 
										_nEvent.ToString() +
										" trace name context forever, level " + 
										_nLevel.ToString() + "'";
					_cmd.ExecuteNonQuery();
					_nLevel = -1;
					_nEvent = -1;
				}
				string[] _roles = RoleList.Split(',');
				IOraConnection icon = (IOraConnection)_ctx.Application["OracleConnectClass"];
				foreach (string role in _roles)
				{
					_cmd.CommandText = icon.GetSetRoleCommand(role);
					_cmd.ExecuteNonQuery();
				}
				_cmd.CommandText = "SELECT id, template FROM doc_scheme WHERE upper(ID)=upper('" + _strTemplateID + "')";
				_reader = _cmd.ExecuteReader();

				if (!_reader.Read())
					throw new ReportException("Шаблон '" + _strTemplateID + "' не найден!");

				using (OracleClob clob = _reader.GetOracleClob(1))
				{
					if (clob.IsNull || clob.IsEmpty)
						throw new ApplicationException("Шаблон '" + _strTemplateID + "' пуст!");
					_strBuf = clob.Value;
				}

				if (_strBuf.StartsWith("504B"))
					_isTemplateCompressed = true;
				else
					_isTemplateCompressed = false;

				Dump2Disk();
				MakeDataFile();
				MakeReport(_strReportFile);
			}
			finally
			{
				_reader.Close();
				_reader.Dispose();
				_cmd.Dispose();
				if (_con.State != ConnectionState.Closed) _con.Close();
				_con.Dispose();
			}
		}
	}
}